Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2AAC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA624214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k41C2LWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502487AbgDPJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440886AbgDPIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A8C0610D6;
        Thu, 16 Apr 2020 01:21:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o81so3598184wmo.2;
        Thu, 16 Apr 2020 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GRj1bNy3dNdnoBw7MW0MU1ceAiClIxWnQUWY2HqaiC4=;
        b=k41C2LWc6nojxtzqzWo3WaCxaD7Aryp295keNJJ2Jk42EYRvMnSfnjVuI5lcveaaDD
         5mHdEaxw4+7YoKU0Hew0DLmD0u83Ar4Pc1ShFanWuphFrixVPnHG3dUExE6eEB65jrtT
         rFJWosWqr7z0RfYzulAARF/0Mk/KwYNea4RDRfKDvuFCmreV07f+gxxXVvIBOfZCLTJV
         HHG9DKn7lpcXf7a/3+jNZ4v/eGXffZ8BvXBc04B2TdO9M/vKRuHqhqipJUnLevjYMfCc
         Af92F9WR3LBzL0H4lv5IyqiZugwVhbZpHKItb3tFs1NdnI1E3QvumYO7PgiFAlXL5TSg
         DJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GRj1bNy3dNdnoBw7MW0MU1ceAiClIxWnQUWY2HqaiC4=;
        b=d4e6afHZsKHG9+fn2rmmF/BAl23x6DlzSTKfL7BCeSbogafnrURYyoY29Y/1Xo0OVS
         vz0Uo9DQzPd+XbSucm895KbY5pu0+t3IdirB731RPn2ON4bSca2lZPcnyOL6N9elH7AL
         cIqa5xK9bSojCi2D/cIbcS3Q6s86Jpx8CsWd6Nip32QuuPWL/F128dnk3jFRJud/wfxX
         xnAvhfA8FflJ6kl5CBHD7h/LL1iQLUc4iHO4ci/PFQCl84h0F+Ust7hszMc+eCNkt9FE
         jcXhO2j5jxBsfO5wZzsvJf5gheZHi1fhJW/PY7+9baTO8U+v+DqiW9waeEQqFfURxCAt
         RkXQ==
X-Gm-Message-State: AGi0PuZgHhmTDLzJAzLuFhLzr7GcF8yzmFncq1XAGPOw1SXqWQsDx6L/
        CFm/H0IYQnzwG0fwfb+DWSEpsf1Yg54ozRuNo8dewm9tFQI=
X-Google-Smtp-Source: APiQypIbfCHMM32E+0tY30kGGW/TB28wDgfj2YKPbSVdr0/gZ6TK3K+HlsrYqb1AMsn8gUes95YxM5cZWFK0VFhSHrw=
X-Received: by 2002:a1c:4085:: with SMTP id n127mr3808059wma.163.1587025317838;
 Thu, 16 Apr 2020 01:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295@epcas1p4.samsung.com>
 <001201d60e12$8454abb0$8cfe0310$@samsung.com> <20200415164702.xf3t2stjpkjl6das@fiona>
 <000001d6137e$95efb510$c1cf1f30$@samsung.com>
In-Reply-To: <000001d6137e$95efb510$c1cf1f30$@samsung.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 16 Apr 2020 10:21:46 +0200
Message-ID: <CA+icZUVXEnrc2WXkS=TPXhmOm9rYTyAOZq9Z+f+fauvGp2oofg@mail.gmail.com>
Subject: Re: [ANNOUNCE] exfat-utils-1.0.1 initial version released
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:15 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> > Hi,
> Hi Goldwyn,
>
> >
> > On 10:59 09/04, Namjae Jeon wrote:
> > > The initial version(1.0.1) of exfat-utils is now available.
> > > This is the official userspace utilities for exfat filesystem of
> > > linux-kernel.
> >
> > For the sake of sanity of the distributions which already carry exfat-
> > utils based on fuse (https://protect2.fireeye.com/url?k=20c6da2a-7d5874b0-
> > 20c75165-0cc47a336fae-
> > 6943064efcd15854&q=1&u=https%3A%2F%2Fgithub.com%2Frelan%2Fexfat), would it
> > be possible to either change the name of the project to say exfat-progs or
> > increase the version number to beyond 1.4?
> >
> > exfat-progs is more in line with xfsprogs, btrfsprogs or e2fsprogs :)
> Oh, I see. I agree to rename to exfat-progs. I will work to release version
> 1.0.2 with that name.
> Thank you for your opinion!
>

Hi,

this Monday I started testing Linux v5.7-rc1 with CONFIG_EXFAT_FS=m
together with LLVM/Clang v10.

Here I am on Debian/testing AMD64 and wondered how I can do some testing.

In the Debian repositories I found exfat-utils 1.3.0-1.

So good to know this is the wrong user-space tools :-).

+1 for renaming to exfat-progs.

How does someone test EXFAT filesystem with Linux v5.7-rc1?
I know that xfs-progs ships tests also for EXT4 filesystem.

Thanks in advance.

Regards,
- Sedat -
