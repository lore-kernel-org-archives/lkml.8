Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050C9207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjJIiaMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgFEKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgFEKTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:19:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9710C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:19:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so11024693ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CTigQLcH21zASrooZtUJCCI769gjmdMorqb3ADmYSew=;
        b=PjJIiaMuWDrTyiji83bvizFhjhIEjVmMJrdmY9PN7RTa5u6HjBFeCbZch9aTPiZeNF
         ezgNRd2j3ufQhwJ271PQQ9u/SgZPRZc3/uAsSbqgtEYAvjqRqTltUQaFlJfUN9Lyoj1C
         niQftp+FqSTV5zTp2EIHge1gdmlAEGFPFBHmjeyRBsN5/EMVwlH23dNzundjIsaSsKFa
         HKgjwRj38l7+1PoypvSslZM+FyGSQPeX6vG4sxTtX8z/OCO21roX9z/rdDMRgvQsEn6V
         dKaDcXgmRHuoGUUoEUexHJTTVn90fUOkOe0khxLWX6T97gR1VkSZPfNJS1U8oIvfG/3f
         F+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CTigQLcH21zASrooZtUJCCI769gjmdMorqb3ADmYSew=;
        b=Ea3dfEXq/ngLx+eRSaDUthqvc8atM3pJ3CsipYu1BcVQqsvYKZ00Jc+xOaD4JKnAKC
         yr4dfhqilm/4q/ynPh4Lxj9hx2ZWWukFQAtesMo1qdFMqt4Z4VXl29Jcb1f6IPqJ1967
         AYRy0ylyFU/0yKcsWw9LENZehT8Tb7MpkiNF7ARcmzIhFTlwqe2YM9TD9rsr8+fUsVMA
         FnGAdNuGqllQ8G2yhkRfshxNDhfCO0+Ez6nhacYdWmmvCd25F0L4WA7E+KTfERue/xKz
         9YXgm1dd3QOFnGtDxtkhvB2XVhybXZFFNGK7Xu8mHzH3dRdGTDAjX3geAnXi86fdcgGA
         K2mw==
X-Gm-Message-State: AOAM531LVaYtupO769nLtQW5SRTeXzcy77r3Awzwlbko9qK5koGk5JVm
        ira1Ia0qi070HoDkK3MWTeFOtxl0nhcEHZjtZRndsA==
X-Google-Smtp-Source: ABdhPJzZNgLQN9r7B5iOHnsY1wkdfiAMQ/fIT+7mks77XrT7pWeatsV800ZrzB6/xqlbFEBE6l1kZW1ZP5oFnBsYYFI=
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr4744488lji.366.1591352359210;
 Fri, 05 Jun 2020 03:19:19 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Jun 2020 15:49:07 +0530
Message-ID: <CA+G9fYuj7ADfxs+-vY3Hbx5zPceYofCLFy1WRe=-w2_v_J7tSA@mail.gmail.com>
Subject: mainline: v4l2 modules missing Kconfigs
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     ": Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, robert.foss@linaro.org,
        stanimir.varbanov@linaro.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test v4l2-compliance modprobe-vivid failed

Test error,
VIDEO_DRIVER=vivid.ko
v4l2-existence-check pass
ln: failed to create symbolic link '/lib/modules/5.7.0+/' -> '': No
such file or directory
modprobe: FATAL: Module vivid not found in directory /lib/modules/5.7.0+
modprobe-vivid fail

The investigations shows that,
the following kernel configs are missing on latest mainline builds on
x86, i386 and arm64.
These are still found on arm config.

CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEO_V4L2_TPG=m

Please suggest the configs required for v4l2 testing.
and any additional test coverage.

We add V4L2 config fragments like this
# Vivid driver for V4L2 tests
CONFIG_VIDEO_VIVID=m
CONFIG_MEDIA_SUPPORT=y
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_DEV=y

git branch: master
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
GOOD:
   git commit: cb8e59cc87201af93dfbb6c3dccc8fcad72a09c2
   good config: https://builds.tuxbuild.com/600ssEELJrReeIBY_a4Ghw/kernel.config
BAD:
   git commit: 6929f71e46bdddbf1c4d67c2728648176c67c555
    bad config: https://builds.tuxbuild.com/2eAqpM2VDo7nnt8HXX2Org/kernel.config

Test ref:
https://lkft.validation.linaro.org/scheduler/job/1471386#L1310

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-8602-g15a2bc4dbb9c/testrun/2785598/suite/v4l2-compliance/test/modprobe-vivid/history/

- Naresh
