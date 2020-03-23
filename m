Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFEC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ABD20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOe+nKCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgCWMba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:31:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40116 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCWMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:31:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id l184so7424882pfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WVYi5XJp4WaCaddQcy1HjEAG2je/Kk0d1P+LoVF1LU=;
        b=pOe+nKChsCyDxA3kKu+UWucseGJUAw5AqsBo7ljLGWVFFRYvte4WaO9LHFWE0Jg6oq
         bkTNuHlS3gKm4K6znOjFupC/LjpnV+C5RpZZcXDjI4cWKhdl5+gHpBHd9y11kEG1rH+v
         7vpghAnkih8eRYbO8cIvU2LvMJKEedxIzaa2CuOrrsDrjKQuq8RW4osafGvRKxl8Fb2N
         OOk/TF5UB2rG1Fkv60/+Iy3gFh5vQ201ZQ3Ejlqoy48orCYMTWCUC0Iyb+PV2jUceTDq
         12T7QH3YbFRn+A9B8Xw/7ktl8sU2ZwiDc/4c5ikpW/ACjbAMdCkfAXUgHxeI6meWMa0C
         iiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WVYi5XJp4WaCaddQcy1HjEAG2je/Kk0d1P+LoVF1LU=;
        b=hmPw39MdBpqQKHQ3Pj1a414tSBimQqnW9S/YtgKiq57QWTl4CBaDNfY8R87b6MtBjE
         LpJGVXmLQ3GK1LItoUt8ovrBETIO/FMFq0REt4KZrdzgBXYrIpq6jW70mUm0X4PlyD0/
         4WISJ5sgD/E3w2vr1bR7vkRx5xXYXJv8oa3WYUwzxSUxPFRGsSqP+Xzzcvrd7wTIX13D
         UHM/xIi6JYwmGzQuPKzaEjhO9TGlLSV9nV0FrPUOaoxwfOzBM/wKPt91rftn2635xwyo
         aomzbvhh6WGnpzQvqiI2plu6wjQGdt8ZOIITmuwTD+xcNX8TM07nWVeqlciqgqU14CZK
         OOYg==
X-Gm-Message-State: ANhLgQ1WCfCB3C/fF7E6hKVn/pd6/ZU3swRFgeiYc4mWWWWyu7sWnjYL
        kd0ezRhKLW1eJeuuzXkxm6aT
X-Google-Smtp-Source: ADFU+vt3DTLu/I5B2gbgbMVEzZd8OJT3CGLsgKm677pDzpkf1N2Iny5qvULAmixEzxzWgEH+t3ThnA==
X-Received: by 2002:a63:a55d:: with SMTP id r29mr4326673pgu.248.1584966686708;
        Mon, 23 Mar 2020 05:31:26 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 144sm3590131pgd.29.2020.03.23.05.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:31:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/7] bus: mhi: core: Drop the references to mhi_dev in mhi_destroy_device()
Date:   Mon, 23 Mar 2020 18:00:59 +0530
Message-Id: <20200323123102.13992-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
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

