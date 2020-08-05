Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B28C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C428621744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ro/6ffDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHEFYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:24:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2517 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEFYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:24:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2a42380000>; Tue, 04 Aug 2020 22:23:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Aug 2020 22:24:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Aug 2020 22:24:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug
 2020 05:24:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Aug 2020 05:24:43 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2a42960001>; Tue, 04 Aug 2020 22:24:43 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 0/9] Audio graph card updates and usage with Tegra210 audio
Date:   Wed, 5 Aug 2020 10:54:15 +0530
Message-ID: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596604985; bh=CWBj8oIauDXITL+s1UE8s39WV9uyZ6M4V8QHcZkfTLg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ro/6ffDrclAOYPE6QTBDWBu0khham8wtMscTmNyvFK5CVasU9CJgvgQa94SJf6tqq
         SQqQqIdRdFoq48V2fpfhV9lmQ8c46lwg8KvDMnj58RBVY69zgFPqI/YKsU+mZWdqs4
         K7RB54E2WMDNrhkpvk430/QAdJNidJ1TClXJxsSNxYCetefyKN4ZA5jdsmd+3Y8kte
         b1Xpfc9cIAee8SQZCx2l5AXIH7fwt8kAXShB8kcIp5/IO557U1uX9TPrukGToT1lWr
         TJhSJOXxyBgss9vNMf/JeYyizz7k4JEI1b/eIKuf58OEeWl+j8AyW7zh3fxDU+yVcy
         keWdSlb8qkz5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes following enhancements to audio-graph card driver.
 * Support multiple instances of a component.
 * Support open platforms with empty Codec endpoint.
 * Identify no-pcm DPCM DAI links which can be used in BE<->BE connections.
 * Add new compatible to support DPCM based DAI chaining.

This pushes DT support for Tegra210 based platforms which uses audio-graph
card and above enhancements.

The series is based on following references where DPCM usgae for Tegra
Audio and simple-card driver proposal were discussed.
 * https://lkml.org/lkml/2020/4/30/519 (DPCM for Tegra)
 * https://lkml.org/lkml/2020/6/27/4 (simple-card driver)

Changelog
=========

v1 -> v2
--------
 * Re-organized ports/endpoints description for ADMAIF and XBAR.
   Updated DT patches accordingly.
 * After above change, multiple Codec endpoint support is not
   required and hence dropped for now. This will be considered
   separately if at all required in future.
 * Re-ordered patches in the series.

Sameer Pujar (9):
  ASoC: soc-core: Fix component name_prefix parsing
  ASoC: audio-graph: Use of_node and DAI for DPCM DAI link names
  ASoC: audio-graph: Identify 'no_pcm' DAI links for DPCM
  ASoC: soc-pcm: Get all BEs along DAPM path
  ASoC: dt-bindings: audio-graph-card: Support for component chaining
  ASoC: audio-graph: Add support for component chaining
  ASoC: audio-graph: Support empty Codec endpoint
  arm64: tegra: Audio graph header for Tegra210
  arm64: tegra: Audio graph sound card for Jetson Nano and TX1

 .../devicetree/bindings/sound/audio-graph-card.txt |   1 +
 .../boot/dts/nvidia/tegra210-audio-graph.dtsi      | 141 +++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 217 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 122 ++++++++++++
 include/sound/soc.h                                |   1 +
 sound/soc/generic/audio-graph-card.c               |  69 ++++++-
 sound/soc/soc-core.c                               |   3 +-
 sound/soc/soc-pcm.c                                |   3 +-
 8 files changed, 545 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-audio-graph.dtsi

-- 
2.7.4

