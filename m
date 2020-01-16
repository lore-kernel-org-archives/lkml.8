Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AE324679
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197599;
	bh=f74gY0E9na8zmrM+BoXB/Vj4yu0BmvUtSEC1+S/QcdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PfkwGQ8+OtZxqtF22hDE4Wu2gepoJYYqmpYyPt4z1dd83++yKTKSLO5l7zWJ8mPFq
	 k6Yx/1ZcIQ7zYqobLRhXb5VGR9+KUMnmJaCSpx7PIl0OyjIkP6SzN4EyWopIDOKgmh
	 upK0ttbOss42kjGJpggcsF8rpHD/eDAmuCgtTFb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405553AbgAPRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405700AbgAPRla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:41:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623B7246B6;
        Thu, 16 Jan 2020 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196490;
        bh=f74gY0E9na8zmrM+BoXB/Vj4yu0BmvUtSEC1+S/QcdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSwUuEn+zYoPPo8c6j4hnIOELr5RdYEeECwhm62m044bLJynll8qYLrPF72LPDdbO
         mkzTZd5U4jXA/7M3ItKTNh069xY1c7XthlvGmzMuoV+JARle24aQEqCM49GP3nJ6HB
         lGy3o6AV0a40/dWDwSmRdihj4slRDw1MdW2iee7A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 234/251] MIPS: Loongson: Fix return value of loongson_hwmon_init
Date:   Thu, 16 Jan 2020 12:36:23 -0500
Message-Id: <20200116173641.22137-194-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit dece3c2a320b0a6d891da6ff774ab763969b6860 ]

When call function hwmon_device_register failed, use the actual
return value instead of always -ENOMEM.

Fixes: 64f09aa967e1 ("MIPS: Loongson-3: Add CPU Hwmon platform driver")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mips/cpu_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 4300a558d0f3..d02214a3f8e3 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -155,7 +155,7 @@ static int __init loongson_hwmon_init(void)
 
 	cpu_hwmon_dev = hwmon_device_register(NULL);
 	if (IS_ERR(cpu_hwmon_dev)) {
-		ret = -ENOMEM;
+		ret = PTR_ERR(cpu_hwmon_dev);
 		pr_err("hwmon_device_register fail!\n");
 		goto fail_hwmon_device_register;
 	}
-- 
2.20.1

