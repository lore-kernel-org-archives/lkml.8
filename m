Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079F1221EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442837;
	bh=jCVTeln9hYqBwZrVBsTL/59b9zWrZJ+FeA82jf6YncU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ACzWSVy86IPJUYyjeopOrauPYePjMBVFlsKdFbfYLrdTk134N6dzZtXHW8wt5/FFM
	 sRjS6i2jj3uz65LRe25YaNiVwCSyiD9OZqMrMHaI+TBJEu2N/TBRfblaVxDINmqtSA
	 kudPZXIBzFg/EGeIQk6sfs0TuMAo9Stf36TyExhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgFRBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgFRBMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EB12193E;
        Thu, 18 Jun 2020 01:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442763;
        bh=jCVTeln9hYqBwZrVBsTL/59b9zWrZJ+FeA82jf6YncU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dn2RXfDMyuUFmLAT7EIVX0YgZ81acSCjBFyRs8FGlSE5+UXy/0b1QmluBP9AHuTEt
         /bLCxeBy1fNpMXbcjwqQGcwmVQgww+xaXHj4znvGfU30iHZTp9HUqcjoWyR6q7/A0A
         NejvHrkc8hpHuUraL2JgUvgdmXxWSAgZkvYpUieg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 213/388] habanalabs: increase timeout during reset
Date:   Wed, 17 Jun 2020 21:05:10 -0400
Message-Id: <20200618010805.600873-213-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>

[ Upstream commit 7a65ee046b2238e053f6ebb610e1a082cfc49490 ]

When doing training, the DL framework (e.g. tensorflow) performs hundreds
of thousands of memory allocations and mappings. In case the driver needs
to perform hard-reset during training, the driver kills the application and
unmaps all those memory allocations. Unfortunately, because of that large
amount of mappings, the driver isn't able to do that in the current timeout
(5 seconds). Therefore, increase the timeout significantly to 30 seconds
to avoid situation where the driver resets the device with active mappings,
which sometime can cause a kernel bug.

BTW, it doesn't mean we will spend all the 30 seconds because the reset
thread checks every one second if the unmap operation is done.

Reviewed-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 31ebcf9458fe..a6dd8e6ca594 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -23,7 +23,7 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
-#define HL_PENDING_RESET_PER_SEC	5
+#define HL_PENDING_RESET_PER_SEC	30
 
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
-- 
2.25.1

