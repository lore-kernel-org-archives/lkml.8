Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62693C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9B82072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="WEmp+VkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgHXI7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgHXI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:59:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4194C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:59:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j25so1692317ejk.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6Nyla3H0wUGAKmzWwi+k8dbGIe1ZX5kzFV4/Pz+xJc=;
        b=WEmp+VkCtcJ2WeYsttZRViQlwO9dCg57Qfm6bvcDqfm0CV17zAJa7ZFBpY1ZsPMakB
         3tEOAsNwISWRBs4FESrd7zxUBzXUET0SNtX8ClxCex+zCeiOp/+BimZ6cUDWQByQW1h3
         PUmRjWafkMvUXjtBgPeYqiXygW/kqReXvwzg/ApU16wWAco3NZU4+Xyzw70SQ5cQrwGg
         b9tWNZKiMHFhT2DGsNWI5aU116gu8hyBKcca/SVKpOXC2JWJfnvI7272B4Crbwux6UFT
         MMXcg+FHgq5wESb3VEykHk0OZycg7Fr12L6L/UvuTj1DBqu3ltK4jZQPZWxncgKPkAov
         hetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=h6Nyla3H0wUGAKmzWwi+k8dbGIe1ZX5kzFV4/Pz+xJc=;
        b=MbY3O6MH4+/arJG9uVzXbiPFCZoy895Uxke9jU2jhV/NeSqSQwWaZrt4BJb/zwoVNp
         HJOwRuxdiw5CRo7bMCO+fti3CXGEoFP7pi2d5STGW7CiRNJYykrgko42D6WX9x6NvAuX
         HpXmDJLTLic6V+UCQ6DFC2yjy9zuldTWfDOaMEDW+Qql9eTRcQcUdAqUVzbjxYUe85iT
         6GcZXcNzVmWD5rNB/sk/TsNwtudZEZ5F3WSwXlBGCB0aeseeYm5RgW7VXttqMuqoYGZS
         4noWR4oO5iQVAGWYjMbGL02/+GyWLr84YN/YEHgkEbFGFP2yYc0A22GuEMmPiHo6tlDt
         f0lA==
X-Gm-Message-State: AOAM533niodPLEALfWHMex5yhZrlJSbX/XhbUbZINOga1qqbcEVzJWrC
        ruSo2HyGLsSWahUrBI1HNYGTtsKkjyYJNA==
X-Google-Smtp-Source: ABdhPJxaZAUd1oAJnAMhDl7Cr1pP6hTC52Sd5CTKaQVBf5nJsWM04lQna+QTamTT6lBMyxnX5PpPOQ==
X-Received: by 2002:a17:907:2078:: with SMTP id qp24mr4500987ejb.286.1598259556116;
        Mon, 24 Aug 2020 01:59:16 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p1sm8339639edu.11.2020.08.24.01.59.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 01:59:15 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Remove additional compatible string for i2c IPs
Date:   Mon, 24 Aug 2020 10:59:14 +0200
Message-Id: <cc294ae1a79ef845af6809ddb4049f0c0f5bb87a.1598259551.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding permits only one compatible string which was decribed in past by
commit 63cab195bf49 ("i2c: removed work arounds in i2c driver for Zynq
Ultrascale+ MPSoC").
The commit aea37006e183 ("dt-bindings: i2c: cadence: Migrate i2c-cadence
documentation to YAML") has converted binding to yaml and the following
issues is reported:
...: i2c@ff030000: compatible: Additional items are not allowed
('cdns,i2c-r1p10' was unexpected)
	From schema:
.../Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml fds
...: i2c@ff030000: compatible: ['cdns,i2c-r1p14', 'cdns,i2c-r1p10'] is too
long

The commit c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string")
has added the second compatible string but without removing origin one.
The patch is only keeping one compatible string "cdns,i2c-r1p14".

Fixes: c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 6a8ff4bcc09b..165a95a106c8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -500,7 +500,7 @@ gpio: gpio@ff0a0000 {
 		};
 
 		i2c0: i2c@ff020000 {
-			compatible = "cdns,i2c-r1p14", "cdns,i2c-r1p10";
+			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 17 4>;
@@ -511,7 +511,7 @@ i2c0: i2c@ff020000 {
 		};
 
 		i2c1: i2c@ff030000 {
-			compatible = "cdns,i2c-r1p14", "cdns,i2c-r1p10";
+			compatible = "cdns,i2c-r1p14";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 18 4>;
-- 
2.28.0

