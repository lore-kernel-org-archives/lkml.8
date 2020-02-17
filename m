Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46FC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204F120801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QRcu7K1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBQIcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33057 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgBQIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so2065786pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQSZYEZ2vhkMED23W6rsFbYhYDKZOEiTycR94nUJ+Ew=;
        b=QRcu7K1ynFQwM/E1GpcioKUsU0jYPrs/IocnAODOpl69n8tyPN0p1m5oqePM3+dU+p
         YXh3OKQ7P927emmDXw95LEbZN6PRdCzzoqyHvyiPtpqu7FXPwU3ttIujRunfr43PaaQs
         lbqIDXrg94IkC/U1l9jxl47ENqXcpB0O3k2lIIrFDllsVk+fwEuN1vlRo1353ejNfxCE
         OM50ksoOxNJY6zn+w3oA34LR7DyD79xytbkFjqCUdM8xmUsF/C2UI2CHjvWtbzXNexsT
         0s8Sqpf83fllFTHw8kW4U/idvnIZP+wqX8nMQAn4J+gqkdoogp9ExNVPU5Uq1WmWjIVR
         WthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQSZYEZ2vhkMED23W6rsFbYhYDKZOEiTycR94nUJ+Ew=;
        b=YhritjcWBM+9jS6cLMsFJbDu8AOpyQOEMApKCOK1uxHRhf70Kjm/2B3FYfZlPlW7OL
         xQFoktibHZSLJLMyzlWtRaun3S45NknTtR5bkCwbQJ2c2fcONdgkfdB61i67tJlt6Z0Z
         rgeka5hworRzNhIfQU1LlRpAg46exyhPWZ7MxEFOTxRuz10lgxoxeLA+ZkWtRWDVYTEY
         +l0uXenWTQZbMSR1Kxr+nUKMgb3qL0IxY/qdc/BvfCRHC24pBnrxa8i68WFVub0Nsm2U
         Ooaq+W40ByzkgZNad91iQ0ZZYpQtfYqAq9PDnKFu+Rh16NhJGJetiiXWU3UaXAk887h/
         m5zA==
X-Gm-Message-State: APjAAAUIi18WPdT+cB07+v2ukS1r4BbFIdOYiZfzU5O0BGKMEASmq2Yb
        bqoc7VV/8rykXsQmPHE8Qb0N9A==
X-Google-Smtp-Source: APXvYqzchtZ835QZOpwl9/RkdAZa/TC3OAT+PpflYbCHUOsWhgYlP8eqrbOPIe6oOTl82ou4Mga+5w==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5mr13963098plb.253.1581928362335;
        Mon, 17 Feb 2020 00:32:42 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:41 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 8/8] riscv: add two hook functions of ftrace
Date:   Mon, 17 Feb 2020 16:32:23 +0800
Message-Id: <20200217083223.2011-9-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the text section be mask as non-writable, the ftrace have to
change the permission of text for dynamic patching the intructions.
Add ftrace_arch_code_modify_prepare and
ftrace_arch_code_modify_post_process to change permission.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c40fdcdeb950..576df0807200 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -7,9 +7,27 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
+#include <asm/set_memory.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+{
+	mutex_lock(&text_mutex);
+	set_kernel_text_rw();
+	set_all_modules_text_rw();
+	return 0;
+}
+
+int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
+{
+	set_all_modules_text_ro();
+	set_kernel_text_ro();
+	mutex_unlock(&text_mutex);
+	return 0;
+}
+
 static int ftrace_check_current_call(unsigned long hook_pos,
 				     unsigned int *expected)
 {
-- 
2.25.0

