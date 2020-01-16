Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C377C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3659E2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201684;
	bh=/49kyxd0PfXibenNT+urM4vRt0IRh8RAXda1+lG3nD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LH7wGt5fvzlNXfaD5ZmvwiQ2YpzOCnrRaEB8UcYcf3LwEycymlUVlyDkwG23zSbZS
	 dcFYIkeraqOB7Z57pvTOoyN9+zr7lyb9pTojWK9frSZ5G0AojbKZ6BNjkpQ1cEGLV3
	 tgU0q+FCaWSeWz1/iFX0ugsEArucj7KUas753dWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgAPRBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387977AbgAPRBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7114A2077B;
        Thu, 16 Jan 2020 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194061;
        bh=/49kyxd0PfXibenNT+urM4vRt0IRh8RAXda1+lG3nD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLrb+5CQJsDV5tLuBAl3SwPhG4gyeqt742cQItG4ARvum05ANBosp/ylYKOvu4FB0
         ru2dKdHWBSS0/pXHj7vA9a5mYx3qh/04gR4oz3K8n0Qhk86tk4aAQ2BKuBfX/4vVKS
         mqOrIuDaHuNZ/Az1GsTozq/Ikak1tHa61wWPfKkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 173/671] ntb_hw_switchtec: NT req id mapping table register entry number should be 512
Date:   Thu, 16 Jan 2020 11:51:22 -0500
Message-Id: <20200116165940.10720-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

[ Upstream commit d123fab71f63aae129aebe052664fda73131921a ]

The number of available NT req id mapping table entries per NTB control
register is 512. The driver mistakenly limits the number to 256.

Fix the array size of NT req id mapping table.

Fixes: c082b04c9d40 ("NTB: switchtec: Add NTB hardware register definitions")
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/switchtec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ab400af6f0ce..623719c91706 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -244,8 +244,8 @@ struct ntb_ctrl_regs {
 		u64 xlate_addr;
 	} bar_entry[6];
 	u32 reserved2[216];
-	u32 req_id_table[256];
-	u32 reserved3[512];
+	u32 req_id_table[512];
+	u32 reserved3[256];
 	u64 lut_entry[512];
 } __packed;
 
-- 
2.20.1

