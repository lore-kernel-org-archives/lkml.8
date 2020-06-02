Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE515C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A0C206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hhZEW1wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFBTfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:35:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49038 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:35:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052JZUKG110487;
        Tue, 2 Jun 2020 14:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591126530;
        bh=b/5XkevPHJRhZ2gZPRNiUFvjA4NxbX0UBQv0ibyIS/k=;
        h=From:To:CC:Subject:Date;
        b=hhZEW1wH2G8LUUa2Oqp26T/S0wzqzgHBRdGcVPTBR99RJFKg9uCSRcXLHZ1BexB6a
         0QaV3sNMEKJ3UN0VzxrPyRrEl7s7I2EC1cNPJFUJ5pp4o00ciz7dtYqgZn25Y8kinE
         Tzywzhonp7f6Eyo/+TJxtmMaWLapAaGO5i55CwGM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052JZUVv102654;
        Tue, 2 Jun 2020 14:35:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 14:35:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 14:35:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052JZTWP050953;
        Tue, 2 Jun 2020 14:35:30 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: ASoc: Fix tdm-slot documentation spelling error
Date:   Tue, 2 Jun 2020 14:35:23 -0500
Message-ID: <20200602193524.30309-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the spelling of 'specified'.  Also fix grammarical issue with the
use of 'a' over 'an'

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tdm-slot.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tdm-slot.txt b/Documentation/devicetree/bindings/sound/tdm-slot.txt
index 34cf70e2cbc4..4bb513ae62fc 100644
--- a/Documentation/devicetree/bindings/sound/tdm-slot.txt
+++ b/Documentation/devicetree/bindings/sound/tdm-slot.txt
@@ -14,8 +14,8 @@ For instance:
 	dai-tdm-slot-tx-mask = <0 1>;
 	dai-tdm-slot-rx-mask = <1 0>;
 
-And for each spcified driver, there could be one .of_xlate_tdm_slot_mask()
-to specify a explicit mapping of the channels and the slots. If it's absent
+And for each specified driver, there could be one .of_xlate_tdm_slot_mask()
+to specify an explicit mapping of the channels and the slots. If it's absent
 the default snd_soc_of_xlate_tdm_slot_mask() will be used to generating the
 tx and rx masks.
 
-- 
2.26.2

