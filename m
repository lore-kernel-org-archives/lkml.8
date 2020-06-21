Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4305247E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icurse.nl header.i=@icurse.nl header.b="r3JSK6r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFUE3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 00:29:30 -0400
Received: from mail.ruun.network ([176.9.184.6]:48483 "EHLO mail.ruun.network"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgFUE3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=icurse.nl;
         s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=VJmjPpOP9JrG+9OSOT1Y4e8RSdB0kSYU9NIPtjYXboA=; b=r
        3JSK6r8Wr+xZVSf4hOEryR0lHC7u8AC/PrjsqtJf9yiEtgZ4vd71KyUlh4VHvMBNByCMh4mZKgyWX
        fNdt2ctD5A7ZYIuK5QArpXwf02Vfr9StjYcMlaDlula5V+dxVArcnwUzOCsSMgKV93rO8tuyCt1FP
        NLzk9a5VMIHBhbIUEqfLpDYHNuMFcur3V+bpK6IijDfmKo2TEBZpr9BfrqIDds7lxK26id5oMjL2I
        IZEntQvhyJ4Buor+xDqa2pKnTg7KawW3q1Dx0dYj8dh3hf6GobX4IrYmzg+La9rsI0B+nfoz3rfCq
        ovZ6E0hw401G58RcraP/unuTdfI9WwjoA==;
Received: from [23.129.64.209] (helo=localhost.localdomain)
        by birchibald.ruun.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <jeffrey@icurse.nl>)
        id 1jmrbd-0008Rj-Ha; Sun, 21 Jun 2020 06:29:22 +0200
From:   Jeffrey Lin <jeffrey@icurse.nl>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Lin <jeffrey@icurse.nl>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] hwmon: (dell-smm) Add Latitude 5480 to fan control whitelist
Date:   Sun, 21 Jun 2020 00:27:49 -0400
Message-Id: <20200621042748.865713-1-jeffrey@icurse.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: jeffrey@icurse.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows manual PWM control without the BIOS fighting back on Dell
Latitude 5480.

Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl>
Acked-by: Pali Rohár <pali@kernel.org>
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

