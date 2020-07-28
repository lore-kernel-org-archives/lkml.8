Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD00207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea2mUzTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgG1R7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgG1R7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:59:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:59:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so1306645pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1CuR54gMeaVLFpH/ii6AIR06fUc7GcpAwE4BlLar214=;
        b=ea2mUzTqB0NNb90vADy/ykGFBld0CZrTogIlU/fbQucYUMl6NoCOerMw/VtAhIkLbv
         dW78rlPhehg0esQzTuOynId+vTaisvn/6y9ldNO6mjnxhegXmyDrWbiAt23bIWFfmWEK
         Bo2/P1HoRVzMp2w54IbBh3ydHSSzVquK/2ZsXPaSBEdUJmLuruAqBIQ2nYw2iNxWUMK5
         1iY/c23K18Tsy1U4UlyB17FJlahhjGKM5rGzdAslbIQPNTNQQ1/rryqyVTi4WR4GwlcM
         S8auaLAVs+Lo77dqe2C3ksBeODWTeaQj48f3n9mNdI33YTgP7RHaDCwkMd6uEiRB36ln
         Jq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1CuR54gMeaVLFpH/ii6AIR06fUc7GcpAwE4BlLar214=;
        b=bbXsh/ne1oDacaSeZGsYdF0s8xQ4D2bj6sJyX1Ef2D5seeHHivN5tQwg9OpxLc5xGQ
         VgHdI8c0BdnWRQdnYf+cl8avMWoEFrnaoWRezrCXxmrCv8zKG6uguGl/suaoz5MGj1eU
         JwUfiAeW88mekH1YhlXRAqnAIap34x/9cKHG24V7BXvvtGAZue9uCO/3d35mrLxjt0dT
         YjHktaRmHu4SM2qBGdvOkVYaTrp9+kXTJI9OLs/7T2Oh78prsWfY/tdQ5Gb+ohoN5Pww
         SG1dQuzXNbtkIWCaYZhakx9DezglcyhRCJ2Fnm0dY1xUxkZGcakK8PgesIyDgRSrUhlC
         lNqQ==
X-Gm-Message-State: AOAM530hhw9M+/qDNvHe/AltkO7Wydxi5+cGl+2ceLUdvISlBCEagPxc
        4cNal0APsOi3B7lHUEzBy9k=
X-Google-Smtp-Source: ABdhPJxk9Pu/1J38jTEqDbP43EL492G7ozhLG2/AJBBatUyuF/mhrP+oaqvBLLzDl7+C3IW09tHVwA==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr26038216pge.131.1595959192115;
        Tue, 28 Jul 2020 10:59:52 -0700 (PDT)
Received: from localhost.localdomain ([132.154.123.243])
        by smtp.gmail.com with ESMTPSA id s4sm5519263pfh.128.2020.07.28.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 10:59:51 -0700 (PDT)
From:   Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: used const keyword
Date:   Tue, 28 Jul 2020 23:29:35 +0530
Message-Id: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran checkpatch.pl script which reported a warning to use const keyword
on line 370.Therefore I made this change.

Signed-off-by: Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214191da..f9cfa15b785f 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,

 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;

--
2.17.1

