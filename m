Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A30C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B12207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599826854;
	bh=hRvZkeA5envDy3jhEryZBWbNL0TKkQVW9LyxnaBNgqQ=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ZgEr1t3QFxLQzlsyb7UmUWv7XpEte6Pt0hJMpWT91jmomTW+nY6QtSQclA23ffyyl
	 yvsn2z/9ndWl28fJghNlV7d9lceIdUd5naoEf9iFuuJWHzLLkeGqSoPCs0fjstN37i
	 c7iE2yLq2prceMqWLuHmJcoCAY2z07D7xtNLECO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgIKMUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgIKMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:16:50 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FDE22207;
        Fri, 11 Sep 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826608;
        bh=hRvZkeA5envDy3jhEryZBWbNL0TKkQVW9LyxnaBNgqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOnLxkIZSbj3z0FDLvaw1/7hm2GKZUM7rCnmALOdyRnjVrL/N8HlwqMpL0EDu6f+W
         xVkJ97yZymr3BSzlaUfa1tf0afl+9nTsGNOShQEi1fYFeO/YzdbjmCst9+2RlVvpIc
         H9A7tRUt7H6adXKWj/jeBNkXN0VwIzDIDE+WB1BU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGhyv-0006WH-W5; Fri, 11 Sep 2020 14:16:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 4/8] dts: phy: phy-hi3670-usb3.txt: use a consistent namespace
Date:   Fri, 11 Sep 2020 14:16:40 +0200
Message-Id: <f7832a577fc4b7d2f8459c1023f9782e43a9efb2.1599826421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599826421.git.mchehab+huawei@kernel.org>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this driver is not used yet, use a more consistent namespace,
similar to the PHY layer for Kirin 960 (hi3660).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
index 4cb02612ff23..2fb27cb8beaf 100644
--- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
@@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
 -----------------------
 
 Required properties:
-- compatible: should be "hisilicon,kirin970-usb-phy"
+- compatible: should be "hisilicon,hi3670-usb-phy"
 - #phy-cells: must be 0
 - hisilicon,pericrg-syscon: phandle of syscon used to control phy.
 - hisilicon,pctrl-syscon: phandle of syscon used to control phy.
@@ -14,7 +14,7 @@ Refer to phy/phy-bindings.txt for the generic PHY binding properties
 
 Example:
 	usb_phy: usbphy {
-		compatible = "hisilicon,kirin970-usb-phy";
+		compatible = "hisilicon,hi3670-usb-phy";
 		#phy-cells = <0>;
 		hisilicon,pericrg-syscon = <&crg_ctrl>;
 		hisilicon,pctrl-syscon = <&pctrl>;
-- 
2.26.2

