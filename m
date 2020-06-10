Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67188C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4365E2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D3x1XFhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFJLLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:11:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52537 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgFJLLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:11:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591787497; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=eobXzs++Nf0GymnLw2TDR9m8XDGyQ+cTGJFMu+d5QZ4=; b=D3x1XFhDJGT8VgWIVpwKexbrnX39r8KZwq/Tq3+4krdOSaa8f6+qplFuCZvr6UB1mhcpQWhI
 9gbhNJMmdZL3fO+caVlFPVnvZch/kItbvhJOnyEteqoEgBjVMgIdk6O8qzIzyFmlNmAYupTA
 CaIGkNSTj1CMMORCt26DwuxxW3U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ee0bfd53a8a8b20b8925472 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 11:11:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7A26C433CB; Wed, 10 Jun 2020 11:11:17 +0000 (UTC)
Received: from localhost (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sthombre)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43575C433C6;
        Wed, 10 Jun 2020 11:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43575C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sthombre@codeaurora.org
From:   Shyam Thombre <sthombre@codeaurora.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, sashal@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shyam Thombre <sthombre@codeaurora.org>
Subject: [PATCH] arm64: mm: reset address tag set by kasan sw tagging
Date:   Wed, 10 Jun 2020 16:39:44 +0530
Message-Id: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN sw tagging sets a random tag of 8 bits in the top byte of the pointer
returned by the memory allocating functions. So for the functions unaware
of this change, the top 8 bits of the address must be reset which is done
by the function arch_kasan_reset_tag().

Signed-off-by: Shyam Thombre <sthombre@codeaurora.org>
---
 arch/arm64/mm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7fbc62..eae7655 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -723,6 +723,7 @@ int kern_addr_valid(unsigned long addr)
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
 
+	addr = arch_kasan_reset_tag(addr);
 	if ((((long)addr) >> VA_BITS) != -1UL)
 		return 0;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

