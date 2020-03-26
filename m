Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B54C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWORKdbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgCZMFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:05:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46653 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgCZMFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:05:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so6044164ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nNaB9xpgft76kVOrndKIt++4NZQfhxGTzqRhmjvGb4=;
        b=XWORKdbfk4/82GG2LMt8cw1STtFxI/ISwgvMyK9Jh8wthi51e4JxXSTZ0TJt5vpjBh
         cO4sttEFEr4uECjeU0J+ooDJoDMx6wLr3W20rvJAV38zSVRH5O9uOVghjhyrb3y5wFFG
         ilIYGxdeDyUMNNlr6MS/q/1gVYPChOTiPj8C+eqRP3RXb5i1iGN9COC/whQnMn5vK/tS
         CVE7dMk0B9XObUIEAgeGtTVCRMlctuW8IkjDv7F1NSZ2zxdQKIRsbTsZAxY7DkXQt1Qw
         IlWCh6R+pjDQfAdEcNyKTQn3orSJ8spu7mBrhwkAIwQ+ke5fQZRV+HgzJwsp8srg4GKA
         Xa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nNaB9xpgft76kVOrndKIt++4NZQfhxGTzqRhmjvGb4=;
        b=WRJ5X3rbOzpfFZrSbb/1juosyFBp4iTfptZUoE5jIc70LBQJJn0GOfNxOHASeRNni6
         6pup8x8VckVK1ssZ/Oqd6OajZwfQu4h7awX+hP3nL28+F+GixofWIAFpIt1gQNVjHoGr
         63jm60aaqMBiV/S7RLDcf1F/3Iahe3gkIsbiKj6CDfYXgcNL8EPO8/woCUbjGZiSYde3
         9lxbYRyk/4TY9nXxtCOmqP0CC6yRmJlRnDwUahoEO5jdYr4uQdEG/yzx8LfRYiJjAjCp
         +U0y5rZiLqvT1uhmeHLf+WwAptJ9rhr45by1qvsuPKRtVVKIahgNDguIWkZvtFjzVlU5
         rRaA==
X-Gm-Message-State: ANhLgQ3m7rNQvWRHlrLaub7iFkWdG2zWjn+igTTMC5eyqy1VHsBya0cL
        1IQA0GDjoGGhlRUYSs4ftF0rXbwRULv3uoHgnco6Xg==
X-Google-Smtp-Source: APiQypKOfvEhGwJX5+841/969FmwKYQ7PXm91S/4oiS1EpNSe8epGsQl/snZwjFZRDTJT3zfulTzEHZLNqv043QbqsY=
X-Received: by 2002:a2e:730e:: with SMTP id o14mr4992253ljc.273.1585224342806;
 Thu, 26 Mar 2020 05:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200326205025.7cdf0d4e@canb.auug.org.au>
In-Reply-To: <20200326205025.7cdf0d4e@canb.auug.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Mar 2020 13:05:31 +0100
Message-ID: <CADYN=9+u3NY8MES7GihA1o_E0OdpRFtBDRBs5dxb4VeDoWO4+A@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 26
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        enric.balletbo@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 10:50, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Changes since 20200325:
>
> The net-next tree gained a conflict against the net tree.
>
> The input tree still had its build failure for which I disabled a driver.
>
> The tip tree gained a semantic conflict against the battery tree.
>
> The irqchip tree still had its build failure for which I reverted
> 2 commits.
>
> The rcu tree gained a conflict against the spdx tree.
>
> The kvm tree gained a conflict against the spdx tree.
>
> The drivers-x86 tree gained a conflict against the tip tree.
>
> The akpm tree lost a patch that turned up elsewhere.
>
> Non-merge commits (relative to Linus' tree): 10806
>  9415 files changed, 417170 insertions(+), 204705 deletions(-)
>
> ----------------------------------------------------------------------------
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
>
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig and htmldocs. And finally, a simple boot test
> of the powerpc pseries_le_defconfig kernel in qemu (with and without
> kvm enabled).
>
> Below is a summary of the state of the merge.
>
> I am currently merging 316 trees (counting Linus' and 78 trees of bug
> fix patches pending for the current merge release).
>
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
>
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
>
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.

When building todays tag on arm64 I see this error, CONFIG_DRM_MEDIATEK=m

ERROR: modpost: "mtk_mmsys_ddp_disconnect"
[drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!
ERROR: modpost: "mtk_mmsys_ddp_connect"
[drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!
make[2]: *** [../scripts/Makefile.modpost:94: __modpost] Error 1
make[1]: *** [/linux/Makefile:1299: modules] Error 2
make: *** [Makefile:180: sub-make] Error 2

I think this is the problematic patch:
396c3fccaf03 ("soc / drm: mediatek: Move routing control to mmsys device")

Cheers,
Anders
