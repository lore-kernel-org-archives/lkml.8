Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17FFC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C5B20753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8HvqyfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgCWUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:51:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40619 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgCWUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:51:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so6433646plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMMdJaa4bONzNf5mDBwmnm5Rm9aUThaT2F27qU30gBI=;
        b=Z8HvqyfM6Z+09cHtpfoWtr7wIJ0l84l8MGsKJ/sLOm775g9Y69xIX+Ri1HVvXvdHRC
         Ku2vkY4chmdk99FHBAD5T6crSfO/EgNGFuSqYYSwlXP2K/PVH3RoxzWQzjJrgOh9+q9H
         aZajNf3FrKBBYgSc23W/Z3bbSfR9myeEgqOdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMMdJaa4bONzNf5mDBwmnm5Rm9aUThaT2F27qU30gBI=;
        b=Sy3WvI1+KeVdpeQDWduMFh/Tqn5xE/b4bOkTxS5pJJtr/Ow8Y+aU3f3nGmPUwhsUS8
         1aNGvylvAa8ePCD/JjDA9LXqR0bZTuWXK5eVx1q9VXojWu3wjx0KfxFrGSGhvnNnePo8
         h+jOZvx9R9Us199gxdyreo3IgoI1nb55+xzcWdhNdxUOGdQc8tfiFzENZOtGVLRPdWnd
         Nl02MEdzZCFsGFiwGxvYJVz1Do84PHbDvfiTa8jfJb+wkCoSBDdBHXfNFwbBb1c7H6NS
         RTOnsAb2F4phHo7Krvu5xQtW5dlTqDauXJZF4njuQQgKnG3l7uaIE8kx7oyDCBoTFdrI
         ZiBA==
X-Gm-Message-State: ANhLgQ1m/5Q1VTNMpz3aLh7VNGxZhjmZDal0FvX9Kmi4As0wN0G0XPE4
        1El4CyjmI3ZbeKJJh8BG2O/img==
X-Google-Smtp-Source: ADFU+vvt3wkoTHMkwng+ZSgKCdf7yKNUmOGtHXTcau2DC27wuHHhjLUh+ushdvDqdjzT0My0MtaA5g==
X-Received: by 2002:a17:90a:3702:: with SMTP id u2mr1264975pjb.191.1584996680281;
        Mon, 23 Mar 2020 13:51:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm13530398pff.173.2020.03.23.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:51:19 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:51:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     bp@alien8.de, Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <202003231350.7D35351@keescook>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323204454.GA2611336@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:44:54PM -0600, Jason A. Donenfeld wrote:
> On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> > Long overdue patch, see below.
> > 
> > Plan is to queue it after 5.7-rc1.
> > 
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > Date: Mon, 16 Mar 2020 16:28:36 +0100
> > Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> > 
> > The currently minimum-supported binutils version 2.21 has the problem of
> > promoting symbols which are defined outside of a section into absolute.
> > According to Arvind:
> > 
> >   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
> >           Invalid absolute R_X86_64_32S relocation: _etext
> >   and after fixing that one, with
> >           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> > 
> > Those two versions of binutils have a bug when it comes to handling
> > symbols defined outside of a section and binutils 2.23 has the proper
> > fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> > 
> > Therefore, up to the fixed version directly, skipping the broken ones.
> > 
> > Currently shipping distros already have the fixed binutils version so
> > there should be no breakage resulting from this.
> > 
> > For more details about the whole thing, see the thread in Link.
> 
> That sounds very good to me. Then we'll be able to use ADX instructions
> without ifdefs.
> 
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Can you send these now and we can land in 5.7 with the doc change?

-Kees

-- 
Kees Cook
