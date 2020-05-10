Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5ECC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E34208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyIHXFLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEJQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEJQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E9C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so16331561wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSgv1QfgHBl9OVDnkQxlixfpsorIFLdZ30raefsXV+Y=;
        b=XyIHXFLdPmo8XDR2EbD3f4LZKJvpR5nEjFLo2fHm7OiGnG1ZLTm7Y0Oqst5lSmU0QS
         /y7AqDLRzclVlEMWXeq0rjRPYYkoOo7zwaS+KEkf6uXXNZINFC/4iPQhjuo2BnMETZzE
         wSYI/AcnCrIDVX0B7UbmAFsZXGSIsk81fU6g++gjF0nWQnqsCb5ydFeApKAzvuC0FeXx
         N+NL+tZ0IgmH1OvNDxVj1EOQhq3VpgJsJtAY+mgxn97HB2ZXVdl+eGZeBQyDurOC+x63
         SbyHVZN1A7Daz0F5JS1Vi6kJ8PbJW8mqh7aZ3s80bL5i9DjpNvzRKN0f6IEBH0yADLiQ
         P8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSgv1QfgHBl9OVDnkQxlixfpsorIFLdZ30raefsXV+Y=;
        b=Oo6nsvfK5fPbsT/6SCRG1YyWe0/8jo7zXyjzjDTWLJXfZsTX8pOEchJ40KUFclS10f
         RBJFg60IYcn/6zLVpeKuOFJw6iuHk85/qg8eBDkEW3nmwSY42C5q+ng5LXOUmczt4f3g
         2g/68Q453hzMGyCb8yOkfOTPC8MRGTeLqgPAAzadZG9Gd14qAQDw2Q6fmr1pCtltrjRP
         f03GKthbplc6gjBB7ci9Eq1JEHmmiQip0dSCwbQ0t6+j4ZAbH7rEf/EzKS9SEzRak9OT
         40BaDIG5V/xfGhM1ABE5Q8CyacVgUBDBKaPgE81jhHE2sEtWzRQcYYlkqacctA7aaVQb
         iuew==
X-Gm-Message-State: AGi0PubHHlmxh8BHsHNTAnP3zfy6J0SKjTpdUyGuPc7HCgjWhfBjFjsQ
        PVcuPmmfpHvXl/RcGuXsjzY=
X-Google-Smtp-Source: APiQypIWZQXaykOe/sU/+MafA9q+T0VrOldhVw/hxI89FHnJ1WJoeR0FXFCU0WtQj9v6kb2KkDqi7w==
X-Received: by 2002:a05:600c:3cd:: with SMTP id z13mr7798860wmd.159.1589129745048;
        Sun, 10 May 2020 09:55:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 03/15] drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
Date:   Sun, 10 May 2020 18:55:26 +0200
Message-Id: <20200510165538.19720-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use devfreq variable that will be lock with spinlock in future
patches. We should either introduce a function to access this one
but as devfreq is optional let's just remove it.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7914b1570841..63e32a9f2749 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -581,10 +581,6 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
-	/* Check whether the hardware is idle */
-	if (atomic_read(&pfdev->devfreq.busy_count))
-		return false;
-
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* If there are any jobs in the HW queue, we're not idle */
 		if (atomic_read(&js->queue[i].sched.hw_rq_count))
-- 
2.20.1

