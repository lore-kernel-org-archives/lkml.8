Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA5021744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bhCNTjwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAJU4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:56:48 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39444 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:56:48 -0500
Received: by mail-pj1-f68.google.com with SMTP id m1so1485693pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7Bryrqer0pGS04ZUgaYTQcw5JUfaRW4Udoe9B8uhwM=;
        b=bhCNTjwJMWbznlxb5U6Tc/GvaJOxnnK45w8gVitTj2k/tXK3AYPZnqEyY+ptYCksei
         GFqXvtKYlPs4gUgQWe297GE/xiMG9rCQaZigl+q0WKupiQ+GI5YqelF6RAvFIdofAwFe
         4F9GmUxOVCyqAzM8SeguT0TXdntnZEpUicVyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7Bryrqer0pGS04ZUgaYTQcw5JUfaRW4Udoe9B8uhwM=;
        b=S4JAlW9XXBGaqoqX2WZgBn1JhWGby5pRN1TRJNFmI44FYfxJc8x+ktfKW9SHQLZdJg
         w66G9Chi7SX4x/2HdVdtjaXFALpBEe83LfuwjrVsGsjRkxxDI28+5VM83bARHdgyH5/D
         yc8Iwo5XiDDsTdQvOLXwpnt9ylF6yGL17RQbxgpU3PYZIR7ZE8o+nz1p1BuU9DNvIkmN
         V13xP0IPKAoPT75Sr5+Main1+uqLgz9z3S92Hb4by/5iCrXghHYaeOFPv/lwfiLCmrmb
         VKS5ABDdE37DGp1I0I3a9EgpYOkqO35CwIfOW0ZiyrVBa8a84j+VUoX5NchNeODjS8Uu
         6K3w==
X-Gm-Message-State: APjAAAURMrAynk5W+Y/Jz+Uvg6eUsCy1clEo30Ttxocqf74OKyl8JnCV
        Tzk/g8PEbI/jneMNGzwUaMmjXg==
X-Google-Smtp-Source: APXvYqwLdFSoWSWJqLWv+94cEyPnOpIJ3FMj+ZDpfuVTwGCyaWdNPi5BOYZSZz49i3CkU+Wgl2wKhw==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr454294plb.309.1578689807510;
        Fri, 10 Jan 2020 12:56:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm3691563pgl.58.2020.01.10.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 12:56:46 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:56:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>, Mauro Rossi <issor.oruam@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <202001101255.3F360ED562@keescook>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110203828.GK19453@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 09:38:28PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> > Pre-2.23 binutils makes symbols defined outside sections absolute, so
> > these two symbols break the build on old linkers.
> 
> -ENOTENOUGHINFO
> 
> Which old linkers, how exactly do they break the build, etc etc?
> 
> Please give exact reproduction steps.

Mauro (now CCed) ran into this too, but on 32-bit builds only with older
binutils. I hadn't set up an environment to try to reproduce it yet, but
it seems like this patch would fix it. Mauro can you test this? Does it
fix it for you too?

https://lore.kernel.org/lkml/20200110202349.1881840-1-nivedita@alum.mit.edu/

-Kees

-- 
Kees Cook
