Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C9C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE37246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f77OMoHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgARRCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:02:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgARRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:02:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so25591207wru.4;
        Sat, 18 Jan 2020 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVdKI4qzpgYXt1ARI5Pkn0qMmMdORH3SJ+ruk4Mge5o=;
        b=f77OMoHUjuk/UxCeuv2xlrDIqAhVEcRmw9pCin/HRcvWEDTgjP4u499mvyYNlrNR5J
         cS0o0sQxngEGmSZF8AzszGBfbAb/J05Z3ns0kIJCGIn3D+3ZoZGQDtViYb7/80dDZjXS
         qn0udBTgAS0qLBwX9GN+PQREKhRTCtRgFOCEjnRLUnqyKl7QVi7y5CvcqzmWhKAO01y4
         TdBtIXzYFI3ZzIVzKaH05cnkR3pGtlhqYEK4nC7mvzstWxQbaqTytXmCOUqqaGYEIPhW
         8rqavzR/ddSGCOqPfKawroyiz6VlJYjaS8MUdM5uh+c7G9R/LZLC70vuwEsvioEvgnIu
         kJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVdKI4qzpgYXt1ARI5Pkn0qMmMdORH3SJ+ruk4Mge5o=;
        b=pN6n7/s8UIgAjk9yhDd0kJ2l7SucrktfqEUSdd9Gj31OIJvl29CQgZ8DySHoBQlvK3
         ka1PzHYmnZAfNxTOnMeHD5HEVx6mq0TtN3CxstCGIiYvg6M3yeKMFt0fV21AWZ1fRPvN
         2L4WbdARSeufBRADo8vF8FBP8es0BDDNVVmBpKIL0B81ANscBZLgICdoie+tnSBB2k6a
         EvfkR30S764LvIfsmkIgqDOghFYGvlZV0/G83aFMf8CVu0rFbu8cda4nz7lOpmQwPXZN
         dwvY4HFKjpavyOWULhvMC6QmmHv1mlPhnB4PeOlpPmT1fNwYUPXyOia/I0rYP7CE+cDB
         AtMA==
X-Gm-Message-State: APjAAAVOzU7ueLRp/b+sAT3kP37yqvbgWXL7wHhEX8D6BY5PHqFmxVyB
        +6ULXl+KjzuHb/cIyaL40Ts=
X-Google-Smtp-Source: APXvYqz7ImU2NwQQn0UM/ohkl4agpIr6kw0ptBWP3KlQk0db+EE5ZP41NsqYzOa2Lw+G5Pps7GjwVg==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr9197083wrr.215.1579366935977;
        Sat, 18 Jan 2020 09:02:15 -0800 (PST)
Received: from localhost.localdomain (abag109.neoplus.adsl.tpnet.pl. [83.6.170.109])
        by smtp.googlemail.com with ESMTPSA id j12sm39896087wrt.55.2020.01.18.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:02:15 -0800 (PST)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: qcom: msm8974-honami: Add USB node.
Date:   Sat, 18 Jan 2020 17:55:18 +0100
Message-Id: <20200118165518.36036-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exact node has been included in Amami DTS
ever since 2017, turns out it works perfectly
fine with Honami, as tested with postmarketOS.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../dts/qcom-msm8974-sony-xperia-honami.dts   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 450b8321e0a6..611bae9fe66b 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -260,6 +260,31 @@ l24 {
 };
 
 &soc {
+	usb@f9a55000 {
+		status = "ok";
+
+		phys = <&usb_hs1_phy>;
+		phy-select = <&tcsr 0xb000 0>;
+		extcon = <&smbb>, <&usb_id>;
+		vbus-supply = <&chg_otg>;
+
+		hnp-disable;
+		srp-disable;
+		adp-disable;
+
+		ulpi {
+			phy@a {
+				status = "ok";
+
+				v1p8-supply = <&pm8941_l6>;
+				v3p3-supply = <&pm8941_l24>;
+
+				extcon = <&smbb>;
+				qcom,init-seq = /bits/ 8 <0x1 0x64>;
+			};
+		};
+	};
+
 	sdhci@f9824900 {
 		status = "ok";
 
-- 
2.24.1

