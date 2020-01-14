Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CCC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2559F2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="EI+oPXbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgANMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:45:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46048 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgANMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:45:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so5188713pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2ocqpNCNamUAy5E/KrLLD+fKqvg94tYj4BJ9iBtt5s=;
        b=EI+oPXbnl+yy9J09rgqE3ehUE+czANY9CAE/rrPG6TEvMrj2c2uqY5/g5kOe0qHrIu
         dLn3aUED0jWJjf3xJQzACY8oGfGNFlNI9PpXDwbL0/AvlEgf/9ns5ql5ZgNbTBN6nUYj
         dJKaPixUuBiQ2BAX/94BWQC+7t9+0iFq5O1ILfjn7WEZjuOP5E9bmiURTrvL79SsEliR
         cAaqlRJnPt6vfhallAtscoLJe/bPtnL8KhFFYYLnZn+vNleYM4CyAYe9TZA6y1/uPDgm
         a9RjE3tMjLP9jwl3FE1DBp4GnyyL4tr9daFUZPCtjlkyMbawXQT8R26waWc1ODf8Hif8
         cKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2ocqpNCNamUAy5E/KrLLD+fKqvg94tYj4BJ9iBtt5s=;
        b=k+ZWBPRAwV2kwsvYOaOtH0/6xNqLofoNMOrdFuWwAxhUKXpIZf26n6XEro3vp4r5yp
         YngXVZ1J80GbwkPos2AksGOW8C5Sp6SjqAlQvrhkOAlD0tSRgz7PhiucPk8zg4WuTOLx
         FUTTOv9aStuU2TYDHdECgKyPzSzSBvI9tERnvQj3FhcVk4SPT5GsiBTxCWZg9VTbUDDH
         UlA3L8EiWa8rKRsSK5Z8SwkOW03b8ykfmieNT2ECJA4VvWsAwqC3Sgpo9laj4+HA7qPE
         ScHRVOD14WX+L4M+xQCnmhT4Q4jGqrfdPEGAc8V9lYWZQizMab1RHWFVmXHh6cJ5EKfD
         IGwA==
X-Gm-Message-State: APjAAAUL6xAdfLQJJKM4ubxVy8Fg5UaeU8l9K9TYzEWROZOdmSf6lMxw
        28jHRbebh3Rb/oQdUMpcoZGt4A==
X-Google-Smtp-Source: APXvYqwGVReQXXDNoX9cGSPsbV23dDIOppPIv/+zsZQ8bVlsNTYIFzag4i6Xq1/CyWTCbCypbBMfWA==
X-Received: by 2002:a17:902:820b:: with SMTP id x11mr19767084pln.196.1579005900149;
        Tue, 14 Jan 2020 04:45:00 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id a185sm17816033pge.15.2020.01.14.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 04:44:59 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: mpq7920: Convert to use .probe_new
Date:   Tue, 14 Jan 2020 20:44:49 +0800
Message-Id: <20200114124449.28408-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114124449.28408-1-axel.lin@ingics.com>
References: <20200114124449.28408-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mpq7920.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index b133bab514a9..54c862edf571 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -260,8 +260,7 @@ static void mpq7920_parse_dt(struct device *dev,
 	of_node_put(np);
 }
 
-static int mpq7920_i2c_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int mpq7920_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct mpq7920_regulator_info *info;
@@ -321,7 +320,7 @@ static struct i2c_driver mpq7920_regulator_driver = {
 		.name = "mpq7920",
 		.of_match_table = of_match_ptr(mpq7920_of_match),
 	},
-	.probe = mpq7920_i2c_probe,
+	.probe_new = mpq7920_i2c_probe,
 	.id_table = mpq7920_id,
 };
 module_i2c_driver(mpq7920_regulator_driver);
-- 
2.20.1

