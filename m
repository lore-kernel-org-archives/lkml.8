Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD41C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979F420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688344;
	bh=2HVNUDBs+35ni5M85dC7Eic1lQglqwduNwSVjrU4IN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QgTyRfxfbWrCCJ9nLpVrefvQE2irn7Zs/aIjh/lZA+gx86BkbWk+sEzNax/auCveH
	 LOxlpTZpKfXPu6jYOXDSBH1WwZDrJgzFfmDbjBbyNkmjNzX+SdR4Cr2J0muGSAzDn5
	 MibbqtwOm3TVIYOjzr/7kDqvYTGUQQesCrmp2K8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgHQSS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388370AbgHQQFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B85320729;
        Mon, 17 Aug 2020 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680324;
        bh=2HVNUDBs+35ni5M85dC7Eic1lQglqwduNwSVjrU4IN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvisBWAFquQSukD+tnib9MUYoAwnAaSLA0HnTkfU5fHNSQX7S7dE4sPtA5xau2o4Z
         fdi83UVL+Eiek9cVoI9dTpXn6LiNYSn/AwFtSSY23r3kd6Knm6NzMoaSF0ufI6X6mA
         Sb3LkN4Lv+2EpV3hebcWHyjeiUTvcutCPo5fj3uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milton Miller <miltonm@us.ibm.com>,
        Anton Blanchard <anton@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 142/270] powerpc/vdso: Fix vdso cpu truncation
Date:   Mon, 17 Aug 2020 17:15:43 +0200
Message-Id: <20200817143802.881463311@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

[ Upstream commit a9f675f950a07d5c1dbcbb97aabac56f5ed085e3 ]

The code in vdso_cpu_init that exposes the cpu and numa node to
userspace via SPRG_VDSO incorrctly masks the cpu to 12 bits. This means
that any kernel running on a box with more than 4096 threads (NR_CPUS
advertises a limit of of 8192 cpus) would expose userspace to two cpu
contexts running at the same time with the same cpu number.

Note: I'm not aware of any distro shipping a kernel with support for more
than 4096 threads today, nor of any system image that currently exceeds
4096 threads. Found via code browsing.

Fixes: 18ad51dd342a7eb09dbcd059d0b451b616d4dafc ("powerpc: Add VDSO version of getcpu")
Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Anton Blanchard <anton@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200715233704.1352257-1-anton@ozlabs.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index eae9ddaecbcf4..efb1ba40274a8 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -682,7 +682,7 @@ int vdso_getcpu_init(void)
 	node = cpu_to_node(cpu);
 	WARN_ON_ONCE(node > 0xffff);
 
-	val = (cpu & 0xfff) | ((node & 0xffff) << 16);
+	val = (cpu & 0xffff) | ((node & 0xffff) << 16);
 	mtspr(SPRN_SPRG_VDSO_WRITE, val);
 	get_paca()->sprg_vdso = val;
 
-- 
2.25.1



