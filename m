Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4652207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejILNa5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJJyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so5273069wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS74RW3R7oVrVUcdeGz+IwEJ/hodNEH2pQb2ItCjHlw=;
        b=ejILNa5rnxbthqxA80AceNynfoEltSRLhAzv3sLbCnMZ3ljvh7YG1dB3RObjmrMZB0
         Ybjqg1o+Y/+eMN7Vf24D9gGIJpgdEw+TFrvoDAazs/6Coh5Jps3SyomJ3lzbnBh9lyax
         nG821Fpjz5ip2XIC7uXG5jccFddLtu6mJf8kf5pvRPndMhvu4ksp58uFqDhMRhoDaQcF
         GEmiLMiQkFMlVW7t1iAvXORhIzwFsU7/NgF0Lx39EaJFJkaqQ22KxIIWerrLHemTpf7y
         hrKNIVRKjOGjRKgUFUdV7SPxZFkaPhDGTTNjKSP0n0OPp01RKahEH5DXfjhieLQ4d9RY
         eqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS74RW3R7oVrVUcdeGz+IwEJ/hodNEH2pQb2ItCjHlw=;
        b=WF9u4hg7p2kYy52O6DkMNL3PSCGArhQIJbkGENjOlX+078PstcvxBjik/HrdWTO0Ge
         aXXwsr7vJZvWb9wqilbYUT3lFgZ5jWBf7kocqF2wj7q+XdtwW8GhUgGDjAVL+suRwO4b
         whPV4JZKwnYKZLeHw08xXWd0g19fMAfl8wKMw69kwWXsJVH49m35nf306TWcsXlgQKUF
         aWQ7Wxu/eaSoGGjC7DGwTQ7DfUh4wVrqt3PnR9TYE4Pcao+oqg90qY/e6T4Be8/okb6k
         lsae6cjlCLOQW3uRaI6A44JPFB8jqmfMj76I521yHy9n1AkZhA+Er6uJoxRFYy2Rk7bs
         eXLA==
X-Gm-Message-State: AOAM532HjbP/vEGr+g9h8/DGWgq5uMoIHP9PTZbU2MQLVS6nvNKRNa98
        m6kVohDybmw6Gk9DhB/5m3o=
X-Google-Smtp-Source: ABdhPJzrC/ZiUbGKpJ84xvjFBKwLntuX+nYt1kRH1Pkpr10cGiOjqiIDkFm8v2CTnAcrKHwkKQMaCA==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr4620435wma.90.1594374852364;
        Fri, 10 Jul 2020 02:54:12 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:11 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
Date:   Fri, 10 Jul 2020 11:53:55 +0200
Message-Id: <20200710095409.407087-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie cleans and adds regulator support to Panfrost devfreq.
This is mostly based on comment for the freshly introduced lima
devfreq.

We need to add regulator support because on Allwinner the GPU OPP
table defines both frequencies and voltages.

First patches [01-07] should not change the actual behavior
and introduce a proper panfrost_devfreq struct.

Regards,
Clément

Changes since v4:
 - Fix missed a pfdev to &pfdev->devfreq during rebase

Changes since v3:
 - Collect Steven Price reviewed-by tags
 - Rebase on next/master (next-20200709)

Changes since v2:
 - Collect Alyssa Rosenzweig reviewed-by tags
 - Fix opp_set_regulator before adding opp_table (introduce in v2)
 - Call err_fini in case opp_add_table failed

Changes since v1:
 - Collect Steven Price reviewed-by tags
 - Fix spinlock comment
 - Drop OPP clock-name patch
 - Drop device_property_test patch
 - Add rename error labels patch

Clément Péron (14):
  drm/panfrost: avoid static declaration
  drm/panfrost: clean headers in devfreq
  drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
  drm/panfrost: introduce panfrost_devfreq struct
  drm/panfrost: use spinlock instead of atomic
  drm/panfrost: properly handle error in probe
  drm/panfrost: rename error labels in device_init
  drm/panfrost: move devfreq_init()/fini() in device
  drm/panfrost: dynamically alloc regulators
  drm/panfrost: add regulators to devfreq
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
  [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 ++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 175 ++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 ++-
 drivers/gpu/drm/panfrost/panfrost_device.c    |  61 +++---
 drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
 drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
 9 files changed, 296 insertions(+), 113 deletions(-)

-- 
2.25.1

