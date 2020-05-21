Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C946D20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAowRAhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgEURDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgEURDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157CC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so3066823plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1JC31ww1q7sQ26rx5mXgh+sPUgUYnNfccjrjhPmuhCg=;
        b=OAowRAhWFjiS6YrTzw28NNLGeVvOl/ZjlR5oJAehHba785tAHq1EXuLtb5AuDBibZr
         B4kNZ53Kh6r4SAZalglyEdqRHL5Rc3iThE/q2UO/zHXFIDsIdVIJhBVvbl9wtnlI5OlI
         ZXXsio7/Y4hLeJu5VfRKdogekJjwcBMtZBHANDvWl+QUZtrNMmqUj1hlkP5MSALUaSC7
         ImhMqGgRjQhTa//CQ/vXBVezoc62wBSs/f37vQHNuaFFfrA0DZQQO7mvPx027UXDu7Tk
         D39DOT5hK++uhW6XWJx2V3GAhzN9TP1RUX1CXtNg3Sc4XY+gFeKFyvoZtt+xDDfyEyB8
         8xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1JC31ww1q7sQ26rx5mXgh+sPUgUYnNfccjrjhPmuhCg=;
        b=uSM6Btb29lmEp3RaCC8YbqlbbbN/mtElk52qhwfWSQydazCYNPP0xChmnXMtGQ1/fM
         /Td8+/I+1eJqZlFeQrnJNqb9eKy5Kq0lhsFzasa09TWXbeDgdFNnvrFqwe0m/clJCPk8
         6Q/a5NadFkWAMoAtVfgHRWdOFKM2EJu3UcHGu5RYT4o0aoJjToB+RFS/MnfYEKd547YU
         XY4nkgkNXosKEpjDbcWHgkcmITvDfN2CsfXuNnbaOY8g2SrfktQq7bBtnFYR9iRf1dtd
         SebFIYEm+awdexTdC7sPsVsHeGGyfjpiDElbuiHDsh7BiNnfgrb5mfkueGjASPQz5Mmp
         iUsg==
X-Gm-Message-State: AOAM533yeZumXbqHA3Fc8XW+DjfwlnZfb7P74GnKhI8X/VxUDXKWPnqq
        KZLUzLPBV7pSWPZ5pytuexhBj66RhQ==
X-Google-Smtp-Source: ABdhPJzEw5nI3aeBZju1p5rockRFgVKs95aj+pu2mEXhUoCr0FV04xEum23zRx01eia8+R/KJ1Ypxw==
X-Received: by 2002:a17:90b:3745:: with SMTP id ne5mr12430237pjb.68.1590080596586;
        Thu, 21 May 2020 10:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 04/14] bus: mhi: core: Read transfer length from an event properly
Date:   Thu, 21 May 2020 22:32:39 +0530
Message-Id: <20200521170249.21795-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

When MHI Driver receives an EOT event, it reads xfer_len from the
event in the last TRE. The value is under control of the MHI device
and never validated by Host MHI driver. The value should never be
larger than the real size of the buffer but a malicious device can
set the value 0xFFFF as maximum. This causes driver to memory
overflow (both read or write). Fix this issue by reading minimum of
transfer length from event and the buffer length provided.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 64022865cb75..a394691d9383 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -513,7 +513,10 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
 
 			result.buf_addr = buf_info->cb_buf;
-			result.bytes_xferd = xfer_len;
+
+			/* truncate to buf len if xfer_len is larger */
+			result.bytes_xferd =
+				min_t(u16, xfer_len, buf_info->len);
 			mhi_del_ring_element(mhi_cntrl, buf_ring);
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
@@ -597,7 +600,9 @@ static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
 
 	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
 		-EOVERFLOW : 0;
-	result.bytes_xferd = xfer_len;
+
+	/* truncate to buf len if xfer_len is larger */
+	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
 	result.buf_addr = buf_info->cb_buf;
 	result.dir = mhi_chan->dir;
 
-- 
2.17.1

