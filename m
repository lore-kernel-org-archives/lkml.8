Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA76C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9B21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZyYM17G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIGIHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:07:52 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:43205 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgIGIFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:05:43 -0400
IronPort-SDR: u+T+QGwwWyG+BrlmfThsZjXBa77iQ383OzimWtt5FvUDvqRSJcR6sF2ssX2I6WBxyggATIcvVo
 aim6v9Z+iodBcJMEtj7VnSCbOgjpbinc+Cwtk6S+fSg+8XGjL4O3hPtzlsJ5g4hkml8sL1sXZZ
 LxKB/xWJYrWLIzUM1JA0Jax7PAiXMVHZoRNIhvRNs+FW/eXIi053htRyNGJvLxreYRdM0UmMtQ
 4LY0wi65OI/cnjEFbbhAjJJE3djMi+3ctfVPj2bepIGq2JG/0c48sInT2TbsPuwElDjwO614Wc
 DCY=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750638"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Sep 2020 10:04:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Sep 2020 10:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599465890; x=1631001890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UU4gx9FJhlA+He8aLQ485OrFfVM+zBRiE+ae1YhHj1A=;
  b=ZyYM17G8XuwrsH4A6Ya17tIqL5xFoHGHBU7L/G3iI2t906oikWjp4LmQ
   GqCuJVpn3T3lawRPY2rl75NRxdrGJgws5pWL4rD1r1DaLoDvMA6bsZokm
   LeJ/czdYO6e5X90624l8rvfr3g49pOK74fHF3Vpsmvs8rLve+SBnelznJ
   0w3+FAWvvJyYuC/Qzc+V4hgf9NmoitpwkzA21ua4Pd+G5tAJZav76bVKn
   haCLJoPIph2JzKqeaYuWXiEEekDo0MjKhz4Wkh/J4rYFF+xtvlTYUn28m
   0z6x6f7Q3DPOxiq826Q0z6AHLFyJ+5GfYvcC6WhjrWP5IYQTQsQhu9s+q
   g==;
IronPort-SDR: vF5dzN6hNPyGujtXtLGYOF+jHxKv4rm0C2ebxGkJc/8R9wHzTkNaO1hd9Od6oStlpaMqrS9FcB
 HE17a5IQaAJqjF92luxive6wUmquIstRLVJUyDC+18+5mKQ8C1wJJeCqBAADtbWu1ZqHkVAfFh
 b/LoX4xSqFRKQVGdzvffWNv1+G0UKUcSunB3OPrUmodpRrEzJkNxdgHy+9ErIooOlBLSJ+2Hq/
 5oNa9X0IJarsql1DrB3lMrk7RwQYiXcYtciJPzBdBUgyqui6OgM9+Sfa+sQxHd+0QZbNKoG64g
 Zpg=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750637"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.134])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 76014280075;
        Mon,  7 Sep 2020 10:04:50 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 2/3] ARM: dts: imx6qdl: tqma6: remove obsolete fsl,spi-num-chipselects
Date:   Mon,  7 Sep 2020 10:04:28 +0200
Message-Id: <20200907080429.12496-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
References: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is unneeded and not supported by the spi-imx driver.

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v3: split patch
v2: drop fsl,spi-num-chipselects instead of replacing with num-cs

 arch/arm/boot/dts/imx6qdl-tqma6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
index 9513020ddd1a..b18b83ac6aee 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
@@ -20,7 +20,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
-- 
2.17.1

