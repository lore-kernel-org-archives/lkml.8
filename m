Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B8C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186552071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd/xGVYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgICKBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgICKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:01:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E41C061244;
        Thu,  3 Sep 2020 03:01:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so2552935wrt.3;
        Thu, 03 Sep 2020 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVT3ygOcuFe0LWyBz2DhihSeRm+lXNm0vzdkiRVpYsk=;
        b=Gd/xGVYI9n7IwNRt6fMphB2oiARF7ZaKP7+pcG/wHTe5GLhbZQ111XwaZWIDVdQMZS
         Nw++OT232hRTt4xRYOitzQV+uVVranejsOGEE65UKM1S1ETUjh7CljuZ6x9nJhpVmluT
         XaXOS+iKy4ZPoPOlv8Sbhn2FPKLaJWJuV7y1nFM5atU50eKl/gAtlAsFxfcxHwgqdZe4
         ZyaRD5YZDotXHdvSq0cBw4L6DWNnmTP6Huu1FUOD4EFCGgJtSn8OV/D6PxxUdwFkVXyc
         yUD24OfQ+8u64jRMMgnFtlZzKg+ugSWbEpJAzR3PljIuSRit02wVR6Cf/woUBGepHM4k
         G/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVT3ygOcuFe0LWyBz2DhihSeRm+lXNm0vzdkiRVpYsk=;
        b=jo9B8aedduMxXCaVdahbyZRIJwXfXAJdLde6evWPAJFOJHJMrZMKM/ZqfLsXybS2nx
         OBm/aq8S6nuLSsJ8t4qy7oGxiT98BrJ7R3JXnJVGDQgTKQV2cqLd4M6YZ3e+DAdti6Wf
         wvX3FVtB7HcSXnyIoniy3LZX5F0ZdPzFM9q8iKiifQffpPcrCMWCrZ7hQpeKbMMqi4Tn
         IcOwb5thO8KINuUhWDgO07cluyvfbjnJFzAARBthH9tVZmpxMFbhOVCWYAJr2s1JwTho
         KJNoV7PVhowZiInE82Wtlr82LaysfYhL/TVMWa9SnemA++VntPQrzlkWL3/69h0OegHk
         mTqw==
X-Gm-Message-State: AOAM531UMxjrx0KQiu+c24+DhfjUjNKKwlR88JtPDEqLJyJxjITR+rtT
        ISHqBcxyK/OKENg8l48qRBQ=
X-Google-Smtp-Source: ABdhPJy7BnsjGdfd2QUKqJ8X4zF9U3qlAGkBS5H5ShHh+J5C67lXOew+hI1JpzzuZufYYJpJVEodKg==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr1581975wrm.174.1599127307905;
        Thu, 03 Sep 2020 03:01:47 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id u126sm4487724wmu.9.2020.09.03.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 03:01:47 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: core: Free rvdev on error path
Date:   Thu,  3 Sep 2020 11:01:42 +0100
Message-Id: <20200903100142.57117-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rpoc_handle_vdev(), rvdev is not freed properly on the error path and
one of the labels is misnamed. Fix this up.

Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/remoteproc/remoteproc_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d4bd71f87b03..84dea43d196e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -531,7 +531,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	rvdev->dev.parent = &rproc->dev;
 	ret = dma_copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
 	if (ret)
-		return ret;
+		goto free_rvdev;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
 	dev_set_drvdata(&rvdev->dev, rvdev);
@@ -539,7 +539,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	ret = device_register(&rvdev->dev);
 	if (ret) {
 		put_device(&rvdev->dev);
-		return ret;
+		goto free_rvdev;
 	}
 	/* Make device dma capable by inheriting from parent's capabilities */
 	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
@@ -556,7 +556,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	for (i = 0; i < rsc->num_of_vrings; i++) {
 		ret = rproc_parse_vring(rvdev, rsc, i);
 		if (ret)
-			goto free_rvdev;
+			goto unregister_dev;
 	}
 
 	/* remember the resource offset*/
@@ -581,8 +581,10 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 unwind_vring_allocations:
 	for (i--; i >= 0; i--)
 		rproc_free_vring(&rvdev->vring[i]);
-free_rvdev:
+unregister_dev:
 	device_unregister(&rvdev->dev);
+free_rvdev:
+	kfree(rvdev);
 	return ret;
 }
 
-- 
2.28.0

