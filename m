Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF113C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FE206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700509;
	bh=KNL8q96VW054YfXBZfeHGlfLCZJ5LleWzR+KoB/9j4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYTMlxwGabmUI2RoTtOtxPFvnM3PCq/qdzojMqhBc4scK8YSvqMKopgXJ2+HafYnH
	 lt4bahuhnCOMGVAIZi+mbUHFQonpy5x3tbpoldGUzkXFH/KH4ZtDQx548hcvb7K/IJ
	 TqVyWQyMFlamcSk0SM6pVtzmv3fp1jqOPi80N/vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbgBNRPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391978AbgBNQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850F8246AD;
        Fri, 14 Feb 2020 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696741;
        bh=KNL8q96VW054YfXBZfeHGlfLCZJ5LleWzR+KoB/9j4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP+i+K7FIY27LRRPQM/NXX2a5dQXLLVUimHUFPdpYZsh3s02DfzlENgMm7+jAuVRq
         mY8NUBBVVgWzwXxSZ0hCHTY5FIa2vN7BI6KKElSlwc1brCpniQL2lrrGV/Ox7464i6
         0q73Tt/Hqs3+ttIWwpjUDNDtq7fwXC2lzZggWbRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 025/252] MIPS: Loongson: Fix potential NULL dereference in loongson3_platform_init()
Date:   Fri, 14 Feb 2020 11:08:00 -0500
Message-Id: <20200214161147.15842-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 72d052e28d1d2363f9107be63ef3a3afdea6143c ]

If kzalloc fails, it should return -ENOMEM, otherwise may trigger a NULL
pointer dereference.

Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/loongson64/loongson-3/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/loongson-3/platform.c b/arch/mips/loongson64/loongson-3/platform.c
index 25a97cc0ee336..0db4cc3196ebd 100644
--- a/arch/mips/loongson64/loongson-3/platform.c
+++ b/arch/mips/loongson64/loongson-3/platform.c
@@ -31,6 +31,9 @@ static int __init loongson3_platform_init(void)
 			continue;
 
 		pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
+		if (!pdev)
+			return -ENOMEM;
+
 		pdev->name = loongson_sysconf.sensors[i].name;
 		pdev->id = loongson_sysconf.sensors[i].id;
 		pdev->dev.platform_data = &loongson_sysconf.sensors[i];
-- 
2.20.1

