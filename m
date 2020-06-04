Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B4D206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VP+7o3gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgFDRjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:39:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39616 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729998AbgFDRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:39:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CD24A40030;
        Thu,  4 Jun 2020 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591292391; bh=BOUD1okbFsKFgS4cJO7HwMo5yaVDRq1gtmBar4MecC4=;
        h=From:To:Cc:Subject:Date:From;
        b=VP+7o3gYWKNyuGlJmZaKb49L+qgki/pR6R9weR24jXo9XxKtAILnITJ9P1WD1mgnl
         hBzFdKP86TzvwyeRZF0fGuKESNM6OoY1w27vKkyK+XHA1zinoOjZDyfswPtXALFT8w
         hz2r/P8gcOPMhCOqNY+TRgGT1OIzK2h2bQngLKCGTOQp3jMe1Fsa4KJKTfhEWsx8PU
         KGOGtRyPqI5g+EH9Tzazownz9bvR7XFwOq91slaG2lfBvzd5VriejkjwwE7i1BVu/c
         jtpv5fT0CxwhhlHwZe3kmkGkiCiSqbOjme6uYHt2cTasmekNsfulT70ZROujS7wT4h
         cj5Ud5FPnBr0Q==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.49.234])
        by mailhost.synopsys.com (Postfix) with ESMTP id 94592A005C;
        Thu,  4 Jun 2020 17:39:44 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/4] ARC: [plat-hsdk-4xd] initial port for HSDK-4xD board
Date:   Thu,  4 Jun 2020 20:39:23 +0300
Message-Id: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v1->v2:
 * Fallback to ISA default mcpu flag if custom one isn't supported by
   compiler.
 * Drop HSDK custom Kconfig options (choose between HSDK and HSDK-4xD) as
   we don't need it (at least for now). Instead we select ARC_LPB_DISABLE
   for both boards but it's totally OK as HSDK doesn't have LPB so
   disabling will be skipped by BCR check in runtime.
 * Add missing HSDK-4xD device tree bindings. Convert HSDK device tree
   bindings to json-schema.

Eugeniy Paltsev (4):
  ARC: allow to override default mcpu compiler flag
  ARC: ARCv2: support loop buffer (LPB) disabling
  ARC: [plat-hsdk-4xd] initial port for HSDK-4xD board
  ARC: [plat-hsdk*] document HSDK-4xD board/SoC bindings

 .../devicetree/bindings/arc/hsdk.txt          |   7 -
 .../devicetree/bindings/arc/hsdk.yaml         |  26 ++
 arch/arc/Kconfig                              |  15 +
 arch/arc/Makefile                             |  21 +-
 arch/arc/boot/dts/hsdk-4xd.dts                | 322 ++++++++++++++++++
 arch/arc/configs/hsdk_4xd_defconfig           |  98 ++++++
 arch/arc/kernel/devtree.c                     |   1 +
 arch/arc/kernel/head.S                        |   8 +
 arch/arc/plat-hsdk/Kconfig                    |   3 +-
 arch/arc/plat-hsdk/platform.c                 |   1 +
 10 files changed, 492 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arc/hsdk.txt
 create mode 100644 Documentation/devicetree/bindings/arc/hsdk.yaml
 create mode 100644 arch/arc/boot/dts/hsdk-4xd.dts
 create mode 100644 arch/arc/configs/hsdk_4xd_defconfig

-- 
2.21.3

