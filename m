Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4965C207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwTEejYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgEURDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgEURDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so3075556plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJ2eNc7apCnjQNGt0p93zRKod9HTjcRq8eOl30pVQTU=;
        b=YwTEejYR13iNTc9f8w+Ou8vlbI/keF79pDuGS3WDvqbPvtIzQJIuvC9YPjn/5YwN0a
         IhI9UmjhVKDJLw15YnbHt1NUFrsz8GKkv2nVAfPpcty4fKVRXHVvsNqwvJ0UzMDwrGtZ
         ESNiehxml3V33/vxYZYBs8tfFR/UWCfkyrRX4HaSMgedNe8jzcmYmv6+jtDekbvlk68N
         rfohiKIviqXx2vxXha+zA0MxkpCp8eJgB+IxuABGahF+J/q7clBnwiRJzPczvpVWMNVL
         YGKI69PHWtK8DtPoOvHPNkf727cxijzjt7olmiNm+Zhv3IOIH8IA6xkiXQxezrDUNEvE
         Wa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJ2eNc7apCnjQNGt0p93zRKod9HTjcRq8eOl30pVQTU=;
        b=bJ1cOwGrFAeLI0TdhMCZ+vnc1PSAwasFintVHGPhMXfT9FYHXUuOlNNMX0/TKXIaz6
         52n3UQIlEGSd5PvERUfPnn1Z9Sm3ENhKydM3G2Xv8XSSNp36z5zkpiZ7qmS5F99hf2w9
         q0jMegxNuK+m+44AJWPM4C5YVRqYo4hY83Fh7Z80/6HzxwUCC6Xk5taGJPOGyGRYLJYi
         edl4RnkD3fojgMlg5KbH4dDv7vzaKcNz00cjegdcSEmlQxb5gDuxia6xVWSwzxAp+b/l
         5o9aQNbUNijpuzD+VAFIjDSXbhjzJTXjBUp7H3Zb+hydoQY7QRk1l82F72S3msjkEMnw
         DY5g==
X-Gm-Message-State: AOAM530ASTkZxVHdw87D+6T2J72qfSV+c0rj2RT7i4nxkTcxGm9oRqoE
        If8OUZuPvD8tF/4piz/mok0E
X-Google-Smtp-Source: ABdhPJxNcDnyrVnLZQYtsvzE3JxE5TwSm3623VUPGydPUzOaNwfrjh0Z/0Gwoot6q53jptV3LJn3ow==
X-Received: by 2002:a17:90b:68a:: with SMTP id m10mr11735414pjz.5.1590080587521;
        Thu, 21 May 2020 10:03:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 02/14] bus: mhi: core: Cache intmod from mhi event to mhi channel
Date:   Thu, 21 May 2020 22:32:37 +0530
Message-Id: <20200521170249.21795-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Driver is using zero initialized intmod value from mhi channel when
configuring TRE for bei field. This prevents interrupt moderation to
take effect in case it is supported by an event ring. Fix this by
copying intmod value from associated event ring to mhi channel upon
registering mhi controller.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index eb2ab058a01d..1a93d24efffc 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -863,6 +863,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		mutex_init(&mhi_chan->mutex);
 		init_completion(&mhi_chan->completion);
 		rwlock_init(&mhi_chan->lock);
+
+		/* used in setting bei field of TRE */
+		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+		mhi_chan->intmod = mhi_event->intmod;
 	}
 
 	if (mhi_cntrl->bounce_buf) {
-- 
2.17.1

