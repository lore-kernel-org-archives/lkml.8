Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5042075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OVZd9pGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgE0VAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:00:31 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38366 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgE0VAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:00:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XNWw63vMz9vY6C
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OfCF3PQ-F0w1 for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 16:00:28 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XNWw4Wd7z9vY6f
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 16:00:28 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XNWw4Wd7z9vY6f
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XNWw4Wd7z9vY6f
Received: by mail-io1-f70.google.com with SMTP id j23so10044021iok.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HUfddYaBDcQ1QFr6cz0pOekNbdRK7nMNiK7RoAnFctQ=;
        b=OVZd9pGw7a7FtLUoDlyqoKQRPkb4QEIFCuj9r1b3w32QVRGgZFh5etltRHQZ9pckuj
         bQ8XwVKasUGKFmtLOa0tmIFQj/vQ6EztlbZr5XDxCAxp74DMxkZN9zeoRRzxdPQayYTz
         fHHoVYAyb9ontJDCSfHtt0JmjCGSPQdphgwSBghRZUuFVPlyisvqdtRz+zLI+63AqeMw
         Sc35eiWj2Je/MM75T6xXotPeaOXTATxORSfeZhWbjJeucB/KEmNXe5KFMwQJbRLpNsJq
         h/w5K2WBpVsGz1RprHf5gfMDOL/gxJWuBV/1U+tFQ0lUslgGWYBe88rajbMw6IDu4vrp
         DWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HUfddYaBDcQ1QFr6cz0pOekNbdRK7nMNiK7RoAnFctQ=;
        b=R5LuKB8vfD8QW+6kgUXTcgdnyzMehOwhGhJZz3QF35XYzHe2muwJQf7vEiib2d8466
         VRGMZC9RdWswjfkRoam1j1jwnfIHsRw8PQBzOu49GINhF9WGy6XZ2xHOo1EIo9pv/eaH
         IsE70FFpNo3osN2Ok7Uqy6J4Hf8WKVfnqHu3fQciJ/zJP5tik1H4nhNl4xNWpH5IjtaM
         yo4vT16oehdx0rmLmuvjaiO7fmGOh5uvIYX88XXHUZMd4bZkxT3wir1iLWLC1H4q6rS5
         3RndfpqYKRgcxDwaWuqREIiD4oMNtEjgCH1Lq4g3nrnJSK9p19IcOCdALJfZIiV9AQGg
         NZZQ==
X-Gm-Message-State: AOAM5311OBmJbo0Hj2wKW9rg4U8Y56EdtZ4ewqvmhfx6YCyI8mbqED2v
        NlqSFUEAv5QuBWq2MdcylQ2aMA0+L6gC/eGkDwkL9STz6uNjBIVpHBdC8OACdAjAIsOWc7MwKvf
        75II7jwTtKpg9ABcwjtMnjrJrUD40
X-Received: by 2002:a5d:9a87:: with SMTP id c7mr10986364iom.152.1590613227947;
        Wed, 27 May 2020 14:00:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYzzsZr67+NLlaukFPS7WCxvFJ71Vx5yVwL4woKj59hxFx7OukcGbcZtO43XVWAP+Pn1Z8wQ==
X-Received: by 2002:a5d:9a87:: with SMTP id c7mr10986340iom.152.1590613227572;
        Wed, 27 May 2020 14:00:27 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id o18sm2078369ils.30.2020.05.27.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:00:26 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Joerg Roedel <joro@8bytes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Fix reference count leak in iommu_group_alloc.
Date:   Wed, 27 May 2020 16:00:19 -0500
Message-Id: <20200527210020.6522-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1faa08c8bbb4..03d6a26687bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,7 +510,7 @@ struct iommu_group *iommu_group_alloc(void)
 				   NULL, "%d", group->id);
 	if (ret) {
 		ida_simple_remove(&iommu_group_ida, group->id);
-		kfree(group);
+		kobject_put(&group->kobj);
 		return ERR_PTR(ret);
 	}
 
-- 
2.17.1

