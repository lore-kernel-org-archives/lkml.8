Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB84C3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D4C24685
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696208;
	bh=SADULr2v8CoS9zmj1WlBhdagSQ+W/CvrBu4siprNm2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhc17482QibAtVIdUgGa3zVCdseuiXBlSLsVNEp0nYfBE+0kAtdpL3uTdR3sxrNSH
	 ABjdmvfIwqN+rAuYgjZNOa2KF2t+VBS31LEy4esH9o4rUVt85JXhqbBJO7p10ltBDX
	 s8WMU5P7lPPCzvhi7jvKT6qxvwCMa9toq7eN9XjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbgBNQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389550AbgBNQDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:03:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCFC24654;
        Fri, 14 Feb 2020 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696187;
        bh=SADULr2v8CoS9zmj1WlBhdagSQ+W/CvrBu4siprNm2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdG+HDEZJbo6Dw/egrZwLbcIDvCbqxzCLBxCULMR+jpkGgcdnQZMfDzGBBdoSEa7M
         5I7PEbxqInQ417938gocuHuyKp1xW+SOxKo47LoHe6oyarAj4KEWy0qgx9yZ0L7RH9
         okIZm56215X3iQGAyBdTX/KG1N//mUSj58FqoX9U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 056/459] MIPS: Loongson: Fix potential NULL dereference in loongson3_platform_init()
Date:   Fri, 14 Feb 2020 10:55:06 -0500
Message-Id: <20200214160149.11681-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
index 13f3404f00300..9674ae1361a85 100644
--- a/arch/mips/loongson64/loongson-3/platform.c
+++ b/arch/mips/loongson64/loongson-3/platform.c
@@ -27,6 +27,9 @@ static int __init loongson3_platform_init(void)
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

