Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9213C352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805992072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AsYJABa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634592AbgDOAZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbgDOAZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:25:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFDDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:25:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ay6so3185969pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y4P8rWiotzQvb4JxyUfpgXR3sblXTGBUlf8HwRLY7Kc=;
        b=AsYJABa9hWEbNsCLZkMt/OCoNzfNwn/PFH5DvXWcOFmj0zSxjoT9Xj7gjW0EwgQqeg
         2YtAplcWXxOBgTdg1AhsL1QHgA7fYSSgofdbx395pC9kP74ENeJrHlA2WZsiqsvt3lQt
         KQSry7u4otle1WPyN5l08+Ebf6aMQ1NA1mC/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y4P8rWiotzQvb4JxyUfpgXR3sblXTGBUlf8HwRLY7Kc=;
        b=T2tL9kFOlk+2580tKdKT8slyuEGR2whQc03K1lddI7apKz1+bxw1JQtK4+a6xgW0p7
         Kmbk7CGe8WM+BwnGmmx9UwangEwGF30INRl3OYPV2299IxBtGUWHiRCUcOegeuxc8W3O
         SsEGCTUXOAr4g8mMn867OCy0uyvvaxFXdx5TnlF2AqLAv0Njqb5RAN61qom0B/E6mkr8
         NYMlt+YweM6b0xO9+PSJBZc1mBcf0tT9s8p6i9Hyg06NyihFmB7NxJjkfqQxVu4RX3DO
         Ikm6WB+SiHyjmchNgL82nMPEa+UWGgIoDlpCNilTYZ5+I9jU0BlljvrnEBoxHJ1muQ1q
         bAGw==
X-Gm-Message-State: AGi0PubK/yZvTSi+m4wGHymrtNhvDnGmPOOQyBiblKcXmeyhIApe6gf0
        HMnOqtf65D8NqwySoGsbBQ4t1w==
X-Google-Smtp-Source: APiQypKGHCKpDkSFeTfwGA6QewjHHXSq+/zD/8rw7FSMGD7U7vonI+gEQq9MYBJNXyMNe4BdWpsLtg==
X-Received: by 2002:a17:90a:c304:: with SMTP id g4mr3029358pjt.157.1586910334896;
        Tue, 14 Apr 2020 17:25:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z7sm2878341pff.47.2020.04.14.17.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:25:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] test_firmware: remove unnecessary test_fw_mutex in test_dev_config_show_xxx
Date:   Tue, 14 Apr 2020 17:25:17 -0700
Message-Id: <20200415002517.4328-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
functions that show simple bool, int, and u8.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 lib/test_firmware.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 0c7fbcf07ac5..9fee2b93a8d1 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
 	return ret;
 }
 
-static ssize_t
-test_dev_config_show_bool(char *buf,
-			  bool config)
+static ssize_t test_dev_config_show_bool(char *buf, bool val)
 {
-	bool val;
-
-	mutex_lock(&test_fw_mutex);
-	val = config;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static ssize_t test_dev_config_show_int(char *buf, int cfg)
+static ssize_t test_dev_config_show_int(char *buf, int val)
 {
-	int val;
-
-	mutex_lock(&test_fw_mutex);
-	val = cfg;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
@@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	return size;
 }
 
-static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
+static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
-	u8 val;
-
-	mutex_lock(&test_fw_mutex);
-	val = cfg;
-	mutex_unlock(&test_fw_mutex);
-
 	return snprintf(buf, PAGE_SIZE, "%u\n", val);
 }
 
-- 
2.17.1

