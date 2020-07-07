Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B144206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA2DBIll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGGAWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGGAWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:22:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69FC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:22:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2so22415980pgc.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fij5Uh7COE6WXjPrVQpr9X/Ig6eFR/71WrRm3BLQkPg=;
        b=gA2DBIllta+JWJrQotTY71mKTQT1FV4hPwOG16MX/N+o+3s4xQFZMO1M7d1q1N+EAo
         zVbC+NuFemXLecSHkOrGZGPcJ51kUyCoHnry/ftqh7KuVFiV8GBdmwJfprw2WaDL6NNj
         GK3w11SpRrHr5pesm93AlaG076BcJ3uwdbFpdmvuuFSkxuCgRHZqFFcw89cg96fH1b+z
         Of3+fjsRTIgrj16I6Etj6DOJzqillTWS6lT+EifUUWcokRNnVkwBkHpcvWanNuHZWaUj
         wJCMU/3CkAPlsqCvAB+Rm696XVhIY6WO4GckkxwYfwF2UHMLsp+3iv02jXabZGuQhdRe
         A7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fij5Uh7COE6WXjPrVQpr9X/Ig6eFR/71WrRm3BLQkPg=;
        b=RJwOtWXTOnHSdSCRB1JNdDzEmjGS3TteCv4UR9oZG033jTMg1J2m77dxo8HRMxQqJ1
         PckWcCLH8a5GT+1g3j8F+BbbwdVkx0jIyD1863Qk1J132/Z0PLoQWRMmEu84NNnz+fOZ
         1uBXOt6fAsmNsd2oiKZLlu+8pg72/eyWlV3hnMTKmoycXyLUA07weFJt/Zy17IN6YWtl
         1JQQN8D1th8LMy2RWvGwBZhCcCbVkgJ7PTf2vxFTRM+IYyyy9tdKDgt/v6AqJnhFKcte
         Dlxp8R9jZwDUjo9rNaxxtpdey92tY/lRf9CBwkjqt7ED4LKtHOSJUGTaX895tCdVBCH0
         ctHA==
X-Gm-Message-State: AOAM5330+andXXK49XEjCX+WpBQ6ohIN0pVsDohPQrbVQkhGTBq6xSRN
        bKssfFEtQDIcMYCnTVkX7n094IPsMjTfUJBu
X-Google-Smtp-Source: ABdhPJzvrFRB/K4wKxyVqYOjy3YwmkPCVm7GNw+2uz0ye07WekWtm8QHE6JbVbReRNMJirl1/bvvA6WVmu9OPUgl
X-Received: by 2002:a17:90b:4c12:: with SMTP id na18mr314677pjb.0.1594081367628;
 Mon, 06 Jul 2020 17:22:47 -0700 (PDT)
Date:   Tue,  7 Jul 2020 00:22:03 +0000
In-Reply-To: <20200707002203.2494094-1-linchuyuan@google.com>
Message-Id: <20200707002203.2494094-3-linchuyuan@google.com>
Mime-Version: 1.0
References: <20200707002203.2494094-1-linchuyuan@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v3 2/2] hwmon:max6697: fixing the type issue where the
 comparison is always true
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@google.com
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, zhongqil@google.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Use reverse christmas tree order convension
  - fix the type issue where comparision is always true
  - Change the line limit to 100 char instead of 80 char

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/max6697.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 8c814c544116..6b213e146fbe 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -329,15 +329,13 @@ static ssize_t offset_store(struct device *dev,
 			    struct device_attribute *devattr, const char *buf,
 			    size_t count)
 {
-	long temp;
-	u8 val, select;
-	int ret, index;
+	int val, ret, index, select;
 	struct max6697_data *data;
+	long temp;
 
 	index = to_sensor_dev_attr(devattr)->index;
 	data = dev_get_drvdata(dev);
-	select = i2c_smbus_read_byte_data(data->client,
-					  MAX6581_REG_OFFSET_SELECT);
+	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
 	if (select < 0)
 		return select;
 	ret = kstrtol(buf, 10, &temp);
@@ -345,22 +343,18 @@ static ssize_t offset_store(struct device *dev,
 		return ret;
 	/* disable the offset for channel */
 	if (temp == 0) {
-		ret = i2c_smbus_write_byte_data(data->client,
-						MAX6581_REG_OFFSET_SELECT,
+		ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,
 						select & ~(1 << (index - 1)));
 		return ret < 0 ? ret : count;
 	}
 	temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
 	val = DIV_ROUND_CLOSEST(temp, 250);
 	mutex_lock(&data->update_lock);
-	ret = i2c_smbus_write_byte_data(data->client,
-					MAX6581_REG_OFFSET_SELECT,
+	ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,
 					select | (1 << (index - 1)));
 	if (ret < 0)
 		return ret;
-	ret = i2c_smbus_write_byte_data(data->client,
-					MAX6581_REG_OFFSET,
-					val);
+	ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET, val);
 	mutex_unlock(&data->update_lock);
 	return ret < 0 ? ret : count;
 }
@@ -368,18 +362,16 @@ static ssize_t offset_store(struct device *dev,
 static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
 			   char *buf)
 {
-	int select, ret, index;
 	struct max6697_data *data;
+	int select, ret, index;
 
 	index = to_sensor_dev_attr(devattr)->index;
 	data = dev_get_drvdata(dev);
-	select = i2c_smbus_read_byte_data(data->client,
-					  MAX6581_REG_OFFSET_SELECT);
+	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
 	if (select < 0)
 		return select;
 	if (select & (1 << (index - 1))) {
-		ret = i2c_smbus_read_byte_data(data->client,
-					       MAX6581_REG_OFFSET);
+		ret = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET);
 		if (ret < 0)
 			return ret;
 	} else {
-- 
2.27.0.383.g050319c2ae-goog

