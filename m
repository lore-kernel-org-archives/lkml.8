Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1B6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CB220776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icurse.nl header.i=@icurse.nl header.b="WoR3i4en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgFSB4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:56:10 -0400
Received: from mail.ruun.network ([176.9.184.6]:58697 "EHLO mail.ruun.network"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgFSB4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=icurse.nl;
         s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=t9VVt/q1Wb+H1nPMXXRmFagjrPdnSTriMlimvb6Aj+8=; b=W
        oR3i4enDVUcJq1BmoUfG14OaX+2TnMBg2MJVRN/++pV7fstDgoi6ljgOHh11M7qGU+5EdVVvoQD/g
        wOujh08GTAQ+fqqO6kKPlguhkOhcCko/Rn7IlS/OqW/3rsPk/u+D/Gs8TjbNfSWjyuD2WVNnFPT2S
        Qjh73XIIjTyWoKtIK6+3mQl6FvGtBhGv49rqFaCIBWiqfKewFLNhPtru5nnTGiJ821vD08jW+w5Vq
        ZmKVZvDtdQADTzT5Nwo+GqScSBoAUJdDy5kVTwyJRxUXuouRu4c7qYjL5DzxySGWygGHZ7IcN/bMJ
        p52vkBKKrNmRMucWXT607uY67OTJQx7UA==;
Received: from cpe-98-14-166-248.nyc.res.rr.com ([98.14.166.248] helo=localhost.localdomain)
        by birchibald.ruun.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <jeffrey@icurse.nl>)
        id 1jm6G5-0001WA-3f; Fri, 19 Jun 2020 03:55:57 +0200
From:   Jeffrey Lin <jeffrey@icurse.nl>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Lin <jeffrey@icurse.nl>
Subject: [PATCH] hwmon: (dell-smm) Add Latitude 5480 to fan control whitelist
Date:   Thu, 18 Jun 2020 21:55:29 -0400
Message-Id: <20200619015529.285241-1-jeffrey@icurse.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: jeffrey@icurse.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows manual PWM control without the BIOS fighting back on Dell
Latitude 5480.

Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl>
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 16be012a95ed..ec448f5f2dc3 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1187,6 +1187,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
 		},
 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident = "Dell Latitude 5480",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 5480"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{
 		.ident = "Dell Latitude E6440",
 		.matches = {
-- 
2.27.0

