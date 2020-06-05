Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63038C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322E5208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366625;
	bh=04t9itlU1J/2xv4vUewI0M8oZPMJaRDzx3JulnAkUFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Le0UP/AKf/oWj1OV6VB/noq/PZvM/ZEwhUtNHK2YIjjg4g50xiHgI9pUc3YeIR/hq
	 vVVXj8BbSEGPXIWawE9tFLjOKGD958LUq+GKUkeoxgBNWtDOJFkcSlaYp95W6D9Z+f
	 4z7rdS4fZGvdg/REodoUF5C5L893fJFYoewgpXE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFEORE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgFEOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EECA20835;
        Fri,  5 Jun 2020 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366610;
        bh=04t9itlU1J/2xv4vUewI0M8oZPMJaRDzx3JulnAkUFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=is+SIp8swWgEo6uES4MQYy697JEDxB1+PLQXA3x6h91o0OIkcQ7GZgzL6sqksQxjE
         tl+1JLCEZzRoPgjsB1SkON17bpH8KYfOVaePkNBaRsrMLgfUGA1eYgYRt9fCZsW2d4
         YaDSzRy8FtmP9jZiAeR4zp0cv90jpEQ2BiHSPfI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 22/43] riscv: Fix print_vm_layout build error if NOMMU
Date:   Fri,  5 Jun 2020 16:14:52 +0200
Message-Id: <20200605140153.686917117@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 8fa3cdff05f009855a6a99a7d77a41004009bbab ]

arch/riscv/mm/init.c: In function ‘print_vm_layout’:
arch/riscv/mm/init.c:68:37: error: ‘FIXADDR_START’ undeclared (first use in this function);
arch/riscv/mm/init.c:69:20: error: ‘FIXADDR_TOP’ undeclared
arch/riscv/mm/init.c:70:37: error: ‘PCI_IO_START’ undeclared
arch/riscv/mm/init.c:71:20: error: ‘PCI_IO_END’ undeclared
arch/riscv/mm/init.c:72:38: error: ‘VMEMMAP_START’ undeclared
arch/riscv/mm/init.c:73:20: error: ‘VMEMMAP_END’ undeclared (first use in this function);

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 157924baa191..1dc26384a6c4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -46,7 +46,7 @@ static void setup_zero_page(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 }
 
-#ifdef CONFIG_DEBUG_VM
+#if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
-- 
2.25.1



