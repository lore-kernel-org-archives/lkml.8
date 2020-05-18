Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97220C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EF020657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826083;
	bh=twspVT1zrYkRZRsrbISXp+khKPtPDdbQVathL8OXLA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L9J1k9WpfqAFtp1l+cICJyLZKFl6lqVnOARNLYkBLaRPitVvH0m6+KwIZ4oltZgnZ
	 NK9o6nfvv89m6NAqoj412xV27B1o3M+UNSyR5g8JH97jabv/bSmadMqJG2jCK13ZVs
	 TJOPfETHUwh9MTyVIAcx83t263Vt3btNNM2c8ZRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbgERSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbgERRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37D820674;
        Mon, 18 May 2020 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824307;
        bh=twspVT1zrYkRZRsrbISXp+khKPtPDdbQVathL8OXLA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ed8ypBV3tXxuu/lhyrFec7HnWUnzkrnfocaJE1ewUANJKrdCMZFQj5H0Nn4YB64kJ
         XFzDgHVPmbe/kZZsQKfDg/v7zR3pBs75KrKRJGKnURNQyVq62G9qx6hwCM5NwfOjeL
         izFuWDG7XhcuUbtMLzyck9omVoYKm8bEi4aGvxNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/80] arm64: fix the flush_icache_range arguments in machine_kexec
Date:   Mon, 18 May 2020 19:36:58 +0200
Message-Id: <20200518173458.397323938@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit d51c214541c5154dda3037289ee895ea3ded5ebd ]

The second argument is the end "pointer", not the length.

Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
Cc: <stable@vger.kernel.org> # 4.8.x-
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 922add8adb749..5e26ef0078638 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -192,6 +192,7 @@ void machine_kexec(struct kimage *kimage)
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
 	__flush_icache_range((uintptr_t)reboot_code_buffer,
+			     (uintptr_t)reboot_code_buffer +
 			     arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
-- 
2.20.1



