Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92AFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D092074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="s1xR3LsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgIDPuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIDPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8D7C061261
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so6522827wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/17FBPXPIWM8suCIksrM34pviF3YRrgB9AFaEGMFdE=;
        b=s1xR3LsW3xC8wWHiTS17D3noApVypmQZqsrQfpiRs3PVIwAeFMZZbmrhd8Ci29gUPJ
         qeOOKIOcwVPtsmoJlPGUTae8LZaB1lpmP6r4EJ1NBihJlqmxiuHREKgewRXkyhcbElzS
         SS1a0rIr4TASNOM3hcJ3cZB11T75Gewkn/+XChRfGta6FMOWhPlpWi43w+qSn+26/cg3
         pbuCojaEVkETdLTS/bA9q1uWIDfRtJyA3iW487kzDXs//zaJpMKiytj5yoUxgcrwimPG
         bUmkGN4uCR708R4v0zUpXw1XNhk53ufiFhyihcZ01PCTVRPSHlYYUYA4uWSsDCodiL31
         v+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/17FBPXPIWM8suCIksrM34pviF3YRrgB9AFaEGMFdE=;
        b=q9xxfwEUyNBoxewVFhc9LKvng7dluRFMZzeLOewxzKHClr8hD68xpwP40VCFE/DBWr
         KbtrJEf3Jixh3ADBqcnanvYJfTxJG1W/q/aFAsQ8RAdAYtjpMfsOoL81g8MMz4uluiqz
         fmGjbBPusLAPWTJTHFiUMrHRxZGxfVCtpwIgS10QzOC4rp5HNIczB5C826ZBysPtVyYk
         ZwHTIKrVSsYELHjyFCcO2PMGffA/d31klwizOB0cLZypxzF5zbbGMKh/KR1phEuuBngN
         P4/wXDtdifjgjqTv6Nf3ldgoHRRHnja40tXzGKNl8CEfpfdwX0hc2A2akwgCgzmcVaDN
         lvyw==
X-Gm-Message-State: AOAM532kJVB1oew8XRc2QG81lUqXh1w5o1dKEilX6B+NWZAfAuSr+wtc
        E7JN1UdQIO2abdLrSIWRs6FUKw==
X-Google-Smtp-Source: ABdhPJz+8ARUs/kkukG0PPhJ3TJmui9hHStd+idsyDCLVB6+Ez/AJZiQ1EBjt7zRf0qJu3eKFFnoJg==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr8050965wmg.164.1599234394881;
        Fri, 04 Sep 2020 08:46:34 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/23] lib: uaccess: provide getline_from_user()
Date:   Fri,  4 Sep 2020 17:45:27 +0200
Message-Id: <20200904154547.3836-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a uaccess helper that allows callers to copy a single line from
user memory. This is useful for debugfs write callbacks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/uaccess.h |  3 +++
 lib/usercopy.c          | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 94b285411659..5aedd8ac5c31 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -333,6 +333,9 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 		long count);
 long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
+ssize_t getline_from_user(char *dst, size_t dst_size,
+			  const char __user *src, size_t src_size);
+
 /**
  * get_kernel_nofault(): safely attempt to read from a location
  * @val: read into this variable
diff --git a/lib/usercopy.c b/lib/usercopy.c
index b26509f112f9..55aaaf93d847 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -87,3 +87,40 @@ int check_zeroed_user(const void __user *from, size_t size)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(check_zeroed_user);
+
+/**
+ * getline_from_user - Copy a single line from user
+ * @dst: Where to copy the line to
+ * @dst_size: Size of the destination buffer
+ * @src: Where to copy the line from
+ * @src_size: Size of the source user buffer
+ *
+ * Copies a number of characters from given user buffer into the dst buffer.
+ * The number of bytes is limited to the lesser of the sizes of both buffers.
+ * If the copied string contains a newline, its first occurrence is replaced
+ * by a NULL byte in the destination buffer. Otherwise the function ensures
+ * the copied string is NULL-terminated.
+ *
+ * Returns the number of copied bytes or a negative error number on failure.
+ */
+
+ssize_t getline_from_user(char *dst, size_t dst_size,
+			  const char __user *src, size_t src_size)
+{
+	size_t size = min_t(size_t, dst_size, src_size);
+	char *c;
+	int ret;
+
+	ret = copy_from_user(dst, src, size);
+	if (ret)
+		return -EFAULT;
+
+	dst[size - 1] = '\0';
+
+	c = strchrnul(dst, '\n');
+	if (*c)
+		*c = '\0';
+
+	return c - dst;
+}
+EXPORT_SYMBOL(getline_from_user);
-- 
2.26.1

