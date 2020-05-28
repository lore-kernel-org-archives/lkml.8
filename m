Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51939C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CBB2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gzewTqIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgE1Ckq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:40:46 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36932 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Ckp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:40:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XX4X4ywWz9vKZG
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1B8TlDUZRc1B for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 21:40:44 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XX4X3H9kz9vKZ7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:40:44 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XX4X3H9kz9vKZ7
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XX4X3H9kz9vKZ7
Received: by mail-io1-f70.google.com with SMTP id n123so2622023iod.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ybVEX7PSlMurjHo6h6uiVHqa++JM7m3HwUct2YUWqzM=;
        b=gzewTqIVazU1WNimvBAOHsLzFc0bwR6EBq5xTei1B+uAPHqyQ+nIEF/YSGY2JryaP+
         Lt6o5dL9xAZ1b2yla2W5ztcHf4m/lD4CKyZZr5DXSO50A3kvXjTOMnfLWC8QeL0vPeym
         AMl6L3zqkLKRLmQ6ZrwEZuI2OtgWkHN00ra2QRF/h+cnFofLeGZt3kxRisTms7qbi2UT
         CYdQanA1MyQ6aWSPP5orgCr8GWhWhEsejiQFErQBHfiJzJAWzk46huyex0iZWbkYk3Zo
         QglLBRQqHw8HJGt+/YQYlOe/9tWPwvlI/B/D5Kw/ufxGdVZmAzYoQjW7MlCD5hXm3KFq
         rZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ybVEX7PSlMurjHo6h6uiVHqa++JM7m3HwUct2YUWqzM=;
        b=lR8Rrjfr2zJYu1fM48mseLRvjYPj3n4jOh9NApvKKE6tm3CMeEZ0IAgWbRvDPZvhlo
         XVqln4yiemMTGUNlbQxCLUHyTcF4PiG4ZBAgZQjcDM5hSPbGWmv8u3Gow4pMYcKorLa6
         KXzbXwKUqV7GAM4BobTVU1DYdnMTMdiM1Up1IyvIqpYva36YR2LbxSdemdoLYvC/ddOJ
         WvRuuLnMmG/rxZ6ZFbiPCQH/v25Kq5B+mJwQwDY2ezHqqHn54Zt0GA/CrYNDTe88Va3l
         fB1LmoknCqD2adKufUpfSKannvUMfvVExopYyVa303uTRRcHuV0BZxj79TWnos3mDocj
         YHVg==
X-Gm-Message-State: AOAM532PyXb+LQ6Z1fVDx41UK/vQRlAb8vp3n9H1OWZNpfK4gA+q4nLY
        c6LxtUOKHCmkabCBUg97X5NtW8npDqdqdYkktkwdWuAsfKH1kq7yPesG8lH4lZ2LKopnan5uSKj
        UQ+4oT4JwEMcyMk2QvgYHn6aTBccA
X-Received: by 2002:a92:d88c:: with SMTP id e12mr1109345iln.197.1590633643990;
        Wed, 27 May 2020 19:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY40R37MXlyClg6t19b+U+/ZakWhvOYEAiamlxkpTsbI/OPuZaKCgHJmDVcbcLC7/lG/Y6Ag==
X-Received: by 2002:a92:d88c:: with SMTP id e12mr1109332iln.197.1590633643669;
        Wed, 27 May 2020 19:40:43 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id n17sm2119172ili.1.2020.05.27.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:40:42 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/qib: Fix several reference count leak qib_create_port_files
Date:   Wed, 27 May 2020 21:40:36 -0500
Message-Id: <20200528024037.6611-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. To fix these
issues, we correct the jump targets when the calls of
kobject_init_and_add() fail, to make sure they can be handled by
kobject_put(). Previous commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 568b21eb6ea1..017ed82070f9 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -760,7 +760,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping linkcontrol sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail;
+		goto bail_link;
 	}
 	kobject_uevent(&ppd->pport_kobj, KOBJ_ADD);
 
@@ -770,7 +770,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping sl2vl sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail_link;
+		goto bail_sl;
 	}
 	kobject_uevent(&ppd->sl2vl_kobj, KOBJ_ADD);
 
@@ -780,7 +780,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 			"Skipping diag_counters sysfs info, (err %d) port %u\n",
 			ret, port_num);
-		goto bail_sl;
+		goto bail_diagc;
 	}
 	kobject_uevent(&ppd->diagc_kobj, KOBJ_ADD);
 
@@ -793,7 +793,7 @@ int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 		qib_dev_err(dd,
 		 "Skipping Congestion Control sysfs info, (err %d) port %u\n",
 		 ret, port_num);
-		goto bail_diagc;
+		goto bail_cc;
 	}
 
 	kobject_uevent(&ppd->pport_cc_kobj, KOBJ_ADD);
-- 
2.17.1

