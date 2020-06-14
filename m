Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6071B20789
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fneoPuxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFNC4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:56:15 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58122 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgFNC4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:56:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kzcX6HxZz9vCCQ
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xc68N0bDF6tJ for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:56:12 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kzcX4W8Tz9vC9W
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:56:12 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kzcX4W8Tz9vC9W
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kzcX4W8Tz9vC9W
Received: by mail-io1-f71.google.com with SMTP id m11so8950280ioj.14
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sfUbtD+8UmbRScetzBNuWx8h71Z2ueqfA2qMCF+mkCI=;
        b=fneoPuxjbgjZ20tPjhKit5n/XkQZsnTeVuP6LXEZhSCquYV74bLpfB86eYpxiqKl1H
         +bGm2eixLjW8kIj/1StBc/qKKa0B08abqZIUobkVEHl3vw0MYz/pxs7Nz8eICXmHDUUL
         WzTlZnL5OQ+YEJ+CqZ6JgAkc8Mhux56zzUVAsLzLWE6INlUyXlFaRYOXUXjYsjxFRRKn
         cXlbK+lcdMRTHOih7Qellu48K1ZaeOJbRWBeMXjKM10ChGYcJQ2jsCRfw0p2ztkfz6lj
         yhrZ4XH2jabr2SK7PdRjAz1FpKkh47t00lln3p1UYGeETuRiMr8MSwhx+IPsuIaZh6q5
         vv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfUbtD+8UmbRScetzBNuWx8h71Z2ueqfA2qMCF+mkCI=;
        b=QOtUzoH+0DFSt7jByV6etNqHwJkFdWvypwgaD4Gaxwr3jico0d40siTHtpBiSHE0th
         QwtB11xfH1/tAvy817KF15HO8IE/1+0M7DBq7cthvztY9W6kzVl83FSkR3PD3aQT4YBG
         YxtyGtp1JvQAc7WKbNL+4tIocbeR/eLDeVvWvmmR+ikDaPgT42E+uIGzotdhaVzjWs/k
         JcB4ZoNdXA971TQpaow/GzZuD5xK8Sqt1Fdduilh4fqDOEPBAZ9KYLB/TQRJKLYEikgE
         Xgz+RxZ+76O/xkEu7cUrmkkLYKy2su9V93sMmF5BHbMKJ5rXdkLN9XwA8Nh+rJfYx01i
         j4fQ==
X-Gm-Message-State: AOAM530g9iwRox7p4cd+A47IRBgbQurD+599j3PbmhoDW3CXc0Hcy3K/
        ubskuZ40LdSgoM89lY1ZKnH3IF4pxqDjCV8XAd/O3TTokVPN1/XzTrl+mIGBsqF6iNdY5vh4S5i
        PQtfUVURhe92a+VDOwbKGUgVkQDml
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr20318750ilq.51.1592103372127;
        Sat, 13 Jun 2020 19:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT40lgbxZYXXfJLRdJt0H2oqsZMfaaWEzQECLPWBqB3tSO1dB9XwzkOS3idy+ANAfqNQG7Uw==
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr20318737ilq.51.1592103371890;
        Sat, 13 Jun 2020 19:56:11 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id l16sm5565374ilm.58.2020.06.13.19.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:56:10 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Archit Taneja <archit@ti.com>,
        Kamil Debski <k.debski@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ti-vpe: Fix a missing check and reference count leak
Date:   Sat, 13 Jun 2020 21:56:05 -0500
Message-Id: <20200614025605.27728-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
And also, when the call of function vpe_runtime_get() failed,
we won't call vpe_runtime_put().
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails
inside vpe_runtime_get().

Fixes: 4571912743ac ("[media] v4l: ti-vpe: Add VPE mem to mem driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index cff2fcd6d812..82d3ee45e2e9 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -2475,6 +2475,8 @@ static int vpe_runtime_get(struct platform_device *pdev)
 
 	r = pm_runtime_get_sync(&pdev->dev);
 	WARN_ON(r < 0);
+	if (r)
+		pm_runtime_put_noidle(&pdev->dev);
 	return r < 0 ? r : 0;
 }
 
-- 
2.17.1

