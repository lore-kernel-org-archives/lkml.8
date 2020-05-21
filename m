Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A57C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E462065F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwNszkEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgEUHC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgEUHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:02:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E7C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w64so5248157wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/J+QSCnpCz+dK7a2CTZvs1hYwiiujWP44h1PKOVX/6Y=;
        b=OwNszkECZJFOIvu74Y9eydjyHX7pOhDFAGPl4TJPF7UkdVx9cBk5DeGUw7r56ShvKV
         zW2riszf3QMm1u7ASnxm0YBdRVnUumjDvWEpWcnlT+RN5cymWYFnZd60i/l30PbKreS7
         W0Qk7+YLi40gFQY6+5pKGCzgLl0kz3WkqDx9+GOJGhs2dgyXIiqiwf8Q11SqPRsOBuGn
         HKQ0VkYfw88EQAPs7T67lkBi5pD3sfroSaOwMTUUTJGvXSOiVWUXWtvKclXVQpnomdA0
         DWLhILIaDW3xxPYZaM9CkZ7YGhKkGFBO+NhrjFehuMAsn28Uuaz0gW9JiDYLOtqAmEqB
         DCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/J+QSCnpCz+dK7a2CTZvs1hYwiiujWP44h1PKOVX/6Y=;
        b=BWdVJBPdPsNwaK5gbVqqAX0/L2stYWAHjatvFBOwaL8OwVSzgpxN9zHutNc5jv6l07
         rx9mhhVV737l1/W+2/ywB9P2lwIjIXSuHzxvlwyIB2FsxjzfhDnFMAy3dA5Tfstj4Yp0
         oq3iLqi9NiVEoW12AMPUdMgszxZgvXy80XnrifYocrO8EpnCythqqI5QjOHrt715NkbK
         bZ3fLnhdDCvEnAJ+4bFiURkNizWv1V/Gr166oS/qj4QPvB43ELi/1OLiwAfp97QDqEL2
         7kpoKF0S+ASlxG6deVwymXpYBGyRjN5am557iUT0Xo6+ZrxU4AnGQLCLH3+G33gAE+uN
         gGUw==
X-Gm-Message-State: AOAM531/OpNdeQga/JzmO4BAtrL83Lfa+W+Q19+PTm+SI6iYaFeE1m8h
        Ah5KgLtV4vrHlherjUyItqlFkFx/
X-Google-Smtp-Source: ABdhPJzuIZ/WW6Is6+GUaMpmDLmoPeZCXBe6/p46FMF5Lgkmrjl5MBuTP2l6Z5HlGAGFXKl+TyzDzw==
X-Received: by 2002:a1c:408:: with SMTP id 8mr7171592wme.147.1590044538002;
        Thu, 21 May 2020 00:02:18 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id w20sm5448205wmk.25.2020.05.21.00.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:02:17 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 4/4] habanalabs: don't allow hard reset with open processes
Date:   Thu, 21 May 2020 10:02:05 +0300
Message-Id: <20200521070205.26673-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521070205.26673-1-oded.gabbay@gmail.com>
References: <20200521070205.26673-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

When the MMU is heavily used by the engines, unmapping might take a lot of
time due to a full MMU cache invalidation done as part of the unmap flow.
Hence we might not be able to kill all open processes before going to hard
reset the device, as it involves unmapping of all user memory.
In case of a failure in killing all open processes, we should stop the
hard reset flow as it might lead to a kernel crash - one thread (killing
of a process) is updating MMU structures that other thread (hard reset) is
freeing.
Stopping a hard reset flow leaves the device as nonoperational and the
user can then initiate a hard reset via sysfs to reinitialize the device.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 4a4a446f479e..2b38a119704c 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -726,7 +726,7 @@ int hl_device_resume(struct hl_device *hdev)
 	return rc;
 }
 
-static void device_kill_open_processes(struct hl_device *hdev)
+static int device_kill_open_processes(struct hl_device *hdev)
 {
 	u16 pending_total, pending_cnt;
 	struct hl_fpriv	*hpriv;
@@ -779,9 +779,7 @@ static void device_kill_open_processes(struct hl_device *hdev)
 		ssleep(1);
 	}
 
-	if (!list_empty(&hdev->fpriv_list))
-		dev_crit(hdev->dev,
-			"Going to hard reset with open user contexts\n");
+	return list_empty(&hdev->fpriv_list) ? 0 : -EBUSY;
 }
 
 static void device_hard_reset_pending(struct work_struct *work)
@@ -908,7 +906,12 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		 * process can't really exit until all its CSs are done, which
 		 * is what we do in cs rollback
 		 */
-		device_kill_open_processes(hdev);
+		rc = device_kill_open_processes(hdev);
+		if (rc) {
+			dev_crit(hdev->dev,
+				"Failed to kill all open processes, stopping hard reset\n");
+			goto out_err;
+		}
 
 		/* Flush the Event queue workers to make sure no other thread is
 		 * reading or writing to registers during the reset
@@ -1391,7 +1394,9 @@ void hl_device_fini(struct hl_device *hdev)
 	 * can't really exit until all its CSs are done, which is what we
 	 * do in cs rollback
 	 */
-	device_kill_open_processes(hdev);
+	rc = device_kill_open_processes(hdev);
+	if (rc)
+		dev_crit(hdev->dev, "Failed to kill all open processes\n");
 
 	hl_cb_pool_fini(hdev);
 
-- 
2.17.1

