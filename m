Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29916208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="drHw+/cE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406004AbgE1Si0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:38:26 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57304 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405786AbgE1SiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:38:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49XxKH6tGRz9vpNP
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hh-TLH4RfBLC for <linux-kernel@vger.kernel.org>;
        Thu, 28 May 2020 13:38:11 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49XxKH5CqQz9vpP2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:38:11 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49XxKH5CqQz9vpP2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49XxKH5CqQz9vpP2
Received: by mail-il1-f198.google.com with SMTP id m7so55577ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c1TTnDVto3wkCZeSMQka6W/DEVeWf5sl9QQWLQgXN9k=;
        b=drHw+/cEwBVwGldaRHVnRcYHMf95jXEAagHcGST8WG3PdUnHW1OZewz7BMmxvxp1yM
         Z0GjkBUrfOsTgT2qlIAVhGJnWCVDcu8fCcQpQoidDCITqaPGR/++9h81+sxomz5OmWSs
         ht8U30P2CTMSiK/nwR9qcjh9fbnZCweqrOgTo4bwLQ/aG8J3Fx/M6zLXUy1XvC6TWGST
         GvTAjWKuX51Yndju7P1KyJyY3SHZCdcOuucCvCdnC5ujqYXVpizHwkoxFpXGsyNlMSww
         GK0EOCUIkua4jFO3v4tUENgH3Wk0kJv2L1Jyofk5chHTgESNo/UYB7qxcryS1PcRJZ51
         wiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1TTnDVto3wkCZeSMQka6W/DEVeWf5sl9QQWLQgXN9k=;
        b=efFOclE/cIqyNRugpN8+6wbEQF9QRdJ4FX9b+pGbIedoQQT3M/JFHBZuc6zWWtJ1FW
         qJjUkVLwdPAEl4SLvgjsXrnJ6/rtF8dF5tahikMsFr6bVZK2gQDOqZU7zLDSj5OrIfGA
         2KUNG4LyhGcS98Uc0I2nQral0JQDza3JMAX5jftIvBR5nDGQWofQSTiI9pz4IjqzstpV
         SgbWdQ3tPIDHgfkJINhJ44WWIDhseBbDIhvMjFC0QHgj6oTI05tYgjHQiAopEXGqKo5E
         hRq7x6ZeNh61PsQWfADKMtjuKPDAZ5fX7+ZJ9xTb4PSuvgmze1TGZFbe8a+mRFqOQkVM
         Xs0g==
X-Gm-Message-State: AOAM532i9iz3IS6aN87K1vDbVGqIrMVHRQmcplzRRgcn1/WvM3NqHo5h
        IS2Ijc4NTV3kTat5hfuZJcvkx6A3oslJvaX4muruT5Ii+3zqE2tNrsVmQGQKSylp9omPiC+CfSm
        8bCtJcsbwojm9zcp1tcvhs+74E2bF
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4148969ilj.264.1590691090659;
        Thu, 28 May 2020 11:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVPW9yLSepCvAllSlkGigtULfsb2Nh6cdvsTpPFGOt+J3pcMQEfAYp4Vvxp0BCM63yq1AvpA==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4148945ilj.264.1590691090336;
        Thu, 28 May 2020 11:38:10 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id i13sm3701456ill.65.2020.05.28.11.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:38:09 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Matt Fleming <matt.fleming@intel.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/esrt: Fix reference count leak in esre_create_sysfs_entry.
Date:   Thu, 28 May 2020 13:38:04 -0500
Message-Id: <20200528183804.4497-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 0bb549052d33 ("efi: Add esrt support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/efi/esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index e3d692696583..d5915272141f 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
 		rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
 					  "entry%d", entry_num);
 		if (rc) {
-			kfree(entry);
+			kobject_put(&entry->kobj);
 			return rc;
 		}
 	}
-- 
2.17.1

