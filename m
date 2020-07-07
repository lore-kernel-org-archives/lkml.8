Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9795C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A882073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW7PtF7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGGObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgGGObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:31:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D2BC061755;
        Tue,  7 Jul 2020 07:31:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so16815243plq.6;
        Tue, 07 Jul 2020 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0nz+1FAozvxz4aD0FyzlhABh4V7jlm3CdKShkpSDRA=;
        b=eW7PtF7NFYk1NicfihJofSgAhLqj7PraQUnp9z6VGmFxAEdJNqCmBEXVdK7aeNuGMm
         94O0+goyRiecvMNQvEwom8ULyaCkZZzbVAHWMPysc0lsNkHP7SJzAJXSQreJcqTG5W/h
         OqmpJGyHkkzdVbv0qTMcYVs2jvkKsQo2CxNVhCf1Bvdch83rU+XIyMTeESkf36+w/CGC
         YPGjNC9454H4j9uP1IjJPIs4zI6orpDSp7bGMXQR5KUHvQ/uqxXi4Yr/BwZa5d2+GT1+
         m4TlG964HnNZTssEb4u0lYpwh5T5O+wT6NDmvqrCATKqv/65gBXhmuq2IeMMH2r+c5vR
         sThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0nz+1FAozvxz4aD0FyzlhABh4V7jlm3CdKShkpSDRA=;
        b=lX/fN4q+UdL2wmbY2bpO2bpssN2YZ9Lka6lHWR8A7Ahzkpe+e4Fc0/Qfs8JROEr/Tz
         chDkLPVZ64gt7Zg9uRi1xXVBEFmQ156KUsICGPdiamU63x+LcH0o7051LNEiscrt9wMN
         9gNFaWKMfRzITSqUeGngkuumfrFqICKxjdUSfbXgTJOSkX3+VtS6Lj5M7c6QSVzjqXeu
         CS3f9UZpClJhBiRGyq18Q5KmIcyqxKlrGzGm9JUC4H/dLJ4MOiuWEp9EQmoJqNdPRDUY
         +XX3w8ApxriY9PqM/YQL8SQKFLL6xwvLX2vTPkbz4INFi57Vn9DrZOw1yS//VhmSVIM6
         le6g==
X-Gm-Message-State: AOAM532Pi0hzIstc2BUovmDFfWyJ/wBGfrDSLgf2VQhqBSECmfDZv7il
        1EKbB7VfdOvGtm/LNbDOWJFy+r50swYeuQ==
X-Google-Smtp-Source: ABdhPJxloa0N7jgpB2WDZ/s0AhGF57yia3mju1qYn5+CWNJsmWvkhtRY7sKGqd7PU/zvv0lfTIewEA==
X-Received: by 2002:a17:90a:e50c:: with SMTP id t12mr4622378pjy.209.1594132269209;
        Tue, 07 Jul 2020 07:31:09 -0700 (PDT)
Received: from localhost.localdomain ([103.228.223.183])
        by smtp.googlemail.com with ESMTPSA id u26sm1219478pgo.71.2020.07.07.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:31:08 -0700 (PDT)
From:   Vishwas M <vishwas.reddy.vr@gmail.com>
Cc:     Steve Glendinning <steve.glendinning@shawell.net>,
        Vishwas M <vishwas.reddy.vr@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (emc2103) fix unable to change fan pwm1_enable attribute
Date:   Tue,  7 Jul 2020 19:57:47 +0530
Message-Id: <20200707142747.118414-1-vishwas.reddy.vr@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug which does not let FAN mode to be changed from
sysfs(pwm1_enable). i.e pwm1_enable can not be set to 3, it will always
remain at 0.

This is caused because the device driver handles the result of
"read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg)" incorrectly. The
driver thinks an error has occurred if the (result != 0). This has been
fixed by changing the condition to (result < 0).

Signed-off-by: Vishwas M <vishwas.reddy.vr@gmail.com>
---
 drivers/hwmon/emc2103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 491a570e8e50..924c02c1631d 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -443,7 +443,7 @@ static ssize_t pwm1_enable_store(struct device *dev,
 	}
 
 	result = read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
-	if (result) {
+	if (result < 0) {
 		count = result;
 		goto err;
 	}
-- 
2.25.1

