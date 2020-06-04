Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA06F20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgFDIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:48:58 -0400
Received: from comms.puri.sm ([159.203.221.185]:52900 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:48:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 20F6AE01AF;
        Thu,  4 Jun 2020 01:48:27 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nnn0gZI6NH5H; Thu,  4 Jun 2020 01:48:26 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/2] MAINTAINERS: Add Purism Librem 5 section to the list
Date:   Thu,  4 Jun 2020 10:47:56 +0200
Message-Id: <20200604084756.586-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200604084756.586-1-martin.kepplinger@puri.sm>
References: <20200604084756.586-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add development information for the devicetree files for hardware
by Purism SPC.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91bc8a7c0c17..ae6ac00c6b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13879,6 +13879,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/pulse8-cec.rst
 F:	drivers/media/cec/usb/pulse8/
 
+PURISM LIBREM 5
+M:	Purism Kernel Team <kernel@puri.sm>
+S:	Supported
+B:	https://source.puri.sm/Librem5/linux-next/issues
+T:	https://source.puri.sm/Librem5/linux-next
+F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.20.1

