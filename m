Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED13C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACF4246AA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194842;
	bh=uUpN2dY7R4VzTueHXTuHcDY+ZoCtUVRaHz1tmu8JhXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iYj0iNOpRiV31eGZqcab2NYQBjIpw5eL8W0E7OYeT561jvZcHLaz6xEZ3mTGyOe1Z
	 rNNI8YzabN9Qe5pIrXQdn/63Ssk6L6kBhyAS9f+7o/tcnKzSMIO3OTkvZ+1e5zeQhz
	 PM9vJIpWwzSNHeshfzgsoZBimGyNFhGrAdAptUbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390907AbgAPROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390211AbgAPRNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0B620684;
        Thu, 16 Jan 2020 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194832;
        bh=uUpN2dY7R4VzTueHXTuHcDY+ZoCtUVRaHz1tmu8JhXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lItvOtJAuEfNF2+dKkwlmDVSSL6eVCbzz49HfkoVSzSizKOxrHLJRTg0IKfIWn70X
         gblNwHrnkzTsP8DN7vV76b8hbuunRP7rJJZQl9Owd1dWHYBPjWmcjmMTp8hdkkE2JW
         sm5+9clD5olWfjQcH8ZCridXt/z9Z2+3JP6jwD58=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 633/671] MIPS: Loongson: Fix return value of loongson_hwmon_init
Date:   Thu, 16 Jan 2020 12:04:31 -0500
Message-Id: <20200116170509.12787-370-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
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
index f66521c7f846..98128374d710 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -159,7 +159,7 @@ static int __init loongson_hwmon_init(void)
 
 	cpu_hwmon_dev = hwmon_device_register(NULL);
 	if (IS_ERR(cpu_hwmon_dev)) {
-		ret = -ENOMEM;
+		ret = PTR_ERR(cpu_hwmon_dev);
 		pr_err("hwmon_device_register fail!\n");
 		goto fail_hwmon_device_register;
 	}
-- 
2.20.1

