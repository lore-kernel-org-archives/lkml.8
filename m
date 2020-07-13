Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480ADC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB702077D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOCsw2XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgGMHr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgGMHrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so14660958wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfL+TnTwzrxBs3OWsbVJ1u2HNp81yr5D58y8jJwfHCg=;
        b=ZOCsw2XWfgZO4y6t3h7ZC4fRzobOluE5SfyhEp/78OJ3fXCO64cAZWdxAucxuNmb8d
         fQW1CEkSz0QItDOS515LTb7R10RH5gaLIez9jQ60GhEhBXW75cH8UOkkfTpZzMHQsNs/
         RsCokTrSJg8XynI4R7kPRHqJgYWSukBRZIL2j5BdduQsq7UTNT/j4YCXvoRgj//aiyYU
         PtN6YMRIcQbXrv/HevL1q/V6DowQRP9qgKgSoXe4Va6L19t03EFjv0n4f+tzAZ92MBqk
         einUA1+6MQrrFUIZFRJiBhnhmdHoyPxXMqHdves3qtlqtb39O/pkYMGFAH+bp8Fw/IZK
         KK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfL+TnTwzrxBs3OWsbVJ1u2HNp81yr5D58y8jJwfHCg=;
        b=LaPSdEWN5HHy4UUrcjIBCFQf3nQr0xbY1nrYEGqe5STAoV8AN0phdbMz5l8t/c0U0m
         4E1t7Vp3cvIKl8asFWqvU2VdNWb+ojBmxP+iC1iWV8J69aBSw8gvMQksZb1pn146yfub
         32nghzRpOHGtEum28nnzyBZKxf+Su9Do9qQI30+Q16NPc8qqQZkR5X+N+rpfbAWZxJb+
         1C1nnjVMT0QJfKtByhXdeStOKjFMxOzKpdXdQjqFhMJjw+8ukR9dnjPmHIxXou6wKP+Y
         hFo2sxqt6QLu8OXmGCQXiyVXJiMefG79aI3Krn89R4cpugTGzu4lfN7sDr5m4LZFBtn+
         1bTQ==
X-Gm-Message-State: AOAM531h/iHjuKsDOtCqf32jmV3aFG74Q3s4w0iaLBXWbqQKC3IAJ99m
        4TA2Ia2YUCH/yIdIN1Svfof2PA==
X-Google-Smtp-Source: ABdhPJwL2BXm740AJ2eXiOSvWSy3Mw83YPcy9MYsFJYzveBILaeUUNfPsKSC84v+itS3oaSc4z3YmA==
X-Received: by 2002:adf:a111:: with SMTP id o17mr77436675wro.257.1594626432329;
        Mon, 13 Jul 2020 00:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH v2 23/29] scsi: aacraid: linit: Provide suggested curly braces around empty body of if()
Date:   Mon, 13 Jul 2020 08:46:39 +0100
Message-Id: <20200713074645.126138-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/linit.c: In function ‘aac_biosparm’:
 drivers/scsi/aacraid/linit.c:368:41: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
 368 | param->heads, param->sectors, num));
 | ^

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/linit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index a308e86a97f19..734dd6e67246d 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -363,9 +363,10 @@ static int aac_biosparm(struct scsi_device *sdev, struct block_device *bdev,
 
 		param->cylinders = cap_to_cyls(capacity, param->heads * param->sectors);
 		if (num < 4 && end_sec == param->sectors) {
-			if (param->cylinders != saved_cylinders)
+			if (param->cylinders != saved_cylinders) {
 				dprintk((KERN_DEBUG "Adopting geometry: heads=%d, sectors=%d from partition table %d.\n",
 					param->heads, param->sectors, num));
+			}
 		} else if (end_head > 0 || end_sec > 0) {
 			dprintk((KERN_DEBUG "Strange geometry: heads=%d, sectors=%d in partition table %d.\n",
 				end_head + 1, end_sec, num));
-- 
2.25.1

