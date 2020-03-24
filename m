Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE3C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61A20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pd8UTyaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCXGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40763 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgCXGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so6976229plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WVYi5XJp4WaCaddQcy1HjEAG2je/Kk0d1P+LoVF1LU=;
        b=pd8UTyaSYpTKXCN7QrLwOBofh1wKx/kx7MMp7nmsCAGZEbgwlZO4bwiH2fcWXPlA5b
         p6BEUK/SHbdRxrz/bGGpfCUiH2b6pZ9DuaNLUDODNLt+y0D+EAVXZBjqwNAqyHhzOH48
         j/MZWAkuys3pFFFmuX6gzEKE+FaqNrGmyrp+UpWN116KU//zbGN8gF9CHL6vuLLnpwPG
         NUtuB6aqgewmt1vhEa3oW66kW8eSsWwSyKMnX3JsIIP6ch0VhJ+pEBCE9FOGn4Tvd3YB
         5SIOKiucbizWWIuvdeQMKrM5HajVCRo+TOn7VrnP3eHKn/0UVpB6qNzdmLrftimF3M8o
         LVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WVYi5XJp4WaCaddQcy1HjEAG2je/Kk0d1P+LoVF1LU=;
        b=eE18r2sc9AjeCWqxZUx5wRwHeOKm1uFZmtctrIPAZt3DSoP9/QK+jhgTIjpGWDZh6U
         Y/rHtlBbNyZO3fvk6itS7Lzy+2zGQV+5iCp2lXYJVdfskcTuY6MrnMhFA13oI7C7Rw/b
         1SPGXdFsrLiNEAh51JcDnv44RkcCS2+cQZabmC/obZbrlaJmiyhRGLPbOZ/doHZ77VpI
         Sohj52VBV/HKzosuf9U5xiPVkZLzyAQGoEV1gP+e0vCNOVdo/VTXRxpgHbLIpWHGp3OT
         LBvvqoNS/4+iLFXFVR+kXt0396AqEcOX7IrRSAJI96qRcNsPhZdF11oxEI9lclPdYE/H
         jFKQ==
X-Gm-Message-State: ANhLgQ3euG3o06CUwSutJjSN9pGdgvGvlPzDLgv3eNOeJ4VupdfJkTPQ
        DL7HK1I1IPjET8BSDcYA6VWm
X-Google-Smtp-Source: ADFU+vtjITQ4IqHQogQZiG/IQLbhQZQbc/2nRvw0YUkLGLuZY8TqVftFygLUnF65xwOp2p2QBRHGug==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr25265479plo.45.1585030283398;
        Mon, 23 Mar 2020 23:11:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id d3sm1198230pjc.42.2020.03.23.23.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:11:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/7] bus: mhi: core: Drop the references to mhi_dev in mhi_destroy_device()
Date:   Tue, 24 Mar 2020 11:40:47 +0530
Message-Id: <20200324061050.14845-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some scenarios like controller suspend and resume, mhi_destroy_device()
will get called without mhi_unregister_controller(). In that case, the
references to the mhi_dev created for the channels will not be dropped
but the channels will be destroyed as per the spec. This will cause issue
during resume as the channels will not be created due to the fact that
mhi_dev is not NULL.

Hence, this change decrements the refcount for mhi_dev in
mhi_destroy_device() for concerned channels and also sets mhi_dev to NULL
in release_device().

Reported-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 12 ++++++++++++
 drivers/bus/mhi/core/main.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index f6e3c16225a7..b38359c480ea 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1028,6 +1028,18 @@ static void mhi_release_device(struct device *dev)
 {
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
 
+	/*
+	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
+	 * devices for the channels will only get created if the mhi_dev
+	 * associated with it is NULL. This scenario will happen during the
+	 * controller suspend and resume.
+	 */
+	if (mhi_dev->ul_chan)
+		mhi_dev->ul_chan->mhi_dev = NULL;
+
+	if (mhi_dev->dl_chan)
+		mhi_dev->dl_chan->mhi_dev = NULL;
+
 	kfree(mhi_dev);
 }
 
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index fa1c9000fc6c..eb4256b81406 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -244,6 +244,19 @@ int mhi_destroy_device(struct device *dev, void *data)
 	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
 		return 0;
 
+	/*
+	 * For the suspend and resume case, this function will get called
+	 * without mhi_unregister_controller(). Hence, we need to drop the
+	 * references to mhi_dev created for ul and dl channels. We can
+	 * be sure that there will be no instances of mhi_dev left after
+	 * this.
+	 */
+	if (mhi_dev->ul_chan)
+		put_device(&mhi_dev->ul_chan->mhi_dev->dev);
+
+	if (mhi_dev->dl_chan)
+		put_device(&mhi_dev->dl_chan->mhi_dev->dev);
+
 	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
 		 mhi_dev->chan_name);
 
-- 
2.17.1

