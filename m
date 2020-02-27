Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2EC34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B11D2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814736;
	bh=KNL8q96VW054YfXBZfeHGlfLCZJ5LleWzR+KoB/9j4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2kLzK0cK17HtkESpGTGpS/n30h6ilI6EIMTQZIBrusqDBGN7mo99qnOxK/I78r3tO
	 tjpDa9r0mv6ssIS/VBb9cSrTpXBELruK4yFLtlvijwLLNjvwo7LRJ6X84vU17C6kYC
	 /eWj+YZh9feuvV6uNWEY4OrZUU5WAVcKOzSvJhrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgB0Opf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgB0Nq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:46:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4A720578;
        Thu, 27 Feb 2020 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811186;
        bh=KNL8q96VW054YfXBZfeHGlfLCZJ5LleWzR+KoB/9j4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSQDU5VQDAzbq6/OSSqJYd007RN5t4Y2QYunkuSr1rHkd78c3ynF94d7DZ29jE1DA
         IKyATR4ESdr1/MMAB2gjcQDjJMrKpiZvfLoMFrmOy7txTTtWv0LVrsbiYRDqWDWQYp
         TSiTJV4yi4y8R4WNj//nP4IqKf7JyfVkQe77pgPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/165] MIPS: Loongson: Fix potential NULL dereference in loongson3_platform_init()
Date:   Thu, 27 Feb 2020 14:35:08 +0100
Message-Id: <20200227132236.102534187@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



