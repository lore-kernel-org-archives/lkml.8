Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5410C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B17B2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218094;
	bh=IBG7E2GJGbsNjViu333rtmT2J38bDQmsbxsfWNMJyGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhrMIWotg0ac9RKti7rAIsLU1h4w/7U8P4etUlTdw1zX421m1M08FCG3OnxsDcbFj
	 gRoGRBVfwnk1n8ZBNTgMgkl9vwHflZ1y+D+MfaPghsg0I/K0ZL1h4cWsXbraozgh6H
	 /suKv31cYu6pfQizay/O1kxsNk067Bl80kEv2caE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391882AbgAPXld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390056AbgAPX1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1165214AF;
        Thu, 16 Jan 2020 23:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217238;
        bh=IBG7E2GJGbsNjViu333rtmT2J38bDQmsbxsfWNMJyGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/e16R6o559zN/Yhz1si05CZekF9+q8UVXmAdZBVHYmrRZLnwqjB56i63hq9j/3Yh
         Iae5nzvgoiIBFm+ghzKRYjXF1dT/kVV2TybcVTTQDFqg6awwXrxewG8CJT1y9zTR6n
         f1fscdjYAJhRwltRQesPzP10WvbnRdDOXkmw5gZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 186/203] riscv: export flush_icache_all to modules
Date:   Fri, 17 Jan 2020 00:18:23 +0100
Message-Id: <20200116231800.578347871@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

[ Upstream commit 1833e327a5ea1d1f356fbf6ded0760c9ff4b0594 ]

This is needed by LKDTM (crash dump test module), it calls
flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
other architectures, the actual implementation is exported, so follow
that precedence and export it here too.

Fixes build of CONFIG_LKDTM that fails with:
ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/cacheflush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 3f15938dec89..c54bd3c79955 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -14,6 +14,7 @@ void flush_icache_all(void)
 {
 	sbi_remote_fence_i(NULL);
 }
+EXPORT_SYMBOL(flush_icache_all);
 
 /*
  * Performs an icache flush for the given MM context.  RISC-V has no direct
-- 
2.20.1



