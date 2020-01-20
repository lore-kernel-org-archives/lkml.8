Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FEC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156720678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fUMb/4Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgATOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:23:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6897 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgATOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:23:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e25b7dc0000>; Mon, 20 Jan 2020 06:23:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jan 2020 06:23:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 20 Jan 2020 06:23:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 14:23:39 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jan 2020 14:23:39 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e25b7e60001>; Mon, 20 Jan 2020 06:23:38 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/9] add ASoC components for AHUB
Date:   Mon, 20 Jan 2020 19:53:09 +0530
Message-ID: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579530205; bh=sVGMvsXJQ6JsuBd+PLRFpAWsDnTvG1rYsC5JQVaB0T0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=fUMb/4YbwZ0XTAeUPWMxqWnKINkn07UBCoCAAjLbdFdLFrJ5Jm9zRfIfZSjVNCNCU
         eVamqwNt3pIWN+uQaVHh1SQeqbc12KoElR5pQAJnBN4Z8+EMtKC41EbiC/zULCX7YM
         2FU6AWMZ/F0PHdqEHDBo+sdZ9k3NCmw52Jcoi+wkoG3RNybVvXJz7sawD6sJUiO+db
         9mSzlMOwOi7JUE2ojTH4j7IG0AWGEXLNZS7iOlKa39yniu050LP4zLu9EawIJ4Bxx9
         /s1Zh+pvHIuD96ZgtF4Z/y+GtLHC6FlXbY1TlP9hfa0u3RsoaAZ/ad8sJj+xwuIpNi
         FExgsPGoVqj+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overview
========
The Audio Hub (AHUB) is part of the Audio Processing Engine (APE) which
comprises a collection of hardware accelerators for audio pre-processing
and post-processing. It also includes a programmable full crossbar for
routing audio data across these accelerators.

This series exposes some of these below mentioned HW devices as ASoC
components for Tegra platforms from Tegra210 onwards.
 * ADMAIF : The interface between ADMA and AHUB
 * XBAR   : Crossbar for routing audio samples across various modules
 * I2S    : Inter-IC Sound Controller
 * DMIC   : Digital Microphone
 * DSPK   : Digital Speaker

Following is the summary of current series.
 1. Add YAML DT binding documentation for above mentioned modules.
 2. ACIF programming is same for Tegra generations and hence it is moved
    to a common file.
 3. Add ASoC driver components for each of the above modules.
 4. Add DT entries for above components for Tegra210, Tegra186 and
    Tegra194.
 5. Enable these components for Jetson-Tx1, Jetson-Tx2 and
    Jetson-Xavier.

Machine driver series will be sent separately.

Sameer Pujar (9):
  dt-bindings: sound: tegra: add DT binding for AHUB
  ASoC: tegra: add support for CIF programming
  ASoC: tegra: add Tegra210 based DMIC driver
  ASoC: tegra: add Tegra210 based I2S driver
  ASoC: tegra: add Tegra210 based AHUB driver
  ASoC: tegra: add Tegra186 based DSPK driver
  ASoC: tegra: add Tegra210 based ADMAIF driver
  arm64: tegra: add AHUB components for few Tegra chips
  arm64: tegra: enable AHUB modules for few Tegra chips

 .../bindings/sound/nvidia,tegra186-dspk.yaml       | 105 +++
 .../bindings/sound/nvidia,tegra210-admaif.yaml     | 165 ++++
 .../bindings/sound/nvidia,tegra210-ahub.yaml       | 130 +++
 .../bindings/sound/nvidia,tegra210-dmic.yaml       | 105 +++
 .../bindings/sound/nvidia,tegra210-i2s.yaml        | 112 +++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  48 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 231 ++++-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  36 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 239 +++++-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  40 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 145 ++++
 sound/soc/tegra/Kconfig                            |  56 ++
 sound/soc/tegra/Makefile                           |  12 +
 sound/soc/tegra/tegra186_dspk.c                    | 516 +++++++++++
 sound/soc/tegra/tegra186_dspk.h                    |  73 ++
 sound/soc/tegra/tegra210_admaif.c                  | 896 ++++++++++++++++++++
 sound/soc/tegra/tegra210_admaif.h                  | 164 ++++
 sound/soc/tegra/tegra210_ahub.c                    | 667 +++++++++++++++
 sound/soc/tegra/tegra210_ahub.h                    | 125 +++
 sound/soc/tegra/tegra210_dmic.c                    | 522 ++++++++++++
 sound/soc/tegra/tegra210_dmic.h                    |  85 ++
 sound/soc/tegra/tegra210_i2s.c                     | 941 +++++++++++++++++++++
 sound/soc/tegra/tegra210_i2s.h                     | 132 +++
 sound/soc/tegra/tegra30_ahub.c                     |  94 +-
 sound/soc/tegra/tegra30_ahub.h                     | 129 ---
 sound/soc/tegra/tegra30_i2s.c                      |  35 +-
 sound/soc/tegra/tegra30_i2s.h                      |   7 -
 sound/soc/tegra/tegra_cif.c                        |  34 +
 sound/soc/tegra/tegra_cif.h                        |  50 ++
 sound/soc/tegra/tegra_pcm.c                        | 224 ++++-
 sound/soc/tegra/tegra_pcm.h                        |  23 +-
 31 files changed, 5897 insertions(+), 244 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
 create mode 100644 sound/soc/tegra/tegra186_dspk.c
 create mode 100644 sound/soc/tegra/tegra186_dspk.h
 create mode 100644 sound/soc/tegra/tegra210_admaif.c
 create mode 100644 sound/soc/tegra/tegra210_admaif.h
 create mode 100644 sound/soc/tegra/tegra210_ahub.c
 create mode 100644 sound/soc/tegra/tegra210_ahub.h
 create mode 100644 sound/soc/tegra/tegra210_dmic.c
 create mode 100644 sound/soc/tegra/tegra210_dmic.h
 create mode 100644 sound/soc/tegra/tegra210_i2s.c
 create mode 100644 sound/soc/tegra/tegra210_i2s.h
 create mode 100644 sound/soc/tegra/tegra_cif.c
 create mode 100644 sound/soc/tegra/tegra_cif.h

-- 
2.7.4

