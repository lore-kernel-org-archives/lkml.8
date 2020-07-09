Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067D7207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHzyKOxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGIRqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgGIRqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79265C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so3289509wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaCRoLNPh8rfOtJymwBCMA+9wwfzZ0YZT8hDB5cEPf8=;
        b=MHzyKOxtOXPmABYls8bZGdJ0/FFwgWKEjJZ2uNXDNi+1EhQXcbBGozwD1qdFSzqyHI
         lHQK2aOSSA5ysnbzPIGEPrfDdt2pLdpRiRPeXLudDa0ShJrmZ45aQ3Tn76aMKUtFPVVS
         7OPeyC+yoTPgPCvRt+9+oD1lWbV9xf2zuZT5Hj3VeCX/7G+N3iY23K+0kej9+5k4s2EW
         8qKVvOJ5yKAN1RB6D0wFoTHoIkEY14bC/uhokXf4t6GTkml0v6QzRDpvIGSOfWscP03H
         7rv0njww555uSJdnwzLb3XdBGLYsDN90x9vcFunzyMgSnCEAyTAB/uO88v/jgpb9qVc7
         9j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaCRoLNPh8rfOtJymwBCMA+9wwfzZ0YZT8hDB5cEPf8=;
        b=EPSti/5/rmgM1X0QZDZg7LPCYeLQaj7tpR1maiy4S4K9UBDpU/J/sFOfDxwQSoctKO
         QPiwiwjAC8JKug7aa2cqIkn3Yt/L64NCSdlKC+I/lVkk8vdmpoYlPMDGlWxQ6RL+jqib
         onDZQPXnjsc1sMT2sgaJ0CvzgdCeAie1DBBnqTLOWMeZum1U509cAf9FFjBdHSCxj61n
         kCK71ZQdwJG/J3SnwER8psXpUM21jnaD4WICocnU0fmTfkZehI5Lcy8tKfpo+B9dp3Pn
         VPEwxsnjJJNtOPLbI8paz1E89Qwq0XzVfOVCo+rL9XLpetPZE1Iqovq+5RomnLjYcWeY
         GuKw==
X-Gm-Message-State: AOAM531hGi928L2R3+mlOQaFvGusYNAGjgTXxJpLVCOPDz6B2CDkn9c+
        tLoi/RZojbgz+xJvW5gBl7ywVQ==
X-Google-Smtp-Source: ABdhPJy6LrvDQt95ybGxKacGSLi0IIOHk0vIsv/MO6uk/lJXy+lh7TszUuzy+QhVyyiBwD7oAgk4IQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr63120313wrx.26.1594316783189;
        Thu, 09 Jul 2020 10:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 21/24] scsi: aic7xxx: aic79xx_osm: Remove unused variable 'ahd'
Date:   Thu,  9 Jul 2020 18:45:53 +0100
Message-Id: <20200709174556.7651-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasn't been used since 2005.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_linux_slave_configure’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:703:20: warning: variable ‘ahd’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index dc4fe334efd01..9235b6283c0b3 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -700,9 +700,6 @@ ahd_linux_slave_alloc(struct scsi_device *sdev)
 static int
 ahd_linux_slave_configure(struct scsi_device *sdev)
 {
-	struct	ahd_softc *ahd;
-
-	ahd = *((struct ahd_softc **)sdev->host->hostdata);
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
 
-- 
2.25.1

