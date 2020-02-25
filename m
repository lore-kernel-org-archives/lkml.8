Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDAC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBBE2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsxYTXV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBYCXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:23:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40317 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgBYCXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:23:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so602687pjb.5;
        Mon, 24 Feb 2020 18:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m8hULrGihgVZOxgfqnivBDbgwY8abtgQaozDoMq6UMc=;
        b=hsxYTXV/qlGl3OwRfYspSMFfZJyUAcuhKwT2z7BW9BwfLwPVAeMHeUCnUy7kMMpUbt
         SLSAgmXSXBJ2v01YlnwRI5nZnZeMj/eptGHF0FPy7/DGdOqgKIdCelCDa2iORztISSef
         86QCX7bhIhnYKxJlAWK93SANVj2b4Oc8fLAHFOIatA531SMoDccuL6wAmq6PwchD/3ab
         FHVE+jrQ+fhM22fG0sVzIDxLw/hGV8P/TvFd4Ldxu9hzY/vdKV9t5DKuXtbWC4oxiIw6
         2t6JX1T0vN+D7zNGGEcBe4Uu3fCjUp+ZTgeHDuS96+rdpkgl0eSV/RZ41DpmuEaotFSh
         7TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m8hULrGihgVZOxgfqnivBDbgwY8abtgQaozDoMq6UMc=;
        b=saAhZdGi+5A8E8QPK33pM1lx5sTJ7MGwmhM0XR5ZZ7yhOqfa7J1aaok+QR27d+1lhC
         yzoHhvTQ700Gy0bCD0nYgrlBtC3EWfb0nmvk0QLjGZxxwpR6pGjzsog8awBW6HbZvwwG
         2TOMUeKXPo7izHI7qv1oD9yP/33BmEwCNwg12P+Et/3/836aAVH3P88Jc4Ijc0XPPhD2
         O9+y/t1tIlq2ynRJdo2Bju6Cm9a0BIm3bIUsedd6dijqhmKJTJWlT5ITWpG/zINXtYKR
         7f49O4STTgKkiJ9HvG2Lt2C0Ap+1sUyGn7egExaV3F3Ms22bqY/ajecdwSIHDVdECZ1v
         H6Sw==
X-Gm-Message-State: APjAAAXpYP64qV0BAKF2i1iHIKG9pAClw6kdKkWByjIRm6zHsAcmVRVP
        T0hqWpO3/+hKENpyMAWkm2U=
X-Google-Smtp-Source: APXvYqw/c5fOX/rsITgDH/vSqNiuMvjx2EnBkD83jV4tKnj3AteLYS5cn+Ng8GgddNzbzOVekee7AQ==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr54303402plr.5.1582597402887;
        Mon, 24 Feb 2020 18:23:22 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id m15sm5066220pgh.80.2020.02.24.18.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 18:23:22 -0800 (PST)
From:   guosongsu@gmail.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        suguosong <suguosong@xiaomi.com>
Subject: [PATCH] RTC: use kobj_to_dev
Date:   Tue, 25 Feb 2020 10:19:23 +0800
Message-Id: <20200225021923.8570-1-guosongsu@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suguosong <suguosong@xiaomi.com>

use kobj_to_dev instead of open-conding it

Signed-off-by: suguosong <suguosong@xiaomi.com>
---
 drivers/rtc/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index b7ca7d79fb28..950fac0d41ff 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -279,7 +279,7 @@ static bool rtc_does_wakealarm(struct rtc_device *rtc)
 static umode_t rtc_attr_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct rtc_device *rtc = to_rtc_device(dev);
 	umode_t mode = attr->mode;
 
-- 
2.14.1

