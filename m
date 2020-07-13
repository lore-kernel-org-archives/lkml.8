Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F3C43446
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901A72072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt6jQe7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgGMHsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgGMHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77971C08C5DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so14682778wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sy/K8f8HsXXHV/Uh8PtUz+jEUwEZnfQCudyYCgnVPrY=;
        b=kt6jQe7UWHbiVRqqHAaPcHsfaVUEXSIAcl/9X9mskmqMpLpuREDcN7aUNNwfe7SHm4
         G5Vi3tz3xcp2BtKvJ4qP5zBWiKA17OHpjW1AnQISAYP+lbm0isTG48B4QqG3RNz9bDsW
         ZXpKQkU9qVkOQRqTppnAx+oa+jj/Djxk9+LbNn0pb6Q7Ia47s7JRMV8CIpEDn6UyL45R
         +vJZ5hgQlbbw2TTVWL0fdg9FojpzLGyY0J5LrgyU4TRhACyrGjMHERkR3T/3s4xDICCK
         PLmfvl+a9vHtgJX+16ASFKwI9Eaa6zFMQ2zOtQIffq+/Yh7EUqu3xQUgQzlvccHx9EIj
         ccxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sy/K8f8HsXXHV/Uh8PtUz+jEUwEZnfQCudyYCgnVPrY=;
        b=SDr/+mfZyhWhtwHiStOqoVepFJFtcvAlmy2pPtjEE0P3ia8d1xust4BpbNRIaxVfB5
         pvRcFQ7GH4IJ+1DIXHDtMrL9nrpry7x7a0D3cO2dtAFldwPwznVvBD16LJv/9phxQG/3
         oQNlgApv6oljlebR+CyAGscjVb58yciZUsb+SFcWmkWC1i3CHU+kMzabuwT5r7rHf50W
         02zny4Oa55DM1dV8EsJrNKeEkwGVWHjbfN9wetwEfPfqSlNHPgeToHIyTQoEpX7UY31B
         N5C1Fl10nRIM4pEnOKUB8RAsfnHvb1i9jeDgv+p+TAJEzSoqf+Wv5WVpn8ILK3mA3q+b
         W5/w==
X-Gm-Message-State: AOAM532QqjT2QFvHQtJxUKETWAaJJAhKmvdWxMzbyS5QpC5xOy//L13u
        TFh+dfetpEBDm214LLdhCXH9vA==
X-Google-Smtp-Source: ABdhPJwFTSTf7Ywa1zYhk/JfUL8jHuWt4NWPQfjanjCq/oXBWN4ntrKoRwxHXCLGoDLZofOuTo1gow==
X-Received: by 2002:adf:9286:: with SMTP id 6mr78950566wrn.361.1594626428201;
        Mon, 13 Jul 2020 00:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>,
        "Daniel M. Eischen" <deischen@iworks.InterWorks.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH v2 19/29] scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'ahc'
Date:   Mon, 13 Jul 2020 08:46:35 +0100
Message-Id: <20200713074645.126138-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though 'ahc' hasn't been used since 2005.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic7xxx_osm.c: In function ‘ahc_linux_slave_configure’:
 drivers/scsi/aic7xxx/aic7xxx_osm.c:674:20: warning: variable ‘ahc’ set but not used [-Wunused-but-set-variable]
 674 | struct ahc_softc *ahc;
 | ^~~

Cc: Hannes Reinecke <hare@suse.com>
Cc: "Daniel M. Eischen" <deischen@iworks.InterWorks.org>
Cc: Doug Ledford <dledford@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 32bfe20d79cc1..cc4c7b1781466 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -666,10 +666,6 @@ ahc_linux_slave_alloc(struct scsi_device *sdev)
 static int
 ahc_linux_slave_configure(struct scsi_device *sdev)
 {
-	struct	ahc_softc *ahc;
-
-	ahc = *((struct ahc_softc **)sdev->host->hostdata);
-
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
 
-- 
2.25.1

