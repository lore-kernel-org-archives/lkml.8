Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8442DC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A532076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iEXF+9cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCXHbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:31:14 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36488 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgCXHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:31:11 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so1056479pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54p31XcZy9VY/uTSVV1VAo6tqKUeT0iaZ8T4Yx3sR7Y=;
        b=iEXF+9cxq8xsvBHmABzfWbJjn41vgvA6oKrfEkKliYoY7j4OI83K0ywdq9cODsiA2Z
         v6OCCQIEj68L96a+WLVMjjt6ALm+CsD3j0D4KebwyuwLrDSgVo6P9mlbgoXk12+g8hYq
         h3HZjhPy1S8gcvtOkooUJKx59NBgXDGs9v2+7xxixk90ggSaHgyDTC4fWJPtMQM6OEfo
         1wP2sr8P3cQdvqRJvgyEiw6sOtpJrqjA4X1skfY4hFk5KMDcO1X3+K0WPyoE+Y3vNWP+
         0/At0OSgtSowO8eLWPmOYfifL5cMVVVHKwjfRwnTsOBdpeyiYvdATTYSilWaUKS0Ndx7
         0slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54p31XcZy9VY/uTSVV1VAo6tqKUeT0iaZ8T4Yx3sR7Y=;
        b=Kmw2HQR3BTApcBy7pckdw6vYZnv2ASegpKkCEZe8fqLahpAec4hfAat4XFSXZb5wqo
         Me63TuLaBqohQZX/+I2/Cnuk22BvvyaUPk2cJg4SO8CeKb0zDM2zACQnGnkMa82+/6ak
         QHqCzqgOmolVUYEQjEE8bNvrlIkHfxLcNEgG+5ZAuZk2Jd4kf9kIt6QpwHIgygJLrYZu
         VPU7AYFhb4H8Kjh0WGIwSMa5rPqB5H7KM1E6KIDIoJhFu3EmM5QN1hTbWn/GUPD6ZRC9
         Bk4G3l0hmDKeTCx98/7WiOECODZZjk6LWZv4Z2pwc/S1+ue1hgnXRVhHWNk+nJUDYC/C
         KKTg==
X-Gm-Message-State: ANhLgQ1p/r1AYutGO859RvpvMAvD5Jv9OVF8akrb3Xjr6xPbtjRPvH6U
        aafkAGagSVQQaOpTwHG1rSlOjw==
X-Google-Smtp-Source: ADFU+vv2b4TrS7mtJtADgnbvhx9fw/lDSwAZQDta7SAXFjV1VN2AFgelMDsi76samQ/8v1L0pkUKOA==
X-Received: by 2002:a17:90a:cc14:: with SMTP id b20mr3916243pju.75.1585035071082;
        Tue, 24 Mar 2020 00:31:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:31:10 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 8/8] riscv/kaslr: dump out kernel offset information on panic
Date:   Tue, 24 Mar 2020 15:30:53 +0800
Message-Id: <ea7c01b7c969ddc269a8f94cc9646fc48b7ff790.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1584352425.git.zong.li@sifive.com>
References: <cover.1584352425.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump out the kernel offset when panic to help debug kernel.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/setup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 913d25e4b9fa..3ce50bf628ba 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -85,3 +85,26 @@ void __init setup_arch(char **cmdline_p)
 
 	riscv_fill_hwcap();
 }
+
+static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
+			      void *p)
+{
+	pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
+		 get_kaslr_offset(), PAGE_OFFSET);
+
+	return 0;
+}
+
+static struct notifier_block kernel_offset_notifier = {
+	.notifier_call = dump_kernel_offset
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && get_kaslr_offset() > 0)
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &kernel_offset_notifier);
+
+	return 0;
+}
+__initcall(register_kernel_offset_dumper);
-- 
2.25.1

