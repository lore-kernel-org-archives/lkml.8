Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B827C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="I+w9WWkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgFOQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:16:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51363 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbgFOQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:16:18 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FGEqZj010821;
        Mon, 15 Jun 2020 18:15:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=iyFqkNB9Q+sojHOa8tnZLZLNwaN79m7slShmWmRnBrQ=;
 b=I+w9WWkfZBDHpHeV7F2RnFeiaMz8gKWi4Kn1mJrrBrzX/4kbcD91L4kt6Yo8FfNuoKdl
 lcqvCRqtwy1DmvFcQ5QQD8j0i8S7QlLFJbLiCP61cACO3QxOC06h1o6YRGd0zFTyU0EL
 MZQ6Ka3YNmD9u4dJhbHENfOcD/peq7PLnNoBqThI/9RRCd+0Rj7Sbdi3yMG6qCPHFA1j
 6j29M+DJn8/LkNm0ca+6l1LyzVqFAvzgf+p3DJsSFXHKhUO+v7NDwIXZT2xG1xoD2ljA
 eauSE6YzZJLx3C314jyeHRxF9u4hmuDGbe9BPbh/cADi8iuGm0Q0g5zf1IRoGwIoRm9V gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjvthhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 18:15:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D18F10002A;
        Mon, 15 Jun 2020 18:15:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 062AA2C5ADA;
        Mon, 15 Jun 2020 18:15:48 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jun 2020 18:15:47
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/6] dt-bindings: connector: add power-opmode optional property to usb-connector
Date:   Mon, 15 Jun 2020 18:15:07 +0200
Message-ID: <20200615161512.19150-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615161512.19150-1-amelie.delaunay@st.com>
References: <20200615161512.19150-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_06:2020-06-15,2020-06-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power operation mode may depends on hardware design, so, add the optional
property power-opmode for usb-c connector to select the power operation
mode capability.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 9bd52e63c935..cd7feb2d4984 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -88,6 +88,17 @@ properties:
       - device
       - dual
 
+  power-opmode:
+    description: Determines the power operation mode that the Type C connector
+      will support.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - default
+      - 1.5A
+      - 3.0A
+      - usb_power_delivery
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-- 
2.17.1

