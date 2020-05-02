Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A19B20757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 21:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qiXSHn3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgEBVLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 17:11:09 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53558 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgEBVLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 17:11:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49F1xl6sb4z9vKlq
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 21:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oSteTtLyjhaa for <linux-kernel@vger.kernel.org>;
        Sat,  2 May 2020 16:11:07 -0500 (CDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49F1xl5Sltz9vKTj
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 16:11:07 -0500 (CDT)
Received: by mail-qk1-f197.google.com with SMTP id d187so7069865qkc.18
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=98Gw/YIKBAo25+eia8JVZ/k22pWYO0PDQMHyI7+B3/Y=;
        b=qiXSHn3VnvB/69IWAG+v5cQyvBCq6ZxUOeK/CmnxT5yJCxiSzFhnxlJML24aAdXu8D
         +eaj2Nsq05zO4XATqr44CfX8qbwWcBAq0IVDFn1r4Ful+yx3U24s84fh6ZYmKT5bV1wn
         TPw5LykhGf79lQojJ6PSpVILIStk9+PpXQlaCQe+ShXXT8nFkyWgmOmGucjxQsAUpLNQ
         ECn8BFafsy5uQlIZNhJVhBnNFiOKUAULkKEo55x9szxvFXUvVrT3W5GUgJawmSf0tAV/
         ppNdq0kCTqyO3v+kQbAIi7otRocRzuJ96dpQvq2WrIhPIrgnNj1aYCYJXJ37qjP2yXsI
         iPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=98Gw/YIKBAo25+eia8JVZ/k22pWYO0PDQMHyI7+B3/Y=;
        b=R1LBTNCmdS8AlYf7WWNMmoJC6L4ceduSh5tzisye4xE6qsX5nf+gcJRKKeOOvo6Oha
         n7hc9BmNOPfIIoylKeYdbin1pU19vkF8i5baFJAP0JPW/EX5/Od3wTcdn6Ic9KrBGPQr
         i1jkGl5zBIuNT1YDe74Dqmu+mT/J5t6FYj2erhlaFg0OvF3+dAUXkgsMj/SqlmMvV25T
         3Raoz5f+n5b0Fx9hqWa/hDXizQHGXaAj98VjrWbLlGAefBtetQ2nA/Hv94uUmgF5Cnpy
         Bsw6UtsD3pYKmpq8YAVH4axTWpK8Ifmm98MhTgN9ig/35apefKloROwz+6I/z2CvxfX5
         IRaA==
X-Gm-Message-State: AGi0PuZbI/D28Zu/qHdWeSrAxdHc4aQ4NXbFnN/rMzs5wpuxK5WOGPrc
        YwsulZGVMqj0RWAbQsgrT+PTZmq1ulwzQH5Rj6RtOklVikA8HrhQ85V7S1YE0drjPSTtvHRWK9L
        zVwkWQtCPJJr3GPC29zT/ALcV+3wo
X-Received: by 2002:a37:a186:: with SMTP id k128mr9694072qke.149.1588453867094;
        Sat, 02 May 2020 14:11:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDJ29emRSGxtOrg7phOUBKtXGhr9D7AIFJJXZK+qKPj9RkQfFg5OekLu1Lbs0v6owzYNPvoA==
X-Received: by 2002:a37:a186:: with SMTP id k128mr9694039qke.149.1588453866425;
        Sat, 02 May 2020 14:11:06 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id l12sm5919552qke.89.2020.05.02.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 14:11:05 -0700 (PDT)
From:   wu000273@umn.edu
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] power: supply: fix memory leaks
Date:   Sat,  2 May 2020 16:10:56 -0500
Message-Id: <20200502211056.20975-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function power_supply_add_hwmon_sysfs(), psyhw->props is
allocated by bitmap_zalloc(). But this pointer is not deallocated
in several error paths, which lead to memory leak bugs. To fix
this, we can call bitmap_free() to free this pointer.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/power/supply/power_supply_hwmon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..7453390ab7a4 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -307,7 +307,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
-		goto error;
+		goto out_free;
 
 	for (i = 0; i < desc->num_properties; i++) {
 		const enum power_supply_property prop = desc->properties[i];
@@ -342,7 +342,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
 		if (!new_name) {
 			ret = -ENOMEM;
-			goto error;
+			goto out_free;
 		}
 		strreplace(new_name, '-', '_');
 		name = new_name;
@@ -353,10 +353,12 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 						NULL);
 	ret = PTR_ERR_OR_ZERO(hwmon);
 	if (ret)
-		goto error;
+		goto out_free;
 
 	devres_close_group(dev, power_supply_add_hwmon_sysfs);
 	return 0;
+out_free:
+	bitmap_free(psyhw->props);
 error:
 	devres_release_group(dev, NULL);
 	return ret;
-- 
2.17.1

