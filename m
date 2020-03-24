Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB425C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C8F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpuMECOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCXMNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:13:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25725 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbgCXMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585051990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58l/H2MApEOu+ie/Vjhf3T42AhKzIjQCCWFefzgW4/M=;
        b=QpuMECOSKvYM5JqwmLQAVcwj4+0CVwvRRtUwh+zDy6Qlmtn2XGJ7eYOjOs3t9vLDkcTdnm
        Gt/QxwcMTDaVEGx5Xgo0RgW3GGGwQN93oB/MGA/L5xlEmmJ9eWf3exHwCKltcgSOoFRCwV
        JeYYrTXxF4/h3wTuItqsj1YaRo8TDZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-gjGvKRESNcSsA9rl3IRp-g-1; Tue, 24 Mar 2020 08:13:06 -0400
X-MC-Unique: gjGvKRESNcSsA9rl3IRp-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C5FB100550D;
        Tue, 24 Mar 2020 12:13:04 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0BB03A4;
        Tue, 24 Mar 2020 12:13:00 +0000 (UTC)
Date:   Tue, 24 Mar 2020 13:13:06 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Pratik Patel <pratikp@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Williams <michael.williams@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] coresight: do not use the BIT() macro in the UAPI header
Message-ID: <20200324121306.GA5735@asgard.redhat.com>
References: <20200324042213.GA10452@asgard.redhat.com>
 <20200324062853.GD1977781@kroah.com>
 <20200324095304.GA2444@asgard.redhat.com>
 <20200324101938.GA2220478@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324101938.GA2220478@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:19:38AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2020 at 10:53:04AM +0100, Eugene Syromiatnikov wrote:
> > On Tue, Mar 24, 2020 at 07:28:53AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 24, 2020 at 05:22:13AM +0100, Eugene Syromiatnikov wrote:
> > > > The BIT() macro definition is not available for the UAPI headers
> > > > (moreover, it can be defined differently in the user space); replace
> > > > its usage with the _BITUL() macro that is defined in <linux/const.h>.
> > > 
> > > Why is somehow _BITUL() ok to use here instead?
> > 
> > It is provided in an UAPI header (include/uapi/linux/const.h)
> > and is appropriately prefixed with an underscore to avoid conflicts.
> 
> Because no one uses _ in their own macros?  :)

Well, it is a reserved prefix (ANSI C99, 4.1.2 "Standard headers": "All
other identifiers that begin with an underscore and either an upper-case
letter or another underscore are reserved"), so valid C files shouldn't
use them.

> Anyway, this is fine, but if it's really the way forward, I think a lot
> of files will end up being changed...

There are 5 cases for using BIT() in UAPI headers so far (rtc.h[1],
serio.h[2], psci.h[3], pkt_sched.h[4], coresight-stm.h), two of them were
conversions from the open-coded variant; the usage of _BITUL in pkt_sched.h
made me think that it is the better approach since people tend to use
BIT-like macro anyway, so, by increasing a number of cases it may raise
awareness of the UAPI specifics.

[1] https://lore.kernel.org/lkml/20200324041209.GA30727@asgard.redhat.com/
[2] https://lore.kernel.org/lkml/20200324041341.GA32335@asgard.redhat.com/
[3] https://lore.kernel.org/lkml/20200324041526.GA1978@asgard.redhat.com/
[4] https://lore.kernel.org/lkml/20200324041920.GA7068@asgard.redhat.com/

> 
> thanks,
> 
> greg k-h
> 

