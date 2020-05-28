Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F974C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0912078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GgwTeWRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgE1Tok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:44:40 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58432 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgE1Toi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:44:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49Xynw5VKlz9vBss
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9QOv1jpIcJ5l for <linux-kernel@vger.kernel.org>;
        Thu, 28 May 2020 14:44:36 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49Xynw3qg2z9vYwf
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:44:36 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49Xynw3qg2z9vYwf
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49Xynw3qg2z9vYwf
Received: by mail-il1-f200.google.com with SMTP id p81so234939ill.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PfzknLmfX2Bjtf5+K+UAI2zCUlxWnyr31FaRztaH9EY=;
        b=GgwTeWRsrJf6uCZBd7WIQP/vQw66yUYSI/IfKQP4/Nqx0gXbfaqNYSjwaJghfc7Its
         VNBzs7Yf5oj4ZQ2zRIUDaSA3o/aMAKiiEH0Ftk9jT4icfOYKFSwzIT53RwVyh68zFnVc
         Hb7MNIURqQd4TN3LIVHG9F8/vpp2seM6ozkVM7NJ58FH0obdTcPT+eDpBHNRB1PU1rhd
         lH3hsuKfEkMkPSg3i3fzjyK56HNHWvQs3d3mTE0j4G84MGbMXRDr5kjHFx5JheVkhlzv
         Jrxp4+VzCS9X8bQi1AntSp4fIYAEiCFBgNISwYBDcW4ovqPffcIP5L28ZEjenIj1lpXV
         dNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PfzknLmfX2Bjtf5+K+UAI2zCUlxWnyr31FaRztaH9EY=;
        b=s1X0bEu8oEEzIh/oThefrNb9ZmAqlI1cwCyn2Hm7CqRHXJV46UK125J0BGcCpmOuhf
         BiJuIsFLQuGN/poLzUjGzW1p5lC6AnARnWuR3P42fFipX5VvweFvmlusQU62TnrVg7e6
         f7CDSIXXGvY218FelNsqng5pagiUoDTN0kKw+pBKd220lmJ8QPFtm7Y/4GHAUlEdlsyj
         B+6IhoR/NXFUbILstpSTab1umPaN9j0Dh51tpPsRMB9RqVYoPW5cxulRz7xyJUUEryu2
         RbHbX0pcskcHMouqFwOQUmzRCY2YxWKoTAD1MJiVmlUnRfasW3SJ9szZS9tth1zcBVM0
         NTIA==
X-Gm-Message-State: AOAM5333mmkN6a1hqfSxSUmgEilC8WmNWabFCpJLLwd1n7LplhFX8eJF
        eS53bbOM/5bFAmh20sgJKYiDJWSvlSCCyPMmYHqO5RXlhgTLSASbY7y97R3ZBQfh/wAQ8aXRIxA
        SNBTvsPZ5elsIDcsPp8xJJRP1bfO0
X-Received: by 2002:a6b:4413:: with SMTP id r19mr3702487ioa.162.1590695076080;
        Thu, 28 May 2020 12:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyzHOXdfF7fbsziLAX3p+sQwgpWqimkngVD+dlB/SgAXob/nxTRKphQmLbUKH8qsco8UxYGg==
X-Received: by 2002:a6b:4413:: with SMTP id r19mr3702460ioa.162.1590695075587;
        Thu, 28 May 2020 12:44:35 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id s66sm3096905ilb.25.2020.05.28.12.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:44:34 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@gmail.com>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omapfb: Fix reference count leak in display_init_sysfs.
Date:   Thu, 28 May 2020 14:44:23 -0500
Message-Id: <20200528194424.11596-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Because function omap_dss_put_device() doesn't handle dssdev->kobj,
thus we need insert kobject_put() to clean up the kobject,
when kobject_init_and_add() fails.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index 6dbe265b312d..51322ac7df07 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -316,6 +316,7 @@ int display_init_sysfs(struct platform_device *pdev)
 			&pdev->dev.kobj, "%s", dssdev->alias);
 		if (r) {
 			DSSERR("failed to create sysfs files\n");
+			kobject_put(&dssdev->kobj);
 			omap_dss_put_device(dssdev);
 			goto err;
 		}
-- 
2.17.1

