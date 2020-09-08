Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770EAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DD8247C4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599579743;
	bh=YMyeZdu9AK2XDZlChIpD6tD+lXjuHM/nRNxJfMP4bXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wHUYCbYBX2X+4kWpTz2n5j5Pfmdn9fjs30AUNmIEYzaId3fVy8Uizpo4nyvxnPh0g
	 ahmKHiLVww9W8U7uZVUV8t2XQizluSgle1mHaKKX2/Gj6Le2s5cNgaSXrGbGjs8pko
	 2cseEYaFGDAWmycVgtbUf/uLV1drA827+PnYkMuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgIHPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgIHPfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0B52246B;
        Tue,  8 Sep 2020 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579272;
        bh=YMyeZdu9AK2XDZlChIpD6tD+lXjuHM/nRNxJfMP4bXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apWKfGHEAJjM8qQCRghVTU41PcE6ZDbStpwes073x1t6B1sDdfR1nwll9Byge3UNw
         nU37gSMJCCMnIYbiNHDX7udpK9EvT1Fzss0sbZ7ch3ErqCXOsDVeEsyRzw/QKj2Upd
         xgP7s7AOVMhlOkZakY1W5TGApzQuFMXmx/TQMYIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grant Peltier <grantpeltier93@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 001/186] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1 telemetry for RAA228228
Date:   Tue,  8 Sep 2020 17:22:23 +0200
Message-Id: <20200908152241.723270140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Peltier <grantpeltier93@gmail.com>

[ Upstream commit 51fb91ed5a6fa855a74731610cd5435d83d6e17f ]

Per the RAA228228 datasheet, READ_TEMPERATURE_1 is not a supported PMBus
command.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/isl68137.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 0c622711ef7e0..58aa95a3c010c 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -67,6 +67,7 @@ enum variants {
 	raa_dmpvr1_2rail,
 	raa_dmpvr2_1rail,
 	raa_dmpvr2_2rail,
+	raa_dmpvr2_2rail_nontc,
 	raa_dmpvr2_3rail,
 	raa_dmpvr2_hv,
 };
@@ -241,6 +242,10 @@ static int isl68137_probe(struct i2c_client *client,
 		info->pages = 1;
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		break;
+	case raa_dmpvr2_2rail_nontc:
+		info->func[0] &= ~PMBUS_HAVE_TEMP;
+		info->func[1] &= ~PMBUS_HAVE_TEMP;
+		fallthrough;
 	case raa_dmpvr2_2rail:
 		info->pages = 2;
 		info->read_word_data = raa_dmpvr2_read_word_data;
@@ -304,7 +309,7 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228000", raa_dmpvr2_hv},
 	{"raa228004", raa_dmpvr2_hv},
 	{"raa228006", raa_dmpvr2_hv},
-	{"raa228228", raa_dmpvr2_2rail},
+	{"raa228228", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
 	{}
-- 
2.25.1



