Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC94C433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2B220792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSQhe3Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgGUQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbgGUQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B252C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so21871428wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVya3i2RYFmjDn+ApSCZmjqKSuYsjstrD5lmzrYcCv8=;
        b=cSQhe3GpFZLwDcOqe8hrwIBcCqhy1WXeYMuIdLJfCfWZeBQCDXPzn3pMxB1nazlOE/
         CVswu4QRfwLMmGkgIjLDb+7ABgpgobEgfnOJF108eU188HMAFiDMqHSw1O86PMZxaytv
         jnMG7es22SSHN5QWOamQFJi/CJb8wp5fyvtc10G4sgM5J06aQkF9/ZJ1vTR08HVDKixA
         GiMfdcdsnFiPPXBLQNg0Bfb3KkCk/6H5gBokXyKRP1b8xxrLEnj42rm923hcEK1MFw/g
         oapqloEgzSomASzZ08MYGCEk5YLYbGvntXakIiGl4DkBG/g/BeBfRMCfZmCJbZ2H8bdq
         CikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVya3i2RYFmjDn+ApSCZmjqKSuYsjstrD5lmzrYcCv8=;
        b=K6pa5p8ohfJF7R+iljhd/E85kd9QINFjtTsu+wCusVOkTve9QZkj89cH/b+afhUqIv
         fyg//AWFd7nraYObbYMK65WfDedF1DMoiyTLSbVlWyZHKLr5AoAAO0pHqyrVYnfaRzsk
         fAZMsB1OkwbF/BIhnKftlxbEWReC5kulBoB6dBx/xk7qb0WnbPFFatBtCZfG56aVbpfD
         5eWrbzs/hLbX1pn/SwItsFSoR/aVuMS6/bG21DzrPyEJa36PYq86o+KkiNSPUeX2LTXB
         ehO8D8PLFi6mvNWip5uUfZb+vRz8KnkSDEw30YmrjeIjYtesRxRQ7THL1ei7WzW/Vy4V
         VQfg==
X-Gm-Message-State: AOAM533d0OJrW37hICDEIOUcNbseFB/GG49OTwAxoX31gRw9hMEU0cAV
        LQ2iuOjUygpAIoYO+ijPtzq2bA==
X-Google-Smtp-Source: ABdhPJyYJSQbCGjzZ/HHRSdXd5WAJbAKCE0eLK46l5v37puMWdWQo3SYyslUvw9wc5pEwhmtZ1gg9w==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr4952074wrf.309.1595349765151;
        Tue, 21 Jul 2020 09:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 34/40] scsi: csiostor: csio_lnode: Demote kerneldoc that fails to meet the criteria
Date:   Tue, 21 Jul 2020 17:41:42 +0100
Message-Id: <20200721164148.2617584-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches some of the other headers in the file.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/csiostor/csio_lnode.c:2079: warning: Function parameter or member 'hw' not described in 'csio_lnode_init'
 drivers/scsi/csiostor/csio_lnode.c:2079: warning: Function parameter or member 'pln' not described in 'csio_lnode_init'

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/csiostor/csio_lnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
index 74ff8adc41f77..61cf54208451a 100644
--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -2068,10 +2068,9 @@ csio_ln_exit(struct csio_lnode *ln)
 	ln->fcfinfo = NULL;
 }
 
-/**
+/*
  * csio_lnode_init - Initialize the members of an lnode.
  * @ln:		lnode
- *
  */
 int
 csio_lnode_init(struct csio_lnode *ln, struct csio_hw *hw,
-- 
2.25.1

