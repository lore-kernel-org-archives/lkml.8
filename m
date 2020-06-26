Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F321C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46217208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD9Q+/Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgFZNFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8277C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so9434009wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnDd4j0ST145ZKeSSkw7lJ4M0WvMcY2dd1eGT6PhUvQ=;
        b=rD9Q+/MdYAlK7GwwCud9z4mDJYqfCSBtUUO+yQP8diYsyyOv3LrCBx8gMTRQJmNPqy
         8eR9J0ba/xpUahmzaB3rFvWZm+r/9s4zZcLfV9msgEtRMxiv+BiN7AEt1eaBt3husw5h
         vc/ojDmi7VtWGYsgj+z6R71ru2v8qyzUwKYVv824FY7h79tch/fa19ZIafKJGLK/uhMV
         FfdeN1CXMUHH0s4W392zQGtLK5rCmUbpYQwkcDSa33s4ZZpa6sGMQlV8CrK6lLgjGWa6
         W/S/88/kdyIbRCWOJmvCL/vLCa2ASIzlLwiO6+v3ERLgDPYKFUwnnEMPpVfwSQILNjjg
         USvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnDd4j0ST145ZKeSSkw7lJ4M0WvMcY2dd1eGT6PhUvQ=;
        b=QFKa/+FZoMwAM1xFFi98+Q1kIccKcE6SGQRdcpNPECZpi8Uhy8r8eZffKfXQVq9MSg
         2alfMpDDSS9D2Vg0ME6HRV2aRehpxx+rvKEAjKMil9TEw4jK9dA3sWLNHiHLU7n1WSw7
         nphlYfHpie0f6ATPrZ1f2BLhjWpfFuzbdjaginr9E/BmaiycxEDR+PClrD44XKjYqbzs
         2YdQoAotZOWqY9Z4i6PAibOzPFCpKV+HevGLN0AUYMgZoDOrA8Yk0I64vfYdysWBGp8K
         nUmt4kstX7f1tfciexC0QjWu4Dnj7UwaZN4WFFjXAzsMgUi9WOEsdkRO4yvX63KjdWL5
         iU4Q==
X-Gm-Message-State: AOAM533z8grCAzbE8mRWiq21OMVgGpHn+4Eo+3jCdIfm4Z6Q+W8JO9Tn
        1wlgYAlL/tpa+67XCiBVQzwaxA==
X-Google-Smtp-Source: ABdhPJxohCKHaCy7HdNTnlvnqVvGHqegU4a3Ml98qFUy57L2Z9oR2VLu0jP0cvvnWHbaMsEe+c3gTg==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr2686605wrv.314.1593176737524;
        Fri, 26 Jun 2020 06:05:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/10] misc: mic: vop: vop_main: Remove set but unused variable 'ret'
Date:   Fri, 26 Jun 2020 14:05:22 +0100
Message-Id: <20200626130525.389469-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasn't been checked since its conception 2 years ago.

Squashes W=1 warning:

 drivers/misc/mic/vop/vop_main.c: In function ‘_vop_scan_devices’:
 drivers/misc/mic/vop/vop_main.c:617:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 617 | int ret;
 | ^~~

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/vop/vop_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 85942f6717c57..4e63cb1360921 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -614,7 +614,6 @@ static void _vop_scan_devices(void __iomem *dp, struct vop_device *vpdev,
 	struct mic_device_desc __iomem *d;
 	struct mic_device_ctrl __iomem *dc;
 	struct device *dev;
-	int ret;
 
 	for (i = sizeof(struct mic_bootparam);
 			i < MIC_DP_SIZE; i += _vop_total_desc_size(d)) {
@@ -644,7 +643,7 @@ static void _vop_scan_devices(void __iomem *dp, struct vop_device *vpdev,
 					 &dc->config_change);
 			put_device(dev);
 			_vop_handle_config_change(d, i, vpdev);
-			ret = _vop_remove_device(d, i, vpdev);
+			_vop_remove_device(d, i, vpdev);
 			if (remove) {
 				iowrite8(0, &dc->config_change);
 				iowrite8(0, &dc->guest_ack);
-- 
2.25.1

