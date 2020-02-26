Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C819C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F924684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yOUwkDUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgBZNIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:08:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgBZNIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:08:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QD8K8t097198;
        Wed, 26 Feb 2020 07:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582722500;
        bh=0bhKPvjJa3/rmLd39zoLbOUlraMceKvkCehpXWM1XR0=;
        h=From:To:CC:Subject:Date;
        b=yOUwkDUujCJL8aqRNJjC4JnIZh0D94A5A/XfZyXhzpur1qQS4LUl2Tj5iGJkjwcnN
         AocFMIz91zT+fkezXBJthtihRQ5j/yDZbbGs9zVmkY5uax2QuIRewRuub2M7HHGJYf
         SJszsK41R3kIGo1ZE3MW0HmVWsoAcn47lHUZLjFs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QD8JUd032725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 07:08:19 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 07:08:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 07:08:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QD8Jwm073329;
        Wed, 26 Feb 2020 07:08:19 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH for-next 1/3] ASoC: dt-bindings: Add TAS2563 compatible to the TAS2562 binding
Date:   Wed, 26 Feb 2020 07:03:03 -0600
Message-ID: <20200226130305.12043-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Texas Instruments TAS2563 audio amplifier to the TAS262
binding.

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index 658e1fb18a99..94796b547184 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -8,7 +8,7 @@ real time monitoring of loudspeaker behavior.
 Required properties:
  - #address-cells  - Should be <1>.
  - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562".
+ - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
  - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
  - ti,imon-slot-no:- TDM TX current sense time slot.
 
-- 
2.25.0

