Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67570C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40E2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m/giYsQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCIIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:22:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38977 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id w65so3946083pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOfAoLdk+wyu9cMPPwg3ptCFXLjHocYAW+86LT+5msM=;
        b=m/giYsQOqBKciJBZcJMXG3pJIU8PzNA/YNo1CXykqc3wPCLwBGH6k2idh+ZXn05yE4
         yRciCQY9RJloiOJwvlJMD6Kq7e+lTftgYDsLY45GGla2EpqtQL2xThwzrXP3vaw8T+E8
         ilhj8Ef/PETZkQnyDqHqgB7VKnhRYu6xwv9b3C2p5CDCMq5HajGUi00OKf1AsAEfiZGx
         WYDOZvYQcT6HFoUIpoD6fqGE6b4LCfgg0ktM8Z5TGwjKJL7SFv72j+SYEIXpQyQ8AKGL
         c6C5c1caGCYFf+wV6+XQyLSB0/yPpD89KnvgSTyv4jILmkZwMyql4ahKfoLtPpNotbmr
         c1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOfAoLdk+wyu9cMPPwg3ptCFXLjHocYAW+86LT+5msM=;
        b=mBTJh54esFQXRrd7SIIawTwX//tD8OOf6MSgcmdsBcb3SvmzgNcval+IzVfgL93V6o
         +uC3LCeh/HfewgiKUNKOMMOBzboL+eIHxz1hKuKq4VjUtNB7DrP6gqEzJBJkC8eui5sb
         +qtNCjGFIEisvPz3CNz2F1uBXHiRIpeEVYvzmpvuZKKIzt+aIAalAz9ObvWntuREajAj
         qrHhg+LsyH6eWhzhlrZALAT38TOvP8Y0/yYmto0TouBs/HVnv3rzFeiJhUWPUOuPmG3e
         kj47KnWAlZqGi8itNbsECkNSaD+kXrYfWt54j975SMTCA8dRJ5dPViID+G6yCqQm5u2X
         LoJw==
X-Gm-Message-State: ANhLgQ3d2jshx8g3AoDeCqMSI/w856jxzmDv7QCHxZL+9ojFi49JhNQY
        eUlGMJ8HQWKggnYJI4E5xiKEAg==
X-Google-Smtp-Source: ADFU+vteMe3ewvhpJQl/NECjXwkfEf/awPln9cYkogZavclnc7ufmZRdrvr43bRED8C+ximaAcRKkg==
X-Received: by 2002:aa7:9e8b:: with SMTP id p11mr15205017pfq.26.1583742163604;
        Mon, 09 Mar 2020 01:22:43 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:43 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 3/9] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
Date:   Mon,  9 Mar 2020 16:22:23 +0800
Message-Id: <d3ff736aeca7146310e0338d87e2d2c09dc0da9b.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. Implement the __kernel_map_pages
functions to fill the poison pattern.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig       |  3 +++
 arch/riscv/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 07bf1a7c0dd2..f524d7e60648 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 7be6cd67e2ef..728759eb530a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
 
 	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
 }
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+
+	if (enable)
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(_PAGE_PRESENT), __pgprot(0));
+	else
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+}
-- 
2.25.1

