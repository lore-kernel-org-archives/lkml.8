Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F400206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702978;
	bh=Xidm1KLHeikUqJj0mf8sqeP5+U4+kFE95p+55aYHmkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7hC0Fd+qbtfw5FFVuH0DHfpFvp/UmbnwmPt1LfYoafBSzzsDhDQWPz4+6hgaj6Bz
	 hAwP8ICTnKfrJDY10sojczbP+ndd1+a4kTuBEJY4LkT9a2IDvvaFfyeJyzpxFdcQyW
	 GARBkSidOWG4E4VSy/6XWMl6s4e4/Bs3MKxYbuCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgBNR4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388209AbgBNP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BC82467B;
        Fri, 14 Feb 2020 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695844;
        bh=Xidm1KLHeikUqJj0mf8sqeP5+U4+kFE95p+55aYHmkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjoXNR6J1NCn5p/r6TLBy/uIq1hqWzXQaSoW+horPo0F0TLNSNmqxiOJ1VsOTH6lH
         0ubvxMYfb8bLGBaRPc+5HIIM04y9iKoQBl7Z24Wrxz9cuMbf5KvfmXpVOZzFVDv380
         c5OkqyZ+8QiQZf9BYa0Cw4O2nUDR5inwSc2erHQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 394/542] EDAC/sifive: Fix return value check in ecc_register()
Date:   Fri, 14 Feb 2020 10:46:26 -0500
Message-Id: <20200214154854.6746-394-sashal@kernel.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 6cd18453b68942913fd3b1913b707646e544c2ac ]

In case of error, the function edac_device_alloc_ctl_info() returns a
NULL pointer, not ERR_PTR(). Replace the IS_ERR() test in the return
value check with a NULL test.

Fixes: 91abaeaaff35 ("EDAC/sifive: Add EDAC platform driver for SiFive SoCs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200115150303.112627-1-weiyongjun1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/sifive_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index c0cc72a3b2be9..3a3dcb14ed99d 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -54,8 +54,8 @@ static int ecc_register(struct platform_device *pdev)
 	p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
 					    1, 1, NULL, 0,
 					    edac_device_alloc_index());
-	if (IS_ERR(p->dci))
-		return PTR_ERR(p->dci);
+	if (!p->dci)
+		return -ENOMEM;
 
 	p->dci->dev = &pdev->dev;
 	p->dci->mod_name = "Sifive ECC Manager";
-- 
2.20.1

