Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D2AC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5502072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HwcNoIc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBQIcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50520 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgBQIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so6824379pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqZre+qvRSlhzzIsQAOcDiYE/HQp90HazzZ9Hh0zU/8=;
        b=HwcNoIc+nhRG7KN6U7GJ/P5tvJVQpfZLmZ3SodJKoS/AdlZAd18lHi9giRGFtuQs14
         qD4SyEasVBlRnYYsohlKQZghcYaIe6o8VQceYzD0d8fR1QfMX7CfDXuyPgF9FRknqUpD
         kPCZIcw2Y/U2XOPbf3ic2AGus5iXzeIrGEcmi0U/51P1JsnN0TcKopFe4Lcn45e8gnpC
         7hEqRIEohlpjyBj0cPgUWdj3BUTvYxH9tKXbToLTszDj8Q0QSBvdx3VzbLZd4FXPVIPD
         UdI3Um6zCRsbQvBseeB8fuC+KIteMRgQU5oL4AmTQKB6GytYK1xpXRama5SQHnb2xTC0
         DRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqZre+qvRSlhzzIsQAOcDiYE/HQp90HazzZ9Hh0zU/8=;
        b=BVOHoV24Ea1y8jwyHX4vOD5zY/xZlfwMBp0zG3X4sBpWEzXO4KgW80WAi3CgPzevoB
         ozG7N5KzP2aeKbsj+lQ5Jl46s7XdEzYL27rduefMU8PzDc1pOv6aKq2/fCvMBJPLWAL5
         iQ1aFS/75N++sfBEr9eFflbDkxQoYz9YnEGw759ONMjhmaIkB4/fRI0wOju/BXIp8Dnn
         7hcQfZY5cRwFK904QrqhM5mF4V21GNg8PqzgGAXrivCp8KUYuswIjCwWfRUN2XrjwwmT
         hsvgQw8z/xK0R6GR2vvnWqf6Rr2+w0+x/vn/OgEfDIH6Ah3ml82sGoE87rBkSWdHWJJX
         EaTA==
X-Gm-Message-State: APjAAAXfVvDVbG2trjaAdQzccwyX9KxkmfSTGQ3QvM0xkMHlW9Hc5+rm
        wOJOPrvrnvtawGrK4wLMbn9E5CyianY=
X-Google-Smtp-Source: APXvYqy+2s0Zjwc0q2R9Pe28sHcFC9n4l5MJdG4iOX9zFBrwLpWdVyrjUYVsdsgQdYU4G3MPld8yrg==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr18718381pjb.94.1581928360712;
        Mon, 17 Feb 2020 00:32:40 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:40 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 7/8] riscv: add DEBUG_WX support
Date:   Mon, 17 Feb 2020 16:32:22 +0800
Message-Id: <20200217083223.2011-8-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support DEBUG_WX to check whether there are mapping with write and
execute permission at the same time.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig.debug        | 30 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/ptdump.h |  6 ++++++
 arch/riscv/mm/init.c            |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index e69de29bb2d1..2bcd88e75626 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DEBUG_WX
+	bool "Warn on W+X mappings at boot"
+	select PTDUMP_CORE
+	help
+	  Generate a warning if any W+X mappings are found at boot.
+
+	  This is useful for discovering cases where the kernel is leaving
+	  W+X mappings after applying NX, as such mappings are a security risk.
+	  This check also includes UXN, which should be set on all kernel
+	  mappings.
+
+	  Look for a message in dmesg output like this:
+
+	    riscv/mm: Checked W+X mappings: passed, no W+X pages found.
+
+	  or like this, if the check failed:
+
+	    riscv/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
+
+	  Note that even if the check fails, your kernel is possibly
+	  still fine, as W+X mappings are not a security hole in
+	  themselves, what they do is that they make the exploitation
+	  of other unfixed kernel bugs easier.
+
+	  There is no runtime or memory usage effect of this option
+	  once the kernel has booted up - it's a one time check.
+
+	  If in doubt, say "Y".
diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
index e29af7191909..eb2a1cc5f22c 100644
--- a/arch/riscv/include/asm/ptdump.h
+++ b/arch/riscv/include/asm/ptdump.h
@@ -8,4 +8,10 @@
 
 void ptdump_check_wx(void);
 
+#ifdef CONFIG_DEBUG_WX
+#define debug_checkwx() ptdump_check_wx()
+#else
+#define debug_checkwx() do { } while (0)
+#endif
+
 #endif /* _ASM_RISCV_PTDUMP_H */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 09fa643e079c..a05d76e5fefe 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -509,6 +509,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
+
+	debug_checkwx();
 }
 #endif
 
-- 
2.25.0

