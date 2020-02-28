Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08906C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D166424690
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ7Z5xT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgB1DhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:37:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730630AbgB1DhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582861021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDJjztBIb3g7WuQ8tm9j5jVgnbmxznk84OuAMLjRbBQ=;
        b=OJ7Z5xT8kgtMXRIZOYfxNCfKkLv5Sbffh+O4OLYmv7legVzzY5N4ziVV5LnbWBvrolKVyy
        iQN5whzpD2El2X9cbczqtxB8HH5QQaqFJW7XMYvPvf5Jxjr3sGJ9UVJiSNBy7bTniKEQPj
        gYQDXTqPmwi9dAwJg32mcbyYjD5dIjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-RILYYk35OgShqd8ub0Y2sA-1; Thu, 27 Feb 2020 22:36:57 -0500
X-MC-Unique: RILYYk35OgShqd8ub0Y2sA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C33B10509B8;
        Fri, 28 Feb 2020 03:36:55 +0000 (UTC)
Received: from localhost (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36AE45D9CD;
        Fri, 28 Feb 2020 03:36:50 +0000 (UTC)
Date:   Fri, 28 Feb 2020 11:36:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        dyoung@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arjan@linux.intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Message-ID: <20200228033648.GJ24216@MiWiFi-R3L-srv>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-10-kristen@linux.intel.com>
 <202002060428.08B14F1@keescook>
 <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
 <20200227024253.GA5707@MiWiFi-R3L-srv>
 <202002270802.1CA8B32AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002270802.1CA8B32AC@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/20 at 08:02am, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 10:42:53AM +0800, Baoquan He wrote:
> > On 02/06/20 at 09:51am, Kristen Carlson Accardi wrote:
> > > On Thu, 2020-02-06 at 04:32 -0800, Kees Cook wrote:
> > 
> > > > In the past, making kallsyms entirely unreadable seemed to break
> > > > weird
> > > > stuff in userspace. How about having an alternative view that just
> > > > contains a alphanumeric sort of the symbol names (and they will
> > > > continue
> > > > to have zeroed addresses for unprivileged users)?
> > > > 
> > > > Or perhaps we wait to hear about this causing a problem, and deal
> > > > with
> > > > it then? :)
> > > > 
> > > 
> > > Yeah - I don't know what people want here. Clearly, we can't leave
> > > kallsyms the way it is. Removing it entirely is a pretty fast way to
> > > figure out how people use it though :).
> > 
> > Kexec-tools and makedumpfile are the users of /proc/kallsyms currently. 
> > We use kallsyms to get page_offset_base and _stext.
> 
> AIUI, those run as root so they'd be able to consume the uncensored
> output.

Yes, they have to be run under root.

