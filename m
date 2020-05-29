Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5023D20721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXyI1nGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgE2Mq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgE2Mq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:46:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92180C03E969;
        Fri, 29 May 2020 05:46:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z64so1343372pfb.1;
        Fri, 29 May 2020 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/q+MI9DCYmzNXOUcv5PNKoWs6DLZXfWW5JzDERtOTi0=;
        b=BXyI1nGH9q7WV+suVu4sRRfrCawjSHzAZkw0A91VCTaw+zCwkYabvL0E9RJhTabyMe
         IZDGzWyLTv69FfqLS3mk0pdXMS7UG37oI6S6f9NaJmufisRJRUZCUdeQ0Z6w6yJ+U5xd
         nICH6zJtFZ1Ky+rEFarg7gMOwGvQ8nc/YHC/SwqqL+YVHzOQPNaXoDWb2+5dIUZxbdcA
         PXckHKFILQl0iG1CmUKw0v67HPGAd3Xl3Fybq/MbrLFAJyT45ABp9vMnQMbJmWs5IYzJ
         d4vAM+XxebyIkNp6uCEypy7nwJSBDw5v0EghA80wURhZoG6WBV6KCzFYK/Yqa9WPEcfU
         ueJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/q+MI9DCYmzNXOUcv5PNKoWs6DLZXfWW5JzDERtOTi0=;
        b=qfFyg0HV2ha5EPnZbrBB+o0r22A7UWcaxpnyFm3t62StEK2QuOis5yBkYnNZClfP1t
         3eCVf4gl/zHMpaKEEIgSvwjag2gEfeXw8lxPbFjum1U6cNUSESSEZnUt9TdoPCG7sb5y
         H5MBhQqvnZaljgVlemuzMKU5WZ9ueMASoq3oyRdkqK7n4HtmtI/f5QEhzeae+9iS6W+i
         MJVmRXR6F06T/AWdRhFxsXI7EXpU5FKVjWTs4QJd2KRxOE7cSyc5AeuefKkiFoPHZjnY
         gIbKJjgGJrbhBJbc3vXkY6tfNXwc946WKM8WugoqCvL07eSgbc2y3VigOiu2ob+7z/3b
         dbeA==
X-Gm-Message-State: AOAM531qtNZ/AXC/0sT6C+yfjqbbn8XTuLNcPbhUZWSMGdbiuYyUjvVT
        7JL0UTYzTnpnaRIOyATGGz86UYhvgCI=
X-Google-Smtp-Source: ABdhPJwZyYjuXsZ1Rfhk+XonOEk9hVjmtO4n1WKyBOWY8Too4XOwaSPB/nqehEX5nZRw4hcYiF/t5A==
X-Received: by 2002:a63:7d1d:: with SMTP id y29mr8120125pgc.189.1590756415869;
        Fri, 29 May 2020 05:46:55 -0700 (PDT)
Received: from cnn ([2401:4900:2654:9f89:6942:a923:c6ef:8ae2])
        by smtp.gmail.com with ESMTPSA id 25sm8180906pjk.50.2020.05.29.05.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 05:46:55 -0700 (PDT)
Date:   Fri, 29 May 2020 18:16:07 +0530
From:   Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
To:     linux-hwmon@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux@roeck-us.net, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, manikandan.e@hcl.com
Subject: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN 
Message-ID: <20200529124607.GA3469@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adm1278 temperature sysfs attribute need it for one of the openbmc platform . 
This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.

Signed-off-by   : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>

v2:
   - Add Signed-off-by.
   - Removed ADM1278_TEMP1_EN check.
---
 drivers/hwmon/pmbus/adm1275.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fb..ab5fceb 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -666,7 +666,23 @@ static int adm1275_probe(struct i2c_client *client,
 		tindex = 3;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
+
+		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+		if (config < 0)
+			return config;
+
+		/* Enable TEMP1 by default */
+		config |= ADM1278_TEMP1_EN;
+		ret = i2c_smbus_write_byte_data(client,
+					ADM1275_PMON_CONFIG,
+					config);
+		if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to enable temperature config\n");
+		return -ENODEV;
+		}
 
 		/* Enable VOUT if not enabled (it is disabled by default) */
 		if (!(config & ADM1278_VOUT_EN)) {
@@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
 			}
 		}
 
-		if (config & ADM1278_TEMP1_EN)
-			info->func[0] |=
-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
-- 
2.7.4

