Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87BC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FD2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581780516;
	bh=hLSGZEQWdxHnGb3NCznVMrshFsU5QAvYHIqnrYcr84c=;
	h=From:To:Subject:Date:List-ID:From;
	b=zFJdfxmJM1+p18QyHDfErcmEcNvst0nVkdFpaUm2TIW5nWVQCEii59TyXknDw8wUp
	 8F1BlIH1RigU2qmzSqHx6B+Am/YjsTPQa0qKS5ln36F1AwRC9CsiUbTaNRnRdWElSc
	 g8mBvIYRSp5DFe4xB9VK8ZEcZNfwbyU5Li1tbT1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBOP2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 10:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBOP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:28:34 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00B22081E;
        Sat, 15 Feb 2020 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581780514;
        bh=hLSGZEQWdxHnGb3NCznVMrshFsU5QAvYHIqnrYcr84c=;
        h=From:To:Subject:Date:From;
        b=JpqT9cL8K0KPKzQA05xkkrWZkSO1u/inIKPw2Z5dQwCdp4JIsuJO8fjfqajSxSMWG
         A+QbmnJCLQyk7x2Xtmxgqus+QPinGVxBccvqOPfRLHvckIBo/5VhOdScx18PVQ3GfO
         kc9yP1uKxFxFLK6xHRCGwmmcJPcc+9tczXyVwfAU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] sh: sh4a: Bring back tmu3_device early device
Date:   Sat, 15 Feb 2020 16:28:28 +0100
Message-Id: <20200215152828.28439-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1399c195ef50 ("sh: Switch to new style TMU device") converted
tmu3_device platform device to new style of platform data but removed it
from sh7786_early_devices array effectively removing last three timers
and causing a warning:

    arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
        warning: ‘tmu3_device’ defined but not used [-Wunused-variable]

Fixes: 1399c195ef50 ("sh: Switch to new style TMU device")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes since v1:
1. Add tmu3_device to early device list, as suggested by Geert.
2. Add Fixes tag.
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 4b0db8259e3d..74620f30b19b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -391,6 +391,7 @@ static struct platform_device *sh7786_early_devices[] __initdata = {
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
+	&tmu3_device,
 };
 
 static struct platform_device *sh7786_devices[] __initdata = {
-- 
2.17.1

