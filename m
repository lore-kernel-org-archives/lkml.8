Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852BD206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sd4ljwqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbgF3Nvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbgF3Nv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8DC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so20236143wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PcEwXK0xNmm8KLbdljUMIqWDcW1MZg3tkSRXZHPr9pQ=;
        b=sd4ljwqmp/zYlzEoyZu1xy0nSWXuHKG4YDJ8lnb8YsfDmzJwM0MYDZEmm+1XCWSUer
         kEcYOjz7nPz45b2R1EaJZoW1wAI9UIwneyJO56ceV1BdxO3seNPw/q3Yf0qJZ2sM+dXF
         Zr39Osy771y39P14DYzfnfHvyUTVYsS5B13UlvieqiYUEek39OqnSmcL9pS0C1N6PAx5
         ycM5xQ2Vp7wOT0V7xpt8oRAWeptXJLiTuEkBkKCsI/CZLRgrEUGZpIaUJNiMAB0pQVev
         pwLjI03jAZ0xVV8yfggMZ0IQCjTTutEPkZ4T5h2Ry/WRKyV8nLkk5Ua9TTJ81pphvVfo
         XNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcEwXK0xNmm8KLbdljUMIqWDcW1MZg3tkSRXZHPr9pQ=;
        b=Dxo+YmQZOKyHuRHO+yI5meZ+9Ky3tgriIzfYRB9sRQFZYtlxQoaO1DII73aOTrtD4N
         aOvPazWppf1EvAbzOV8CUzNmuOjdSwfuJQetP8CBfj0X4rqX56bw8FaZor2cSuxNIgH4
         Glqaae0y+/r1+urMzHM4GtfrAPRjxnKl+jkeV7XzKGfUe1K1LiqX4A6aKO6GzY6dOgw6
         1vjX/XJhNRa3YUVn/4wvRttqAhefjiG4eo3hFZ1XdlN1pazT0FWGDJriota/MxWl+RP6
         m5unp0VXFWdk7tOKF+6PvMsig+URFkhfeszX2m/xMGct+fo8R6orLgIW8NX1NcYaia7T
         Brkw==
X-Gm-Message-State: AOAM533Fm6OeX2t+cibd23swlaAQrPxi6SBuzNzxnGRt2kB/JDhuD6nt
        l4KKyDCk5IWr8B4nHUEcHo9xb+lqWMA=
X-Google-Smtp-Source: ABdhPJxZLNyr0uQ8NR+OdfFIu/76siTbfZmzTER0rduvkESdd8zMDl2QiaPTsICt2/mN/E+Xl8xGcg==
X-Received: by 2002:adf:c382:: with SMTP id p2mr21631803wrf.283.1593525086937;
        Tue, 30 Jun 2020 06:51:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 12/30] misc: mic: host: mic_x100: Add missing descriptions to kerneldoc headers
Date:   Tue, 30 Jun 2020 14:50:52 +0100
Message-Id: <20200630135110.2236389-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 warnings:

 drivers/misc/mic/host/mic_x100.c:127: warning: Function parameter or member 'doorbell' not described in 'mic_x100_send_sbox_intr'
 drivers/misc/mic/host/mic_x100.c:148: warning: Function parameter or member 'doorbell' not described in 'mic_x100_send_rdmasr_intr'
 drivers/misc/mic/host/mic_x100.c:511: warning: Function parameter or member 'dma_addr' not described in 'mic_x100_smpt_set'
 drivers/misc/mic/host/mic_x100.c:511: warning: Function parameter or member 'index' not described in 'mic_x100_smpt_set'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/host/mic_x100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/mic/host/mic_x100.c b/drivers/misc/mic/host/mic_x100.c
index 843ce13750158..f5536c1ad6071 100644
--- a/drivers/misc/mic/host/mic_x100.c
+++ b/drivers/misc/mic/host/mic_x100.c
@@ -121,6 +121,7 @@ static void mic_x100_disable_interrupts(struct mic_device *mdev)
 /**
  * mic_x100_send_sbox_intr - Send an MIC_X100_SBOX interrupt to MIC.
  * @mdev: pointer to mic_device instance
+ * @doorbell: doorbell number
  */
 static void mic_x100_send_sbox_intr(struct mic_device *mdev,
 				    int doorbell)
@@ -142,6 +143,7 @@ static void mic_x100_send_sbox_intr(struct mic_device *mdev,
 /**
  * mic_x100_send_rdmasr_intr - Send an RDMASR interrupt to MIC.
  * @mdev: pointer to mic_device instance
+ * @doorbell: doorbell number
  */
 static void mic_x100_send_rdmasr_intr(struct mic_device *mdev,
 				      int doorbell)
@@ -503,6 +505,8 @@ static u32 mic_x100_get_postcode(struct mic_device *mdev)
 /**
  * mic_x100_smpt_set - Update an SMPT entry with a DMA address.
  * @mdev: pointer to mic_device instance
+ * @dma_addr: DMA address to use
+ * @index: entry to write to
  *
  * RETURNS: none.
  */
-- 
2.25.1

