Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00DF214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JWlLBHhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgCCKRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:17:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgCCKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:17:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AHfnO068895;
        Tue, 3 Mar 2020 04:17:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583230661;
        bh=Rr6+dT1dgtEaWIGOuG6HWq0KhTufJCJkgVr1a70GIP8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JWlLBHhpBc/05IM5CNlPmtUEDfn6QEhuRX0OtjmcUDwQX9iu52RIW0t6OVP7Z/Y/I
         WQjoHIEloLQEzWjikhtb/FYgp/+SxT9QyJHLowHq84HL9sEzXdyAk7WhpSOWn+JY8R
         Mm/ogY7A6i3d14vHufszr0pO6dcvD/Jw+RtPcLpM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 023AHfiG105637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 04:17:41 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:17:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:17:40 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023AHONh004649;
        Tue, 3 Mar 2020 04:17:38 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR line
Date:   Tue, 3 Mar 2020 12:17:22 +0200
Message-ID: <20200303101722.26052-7-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303101722.26052-1-rogerq@ti.com>
References: <20200303101722.26052-1-rogerq@ti.com>
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
index f057322b8c11..964a46e7af5e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -325,6 +325,7 @@
 
 &serdes_wiz3 {
 	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_HIGH>;
+	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
 };
 
 &serdes3 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

