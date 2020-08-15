Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E68206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRyyO52S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgHOV5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgHOVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33485C0F26E1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so10535641wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yYAV3igQMmpvvFnmjUsCROUH1VHG4f/mO3o8H4VbMTk=;
        b=WRyyO52SFPyfUOYVGJQ9KBtomPv1RxCctqbvWMXYzHmfQhL/eCOx7oJoNkm8uiAphU
         NlK9F1xPkGGmMEsjl0vdWySLjeh/eCx27fnuZ8G7oOWHmuTjHe/8Hmn3UIqDnDxUrsrU
         Sabwi4X9jiUwrIXrsryCsQ/9C+9N4JlVNincp+3Cr+zwrRcJdqpgX7wynuag0hP7bMCk
         q3VXWjtuNHpnHIgVm8NBnHCPpHq7f6lssS/DQHs1qinATbmrOToFX47bJ7Uc4D2iYbTR
         E4m3Pe1zGsgytlDIcGtA3GxxekF/REP/H6oFxJBa3p9xz6n0tM/d4rqBDK5QDe/D1Q9d
         xNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yYAV3igQMmpvvFnmjUsCROUH1VHG4f/mO3o8H4VbMTk=;
        b=eoigeCK9eQ8TN0+1urygT1ApJMj01j8H3DqsTij8DTJmbxD9VHs312J4vlo5aCjiUW
         zrqcvEqjDTzx9OMJ5xCIZDP3kCOMW2spsY2JRiWOA9dP6fJ2QrG9z4l7tEPYy/A9aCr2
         VhkRfo6BnSnRnCZFrl2yPbmtdzL5Yas82+7/KLVFCIEUpG+hA7zr+NKFvdk2eK67IN+B
         nIawmq01pu4e3hGxoz0y5MyZU8mSZwTA+1ojetWY2zsmlT4Z2w79ug+CpsQAXzNuFshf
         BwevyggxQCsp+dRUtp5hGf6ljTY+4NyWGlnChCiJPXMSkLaxwV3H104Bpbr2y5E7/x8F
         QEbQ==
X-Gm-Message-State: AOAM533jw6uUxYMJ15dGsamjjdbMFSJEU6k9Oo15Ou56EGEx5zaPSYa0
        T+cXfPeNFlqpCa6Nwt5GH4Dy4mnAGdU=
X-Google-Smtp-Source: ABdhPJwWIqgnA18r1TGBxonSpy1G+FcEGKxNuN0K06yEHbulWwOvzLCc5n3xAOtGmL0/4+iiUnGRqg==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr7552359wmh.74.1597514382502;
        Sat, 15 Aug 2020 10:59:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:41 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/9] habanalabs: cast int to u32 before printing it with %u
Date:   Sat, 15 Aug 2020 20:59:31 +0300
Message-Id: <20200815175938.16619-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%u is used for unsigned so we need to cast the int variable to u32 to avoid
compiler warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 35214a186913..38895493a0ed 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -286,7 +286,7 @@ static int device_early_init(struct hl_device *hdev)
 	}
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
-		snprintf(workq_name, 32, "hl-free-jobs-%u", i);
+		snprintf(workq_name, 32, "hl-free-jobs-%u", (u32) i);
 		hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
 		if (hdev->cq_wq[i] == NULL) {
 			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
-- 
2.17.1

