Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B9AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3762068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFF51JIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGUIRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgGUIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:17:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5C3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:17:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so15667931ili.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lbf3gjt9wqDFjZNQXE9vw5HIudL+elBicOycwkN2GWQ=;
        b=XFF51JIKpCJq1ReUp9zCAKu5eFh/od9kuhZzToBLGCVAJP03KJDtp+XYG94ZblT9Qx
         CK1ziEE1dRaLBZJpdIVZmzYtFMJsX8Er+cjl7hRDZc4T6nIlyprBCDOwjcXAcTbqrRRY
         TkpQkYZ0IAlo6QOugguELOTIvjzuCdHFZvlUH98PBGDu0BuQOayPKjdMbQsQpAMkXWwH
         ftEPHnuULTfDQp1m/gSu1mDKZ4HcI5zMUgfXJBbvRb4PoVSU479F5QDvhLbwfVHUfxkC
         /BDHudbvF/sTWZbWI/LMibd+TEx9qgcWtP9DkMHRwheFYaOq6QuLw9gzpF/dFxiozk6E
         DSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lbf3gjt9wqDFjZNQXE9vw5HIudL+elBicOycwkN2GWQ=;
        b=SFH5HU6v2FO/V/LrLt2E5nsGLI2rO+pc2Mrt44r5W1PkajMGqvp3PuACSLGXwDJtKK
         xG61Z5uUCFVF6+DNem7MYz52xJoBsubQqT6YgfwW6Iug1x1x8b7GCoG8iHVdnfOsJvQR
         98sBw8GhHmAMT7agtvYf/TIJPD0Q2zODFHX/rkgSliK9voAlO/Dxxe1Gq3lMi/992J/t
         L0/V1r1ogYsXP74IkUSvrGrVWwHxCEGNUPRHpLAIx4ZIj6RhHKqwi7RviyE+sFFHngc/
         +lL94YSBwDGhLYt/sENnBZtrYczAm1JZt0DYhk7DvA0B+poKx7fhzZB4L4DN13oUFlU+
         I2xg==
X-Gm-Message-State: AOAM532T0eS48WNSF1SknYlKbPEPd0/aqFPJyqvpER4Xp5a3oES0Xy3G
        F+H/naLDmGFkTL/CLujJgmS/tJx8AqQEVAfXDKs=
X-Google-Smtp-Source: ABdhPJy41fKMsFaiIQf8bZrLrQpggA3qdNPyEUgnXi1lL9mCrffW343LgeB5Jc7iP2WqJ8RXh7Wl1a7PRlfDyuAG2y8=
X-Received: by 2002:a92:290a:: with SMTP id l10mr28613347ilg.204.1595319423019;
 Tue, 21 Jul 2020 01:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
 <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
In-Reply-To: <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 21 Jul 2020 10:16:51 +0200
Message-ID: <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jul 19, 2020 at 8:47 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > I wonder why there is a time gap between tagging v5.8-rc6 in [1]
> > (first) and [2] (15-16mins later).
> > Can you explain that?
>
> Usually I push to github and kernel.org at the same time.
>
> But every once in a while, my OTP token for kernel.org expires, and
> then I have to get my OPT token generator and update it and push
> again.
>
> So sometimes github ends up getting my pushes earlier, simply because
> it doesn't have quite the same kind of strict security checks.
>

Hi Linus,

OK, I understand.

You happen to know if I can configure in my ~/.gitconfig to pull
linux-git stuff from two repositories - check first git.kernel.org
then GitHub.

Some days ago GitHub had some maintenance issues and I was not able to pull.
Means I trust more the security and integrity concept of git.kernel.org.

To pull from GitHub - saved 15-16mins of my life-time - meant
15-16mins go earlier to sleep - as said I started my build 01:02a.m.
(German local-time).

Thanks.

Regards,
- Sedat -
