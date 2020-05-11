Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCCC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6578A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUAuKlVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgEKLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729563AbgEKLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y16so3316861wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=vvpjcDEwFZ+gJRXyrqzCqXoLGtqfNWB0kYqf8KIErV4=;
        b=ZUAuKlVE9Ri6ufrjyakVsQqh1OedUQs123AJNtufx/GGYIq/JCtaECSm51X2ofBy4y
         oJXJ5tVLmOn23G/04s45tDjHR60jnV9sPNheWsc98dIuGW2TxsUgIsf+cusIfJPk+NdF
         5LaLXQyOSDeO+t1NJ8BsgR420jKLdDOLXulxYg3qS2xUoWWEclDAD+VY73yRFt2g/EFz
         VQRM5EKGci97N92Q6PM5tymBuQSPjYeRaoYy3lb1KImUmHfn+IXD44SP/iJ01pqcxKUF
         zSwCMLwoH15UQ4Z44bEHOR6mG7iiFw4pSv8nh8euwwdRTf/Qw4edG40uDt63819vXzJZ
         sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=vvpjcDEwFZ+gJRXyrqzCqXoLGtqfNWB0kYqf8KIErV4=;
        b=YYb4lzkuvBEYvi4HlywuVMM6Rh4wzpG95zxcdaEB8jDoS60Oc10BHRATX2x5nnU8WI
         zgh6ihNnaoWaOZPjdT6V5OzD3v11po8SMrKqT8uo1brnLQpFQCXsXEwyUbEHIm83QbhO
         kIyB3nVjJXMXXqTKsLLECUydIiLDVXMh4A/+B3ZOI1U8JHEv74pm9FDu8Hb1RrGiYYiL
         UfTomzYgTA32WCgGcePIVzd46HgI09BQIsRjoDi/v7P5zSQXCM7VQG4D+hRWxf3ErAxZ
         re+SRu+88Fin3oiiqql39SnrWtKgS3uGNFTmuOvG1lSj/y9bshqSaMT65t0/hxJX6fbF
         LwqA==
X-Gm-Message-State: AGi0Puarl6lv0Cqo/8gAhiK2xUmbFx6mIhBYiJeSEAHHAY7UpXXhPN9J
        W8014aQtSWEIAzsMFesSeHP7U+51
X-Google-Smtp-Source: APiQypLFg1Toc7tWR9ld5xElbUYrfhhyXU0Ie/JMXJazSO4POZn7vp0/YXtgnepj/4uNbTF4mdXqGw==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr18328213wrn.297.1589196759551;
        Mon, 11 May 2020 04:32:39 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:38 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 02/11] habanalabs: set PM profile to auto only for goya
Date:   Mon, 11 May 2020 14:32:23 +0300
Message-Id: <20200511113232.5771-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Gaudi, the driver doesn't change the PM profile automatically due to
device-controlled PM capabilities. Therefore, set the PM profile to auto
only for Goya so the driver's code to automatically change the profile
won't run on Gaudi.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index e478a191e5f5..36f4f68c8cef 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -410,7 +410,10 @@ int hl_sysfs_init(struct hl_device *hdev)
 {
 	int rc;
 
-	hdev->pm_mng_profile = PM_AUTO;
+	if (hdev->asic_type == ASIC_GOYA)
+		hdev->pm_mng_profile = PM_AUTO;
+	else
+		hdev->pm_mng_profile = PM_MANUAL;
 	hdev->max_power = hdev->asic_prop.max_power_default;
 
 	hdev->asic_funcs->add_device_attr(hdev, &hl_dev_clks_attr_group);
-- 
2.17.1

