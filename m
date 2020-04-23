Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE920C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C565420728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Krb+6wUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgDWQBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:01:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51144 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgDWQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:01:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NG1Xpj027799;
        Thu, 23 Apr 2020 11:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587657693;
        bh=XnXA9bZ8BhuhduXDNJChFHly8DbFIHo/bZqouQ+R7lw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Krb+6wUJbq3I8QzDWTZxqzVP9rj9UqMOMdhfZDh1XXce/SLSc35JsFEROoYHbhOKY
         8oAoerDGm568vj00rQBFdY4Llu0asB0M57SMPipH8xC0/ku7IzHuBBGhnAW7G8NNJE
         K0DqG37knnpo5exE0YFIYcqts3XxtJre5gPrSdmk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03NG1X4x046171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 11:01:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 11:01:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 11:01:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NG1Xf0060730;
        Thu, 23 Apr 2020 11:01:33 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v20 02/17] leds: Add multicolor ID to the color ID list
Date:   Thu, 23 Apr 2020 10:55:09 -0500
Message-ID: <20200423155524.13971-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423155524.13971-1-dmurphy@ti.com>
References: <20200423155524.13971-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new color ID that is declared as MULTICOLOR as with the
multicolor framework declaring a definitive color is not accurate
as the node can contain multiple colors.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/led-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index f1f718dbe0f8..846248a0693d 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -34,6 +34,7 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
 	[LED_COLOR_ID_VIOLET] = "violet",
 	[LED_COLOR_ID_YELLOW] = "yellow",
 	[LED_COLOR_ID_IR] = "ir",
+	[LED_COLOR_ID_MULTI] = "multicolor",
 };
 EXPORT_SYMBOL_GPL(led_colors);
 
-- 
2.25.1

