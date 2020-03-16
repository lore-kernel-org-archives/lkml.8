Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5985C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7D620679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc/KfyNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgCPRq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:46:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbgCPRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:46:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id h6so2029827wrs.6;
        Mon, 16 Mar 2020 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MLNLveD6L+cH6avKSQcqN3AiAJkE99e4WdFigQsP9tE=;
        b=cc/KfyNxH1udwLv/GxysgrFxyCGR7MoHAFg+yjnWH+XHZgkIHtu/ZXMhqn4hDjaf+Q
         +faD+0V+taSxrcG9GhVHBbhZEck94ccZ7kbmgImtmMSA/zcD13JfSP/pzNhSZObXvrUp
         j0KCtd1D1lbm4Qc1F6bQcNr71jxk2lXVOHhVoeunTdVOZJCWgDpR8w2UmezNdHr50tlh
         ZAlK6+Nbblsh6s18P06WlVKkk34Y6w5tESE6W1vVJmznVMBvG2RXpTLH75AYFirMtg87
         FH8uyM0f9/qlL14Q9L/FNa15bhFWEGrLH6L2aMbcur/nFVbqeoVRKiojLOiiDVqL/Cfu
         vk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MLNLveD6L+cH6avKSQcqN3AiAJkE99e4WdFigQsP9tE=;
        b=bxKDmk44nk8HYrcjmqIH+eLa6eXcLPGUrfT2vMUtHPDsf+dinjkLUuGXt3WjnCOWc1
         GhHK7Dsglvvqv0Z/SqGAe5GSNzg+oY1SBL7HkZAfeASARKDFE5KP9dFLXyIXGo5erACG
         BpkOCfDeWh/pRj9f5+tobG4kGqZ5cdpElX7EIp131eUAtRu1jxT9eTtojLzU6V9Fd2vd
         JNXvTbn4dQPGGEre/+5jF0Cc9A5cua4K/xfCipOL0nbKwXfemRIOnLz9gCrvVpZo39Ts
         5w26tbl9pW2x7xk11rw7NcUC4RWn+hSRVqdWjib2+D9VnHm0Pbqq72bV6LgndkwSa5+6
         9gdQ==
X-Gm-Message-State: ANhLgQ0/jOfBrk6VgM/aE0ZiByKqisolNPxZn3DRUz8XiwMDvacJNHCL
        jyi5rNez/zkLQhrOvwVQAgs=
X-Google-Smtp-Source: ADFU+vs1VNAsqxRwQaM3OZDVeqqND1v9e+aTzeUXh86E6O8j108hjsIXs8dG9PQ8GnSWhYlnyBF6Zw==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr526454wrv.104.1584380814347;
        Mon, 16 Mar 2020 10:46:54 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b202sm587440wmd.15.2020.03.16.10.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:46:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: fix lvds-encoder ports subnode for rk3188-bqedison2qc
Date:   Mon, 16 Mar 2020 18:46:47 +0100
Message-Id: <20200316174647.5598-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: lvds-encoder:
'ports' is a required property

Fix error by adding a ports wrapper for port@0 and port@1
inside the 'lvds-encoder' node for rk3188-bqedison2qc.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/
bridge/lvds-codec.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index 8afb2fd5d..66a0ff196 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -58,20 +58,25 @@
 
 	lvds-encoder {
 		compatible = "ti,sn75lvds83", "lvds-encoder";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		port@0 {
-			reg = <0>;
-			lvds_in_vop0: endpoint {
-				remote-endpoint = <&vop0_out_lvds>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_in_vop0: endpoint {
+					remote-endpoint = <&vop0_out_lvds>;
+				};
 			};
-		};
 
-		port@1 {
-			reg = <1>;
-			lvds_out_panel: endpoint {
-				remote-endpoint = <&panel_in_lvds>;
+			port@1 {
+				reg = <1>;
+
+				lvds_out_panel: endpoint {
+					remote-endpoint = <&panel_in_lvds>;
+				};
 			};
 		};
 	};
-- 
2.11.0

