Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8026C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943DF20825
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+AkTBXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgH2Xil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH2Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:38:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A60FC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so2496902wrm.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gR6earlvAFNRcUw4sVCxPtBxPfjjAjdl9voNOlT11FA=;
        b=L+AkTBXdg68ilCOINEw94OLD2BbFpHlWVbCBHYY8HmaQC6KMdJE0SJ6vpUSl9XZhx1
         R55uW70znp/kJHxBwFViNW1wMswqRPA3TSkiyVBPE6pSmoPU1sHIpRLmeylxlAUS32nI
         bOn1KmCvm+vGTN8UuujhpxB+wLAMLwIRGRBqYuVEuzyvvwEuwFAOdUISG2Fhkl0nAAJ+
         yam4mE3a9oo4OBhN63ZzgkCSpQ/pWNIukOwjXsiUYwMICEWTpqLokM8G9yzpSOU271DA
         V+RQPFrWg0Oqi7MJdOwjE9UPC9SDLNqrXOE2Amr/vchGkIT88objXHHT2MIuSPMv47Xz
         qjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR6earlvAFNRcUw4sVCxPtBxPfjjAjdl9voNOlT11FA=;
        b=tbQNgzKMwvjiWuOlRvkzaeKOtasj1PgAwsMQ0IhG/zYb8xoXH0e0PrZvExt0v6tE6U
         yHtH+toRe+uNi7xn0H4PD4zrQ1nlE+ShcaeMB+Pmb7WU1d7yIJBYYc62aI3GW0TS92gD
         rplvZyS4gw5YV2bv6ZpAffD5UTm5CHIUgSKJ3weIUZoV0Ev7Zs+kOmrw/jCzaOjqUrDT
         JJb1IOmvJaTNuZ8cVh3YJKqedqljvJr19848OPnsHbLYRnbYCx05FClzq30n7h7ztakJ
         FZvX49NQfoUbgl08rczkWzJViEvUy9d3D+6sjX8USx0v3Zo6n8G/W4nAN4v6DE2vJ/hQ
         /58A==
X-Gm-Message-State: AOAM530DiONHRvgFQRJdJVZ+8MSAKerfLWCXODeQlqPyKSPp6CDQuf2B
        OPUgMGCMp3hmd17oYQcip3Q=
X-Google-Smtp-Source: ABdhPJxhWjQ2XNe4aQpTkSR1DSRMKGgZR9Hd83mMqoqg2YPR7sDck2Co0aVJqv1e2P2wGmsIYx7gVw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr5128865wrl.35.1598744319223;
        Sat, 29 Aug 2020 16:38:39 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id t13sm5253878wru.65.2020.08.29.16.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 16:38:38 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] sysfs: add helper macro for showing simple integer values
Date:   Sun, 30 Aug 2020 00:37:17 +0100
Message-Id: <20200829233720.42640-3-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829233720.42640-1-alex.dewar90@gmail.com>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs attributes are supposed to be only single values, which are
printed into a buffer of PAGE_SIZE. Accordingly, for many simple
attributes, sprintf() can be used like so:
	static ssize_t my_show(..., char *buf)
	{
		...
		return sprintf("%d\n", my_integer);
	}

The problem is that whilst this use of sprintf() is memory safe, other
cases where e.g. a possibly unterminated string is passed as input, are
not and so use of sprintf() here might make it more difficult to
identify these problematic cases.

Define a macro, sysfs_sprinti(), which outputs the value of a single
integer to a buffer (with terminating "\n\0") and returns the size written.
This way, we can convert over the some of the trivially correct users of
sprintf() and decrease its usage in the kernel source tree.

Another advantage of this approach is that we can now statically check
the type of the integer so that e.g. an unsigned long long will be
formatted as %llu. This will fix cases where the wrong format string has
been passed to sprintf().

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 include/linux/sysfs.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 26e7d9f69dfd..763316788153 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -197,6 +197,37 @@ sysfs_strscpy((dest), (src),                                         \
 		)                                                     \
 )
 
+/**
+ *	sysfs_sprinti - emit an integer-type value from a sysfs show method
+ *	@buf: destination buffer
+ *	@x: the variable whose value is to be shown
+ *
+ *	The appropriate format is passed to sprintf() according to the type of
+ *	x, preventing accidental misuse of format strings.
+ */
+#define sysfs_sprinti(buf, x)                                                               \
+({                                                                                          \
+	BUILD_BUG_ON(!__builtin_types_compatible_p(typeof(x), unsigned int) &&               \
+			!__builtin_types_compatible_p(typeof(x), unsigned long) &&           \
+			!__builtin_types_compatible_p(typeof(x), unsigned long long) &&      \
+			!__builtin_types_compatible_p(typeof(x), int) &&                     \
+			!__builtin_types_compatible_p(typeof(x), short) &&                   \
+			!__builtin_types_compatible_p(typeof(x), unsigned short));           \
+	__builtin_choose_expr(                                                               \
+		__builtin_types_compatible_p(typeof(x), unsigned int),                       \
+		sprintf(buf, "%u\n", (unsigned int)(x)),                                     \
+		__builtin_choose_expr(                                                       \
+			__builtin_types_compatible_p(typeof(x), unsigned long),              \
+			sprintf(buf, "%lu\n", (unsigned long)(x)),                           \
+			__builtin_choose_expr(                                               \
+				__builtin_types_compatible_p(typeof(x), unsigned long long), \
+				sprintf(buf, "%llu\n", (unsigned long long)(x)),             \
+				sprintf(buf, "%d\n", (int)(x))                               \
+			)                                                                    \
+		)                                                                            \
+	);                                                                                   \
+})
+
 struct file;
 struct vm_area_struct;
 
-- 
2.28.0

