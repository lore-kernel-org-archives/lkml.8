Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110E3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBB7206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nYn3psEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437851AbgE1Xxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437677AbgE1Xxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:53:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9411C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:53:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so247169pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MsZSmU61OLe136r//qttOvmTDf94o4Xes23hd9beBhc=;
        b=nYn3psEFlsAo+l4qjLcV/PPFHdSi/yh4Ak7xlfTqvsuuGV0fmcl5epZboPlP0qPDie
         bhpqMExiCSK+2twDheP4//o41BF4oowsaXRpQkFp89iHqzAeQnbdErfzkyrXmnb7BSZz
         uiSrLz3eYN7fipm8yg74y/x/sJD3WeduEtkEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MsZSmU61OLe136r//qttOvmTDf94o4Xes23hd9beBhc=;
        b=devPpLRZ7L7ycUMQc59RI9oPyKIN/OpGDxvwW6LV1fQvIE7sOkh3dYsZXGEG86U7NO
         sKeV3LO3iCQ79BOSEWuRbYeRK4r8pWkfiDxOzjSTkYP2moQd79LoopcED8f0gj8aNb2s
         pe/Od3VHjgd604/3qApJZ1n3qTiUIqMZvIC0KUzVTxXVuIOgsd9/kCYjn2Dcxt/08r4t
         PoCc2Ix665EjgJcYKfS8jOqDt2CWLRXZwBJZWtZ3aMv/r1gbJgZGEulXJr2OwgLVcHvV
         RVaVp3Wi/2ACbqAniWF+FovfuyRcy5hthtNSq3yCZp/MEanYx/NmHoy3t2eG9qyftmLN
         sXRA==
X-Gm-Message-State: AOAM531CgVI1kZ+K8wMORaAWls4LNInLNZZejbInhtWIoFbKiQ4bfH2c
        RqHjvT6K91WJULJTAaHOl1x/iw==
X-Google-Smtp-Source: ABdhPJzIS+ng7A7E9YeduAOageV51r0tFW3WRVx27/g0uUHRZMUKYgeSlFrSrKc4soQTtOvN9PK9zg==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr749166pjq.225.1590710023485;
        Thu, 28 May 2020 16:53:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i197sm5735574pfe.30.2020.05.28.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:53:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     evgreen@chromium.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: Enforce nvmem stride in the sysfs interface
Date:   Thu, 28 May 2020 16:53:02 -0700
Message-Id: <20200528165250.1.Iad7dec5afecba175c816773a0088be805476453f@changeid>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct nvmem_config' has a stride attribute that specifies the
needed alignment for accesses into the nvmem.  This is used in
nvmem_cell_info_to_nvmem_cell() but not in the sysfs read/write
functions.  If the alignment is important in one place it's important
everywhere, so let's add enforcement.

For now we'll consider it totally invalid to access with the wrong
alignment.  We could relax this in the read case where we could just
read some extra bytes and throw them away.  Relaxing it in the write
case seems harder (and less safe?) since we'd have to read some data
first and then write it back.  To keep it symmetric we'll just
disallow it in both cases.

Reported-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 05c6ae4b0b97..1c0e7953f90d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -111,6 +111,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return 0;
 
+	if (!IS_ALIGNED(pos, nvmem->stride))
+		return -EINVAL;
+
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
@@ -148,6 +151,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (pos >= nvmem->size)
 		return -EFBIG;
 
+	if (!IS_ALIGNED(pos, nvmem->stride))
+		return -EINVAL;
+
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

