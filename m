Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBB72071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv6dYDuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404257AbgAXUMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:12:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50447 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgAXUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:12:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so673624wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGbQnLomT2aL9ymHA2JYgr/2Hjo++MPrBSVpPt1u9L8=;
        b=Cv6dYDuVI4HDMQ1Gb0DgdKlfDV5tNc7zZBCipBctbv0S6787hwRBrLZga1Nid5CX4U
         7oBbWOrrtZwXduVVJu1UBt1ossSW2L9TfYsVfnS2dV51w2QKsjp0yEDMw9+CODAlKUcJ
         DMIthNSr5Ews9CDaXHi4QTtPT0tA9NUhfQFbNn9Jak1hrhfXu+ZQHdzhIcnfhYbTXWbT
         InaUAlsyrvS5p1or6nXvdZngdGlEU8i7rzdWlDj6lM/dM354ImRfDMIWn3AQ2QKOS8Ac
         uFJfOSzBlhnmw9R7UU1UEzJkfHwltdYePiX6D5mYTsJgEqdXKy295rRemcsp4mxeOYhI
         aCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGbQnLomT2aL9ymHA2JYgr/2Hjo++MPrBSVpPt1u9L8=;
        b=fmnOb/4+MVFIDNzvFRHxeW8rd8GyqJO3wCZw2MoJ8je3EE+zZORrdJTlyYE2Gm7zRI
         uKPAlyrB2BzVe4GNxnFm4j5qIQouCmoHLCHqQh3EvoxzPcdt0tgaBUNFYYs9aZ8wopYO
         oynQTrrSpCfF3a65njT/AO/nPmXCqPVMxnfIZWBGoRkjSsJsWMN7YiP6D5SnljCJS3/M
         eBasaBtgxxbcUbEyZXAI4JtrnjG+Gxb8y5SNHnepbViwiy9SMOv4aUDOK7zoC/7+3ky2
         fXUzv6H7fK+ZU351+jWZvgHxh8af+YO+nHkmgNIt0ruei3IaR2oIg8eL76fxX9f9aY92
         bSRA==
X-Gm-Message-State: APjAAAUoDTU6ftrnA4Gf+0DE3YnZsrxk3xZw/hSKYSn2qdF0S77iRoN3
        qldT2Pm5CK8QKe6952mG+g==
X-Google-Smtp-Source: APXvYqxwcBfj68Aa84T1/BrX2GAF8rW1UKxr4deCJeZnxjD28LHHPH+s2yb3ZtDJjCwWvdv4HxhFqA==
X-Received: by 2002:a05:600c:d6:: with SMTP id u22mr789089wmm.77.1579896756313;
        Fri, 24 Jan 2020 12:12:36 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.googlemail.com with ESMTPSA id i204sm6897654wma.44.2020.01.24.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:12:35 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] time: Add missing annotation to lock_hrtimer_base()
Date:   Fri, 24 Jan 2020 20:12:21 +0000
Message-Id: <31c31ca2d78d9368d38e1a5909bc0c9a7be5dc98.1579893447.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579893447.git.jbi.octave@gmail.com>
References: <0/3> <cover.1579893447.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at lock_hrtimer_base()

|warning: context imbalance in lock_hrtimer_base() - wrong count at exit
|warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
|warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
|warning: context imbalance in __hrtimer_get_remaining()
|- unexpected unlock

To fix this , an __acquires(timer) annotation is added.
Given that lock_hrtimer_base() does actually call READ_ONCE(timer->base).
This not only fixes the warnings
but also improves on readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/time/hrtimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8de90ea31280..8f555b49395a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -160,6 +160,7 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
 static
 struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 					     unsigned long *flags)
+	__acquires(timer)
 {
 	struct hrtimer_clock_base *base;
 
-- 
2.24.1

