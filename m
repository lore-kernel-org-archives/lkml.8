Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261CC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0223820757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DsWF8qvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgEBXd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:33:58 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:45888 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgEBXdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:33:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49F56V5jcVz9vJsC
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 23:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L8IkDPPKyX7L for <linux-kernel@vger.kernel.org>;
        Sat,  2 May 2020 18:33:54 -0500 (CDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49F56V4fTYz9vJrf
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 18:33:54 -0500 (CDT)
Received: by mail-qt1-f197.google.com with SMTP id q43so15985186qtj.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5Ok6v3QTS7jskLU7bXRb5zaNyLJwMRDHy874gWet09s=;
        b=DsWF8qvZsx5RG9xuqF3JePeNDEacJrPwkOZyQswTfIjPVYFTsuAOC9Fjvz4d5Hkq6L
         9YnvkpVqcSo7VISqviBMZ9tw1gh1BFLBSaOVGqgzpSF9sOBgsQCgXtfAxSyw57jey6At
         u+zqXyCC8GdmAFOrtl2lsIH2CbWWL28yN46ZXvgCxzDM5ceGaZPGdCUiO+Hua/yof0vb
         QVUVuxycX/oUpwrI3vZCAnDCvDgdhUAziu7Lch0nnOG+pHCLs9g55WEpw4j6Svcz1ifp
         cmQqHT4k8jMDVTRbuHOzqcqiazsAIyt/th0LmxuvIRZjLrHAqtWHL7+Szv/MdmVXPApG
         c2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Ok6v3QTS7jskLU7bXRb5zaNyLJwMRDHy874gWet09s=;
        b=Z797+YC0tTpAX8etGUFkIGQTQ05I+lNwwwRt9djaPu+9cIK8LcuOka1kfxF3/iWjeG
         iKXk220bt9W47q8YccsjuWlj2yYK5aJlM0LiswXbAc4Zx5BkGnog6yjAleP+TLPHH2Xv
         sDcH4rDmn2DBtGhW3xeW8eE6g96lGUvoT080mzJSOOsFEMu7fwjjSudBDY1GpvSEBLz6
         z/Hzcxsc9LQs8gnJaZQY0vo3ueSVUelnXrMzSGw4gaD9HjyvHSz86oOYT3U/XyXgF1/Q
         C885/UqcZw1U0gMNmbh4OC2UaeGseFY3m4/wYuhTr2CiigPJW8iGchEw3lu9dDyo6+9w
         tKgQ==
X-Gm-Message-State: AGi0PuZjfJBWprWIWTvY/VsUtYq/lmCrKDDQT90JGFnCfAPHadng8lqz
        dtNAnuXojhwKKJEnY7FRlCwoMUlwJ6LYJVCxjramN8fCKJxnX+5LmasL2alJr/hCIqxMNZBN3Gg
        JRILseA4sBI+5ynFlPXEJqIsSKraB
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr9951154qkz.182.1588462434008;
        Sat, 02 May 2020 16:33:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIp6mvb+J23R0t0JtGB8uh+DMZjcNiEF5oMT/5zh8Qusv1Wa3sgrkzYFNCQpRU3ptC4oHe+7g==
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr9951138qkz.182.1588462433574;
        Sat, 02 May 2020 16:33:53 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id u11sm6708645qtj.10.2020.05.02.16.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 16:33:52 -0700 (PDT)
From:   wu000273@umn.edu
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] power: supply: fix memory leaks (v2)
Date:   Sat,  2 May 2020 18:33:38 -0500
Message-Id: <20200502233338.9188-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function power_supply_add_hwmon_sysfs(), psyhw->props is
allocated by bitmap_zalloc(). But this pointer is not deallocated
when devm_add_action fail,  which lead to a memory leak bug. To fix
this, we replace devm_add_action with devm_add_action_or_reset.

v2:
  - Prevent introducing double-free.
  - Added fixes tag

Fixes: e67d4dfc9ff19 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/power/supply/power_supply_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..7c8296ea0c34 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -304,7 +304,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
+	ret = devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
 		goto error;
-- 
2.17.1

