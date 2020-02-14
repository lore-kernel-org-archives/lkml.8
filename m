Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89896C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA01222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704402;
	bh=oEM+snzuH3vtMPFsFXp2CLTpYfhAj6BMwNR9KNstY/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r2hW1HPR/kiWmfGVmr80YXl3u4rfIMhhg8OA7suS0jJC2MlUj51UNlicWtW09dyqi
	 M4R0ATLA/wVQr3yQaODzziE53piYbXdteTiwtuQPFvW7mzvZTfo8EWXMAWxSfpi/R8
	 BwyC1oMCKmSCLvD/29ZMK4bq6Dr6RDdzgP1sUQBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbgBNSUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgBNPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:50:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B676624654;
        Fri, 14 Feb 2020 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695419;
        bh=oEM+snzuH3vtMPFsFXp2CLTpYfhAj6BMwNR9KNstY/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISd4/cheMRgvg9r5jfTKmL//s3zH3xc37o452qvtS0ntw6PDDG/UMBgK3gPNWgKGr
         a3InjRJ/0Yy2jKrrdqvS3MQx0lzECkISXWONZ1cl6IO9N+BhcqVW4zOufY4tSN/D47
         dxO/b4SJnB9rTlgoQgrlGScVDs3eQCOr0rwGH4QY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 064/542] MIPS: Loongson: Fix potential NULL dereference in loongson3_platform_init()
Date:   Fri, 14 Feb 2020 10:40:56 -0500
Message-Id: <20200214154854.6746-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
 arch/mips/loongson64/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/platform.c b/arch/mips/loongson64/platform.c
index 13f3404f00300..9674ae1361a85 100644
--- a/arch/mips/loongson64/platform.c
+++ b/arch/mips/loongson64/platform.c
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

