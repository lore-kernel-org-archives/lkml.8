Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B04DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478C620702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pBRjibbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbgF2Tuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:50:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50840 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387812AbgF2Tuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:50:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05TCrDMG096114;
        Mon, 29 Jun 2020 07:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593435193;
        bh=ttFOPNsI8C7Qj6EFkUy2MjTPikihl8NG7soqqS4fgw8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pBRjibbJLkrIoCy4o33JgQ9f2ePI58oLNmoKiuNMb50EdVyYrM7OtDkG4xHuW3WMx
         hcYocsAYAUt7SCQj6bVU2oGAEV3GiUyKOqp0sPNtWI3JWUczE4fO4bCtQYmnNtIrTe
         lWnlhcjZ2nWayTTT9Gnm2wzzcfdaW9kAa27W5/3Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05TCrDwk066355;
        Mon, 29 Jun 2020 07:53:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 07:53:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 07:53:12 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05TCquh3015456;
        Mon, 29 Jun 2020 07:53:10 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4 6/6] arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR line
Date:   Mon, 29 Jun 2020 15:52:54 +0300
Message-ID: <20200629125254.28754-7-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629125254.28754-1-rogerq@ti.com>
References: <20200629125254.28754-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Type-C compainon chip on the board needs ~133ms (tCCB_DEFAULT)
to debounce the CC lines in order to detect attach and plug orientation
and reflect the correct DIR status. [1]

On the EVM however we need to wait upto 700ms before sampling the
Type-C DIR line else we can get incorrect direction state.

[1] http://www.ti.com/lit/ds/symlink/tusb321.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 3294b96ebba8..6307fe5ccb06 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -350,6 +350,7 @@
 
 &serdes_wiz3 {
 	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_HIGH>;
+	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
 };
 
 &serdes3 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

