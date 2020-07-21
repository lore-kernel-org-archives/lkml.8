Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4178320792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Egp5H4pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgGUQl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGUQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:41:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so7001895wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSRBp5WStd9Y481S5Og1e8mziqqocuxpn4+5CH6s/V4=;
        b=Egp5H4pu2L6EzccLlHAMIwLTK50EpvvWcuSavl6dxS+o+rUQRPDp2XpTYnTjUS+KUi
         uWcXXe2s/Ehz/WZYWK2zGL15XByi2KO1f61XaLxkMeIDIT6YezDvsqTSLn0cpcs0b5Eu
         kvPRw32tr4a3i05MdWTSX7LKYf9m30098UCHy2q6dMk7VTOVwfgnXeBjXhBultigxuwp
         JZo16vd/sGh2ag2xaKw/9nNAVBmihuOg6m+UxZsxeeN1B0T/jgcOA8YIh3thO5XR5/fu
         khqpOmb/LS+svniR+y9VvCrP1z5dJnmhYAt49FVHboj+QnXVIAb28S4oHvg0xgmu1agu
         Z2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSRBp5WStd9Y481S5Og1e8mziqqocuxpn4+5CH6s/V4=;
        b=KyCpVdvJcFxOjLyAilpb0tCczbV2c50BRD/cxzs7WvHUW0xeuQb81oS7FD9I5QYNYt
         XiFlVfjOjCouSq63gelcsNBMZAUPTndo09HRAkj1HfSmprIHlu/mUdiHFLdauAEt6bU+
         OOE9WI1TOiY/Y9UrgCh7+uM1OQoH1dZlgHPxKzKlhfOMfhjnkKGZf95mz/wNXoWXDK1U
         9j5tyz8869seMdgRPYcI7GewdBmUYloP3JYjqH/0HNgTRr2JticDx36gcJlCOtNiZP08
         9Kt03Q3Ml8/UKRoYhzI9IniydmGPLrDQCD3KRj8lmbSCQL2fqDfofrmOiPYe1l6ojk4x
         BJIA==
X-Gm-Message-State: AOAM530a+c0zjFM3+fwy6i7BAfOgFjq2bDTRjuA8Mjvfp0Yb6KVj3tA+
        sYEOITsSaMJ3U1qbL9p3W9X8PA==
X-Google-Smtp-Source: ABdhPJwR9PfgqrQM6xiiXqEdTd0R303eL546jC1FrUf25+Zxk9wVW2r7JsLFudeclns7p1DZw05OZQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr25734756wrx.50.1595349714031;
        Tue, 21 Jul 2020 09:41:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:41:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, support@areca.com.tw,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 01/40] scsi: arcmsr: arcmsr_hba: Remove statement with no effect
Date:   Tue, 21 Jul 2020 17:41:09 +0100
Message-Id: <20200721164148.2617584-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to LKP, commit [no upstream SHA yet] ("scsi: arcmsr: Remove
some set but unused variables") can be furthered to remove the entire
statement and not just the unused variable read into.

Snipped LKP report:

 config: x86_64-randconfig-m001-20200719
 compiler: gcc-9 (Debian 9.3.0-14) 9.3.0

 New smatch warnings:
  drivers/scsi/arcmsr/arcmsr_hba.c:1490 arcmsr_done4abort_postqueue() warn: statement has no effect 8
  drivers/scsi/arcmsr/arcmsr_hba.c:2459 arcmsr_hbaD_postqueue_isr() warn: statement has no effect 8
  drivers/scsi/arcmsr/arcmsr_hba.c:3526 arcmsr_hbaD_polling_ccbdone() warn: statement has no effect 8

 1a4f550a09f89e Nick Cheng  2007-09-13  1401  static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 1a4f550a09f89e Nick Cheng  2007-09-13  1402  {
 [...]
 18bc435e0a1de2 Lee Jones   2020-07-13 @1490                             pmu->done_qbuffer[doneq_index & 0xFFF].addressHigh;
                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Delete this line.
 [...]

Cc: support@areca.com.tw
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 5feed135eb26c..23e9e12d588f6 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1487,7 +1487,6 @@ static void arcmsr_done4abort_postqueue(struct AdapterControlBlock *acb)
 					((toggle ^ 0x4000) + 1);
 				doneq_index = pmu->doneq_index;
 				spin_unlock_irqrestore(&acb->doneq_lock, flags);
-				pmu->done_qbuffer[doneq_index & 0xFFF].addressHigh;
 				addressLow = pmu->done_qbuffer[doneq_index &
 					0xFFF].addressLow;
 				ccb_cdb_phy = (addressLow & 0xFFFFFFF0);
@@ -2456,7 +2455,6 @@ static void arcmsr_hbaD_postqueue_isr(struct AdapterControlBlock *acb)
 			pmu->doneq_index = index_stripped ? (index_stripped | toggle) :
 				((toggle ^ 0x4000) + 1);
 			doneq_index = pmu->doneq_index;
-			pmu->done_qbuffer[doneq_index & 0xFFF].addressHigh;
 			addressLow = pmu->done_qbuffer[doneq_index &
 				0xFFF].addressLow;
 			ccb_cdb_phy = (addressLow & 0xFFFFFFF0);
@@ -3523,7 +3521,6 @@ static int arcmsr_hbaD_polling_ccbdone(struct AdapterControlBlock *acb,
 				((toggle ^ 0x4000) + 1);
 		doneq_index = pmu->doneq_index;
 		spin_unlock_irqrestore(&acb->doneq_lock, flags);
-		pmu->done_qbuffer[doneq_index & 0xFFF].addressHigh;
 		flag_ccb = pmu->done_qbuffer[doneq_index & 0xFFF].addressLow;
 		ccb_cdb_phy = (flag_ccb & 0xFFFFFFF0);
 		if (acb->cdb_phyadd_hipart)
-- 
2.25.1

