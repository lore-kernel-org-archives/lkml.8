Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2845C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F0420772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="c4iemgVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIDPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgIDPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C595C06125E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so6494296wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWT4LMe1jlQ5F4wTOV6aM7wzQxRaEROx7lvhEPCZV1g=;
        b=c4iemgVawDaHCECJORVkcx3F23o+ngLwd98jCO5TKSproRslYQQctVYTTM8UAJMpno
         9OahHxJIeo5aYvZNRQPvh2jQni7929HthhKQDT5j1D4kwPLA1oL5+XlcMiOwPCZ706kw
         PnJg4bP95Tel8j4NTMYLFXvz80DER0vDH7VENrsFyr329Zym+rZ9HGUJ97VEu7DS47cl
         y7AfhrjHufDdd3ZXZ4+iD9HT9YTtKRt3c/qVr4Cr3W4FCxwVkxwX/GWNt5HJpqxW7O5E
         ku1RbS4J9HF/RsQr9ckv3YiIz2dhVM8llU2PTQ7jPwTbSIWYWa1IUIBiUSSt8RPUngM2
         2Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWT4LMe1jlQ5F4wTOV6aM7wzQxRaEROx7lvhEPCZV1g=;
        b=sScgM60pMQK2MEH5KTkpCdQiwLRpw3+D3FeD5O6P5ychvG6yTwnasJEEuBqbx4VKvv
         qhWu6040wLArfMUqhCFREF+9OQI3E5SXdIhuvLm/123474TuAi/AtF9gpeoEu+QFwxGD
         dmd7fwsjCCQ7GGb07ROmwW+DTVJ68z+3xQUM4zXMfZwf39cIqzUzqr7eVIFU8G+wWfIi
         07UgPM8eLowM/X0jITYOANCGDJy7aFvjmhdkSbECTOxTqlZgNdsq/3V+xyLi6MJqTvwZ
         F0R+tdvUDzhC26HK3YVWr7Twypr9zMKrBC0PUCV6P6iunMVI2kTpZpeXZRbILMLg3vgk
         cf4A==
X-Gm-Message-State: AOAM531ODCTROvyaTDb6PzNy6Gqz121wNdkgD2TOUNDEiyHUdR04efNI
        XOACnJo9rh3YJ+pfTIPTujE/OQ==
X-Google-Smtp-Source: ABdhPJzIHOojNgmX6R7Azvg1X7daJLCe748526/eTTIsYoMZCTXYG8GFpTts0cg6K3JXTDM7/wavuA==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr8883702wmj.68.1599234393322;
        Fri, 04 Sep 2020 08:46:33 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/23] lib: string_helpers: provide kfree_strarray()
Date:   Fri,  4 Sep 2020 17:45:26 +0200
Message-Id: <20200904154547.3836-3-brgl@bgdev.pl>
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

There's a common pattern of dynamically allocating an array of char
pointers and then also dynamically allocating each string in this
array. Provide a helper for freeing such a string array with one call.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 86f150c2a6b6..55b25120a1c6 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -94,4 +94,6 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
+void kfree_strarray(char **str_array, size_t num_str);
+
 #endif
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 963050c0283e..22505efc6aae 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -649,3 +649,25 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 	return pathname;
 }
 EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
+
+/**
+ * kfree_strarray - free a number of dynamically allocated strings contained
+ *                  in an array and the array itself
+ *
+ * @str_array: Dynamically allocated array of strings to free. If NULL - the
+ *             function does nothing.
+ * @num_str: Number of strings (starting from the beginning of the array) to
+ *           free.
+ */
+void kfree_strarray(char **str_array, size_t num_str)
+{
+	unsigned int i;
+
+	if (!str_array)
+		return;
+
+	for (i = 0; i < num_str; i++)
+		kfree(str_array[i]);
+	kfree(str_array);
+}
+EXPORT_SYMBOL_GPL(kfree_strarray);
-- 
2.26.1

