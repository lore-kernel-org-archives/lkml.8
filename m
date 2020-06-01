Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB91C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9977420772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWlctxi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFAHAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFAHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:00:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05819C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:00:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so4383275wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kz/zM/F4CyqxjEb0haovqBG5d3QwLEGu6boEE4kcZxg=;
        b=pWlctxi5GEwc+Mo1Xzle3vTrRkFnXR+9uwpgW50kv6NNyB4XKxwRpUb1R5lq8Jd+cS
         mHTd5LO1Q9wg4Et/Ywb0Tz8Nx0QhFdIoocDR+uPoLTMLJ034nXBi/AM8nvC2Uj/5Szbl
         9krfYO9xK41fq6ethbMEiEg/r7RaFQX69/OqTwHyPjsSdHkC/aCCQWFb+RIdpotaQrng
         OSzVKeTHQGxIgKKrd4iODamfGuGpkgjwPLoepYuKfRqhRPkA3B0/SXf6IXlFztsXLGjv
         pQzG9EnGBjC1FAeusY3bUcKtmlT8NUfr1gj5MnQNopt+T2WJ+94tEUKpvNP1pb58kpre
         tOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kz/zM/F4CyqxjEb0haovqBG5d3QwLEGu6boEE4kcZxg=;
        b=TU0fTqQ8FTDq1vCvb6lsUoVU+LouWnjJ2paOMH78epXws1N0ahDgeZBnRUsUvYFaZb
         ujP6lK89ss8Ji7/en6vb4fIYlceLcq+grj4CFWH8OZKXtCLqKkQCj5eQl7oZ4pH/6F6G
         vsdHc6HWfoWSVgDckh5a6nTCjYLGwHWQ2FvCu6u1zNyJj7y1SJFGr+djr9lSWXnFgpDh
         yZyyz0bLkLkJrhX4/47q6zuN3q/pMVkIedzhEI4AXQMJ9M6LryWSu+4GWms+5/MxLWHh
         ak+W3soZycHsZ7MXNdDir+axSMbIRv5WKmA3wr8NAvgoefPLSu2PLGvugUuN0xldS4Jb
         vsyQ==
X-Gm-Message-State: AOAM532Jy7YDsMyFye6WqC2TUWAoV3Coo+kbMDhpAnrARcCGpsV9Ju5J
        gXdqDF2nyoZHuGvAsMorbLVUECc1
X-Google-Smtp-Source: ABdhPJwyNX3oor/ArLOT7bguzBCaSdBFXf70MQeT9bkVf5KYTIojy/32yHkk5SXvCnvj48cPaYcQAw==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr21488977wrx.326.1590994840398;
        Mon, 01 Jun 2020 00:00:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b8sm20629261wrs.36.2020.06.01.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:00:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: correctly cast u64 to void*
Date:   Mon,  1 Jun 2020 09:56:48 +0300
Message-Id: <20200601065648.8775-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601065648.8775-1-oded.gabbay@gmail.com>
References: <20200601065648.8775-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the u64_to_user_ptr(x) kernel macro to correctly cast u64 to void*

Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 75d8302352e5..f82974a916c3 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -789,7 +789,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		size_to_copy = chunk->num_signal_seq_arr *
 				sizeof(*signal_seq_arr);
 		if (copy_from_user(signal_seq_arr,
-					(void __user *) chunk->signal_seq_arr,
+					u64_to_user_ptr(chunk->signal_seq_arr),
 					size_to_copy)) {
 			dev_err(hdev->dev,
 				"Failed to copy signal seq array from user\n");
-- 
2.17.1

