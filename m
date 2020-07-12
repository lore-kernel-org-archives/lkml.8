Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123FBC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6F6206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ODYDIG6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgGLKBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:01:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6978 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgGLKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:01:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0adf710000>; Sun, 12 Jul 2020 03:01:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:01:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 03:01:33 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:01:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:01:33 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0adf790002>; Sun, 12 Jul 2020 03:01:30 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 0/5] firmware: tegra: Add support for in-band debug
Date:   Sun, 12 Jul 2020 11:01:13 +0100
Message-ID: <20200712100118.13343-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594548081; bh=+jY3sJOmqnyPuEmR9hc/hgEIM+Ez0HGj1wsMbzX4gWI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ODYDIG6U8RKv+pho4SfRk4LbJeC2WnpZhFXR240FcTJ29LB4iEqSFLnGTDXWExnC1
         5pUlafLZjGZnXqdk5DNvO3hrCvxEpuJjGN60FbsRSWqxcakXaXnSSd4OurnAiFmIbw
         WMnIZHI5pHTZ2CQUoIkHr8+S+iBrr1gtlwzmeObR/2DoQUqzkww42aNFhoYrSthS1y
         1uef/jvJnjo8TWuVHD0svxd1YgTRDc44bL7rwp6j1SmDHbUX410fkDbHj/8qTmtO5m
         GA4n0kle+coTCDhl4fUY1duNw6PcsPji2SfSdS1hEmRusiv6lKqTnay4+9YQnfVSrG
         7Hb7IEa4mGcPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for in-band debug messaging for the BPMP and
updates the BPMP ABI to align with the latest version.

Jon Hunter (4):
  firmware: tegra: Use consistent return variable name
  firmware: tegra: Prepare for supporting in-band debugfs
  firmware: tegra: Add support for in-band debug
  firmware: tegra: Update BPMP ABI

Timo Alho (1):
  firmware: tegra: add return code checks and increase debugfs size

 drivers/firmware/tegra/bpmp-debugfs.c | 436 ++++++++++--
 drivers/firmware/tegra/bpmp.c         |   6 +-
 include/soc/tegra/bpmp-abi.h          | 913 ++++++++++++++++++--------
 3 files changed, 1038 insertions(+), 317 deletions(-)

-- 
2.17.1

