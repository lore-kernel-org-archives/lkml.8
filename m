Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F202C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE474207CD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 01:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HSX7QgEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgGEBcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 21:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGEBce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:32:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F6C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 18:32:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so16766961pgk.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 18:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=59VxMmgeT9KxBaJVCFw1M3O2KmYJOpHc2AYpI19GAYA=;
        b=HSX7QgEPS6LoqylMa5IacECE4VnR35/Vx+maHYSJHGTCQcCzRIkD4U7zkpsFkh2bHy
         SVufEof2RP8fvcPSDBbLgp9y7TNnDpBL2UvMPyzzm0PxsHggABDbCVrySBllbgIfjRpm
         ohcBzWP7H0su5mbxwpPYthNv0bWIVhRanJVtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59VxMmgeT9KxBaJVCFw1M3O2KmYJOpHc2AYpI19GAYA=;
        b=HkrH+dzPkG/fvpyVtZNOd8wGPGiLeRvsKQu0ct+ACVGD518mWmq7ugiKH8n0pf3TE3
         g7Sy47gVxpvg3tfeZ3QRpBB4vQ9l0XTcsZfBk8//x2ksDv2lVIse0GQ8u7cgszmlNzr+
         1NVToTjQFHm75+72erZ6iVbWFFeZ0DrbW/TAULNqDnPye2H3lU84cC7/+j5S0vEloDoI
         YtvjuSdN88BG5nDttDB3e54bhrdanu00oAYj2dg6iyaAHgvzBstfb7I2x/C//2FRRFvR
         /4vBq4ciD6Wjlq8Yy9tNEUM+JSheJnqm7HsSribfcjzpGFcHM7WYlzFQGDyy7S9ewv44
         zqMg==
X-Gm-Message-State: AOAM5330O/r9cRVmAyT+dg6lIs7424eHpxzlEjnSUcoKLTJjCDjG/4zo
        2gYFQOmIV2e4X/hYYG+XCTIwmw==
X-Google-Smtp-Source: ABdhPJydgdPeV3xrmm7Cro5fgXstCUAh4/jRr0i8EJMDzDXeuUqNuh3g1Nsudc/hVo0x7aydTHTxlQ==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr29777761pgj.248.1593912754183;
        Sat, 04 Jul 2020 18:32:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm14531744pja.1.2020.07.04.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 18:32:33 -0700 (PDT)
Date:   Sat, 4 Jul 2020 18:32:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <202007041811.45236EE598@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1593897917.7058.11.camel@HansenPartnership.com>
 <CAPM=9tyjdzU-O2nAWFngGSE=aSfUsaRer9x3bk8hpyhCOX0Bew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyjdzU-O2nAWFngGSE=aSfUsaRer9x3bk8hpyhCOX0Bew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 09:39:29AM +1000, Dave Airlie wrote:
> I don't totally agree on that, because like the CoC discussion, people
> need concrete examples. People need reasons, saying simply "be
> inclusive" doesn't work.
> 
> You say "be inclusive" people don't think about it, they just go "I'm
> inclusive" and proceed, never questioning what it means to be
> inclusive, they normalise inclusivity to their self image and within
> their lives where they might never confront anything like this.
> 
> I don't doubt we get the American/Ottoman/Barbery coast people and the
> correct answer to those people is to tell them to examine why they
> suddenly care about Barbery slavery now when they have never even
> heard or worried about it before. Why haven't they submitted patches
> removing slavery terminology from the kernel before?

Right; this part of the patch provides a temporal explanation for "but
why now?" and acts as an internal reference, instead of pointing to
external[1] sources, which lack the Linux-specific contextualization.

Additionally, I think it provides rebuttals to many of the specious
arguments against inclusive terminology (and it could perhaps gain
more, as we've already seen in this thread, against slippery slope
arguments). It also attempts to acknowledge what this change in the
kernel processes provides to the world in general: it's a fairly local
change to make our development community less disruptive to those that
would seek to join it -- it does not, and cannot, solve global racism
(though that would be nice).

[1] https://tools.ietf.org/id/draft-knodel-terminology-01.html

-- 
Kees Cook
