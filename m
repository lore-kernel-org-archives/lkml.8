Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80314C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B62920746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dykk22od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKDnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727824AbgEKDnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 23:43:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00296C061A0C;
        Sun, 10 May 2020 20:43:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so3461392pgv.8;
        Sun, 10 May 2020 20:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U84COOeYtRpAM7eRRotZrI3ddShd7/ixg+GnaNA9BFg=;
        b=Dykk22od04k4WptQIHPcyfgSQUiGElApYnK2RcqI7mKqCR1HUqTIUL1DuuN5GVRpSZ
         0LbnLW9FS1a9nVPygMPt5PFqfoEtlzf9Z1giIFYzcRqIuy1WFHJCSLW/RpdmQsjeST7M
         KuTaFT0I96DSBZiJAkgRTn0+csux+B4yjr6YfhEdHXZvlPxin4XiUVmBhMiXv7FxVsVt
         LvKIErU9uqw/sZ9/Vt/Y0foM7jaS1zUga/6KPysw4WTV3MsKm1WAXXB/Co+xkT2kUmqb
         OkAw7EAq9oT9YRlpZMe7I7BEa/c3sMUcQerHMvg8KLX5IKhhSQbzOG+5ZG5a4l2UENn0
         5/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U84COOeYtRpAM7eRRotZrI3ddShd7/ixg+GnaNA9BFg=;
        b=PD5YVV68GP6DGN0rRMWqCufwb+0FYQqjx33w6R/6HT/JaO3WuaK9K1t4m4mp70JQkl
         qs9j91QQMSpUezw3wI0jTJDyglHmojoNFGmBlRwYNWnAkoRCDE6TXsRZ5j7Tsg4WGjTP
         niPf+s8qdBl9Tk4bKQg2cLrGzkTdUWIvNfXJEPHPxdzIr1c/cdAzeb9V2I2AKxyWsfx2
         qWcVM6nFsvcOhtiIxah8Ucv2SSXvJdFu3+Rm0pYFpxbmflSInuF7I6fY58taA6GTTHRT
         nkBYex4iXPc5Pc+RaXE9bwdkuRe4xtzdcb8Wrgix6FgO+5n5izT3TPjPz58fzUKyEU93
         0QpA==
X-Gm-Message-State: AGi0PuYr1H2GO5jS6kheDqVNcA/2f0PEk7BuB6eqBdux9H4utn/ASTC/
        g1kqob8nJORdsmU6lO1Bl9k=
X-Google-Smtp-Source: APiQypKOH/jX/6/Yy0is3q7Nj5+T7ceq2B5BiieYUefl7AD1XRAqNmYG226QniqidKrxTJ4RzM4Ycg==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr12569699pgc.241.1589168596436;
        Sun, 10 May 2020 20:43:16 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id y16sm8108282pfp.45.2020.05.10.20.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 May 2020 20:43:15 -0700 (PDT)
From:   zhouchuangao <chuangaozhou@gmail.com>
X-Google-Original-From: zhouchuangao <zhouchuangao@xiaomi.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: [PATCH] driver/hwmon/nct6775: Use kobj_to_dev() API
Date:   Mon, 11 May 2020 11:43:06 +0800
Message-Id: <1589168586-7796-1-git-send-email-zhouchuangao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>
---
 drivers/hwmon/nct6775.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 7efa6bf..e7e1ddc 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -2047,7 +2047,7 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 static umode_t nct6775_in_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int in = index / 5;	/* voltage index */
 
@@ -2253,7 +2253,7 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 static umode_t nct6775_fan_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int fan = index / 6;	/* fan index */
 	int nr = index % 6;	/* attribute index */
@@ -2440,7 +2440,7 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int temp = index / 10;	/* temp index */
 	int nr = index % 10;	/* attribute index */
@@ -3257,7 +3257,7 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int pwm = index / 36;	/* pwm index */
 	int nr = index % 36;	/* attribute index */
@@ -3459,7 +3459,7 @@ static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
 static umode_t nct6775_other_is_visible(struct kobject *kobj,
 					struct attribute *attr, int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nct6775_data *data = dev_get_drvdata(dev);
 
 	if (index == 0 && !data->have_vid)
-- 
2.7.4

