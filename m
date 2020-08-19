Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE9CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A9D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaDIMZS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHSRRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHSRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:03 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25169C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:17:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m13so17111762qth.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dql59iVUZIXkMIIjRDDc9cryY7AhHQUktCiD/CtP8/0=;
        b=SaDIMZS2ii5M5hBvS/wwp02CsyM2WPoW3RqEkAntGwgxTc4fVo7Hx68pRr+AOLnMrR
         UPMgRPyCsKDOPkRe5OKLNS4CI8pXI48uTBAWd5kMgZh9TUGqG+xq+ZKk+ufGc2nxez2v
         qM5hV+1DJlqIs2S7mkDklsgr1aszYcG+di4pl68Ichj98sn24wIe5MX/OedzuTsLDsk9
         SQ9AdgEncaUMdDgNBdwuHSqBZ0tbYSqoCC1GYXp4rK63q/3ls3eFhJ7glbLrIKsZonE1
         aE68EPmxKxdI2FE2q2ElWOgDcKvDcg4YidizaXSbXSz+qJabPAnGnjihSoLDAXf3SR+M
         pWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dql59iVUZIXkMIIjRDDc9cryY7AhHQUktCiD/CtP8/0=;
        b=ihRTkXqrQQR/1isk+3v+6NPEmq61WpL4PSn1yBU9BHFqoM+cAgbVCRMIZ+Uvv7gBDg
         LIDibOLIvxixrLWD3Zhaa+1V7FX9s0YsOGRebXl4B01au8ALlsQPsPyzqnOMryZzkKIC
         pGKEE6+yN/36U0G6Bz0F4yCoOJJQBpXFLKpzDh8SXPS5yPWvnW9c7KkfDDT/bm9T4R/H
         NQ2EVhGWaBUQuugBtUK1F2vdSXdk/iDMkOPK1oSROsAJb6xBmPZi/e77rqYDTYPi3as6
         Mpu2KUrZ4NnywKSfRz3TbxbiAIXuYkketPPiSDeTerJ7UVq/miMBFql5x4PErL+614D/
         NRFw==
X-Gm-Message-State: AOAM532l93FZcocH05cxI48r++pW27awoPQpQln03QxABaPHV8YKrxIp
        tHSNhRdTht1vEkXs6+ZkUbrGoz+Z2q9L
X-Google-Smtp-Source: ABdhPJxtxagNEX1cAwExC+2CTX+K29Gd2P21QvxBb0PdzYKFclarlAwZULABq4oqzi5/58pbOaAB1YwWaySr
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr25123931qvv.88.1597857420860;
 Wed, 19 Aug 2020 10:17:00 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:16:56 -0700
Message-Id: <20200819171656.2650926-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] drivers: acpi: apd: Check return value of acpi_dev_get_property
From:   Furquan Shaikh <furquan@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     adurbin@google.com, akshu.agrawal@amd.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`fch_misc_setup()` uses `acpi_dev_get_property()` to read the value of
"is-rv" passed in by BIOS in ACPI tables. However, not all BIOSes
might pass in this property and hence it is important to first check
the return value of `acpi_dev_get_property()` before referencing the
object filled by it.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/acpi_apd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 4c348377a39d..806b8ce05624 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -99,8 +99,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
-	acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj);
-	clk_data->is_rv = obj->integer.value;
+	if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
+		clk_data->is_rv = obj->integer.value;
 
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
-- 
2.28.0.220.ged08abb693-goog

