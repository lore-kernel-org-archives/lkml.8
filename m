Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F132DC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE67F2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSA8Goh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGWM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgGWMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26021C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so4978434wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfRjcVBQyIVpnmla/CO/rMmBV1Hu/Ib2qrKAPkp0wCE=;
        b=DSA8Goh5xSOvhp7gnzWJuGcX7RYXFFEc1KuCxdCEqA3DFTXzzlZCpu24uIQcE1ETxN
         WGqf7bnJ6O8tRMJh376Te3uLSd6JUNozEnnO4034E6o5Ay6++hq1s5zqCyzQMd0gIYQs
         LqQv2JY4Xe1KHsv4gbaN/LFGrH/MdgP7i06vAOKu4n8A7fCYCI60Kr+poaI20VmqmEV3
         v9mEFsDfU5pE2WcIY2AOzc5L+r6BFDrDoT/6SBLLan4gqWQvtVab/CRb8gGemagLkVfM
         FEeYhuHITJqIkYfxwFAZGuTThQGZ7IwpHDjrfb5DBymj15B3uK2FxttvmVYeih+SAnX7
         N+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfRjcVBQyIVpnmla/CO/rMmBV1Hu/Ib2qrKAPkp0wCE=;
        b=YO9oZ8qDtnuKq6R68WNGAQr78iSkhS/KCIDAD8vau3Y/CwyIzgymS/Us0y1/sxIIgD
         Xl5tqa3AGgmsTGs9kL81w+8bEgn9bJKoOkpR0Xj7jEo7RGYn95yOaFffttYVB4NIY9A2
         4c65tOBGa5GcJnLsFdDAfziWHfMum50atnZ1/W2ucXnB37+DSOExXxFXQzvcWUOWCbTC
         7T8MKMKZLEA3xQgJqSh9X8dX4FNsh8ixrFGycMdNT8C6akjD76eOTDTjOq+xK1/+crAi
         5u1px/UOe+gFBbwmOpXHoNakn9pyb2ZYI5MKyaTyoNSRDYiAKYhtKnr59Eo+USr1+A6/
         SRuw==
X-Gm-Message-State: AOAM530Vh18xFUf5OKbyxXOp0N3Bj1ZLLZKETHnukmPpRGfaTJ7C5/VE
        ZD2eR8eCfplSw8t/NIAQOrxzfA==
X-Google-Smtp-Source: ABdhPJwUDa3jAas4QHzpdFeBjvzWKbSJh44OokxCvtuT5rUq+RvFpNpBowdKGw7jam8C/fw0zKeLhg==
X-Received: by 2002:adf:90ea:: with SMTP id i97mr3870556wri.102.1595507128920;
        Thu, 23 Jul 2020 05:25:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [PATCH 32/40] scsi: esas2r: esas2r: Add braces around the one-line if()
Date:   Thu, 23 Jul 2020 13:24:38 +0100
Message-Id: <20200723122446.1329773-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain configurations esas2r_bugon() is sometimes NULLed by the compiler.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/scsi/esas2r/esas2r_log.c:44:
 drivers/scsi/esas2r/esas2r.h: In function ‘esas2r_rq_init_request’:
 drivers/scsi/esas2r/esas2r.h:1229:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
 1229 | esas2r_bugon();
 | ^
 NB: Lots of these - snipped for brevity

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r.h b/drivers/scsi/esas2r/esas2r.h
index 7f43b95f4e945..e30d2f1f53685 100644
--- a/drivers/scsi/esas2r/esas2r.h
+++ b/drivers/scsi/esas2r/esas2r.h
@@ -1225,8 +1225,9 @@ static inline void esas2r_rq_init_request(struct esas2r_request *rq,
 
 	/* req_table entry should be NULL at this point - if not, halt */
 
-	if (a->req_table[LOWORD(vrq->scsi.handle)])
+	if (a->req_table[LOWORD(vrq->scsi.handle)]) {
 		esas2r_bugon();
+	}
 
 	/* fill in the table for this handle so we can get back to the
 	 * request.
-- 
2.25.1

