Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122A5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA4720825
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VHURHVKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgEPGyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:54:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgEPGyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:54:35 -0400
Received: from zn.tnic (p200300EC2F1DA50090D29301FFFB4BAE.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:a500:90d2:9301:fffb:4bae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B50B1EC01AD;
        Sat, 16 May 2020 08:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589612074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ab+P+wPx5NHYsiPgc9J2JsoTDiY7IzZ3zmWeot+Qw+U=;
        b=VHURHVKx6gfcC8pR4Uqeylj3W7FJdMBA5fjAMqIYMpipQmPnLRkxCuYO9pW2i5KsG68avv
        B7jWGHGb1O48AIbsWOmy7pxZuc5CoZccvFfhfHVX3ltEWmgjF3vWwt8bahV1me9SoUCMnq
        i89iEUt/tBdq1xyqWHkkmphz7XlRpEk=
Date:   Sat, 16 May 2020 08:54:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
Message-ID: <20200516065431.GB25771@zn.tnic>
References: <20200505184648.2264-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505184648.2264-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:46:48AM -0700, Tony Luck wrote:
> An interesting thing happened when a guest Linux instance took
> a machine check. The VMM unmapped the bad page from guest physical
> space and passed the machine check to the guest.
> 
> Linux took all the normal actions to offline the page from the process
> that was using it. But then guest Linux crashed because it said there
> was a second machine check inside the kernel with this stack trace:
> 
> do_memory_failure
>     set_mce_nospec
>          set_memory_uc
>               _set_memory_uc
>                    change_page_attr_set_clr
>                         cpa_flush
>                              clflush_cache_range_opt

Maybe I don't see it but how can clflush_cache_range_opt() call
cpa_flush() ?

> This was odd, because a CLFLUSH instruction shouldn't raise a machine
> check (it isn't consuming the data). Further investigation showed that
> the VMM had passed in another machine check because is appeared that the
> guest was accessing the bad page.

This is where you lost me - if the VMM unmaps the page during the first
MCE, how can the guest even attempt to touch it and do this stack trace
above?

/me is confused.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
