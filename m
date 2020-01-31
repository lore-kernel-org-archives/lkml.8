Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A1C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F120707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wmaTaJNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgAaMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:44:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:57433 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728527AbgAaMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:44:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580474662; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Y9uezJFvTZwab5W/ghxsm4kRJLfaW5nZezC8D4k+Dew=; b=wmaTaJNf51xUySNeDThn9a+rRg6ZUibyGGGcdBSNQPGMDeiQOLClKHl+Ixlq7g1f+A0bb17l
 si/nX39iCYU4vDfPxkG3V+BS1T4a9I1OZhC6RHxmHRKw6umq+Uz1I0qkGSNpg+1YBardTmRt
 RN82VTYPH0iTeh3gQjmRyZv2mEY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e342124.7f4e4dd12c00-smtp-out-n02;
 Fri, 31 Jan 2020 12:44:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0967C433A2; Fri, 31 Jan 2020 12:44:19 +0000 (UTC)
Received: from snaseem-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: snaseem)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 529F0C43383;
        Fri, 31 Jan 2020 12:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 529F0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=snaseem@codeaurora.org
From:   Shadab Naseem <snaseem@codeaurora.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraju@codeaurora.org, Shadab Naseem <snaseem@codeaurora.org>
Subject: [PATCH] nvmem: core: Fix msb clearing bits
Date:   Fri, 31 Jan 2020 18:13:55 +0530
Message-Id: <1580474635-11965-1-git-send-email-snaseem@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clearing the msb bits of the resultant buffer, it is
masked with the modulo of the number of bits needed with
respect to the BITS_PER_BYTE. To mask out the buffer,
it is passed though GENMASK of the remainder of the bits
starting from zeroth bit. This case is valid if nbits is not
a multiple of BITS_PER_BYTE and you are actually creating
a GENMASK. If the nbits coming is a multiple of BITS_PER_BYTE,
it would pass a negative value to the high bit number of
GENMASK with zero as the lower bit number.

As per the definition of the GENMASK, the higher bit number (h)
is right operand for bitwise right shift. If the value of the
right operand is negative or is greater or equal to the number
of bits in the promoted left operand, the behavior is undefined.
So passing a negative value to GENMASK could behave differently
across architecture, specifically between 64 and 32 bit.
Also, on passing the hard-coded negative value as GENMASK(-1, 0)
is giving compiler warning for shift-count-overflow.
Hence making a check for clearing the MSB if the nbits are not
a multiple of BITS_PER_BYTE.

Signed-off-by: Shadab Naseem <snaseem@codeaurora.org>
---
 drivers/nvmem/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1e4a798..23c1547 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -926,7 +926,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 		*p-- = 0;
 
 	/* clear msb bits if any leftover in the last byte */
-	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
+	if (cell->nbits%BITS_PER_BYTE)
+		*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
