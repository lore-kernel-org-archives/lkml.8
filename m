Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEAC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2FA214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Vt4Sqwe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgHUHMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:12:16 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:14048 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgHUHMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:12:14 -0400
IronPort-SDR: 2D1en2nIaqpQD5WHCwkl5keNUKSx1Yg7WLkFEX+Jp+IudMxGs1H/g5cCp/jxcMacHgXvy977qn
 5g3ld4Rv8sGPCt/inLic2BkOVLqH70LdODaB2ptDpGVg13T61EzidU9QW3C6DvmrFHbpX2Zngh
 wSVeYWIXGeol0ckTAlkUHDCjLHhVEeQNW8peWblzM86/UMCaKAFTTJ3j1iwbl+kjsFJRNfSETg
 N4lh8O5r9BBLFmbAv+ZzOUyWz2Ya6kArXVgIQ2LdjiAiE5PTUGVhAM1FZUaEtYeQwUHYw7+fs7
 jJo=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="13549137"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Aug 2020 09:12:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 21 Aug 2020 09:12:11 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 21 Aug 2020 09:12:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1597993931; x=1629529931;
  h=from:to:cc:subject:date:message-id;
  bh=4C93rfTkYYAe6YpLxR8PaC5qgCxICWsqnPda3XOTLVU=;
  b=Vt4Sqwe3i0b2cyC3lAhzp2Yi+sqoXtYFC2sCdrTVy8gwY9CyEiL+Um5k
   uQAh5tqzqvc/VIz7efzO02RYLgv/rQ9LqIRcZqU9yvWwFIGGE0Y0uVjqe
   eeHAp8F3vAQXI/MAoYBmLuf7Jc4NG6Sv12voaIF7Adwd5q67FOE5zqyHJ
   c1wt0HK9Q+PnRxOJlrVn6I2EDnsnNv7boPbh/ENCzhYSp84Bdnovc+fU+
   lNGOPSuyQT7bAY5zTVU2MNVPv/7XM5OsmhxxP6QqbXtfAQcE3E8voGhDd
   Ah9qmNvgxe0PM7YWxrdT2pjcXpM7L456B/LhM67awZEsKtNRssxlEaur4
   Q==;
IronPort-SDR: 6LGTt+7iBWNLGsTYozLX6NjYOiV2bCMlsFeIRF2xdffJ9B+qK9CoDa1hEyGqnxS5Q7XWWYVf1P
 v7KRfyhftrSqG/neIJL821FYZLfCDPzGD9wpbq873juzofSBUp76oxRK3bssXI8m2fTfNJLt3i
 OOlRIXO5npr+Vfpsn5wWPnRzD9fwe+kxzQLDPS8f5KiKSFwvyRUdY7MAPMsWo5WtRMynRW3E7A
 0ySil2zYA546DRPRdhaamIo+uQJLKfLV474xZ2T1g5AJ5ZbssgzE4BdXP0f9nLfNRBi+ZZtDkI
 WlU=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="13549136"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Aug 2020 09:12:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 90C36280065;
        Fri, 21 Aug 2020 09:12:11 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: add compatible string for TLV320AIC32x4 codec
Date:   Fri, 21 Aug 2020 09:11:52 +0200
Message-Id: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 63ebf52b43e8..f339be62e7e4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -38,6 +38,8 @@ The compatible list for this generic sound card currently:
 
  "fsl,imx-audio-wm8524"
 
+ "fsl,imx-audio-tlv320aic32x4"
+
 Required properties:
 
   - compatible		: Contains one of entries in the compatible list.
-- 
2.17.1

