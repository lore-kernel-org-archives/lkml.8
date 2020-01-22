Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D34C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AAF24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N12gOWHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgAVI0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:26:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46706 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgAVIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:25:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M8PpMc066110;
        Wed, 22 Jan 2020 02:25:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579681551;
        bh=4yZdLht/dF2W+8Ik5Mp0clG2tpniIX/fKRbolmG+ZKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N12gOWHhQJfT3YNOFdFn24t7tIyU3/mWv7MIr64qXlgWZzgrRvt3xVWQ1em1tPBbs
         dlZclMN5V++zUSgKvFdxYXuJ2CkvOlgSTRKgNFk/8ECb3hD336GVD3dJp6hLPqOtGe
         ghHYrQKpeLRoiOgwZAoEGiBwEDRiF7DD5efL630g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00M8PpYU064250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 02:25:51 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 02:25:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 02:25:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8PeAK046830;
        Wed, 22 Jan 2020 02:25:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/9] arm64: dts: ti: k3-j721e: Correct the address for MAIN NAVSS
Date:   Wed, 22 Jan 2020 10:26:16 +0200
Message-ID: <20200122082621.4974-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122082621.4974-1-peter.ujfalusi@ti.com>
References: <20200122082621.4974-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On am654 the MAIN NAVSS base address was 0x30800000, but in j721e it is
at 0x30000000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index ee5470edb435..027bd1febafa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -130,7 +130,7 @@ cbass_main: interconnect@100000 {
 			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
-			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
+			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71 */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

