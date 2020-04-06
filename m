Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F9C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FDA206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1M5oJ3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDFLAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:00:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33026 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgDFLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:00:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so6927621lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxopcs2TULMnqy9F8WEV0bdgNBrNp58ORmPnzPaTfFs=;
        b=y1M5oJ3Utzf2ol3jjghz/S+YPN8tidN0SnBCLeLcgJYlfB6awxhlVPJuck86wz6RzB
         SsbuZ20qJ5UyLeM7yJC5qalSj8zanv441z2agyFzJ7Z4AVLjTyp41yaW8JgRspGRngyn
         2QgSGGSz2yTXr/dFfd9ebmMHfXgBXXEfVcAfsBxSEaDz1ZZY2XLsZ1DpCz9Ty/gs56J7
         Z1qdzX1BToTL4Z1QJ0Z5X6bDPsryiTvtDbUV5HH6ZKX5gW5nX45vHBtGzYHrHaEXPycK
         vO9ZcgP32VRnOJjjTccTOL0BWX+TMbXAD/9sQPr2FbZfCgquTOqlk+HaUedMR2eQib+a
         hPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxopcs2TULMnqy9F8WEV0bdgNBrNp58ORmPnzPaTfFs=;
        b=BoLKrQE6pxGNC+j29/vvCec8pXE/9izbCn94WGbbW3gsdl4LKTM655zm4N4Zm6o/9/
         pM14zR+qwbEUV2dSA1gsRpnK33xxa8jMnq2cpqq1ZopXkdLZ2oYjTm1XcAywcIkXfp0f
         DctmsgloerJM4nSEFoF/87wde5VCUt4P6seKES+VBknHtwBVe/JG/BTHfgHRn6PzAfWn
         KBGA+x9vdj4f6l+RrlqS3WaNF4rYrExV6LH2uNGgMzeu89JirQ6LN6acWqrcNeZlyFWX
         0Eggj1xo3pqKKZCFk4uG1Zj5cUcCcQnVZCfcyw79ZmwrlzJXgWLF/En3iL02JJn8pCI5
         ZL9g==
X-Gm-Message-State: AGi0PubcfP/x2oUA9i2bI47Wtcv1PR0iktXJ7lTMVZuTEUvhNcMIRD+U
        oBKBSU7L2/pYOEfcjHR8q9Ep4kceSxnWx9ymQ4w/yg==
X-Google-Smtp-Source: APiQypLZx4lGfRvdM1iN8xH3oMXlCylKvoscHREtWVAlwfQ+t5ekB/8oqyPtv7CIXY68xdfCvvFTPf7GlB6K8F+uj54=
X-Received: by 2002:ac2:44c6:: with SMTP id d6mr9164020lfm.26.1586170842336;
 Mon, 06 Apr 2020 04:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200405234639.AU1f3x3Xg%akpm@linux-foundation.org> <CA+G9fYsUsGS6ybozk3A=8aG5VFpF-+DJGNAim4o=Xi9CB43tDA@mail.gmail.com>
In-Reply-To: <CA+G9fYsUsGS6ybozk3A=8aG5VFpF-+DJGNAim4o=Xi9CB43tDA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Apr 2020 16:30:29 +0530
Message-ID: <CA+G9fYssZg-BZSe3_m4NpiVE1-RYsOR_Fpm2i1JT6uGTphaheg@mail.gmail.com>
Subject: Re: mmotm 2020-04-05-16-45 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 6 Apr 2020 at 05:16, <akpm@linux-foundation.org> wrote:
> >
> > The mm-of-the-moment snapshot 2020-04-05-16-45 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> >
> > This tree is partially included in linux-next.  To see which patches are
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> > linux-next.
> >
> >
> > A full copy of the full kernel tree with the linux-next and mmotm patches
> > already applied is available through git within an hour of the mmotm
> > release.  Individual mmotm releases are tagged.  The master branch always
> > points to the latest release, so it's constantly rebasing.
> >
> >         https://github.com/hnaz/linux-mm
> >
> > The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> > contains daily snapshots of the -mm tree.  It is updated more frequently
> > than mmotm, and is untested.
> >
> > A git copy of this tree is also available at
> >
> >         https://github.com/hnaz/linux-mm
> >
> >
> >
> > This mmotm tree contains the following patches against 5.6:
> > (patches marked "*" will be included in linux-next)
> >
> >   origin.patch
> <>
> > * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma.patch
> > * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix.patch
> > * mm-hugetlb-optionally-allocate-gigantic-hugepages-using-cma-fix-2.patch
>
> While building Linux-next master for arm beagle board x15 the following
> build error was noticed.
>
> mm/hugetlb.c: In function 'hugetlb_cma_reserve':
> mm/hugetlb.c:5580:3: error: implicit declaration of function
> 'for_each_mem_pfn_range'; did you mean 'for_each_mem_range'?
> [-Werror=implicit-function-declaration]
>    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>    ^~~~~~~~~~~~~~~~~~~~~~
>    for_each_mem_range
> mm/hugetlb.c:5580:62: error: expected ';' before '{' token
>    for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>                                                               ^
>

Few more details about build test,

CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y

# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CMA is not set


Kernel config link,
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-mainline/2591/config

Build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/743/consoleText


> --
> Linaro LKFT
> https://lkft.linaro.org
