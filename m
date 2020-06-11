Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E78C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A0520720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFKVMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:12:08 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:38675 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgFKVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:12:04 -0400
Received: from [78.134.85.74] (port=40536 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jjUUO-000C9m-UH; Thu, 11 Jun 2020 23:11:57 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional INIT_B GPIO
Date:   Thu, 11 Jun 2020 23:11:43 +0200
Message-Id: <20200611211144.9421-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INIT_B is used by the 6 and 7 series to report the programming status,
providing more control and information about programming errors.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
index 9f103f3872e8..a049082e1513 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
+++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
@@ -16,6 +16,10 @@ Required properties:
 - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
 - done-gpios: config status pin (referred to as DONE in the manual)
 
+Optional properties:
+- init_b-gpios: initialization status and configuration error pin
+                (referred to as INIT_B in the manual)
+
 Example for full FPGA configuration:
 
 	fpga-region0 {
@@ -40,7 +44,8 @@ Example for full FPGA configuration:
 			spi-max-frequency = <60000000>;
 			spi-cpha;
 			reg = <0>;
-			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
 			prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+			init_b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
+			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.27.0

