Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA72C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C84524680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="odywUUL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBZNxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:53:14 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:43824 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBZNxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:53:05 -0500
IronPort-SDR: ISfsMgCWeWjvN2iZ3+pfRkjPUKan5APG+oMT76BKGRI6RTXjQnVMWwYfE29j1MT/vIyZRKkVAu
 dHGD+tDS0tZS96apxr9OWRISjKx6wLMKuHcJDybMtGUHRRhSTcieuxcstn3hhwg6zNK/31K3Mi
 FbR3hviz45NuZkMzc3cZqxMAYZMwe/nnf3g+LtTqDFSZP+risLSp5aelNRL5ZCP4Cg0d+lIurq
 pHn/HtavGVh2rNMkmG9FsPSsMG3uHsZrXmXR6UBhhFVdthBaBus7ptLCjgHka5dAX8SR1dA8NJ
 8yE=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120526"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 14:53:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 14:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582725181; x=1614261181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SzRL5kRe5cM/H4qXOfBupWMALk8ewz0iGV4icrcKX+M=;
  b=odywUUL4YkUecHNmFcVmwF127Z49Cptdyy42ISIHoFmpMZDA/GuqCNCU
   afpnQjbXT9IWQ8Nd+1cvu/7FwDDn9Zy0G+LtpKNWd7D6+UZZ8XAw+LuCW
   kjjTMgQfvEdeiZYLOF6dSlNi2/CY2pUmW9ZgiHWPQY9EKDV0QHGX2C7+2
   RxQL7C+vvCt6F5s4Nj81KRZQ0/gHhkEVFoU3BqhmohRsC3Cc3u0mtZhds
   pOzOu6XLe8DtcInRCDmPqdTfT4rf3VpO47luP+vBvk4NWXcaPCPMe6wm0
   T7bnmuzs/tVMmOwSabaTYjkYOknV/3xM/OTm8M1qzA4Xa7AwIf9SmTmyV
   g==;
IronPort-SDR: 0os0INSCuSvWQx3sERMVBzLvQD9YuTMXBt9d68pReAgoDAsRQOY07zrSMuatGi36uM5xgQUeMd
 PBedhtm2A/gjssh1AMAoY6mwD/EwnmtfHCZ+AMFz7051wVA5M9es80l20SlSul+ao9fx1wqtFr
 t/X86WNdOXniz97wgwHL9uuCZoDjiSYuP3LTWo81nYDYqQv/kSWbAEEjNMwSe0R0GONFLZ+5sP
 UjbpBSmvmwUjjIITrYg4JVD61I5IWR3ScYaH+vFK/18Ao36ktVisi9AIbMyuFhT+V0qL3hRtHs
 qqw=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120525"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5C738280078;
        Wed, 26 Feb 2020 14:53:08 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/4] pwm: pca9685: initialize all LED registers during probe
Date:   Wed, 26 Feb 2020 14:52:28 +0100
Message-Id: <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize all ON delays to 0 during probe, rather than doing it in
pca9685_pwm_enable.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 393ab92aa945..370691b21107 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	/*
-	 * The PWM subsystem does not support a pre-delay.
-	 * So, set the ON-timeout to 0
-	 */
-	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
-	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
-
 	/*
 	 * Clear the full-off bit.
 	 * It has precedence over the others and must be off.
@@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
 
+	/*
+	 * The PWM subsystem does not support a pre-delay.
+	 * So, set the ON-timeout to 0
+	 */
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+
 	pca->chip.ops = &pca9685_pwm_ops;
 	pca->chip.npwm = PCA9685_MAXCHAN;
 
-- 
2.17.1

