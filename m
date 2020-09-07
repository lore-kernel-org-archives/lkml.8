Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF9E21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496586;
	bh=nEKjW6rYP6qA3oTip1YczSNAMKPIAvulBqSmtTcH6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4y1YOBx7h4NxAVtnU5EwkDAeBPtG9ep5zJO218LC9IesxbUCKSr0Sh5s8xRrMazy
	 onaRlBLX8+DCdkNahzsAptG08hBMXBPsgZzR1fitWIKV7FDurwGt5eMA0yXLtqc0Q7
	 jrVYYGON6etXaeOKxmQtEkc+2Gs/buC9qxxmbK/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgIGQgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgIGQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9761E21941;
        Mon,  7 Sep 2020 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496412;
        bh=nEKjW6rYP6qA3oTip1YczSNAMKPIAvulBqSmtTcH6zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQRmA94GV1VtWfTbt+GTPm2KZZOJVWXm4OyCgoJ5TDh3qab8MDDZU6J7298R1ykgy
         OfOXnK+4ibQ7C+PSgbdR5v+8ozAi3WnnEi8hfHdbZNBAr7H6nfLzzAyK77MlPH0Io9
         HcZlWXASyfq6uYRqkjfTdL26v8tGpLup6k86uEms=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hanjun Guo <guohanjun@huawei.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/43] dmaengine: acpi: Put the CSRT table after using it
Date:   Mon,  7 Sep 2020 12:32:48 -0400
Message-Id: <20200907163329.1280888-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanjun Guo <guohanjun@huawei.com>

[ Upstream commit 7eb48dd094de5fe0e216b550e73aa85257903973 ]

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping, put the CSRT table buf after using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/r/1595411661-15936-1-git-send-email-guohanjun@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/acpi-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 8a05db3343d39..dcbcb712de6e8 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -135,11 +135,13 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 		if (ret < 0) {
 			dev_warn(&adev->dev,
 				 "error in parsing resource group\n");
-			return;
+			break;
 		}
 
 		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
 	}
+
+	acpi_put_table((struct acpi_table_header *)csrt);
 }
 
 /**
-- 
2.25.1

