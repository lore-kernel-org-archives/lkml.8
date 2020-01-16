Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E95C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D8320661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202537;
	bh=7+gjoVYPKPnT4tj9n23NpvKEumOwWVHOE8EGjGny3z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BeTF1RlxCs+O7nO75ut485NZehzRgUaH2J21g17V2+6/SH+E8yhfaxuFJsCkh4Sg7
	 87Shwrz4hK1pJBdKFx1uVZtx/IO5uc8ayfkjuq7u1WFh/b1wr3o9HhJsCJXHNFw9sr
	 8qKt3cl3ybQrNXU3Cy7MflTUShX1dlZYdM/88AqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgAPQxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbgAPQxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E965214AF;
        Thu, 16 Jan 2020 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193602;
        bh=7+gjoVYPKPnT4tj9n23NpvKEumOwWVHOE8EGjGny3z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEdj61yc2t+ravsvf4LnqutfwIn7003h+nn8QnF8aEC0+V5/Pc0A6xc5s+wMMhqwM
         4+k0t/kHKCvnTPW7Css+TMYUhl3FWQV8afR66RPeO6/PhlTHfyM6Mdyl+CzJS6S0IN
         aDSROM5cQyHuiPuZrIwH2inIsZ6KyFNv1WjbrgEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Hulk Robot <hulkci@huawei.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 141/205] firmware: arm_scmi: Fix doorbell ring logic for !CONFIG_64BIT
Date:   Thu, 16 Jan 2020 11:41:56 -0500
Message-Id: <20200116164300.6705-141-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 7bd39bc6bfdf96f5df0f92199bbc1a3ee2f2adb8 ]

The logic to ring the scmi performance fastchannel ignores the
value read from the doorbell register in case of !CONFIG_64BIT.
This bug also shows up as warning with '-Wunused-but-set-variable' gcc
flag:

drivers/firmware/arm_scmi/perf.c: In function scmi_perf_fc_ring_db:
drivers/firmware/arm_scmi/perf.c:323:7: warning: variable val set but
			not used [-Wunused-but-set-variable]

Fix the same by aligning the logic with CONFIG_64BIT as used in the
macro SCMI_PERF_FC_RING_DB().

Fixes: 823839571d76 ("firmware: arm_scmi: Make use SCMI v2.0 fastchannel for performance protocol")
Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 4a8012e3cb8c..601af4edad5e 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -323,7 +323,7 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
 
 		if (db->mask)
 			val = ioread64_hi_lo(db->addr) & db->mask;
-		iowrite64_hi_lo(db->set, db->addr);
+		iowrite64_hi_lo(db->set | val, db->addr);
 	}
 #endif
 }
-- 
2.20.1

