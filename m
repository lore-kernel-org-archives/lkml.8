Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED16AC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694C24670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TudCOrdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSSWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:22:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSSWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:22:30 -0500
Received: from zn.tnic (p200300EC2F095500C57DC876B1A4488F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:c57d:c876:b1a4:488f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BCF81EC0CD9;
        Wed, 19 Feb 2020 19:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582136549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lmGikz7Q/Yq4MxVd8jpfVZwtYUz5dkwZIJ5oO0ns5X4=;
        b=TudCOrdnDYBvOHcXxzjmLIGuZTvzfGiI+0vqVO8NEPF9zblw6YIFWGvXG+IE6116JlU2M7
        onbwkIvlL7/KBl7wNVLkAIFR7iNQhJk56Ue1tV9vcb05JM4mck+A94LNwrB7GTrwRwr3Cr
        VS/jU26z4AsPWwNDJuaceo+UhVo8a0I=
Date:   Wed, 19 Feb 2020 19:22:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200219182230.GG30966@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200205162921.GA318609@rani.riverdale.lan>
 <20200218180353.GA930230@rani.riverdale.lan>
 <20200219120938.GB30966@zn.tnic>
 <20200219175717.GA1892094@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219175717.GA1892094@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:57:17PM -0500, Arvind Sankar wrote:
> There isn't any particular urgency (at least until fg-kaslr patches try

Ok, I was just making sure you're not pinging because there's something
more urgent here. See below.

> to make it 64MiB bigger), but it's unclear how long to wait before
> sending a reminder -- Documentation/process suggests that comments
> should be received in a week or so, pinging after 4 and 6 weeks seemed
> reasonable. If x86 has a longer queue, might be worth documenting that
> somewhere?

We try to track all stuff but x86 is super crazy most of the time,
especially currently, so stuff gets prioritized based on urgency and we
also try to round-robin through all submitters so that stuff doesn't get
left out.

Thus the one-week thing will never work with x86. Once a month ping
maybe.

In your case, since it is an improvement which is good to have but not
absolutely a must and not a bugfix, it is understandable that it would
get pushed back in priority.

But stuff usually won't be forgotten and we'll get to it eventually - it
is just that we're mega swamped all the time. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
