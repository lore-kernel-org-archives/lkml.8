Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F30C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC7208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C9h96cDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGCHrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:47:06 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46463 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593762417; x=1625298417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fmDRosteDtE+IMlkhAt1snIWAZ0oO40wspsHahgvM4Q=;
  b=C9h96cDiEAUDs35ahbkUQ+qgYAd42lw3jZxdm3y9hySM/lxGy/xpcUQ2
   bjUzdaYvBB5nl0qJrSpS8w8T7JrbT6nDp4cQdsfXr3Poii/8G3GUm68Dr
   rh/8Fpm9L7+sL7x1EmajqtlrrRIK90BU+109MuNhO6EwCx2Haknu+/E2v
   RcxSzp7kjC/TNMnRnaClaWjA3eMdBn7DuZE1rJsop6q921lliUykt8i0J
   OiW/svHo4eu/n3XI6RCc0k+6aAn3VcoV9sraHR+GAoRl2ya6JknQ2IiBt
   joAIexA4Br2PIGoS9BkdZCxIVQoSh1falSdAhT/4zVV45WE1PuU+H18x5
   Q==;
IronPort-SDR: ILLHhhsqHmSGGsp6QD4FzecUzJY5YEGGqQjDfL0czVI8WW8fyB+0Bj7wUqO6oZlupFd5hiNGG7
 iL3Echal3uefcMr/DJY0CoFpVuIKEW/Ue1hKL0JoBmd+08L75Jyxc5dQIi80qy3tndpIOwRI3/
 4Gz5lSkfCjdpz60iVzpew76mpEZHJDu9TSP1C+uTW8HwcaQIGZ3QPP2DzaiR489euFWVXBZfrc
 CZThS0Zw5tMz79awUozIGhw3lIgdZ4I100imwFNu0yc2eX6GXLlzLLP/rSk9c6RVbpgS9Jp3Q1
 7DE=
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="86113150"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2020 00:46:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 00:46:35 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 3 Jul 2020 00:46:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <mchehab@kernel.org>, <hverkuil@xs4all.nl>, <robh+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 4/4] MAINTAINERS: add microchip csi2dc
Date:   Fri, 3 Jul 2020 10:44:16 +0300
Message-ID: <20200703074416.55272-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703074416.55272-1-eugen.hristev@microchip.com>
References: <20200703074416.55272-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip CSI2DC driver in the list.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 791d2a862e41..a65b8d28c7d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11069,6 +11069,13 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
 
+MICROCHIP CSI2DC DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-media@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
+F:	drivers/media/misc/microchip_csi2dc.c
+
 MICROCHIP DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1

