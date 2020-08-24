Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A752075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="aryGCROj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHXKFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHXKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:05:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA7BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:05:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md23so10359288ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CGGeoueArbEazkLTyBQOHNx0dQ0SfBp0ZU061+y3dX4=;
        b=aryGCROjT88G8zK3ocQu0A/OD9dgUpa/TlUowZYkSEjkVLnRJBVUvDja8HP6gGpl4g
         KmslE+Vhj+gV4/SsPRcjo7iXOgBTEAzACasNul7JXa3SsAMvXHoAcNe1vWTV6QXxklZL
         7QDXEnPkwY0Wo53Or25wdKR+RJviV5mDHcqoQDHYltJ6IC4NxmNCfDG3zz81iBCtpdEB
         IGmu62pwpRBOiUWWK3pZFRs/kLTRNXe/pcksvFi2jNjwvt4EBBITv6k3l/cMAtf0SWzB
         DFyyJleTUWhP3n+GaXZB22+JAQ9Vm/zUBf/LMHurVzUvO2KrfXys/ZpiKX6ADAXrF8Tc
         1P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CGGeoueArbEazkLTyBQOHNx0dQ0SfBp0ZU061+y3dX4=;
        b=b841UT2cJLhraRu2F2zocucZx8IjJWOt2nujQLz9aRN7+XBTzAeYTCu5wwbjHr7QaG
         ZRfElITEnhXO2tpgbfaxhLSMNPOmASQ/SQSaVXrRoS8mJZawBrMjVhCDpQPkcj4gt6vy
         dpqcmVd+rhdXaUjE1k9TAbWvIKJmefH+dANH7IUI5ry/UvT0zN1MEXpQ/lbqWXpwFi9b
         4ABFiGg+LR81okYpOiLCF+c/1Kfg7qxe+3Zu6MMqOg1q8LTT22csqyYfqH5LOQdFbOec
         zj7dKjzFusMROFA4dB999Iqw9qWrgh7c0bAhWrkBYIAk6HsNt6VcGEYlg6eqH3yd9bRW
         QNbQ==
X-Gm-Message-State: AOAM532nRuY7yfDCuWWjO7fmQPOb6mJeHO+VrE13aG9E4+jGARPrT3Ro
        oGhg7u7GspfvpR9CU7PCGSOrL8QTCu4UPg==
X-Google-Smtp-Source: ABdhPJwbGZqxdqKhSe7zOHIpLE14mO6wthK+9cHVtV2Jx0+pmH46ZlVv+YoT5BbvXkXHe9hC93ljxQ==
X-Received: by 2002:a17:906:c1d7:: with SMTP id bw23mr5058441ejb.315.1598263547195;
        Mon, 24 Aug 2020 03:05:47 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p1sm1389959edy.58.2020.08.24.03.05.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:05:46 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Rename buses to be align with simple-bus yaml
Date:   Mon, 24 Aug 2020 12:05:42 +0200
Message-Id: <68f20a2b2bb0feee80bc3348619c2ee98aa69963.1598263539.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename amba-apu and amba to AXI. Based on Xilinx ZynqMP TRM (Chapter 15)
chip is "using the advanced eXtensible interface (AXI) point-to-point
channels for communicating addresses, data, and response transactions
between master and slave clients."

Issues are reported as:
...: amba: $nodename:0: 'amba' does not match
'^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
	From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml
...: amba-apu@0: $nodename:0: 'amba-apu@0' does not match
'^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
	From schema: .../dt-schema/dtschema/schemas/simple-bus.yaml

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

The only one problem with this patch is that it breaks paths in
/proc/device-tree/.
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 165a95a106c8..98073f3223e5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -182,7 +182,7 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
-	amba_apu: amba-apu@0 {
+	amba_apu: axi@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -201,7 +201,7 @@ gic: interrupt-controller@f9010000 {
 		};
 	};
 
-	amba: amba {
+	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.28.0

