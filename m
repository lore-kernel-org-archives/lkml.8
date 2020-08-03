Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E50EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BAF20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gaa05K/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCTRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:17:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbgHCTRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596482255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlRPcUiCaDRmWVJAxXsR/XyWp+YNVRWRo58Ec1/lUXg=;
        b=Gaa05K/BUJhcmroMdsPLWDt5P91PpAI/1beHl7cit0vBGMVoX9sRwET8LLWCXdHXt66HXD
        zgPZrgEB2QE5tJpUxrG1rbxnr+6L4zRFgdy/+bWh38alrAZ+2PW9bkfI+y3oDaxZaC6t1L
        vwSYZUz/u1a+juh9SDVlEJ/rY9v1NRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-l43cMm2WM0i38uQMayFyhA-1; Mon, 03 Aug 2020 15:17:31 -0400
X-MC-Unique: l43cMm2WM0i38uQMayFyhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B982100AA27;
        Mon,  3 Aug 2020 19:17:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C46E19C66;
        Mon,  3 Aug 2020 19:17:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  3 Aug 2020 21:17:29 +0200 (CEST)
Date:   Mon, 3 Aug 2020 21:17:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "chunlei.wang" <Chunlei.wang@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        weiwei.zhang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siganl: ignore other signals when doing coredump
Message-ID: <20200803191725.GA2078@redhat.com>
References: <1595487143.29785.9.camel@mbjsdccf07>
 <20200723175126.cf6a660e46c8da26b1293eb4@linux-foundation.org>
 <1596185654.11648.1.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596185654.11648.1.camel@mbjsdccf07>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, chunlei.wang wrote:
>
> Please tell us much more about why you think Linux would benefit from
> this change.  Precisely what operational problems are you seeing with
> the current code?
> =>
>        Sorry for the late reply.
>
>        If coredump is incomplete, R&D can not find root cause through
> coredump.
>  If the issue is seldom, this modification will speed up the process of
> solving the problem.

To be honest, I do not even know what can I say, except that I disagree
with this change. The very idea looks wrong to me.

Granted, SIGKILL can kill the process which does something useful. Say,
dumps a core. So what?

Where does this SIGKILL come from? How often does this happen?

And why do you think the core dumping is special? Say, you try to debug
the buggy application, but a sudden SIGKILL kills the debuggee and you
lose the debugging session. Does this mean that the kernel needs another
patch to protect the process running under gdb from SIGKILL?

I don't think so. Please feel free to resend this patch, but it needs
a very convincing changelog. And please send it to lkml.

Oleg.

