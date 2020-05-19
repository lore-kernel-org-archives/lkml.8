Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C654C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637F120825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp77Wdhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgESMZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:25:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33179C08C5C0;
        Tue, 19 May 2020 05:25:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so6344043pfk.12;
        Tue, 19 May 2020 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UAG0nDWN7NxcHbETHSWkVEUyOCr5c/khtV94afHrVSs=;
        b=Tp77WdhypJcf6CsxDz9e7xxrl7jdJunhvj1kCjoCFOXWfu/JkVJDLLBMpK57/gxbPX
         9o8EEqgX+AXU6lg/bu4BxEEiWuhDRZnrPbPFAIzTbsDn9Z7ZaUkUMiKKle/jVlGWt64R
         rTjew3blOiNp/po15iZOdIlDaGSfzvel053fdJFSrMVG9IxK8FdD2nBQr5rhk/sQHmhS
         dUKvb+OOKce4HoAOW6tXOeSuqoHsTGWOLBTrmH6uP9Gu1IjI9VrLJeHG4KDway/3o8zQ
         p1/9V0k8IxzjxYUGsjjWaxSyGomRYYj7o3k5RvS+sPvR7jlFRJEFFwXWlAL2y9Xo6l3O
         lo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAG0nDWN7NxcHbETHSWkVEUyOCr5c/khtV94afHrVSs=;
        b=lGrktynBcuB7DzYNiguC7LK+7CAyRT8p2yjSP2r+qpDS4kVpwiE1Zux0XfxFya0Ij4
         LksfNXdDsz/ZrAeInkrfDIfGnO4JLsdel+kmjPJ5l3n9Fu8y0jEnGKf6s0NLYIEygwxp
         E95maRSHtCaPZSMzjgUTdpU6rxBfZLcjHI59qUH0rZ1mthY4iKdPDOpBn5IN893yn02K
         W0+0KIJJrPG8k35ajM+r3I9VEl1/TOA2NwqQKHri5UWTYsS9q8/Brbbz0WLLtkr+I2k0
         L0bq+O7lBPhzbfO8fPnzX9u97XgtLpNr0xvS0P4cpStUiEFLQil9jdkLTUDGSzeMd0aK
         bqjg==
X-Gm-Message-State: AOAM531JNpVLAOkMABRhs4Wv8Kv83l61Hw1C+/We81O45LQazoFIaeph
        gDwL44TGXG5xeAU37krRT/s=
X-Google-Smtp-Source: ABdhPJxVWwg9jKyNLg50QRNytCyx/osQtadPxufs91KgthICPMtzvQimZ6Umr6/TxdZmkkW7p6scHA==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr8993828pgn.391.1589891158758;
        Tue, 19 May 2020 05:25:58 -0700 (PDT)
Received: from localhost ([221.224.30.42])
        by smtp.gmail.com with ESMTPSA id d15sm3000809pjc.0.2020.05.19.05.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 05:25:58 -0700 (PDT)
From:   zhenghaili <hailizheng1993@gmail.com>
X-Google-Original-From: zhenghaili <haili.zheng@powercore.com.cn>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        hailizheng <haili.zheng@powercore.com.cn>
Subject: [PATCH] drivers/hwmon/nct7802: Replace container_of() API
Date:   Tue, 19 May 2020 08:25:19 -0400
Message-Id: <1589891119-16508-1-git-send-email-haili.zheng@powercore.com.cn>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hailizheng <haili.zheng@powercore.com.cn>

Replace container_of() API with kobj_to_dev().

Signed-off-by: hailizheng <haili.zheng@powercore.com.cn>
---
 drivers/hwmon/nct7802.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 2e97e56..570df8e 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -679,7 +679,7 @@ static struct attribute *nct7802_temp_attrs[] = {
 static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	unsigned int reg;
 	int err;
@@ -778,7 +778,7 @@ static struct attribute *nct7802_in_attrs[] = {
 static umode_t nct7802_in_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	unsigned int reg;
 	int err;
@@ -853,7 +853,7 @@ static struct attribute *nct7802_fan_attrs[] = {
 static umode_t nct7802_fan_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct7802_data *data = dev_get_drvdata(dev);
 	int fan = index / 4;	/* 4 attributes per fan */
 	unsigned int reg;
-- 
2.7.4

