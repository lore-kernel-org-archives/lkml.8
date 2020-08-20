Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3CC208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+0iidhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgHTNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:22:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729578AbgHTNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597929582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=EYEbh/d854a4Cvi1ZmxUctES1NziyUONjpMTuL++zu0=;
        b=U+0iidhgi9u9snAkDQ9TDVUc2PkBoI57W3PkqraAcoc+fZNmQhbhK0O5ntUAdHl37lATFu
        bwdjzjkLTe+AorJeuiG33PdjU/rD4QLjsl79YfnvNm/XWsimwEXNzSWP6nVdfKgJvNnc2N
        5t/VIQcK1W5kZ8HpS1AsM1qgvGESGeg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-aY8ZLKuyOc6uRq5QO-umDA-1; Thu, 20 Aug 2020 09:19:38 -0400
X-MC-Unique: aY8ZLKuyOc6uRq5QO-umDA-1
Received: by mail-qt1-f197.google.com with SMTP id m88so1500181qtd.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EYEbh/d854a4Cvi1ZmxUctES1NziyUONjpMTuL++zu0=;
        b=X+BPSf5j4oQb6YjA1RVhKJH6qFnkBJt/kSiij3v50Dzw4okldPrZ/OTC43KNw69GZ0
         D2TWqdAcbbkOpcQJG4CQD04e0D1saNe7RSLcYcG4UGjsKaU4kNEPWva8TleQHVZ6libO
         0anXX1JcA7pTPU0ydRUat1QIC1EISIXc/Wo7CngcOni4VPt4nIaJFhRm6CdVay2bKcz1
         Ge1bccc4z2PhwQ9C2hjNarod7uvt7tZPm5w0tG8ubWrCYb0gmTF99k68Rg8Nz64TH8yT
         YuBhSr5L48x31n/tR8T6jbO7+KgcR1hdC0DvHjn1qsfjnNIwiMmSoDdxep+hQ8niapMO
         ceOA==
X-Gm-Message-State: AOAM531P3frXugvOsV6yipF6TQmsq9+TBPFKh6eLf1H9fex4BtOPY1p/
        Hea66fV/IRV24YVBAm4aqHecO/3J27KqdmefFXcbCVthua4Y299MiU5MZOgNuRPiRjdfyafa5xU
        +7Jqplp/yalkxKVHseGS/VZ3X
X-Received: by 2002:ac8:71d6:: with SMTP id i22mr2532262qtp.371.1597929578429;
        Thu, 20 Aug 2020 06:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylmGEqva8k65GQbvrfrvomBJaM4CqPY7z4t1eMT+zT+dmuDhYUfv1MeCKO+nFkDiWH+W8K5w==
X-Received: by 2002:ac8:71d6:: with SMTP id i22mr2532245qtp.371.1597929578139;
        Thu, 20 Aug 2020 06:19:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b37sm3022312qtk.85.2020.08.20.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 06:19:37 -0700 (PDT)
From:   trix@redhat.com
To:     rydberg@bitmath.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] hwmon: applesmc: check status earlier.
Date:   Thu, 20 Aug 2020 06:19:32 -0700
Message-Id: <20200820131932.10590-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative problem

applesmc.c:758:10: warning: 1st function call argument is an
  uninitialized value
        left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

buffer is filled by the earlier call

	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, ...

This problem is reported because a goto skips the status check.
Other similar problems use data from applesmc_read_key before checking
the status.  So move the checks to before the use.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hwmon/applesmc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 316618409315..a18887990f4a 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -753,15 +753,18 @@ static ssize_t applesmc_light_show(struct device *dev,
 	}
 
 	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
+	if (ret)
+		goto out;
 	/* newer macbooks report a single 10-bit bigendian value */
 	if (data_length == 10) {
 		left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
 		goto out;
 	}
 	left = buffer[2];
+
+	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
 	if (ret)
 		goto out;
-	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
 	right = buffer[2];
 
 out:
@@ -810,12 +813,11 @@ static ssize_t applesmc_show_fan_speed(struct device *dev,
 		  to_index(attr));
 
 	ret = applesmc_read_key(newkey, buffer, 2);
-	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
-
 	if (ret)
 		return ret;
-	else
-		return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
+
+	speed = ((buffer[0] << 8 | buffer[1]) >> 2);
+	return snprintf(sysfsbuf, PAGE_SIZE, "%u\n", speed);
 }
 
 static ssize_t applesmc_store_fan_speed(struct device *dev,
@@ -851,12 +853,11 @@ static ssize_t applesmc_show_fan_manual(struct device *dev,
 	u8 buffer[2];
 
 	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
-	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
-
 	if (ret)
 		return ret;
-	else
-		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
+
+	manual = ((buffer[0] << 8 | buffer[1]) >> to_index(attr)) & 0x01;
+	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", manual);
 }
 
 static ssize_t applesmc_store_fan_manual(struct device *dev,
@@ -872,10 +873,11 @@ static ssize_t applesmc_store_fan_manual(struct device *dev,
 		return -EINVAL;
 
 	ret = applesmc_read_key(FANS_MANUAL, buffer, 2);
-	val = (buffer[0] << 8 | buffer[1]);
 	if (ret)
 		goto out;
 
+	val = (buffer[0] << 8 | buffer[1]);
+
 	if (input)
 		val = val | (0x01 << to_index(attr));
 	else
@@ -951,13 +953,12 @@ static ssize_t applesmc_key_count_show(struct device *dev,
 	u32 count;
 
 	ret = applesmc_read_key(KEY_COUNT_KEY, buffer, 4);
-	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
-						((u32)buffer[2]<<8) + buffer[3];
-
 	if (ret)
 		return ret;
-	else
-		return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
+
+	count = ((u32)buffer[0]<<24) + ((u32)buffer[1]<<16) +
+						((u32)buffer[2]<<8) + buffer[3];
+	return snprintf(sysfsbuf, PAGE_SIZE, "%d\n", count);
 }
 
 static ssize_t applesmc_key_at_index_read_show(struct device *dev,
-- 
2.18.1

