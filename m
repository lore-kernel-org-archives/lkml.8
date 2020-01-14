Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C26C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E0E2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="d4nipDKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANG7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:59:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55890 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgANG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:59:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so5272731pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCBAxuPJwON1Gy5hn3PW9lmQgUC5syzaXBSX40eS+mE=;
        b=d4nipDKe1st0I/SXY9Ir7FSC+6zGAc24kDE90jHBhLJs1cgnxNQDmG5BOrHXOXXDN9
         M5znoCrr9FBDAwkxHTLRxrQjRZjC9xw3CHZGvXHUrYaQFL6u4xKWL3x3XqMH/7X23KwR
         7dsLnKQN+qy8qu/NKmz9IkM0orc+jICbyLBLQSxA5SBY5u8aed2cek/vZgrWe6MvWyYZ
         h665sc7h8JgzPH1HydnPXBgEdneFKkuPuBnIwijRCjCOzEIH8L1jyS4blAzz/4Zv1N0j
         06oq1cgsglipda3d7eHh331a4tKYoGWbxwbGLj7NEDHC63U5G4uuzgzmmIrCPoBIkp1J
         BvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCBAxuPJwON1Gy5hn3PW9lmQgUC5syzaXBSX40eS+mE=;
        b=A9JGMR1UNxZGiNmVNcK7buOfzgrasjh/8I3hEnURaTa78MOzKld3tUWCuipzuj7z0r
         txWdxT4GbTE3Yyxk3VX21FW4hEbfqgDSnYRR5BxKTM624KnoBtLiQYCMk9Rk2LKiMKzQ
         2m+fVS7YlY+5catGDbGWP3vLqotvfyBVjdcX942E3mWjrDaqBKqTPzhHztdVMAzaO9kl
         jAvORZ+WiUaMzSiuCrFUo8XxQmhC+0b1mcBbDiTzs7wHqHYeCemj+UL5xf+2VMOhlHAE
         Q3PlTCodDsEI+afg2ZmvoatTLQ2YlwdAPltVWDaOTCrnhFvkxHGJiQ+phz7zqOHYlIZM
         lAEw==
X-Gm-Message-State: APjAAAUP2wFfDGDi3bMMdfxxQryYzNE10PHk+Sz2aMHVSOflV70MFhiY
        XTlQvDWF3V5iHkV/im+ppxDfOWOvlNc=
X-Google-Smtp-Source: APXvYqzyPDf6N9UafVmaZvY1p6ZEe39MSNHu6C0hOh2acYCd4w00Ixvgj2fPvACdY8KdkzCSJcnODg==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr27686748pjn.51.1578985140155;
        Mon, 13 Jan 2020 22:59:00 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id p21sm16320432pfn.103.2020.01.13.22.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 22:58:59 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mantas Pucka <mantas@8devices.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: vqmmc-ipq4019: Trivial clean up
Date:   Tue, 14 Jan 2020 14:58:47 +0800
Message-Id: <20200114065847.31667-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114065847.31667-1-axel.lin@ingics.com>
References: <20200114065847.31667-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few trivial clean up:
* Make ipq4019_regulator_voltage_ops and vmmc_regulator const
* Make ipq4019_vmmcq_regmap_config static
* Use regulator_map_voltage_ascend

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vqmmc-ipq4019-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 42a2368e9ef7..685b585b39a1 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -18,13 +18,14 @@ static const unsigned int ipq4019_vmmc_voltages[] = {
 	1500000, 1800000, 2500000, 3000000,
 };
 
-static struct regulator_ops ipq4019_regulator_voltage_ops = {
+static const struct regulator_ops ipq4019_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_desc vmmc_regulator = {
+static const struct regulator_desc vmmc_regulator = {
 	.name		= "vmmcq",
 	.ops		= &ipq4019_regulator_voltage_ops,
 	.type		= REGULATOR_VOLTAGE,
@@ -35,7 +36,7 @@ static struct regulator_desc vmmc_regulator = {
 	.vsel_mask	= 0x3,
 };
 
-const struct regmap_config ipq4019_vmmcq_regmap_config = {
+static const struct regmap_config ipq4019_vmmcq_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-- 
2.20.1

