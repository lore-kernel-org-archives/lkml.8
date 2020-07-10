Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AAAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF26207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UYFps1qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJGpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgGJGph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:45:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24558C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 23:45:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so2125705pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJUQ2Pd7TJkImq79MbbmeRR4vOSl3IUThdPOJ2RuPkM=;
        b=UYFps1qc9r4yUJciGWoc6eYA8p17nl0cKxmW5fNy55sBoKDNEy6mttr1/iezNHu2Ys
         dSGM2vNXaEB60P3PSceO79MgqvVFSqlobE0EDna6S4jfOtTYszpaGxN02R2NLo08RF94
         PCoq8LXIptWbC/T89YXodZjGubAkTp1PapvIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJUQ2Pd7TJkImq79MbbmeRR4vOSl3IUThdPOJ2RuPkM=;
        b=j32AwgaD+CMerXM4KDCGRnZK7YTaipk/0NeJhuqkgStUHgSPv6zhhv1YIekgo2uswU
         D3JkSJ7Hs06dWZ8R57qQNouids2VIcmc/tVaGBRK+dgtFxQ/N+9wsCV+rS+pO7iD0BQw
         vAvvl8SLxp3N1kXzcYQbs+e55XmwRpGLlsD47rr5LpyHxUviOsLRNkeNLwZRJ+lEbw81
         KZoyAMWeSa9bMdQb1JGGFHtulvWn7ZUvrkOdAjHq7Ecl8AzjVQKYw/S83kzNmq4qVa+U
         gErX3ckhhPY06XAyCGLMwu13BAkbuiVWmIRhG68Ap+1IeVG+mQGAKDEWUJE8tSHboIAZ
         leUw==
X-Gm-Message-State: AOAM531rsES81K0hk+fLgQ3XfpDIM4oq8HSR9+2Z6Z07mkRuyNxpKlxt
        zgGTjpljB8VYl5BJd7J51zx7SQ==
X-Google-Smtp-Source: ABdhPJzM+mh9VDZS1ApjNT2oXZNIWcf2wPn7lRZ1OaFiAESlm/XJ5L+agLdQ2nCEk/plUCh78OX1oA==
X-Received: by 2002:a62:5bc5:: with SMTP id p188mr64279447pfb.56.1594363536634;
        Thu, 09 Jul 2020 23:45:36 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id e8sm4955029pfl.125.2020.07.09.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 23:45:36 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
Date:   Fri, 10 Jul 2020 14:45:29 +0800
Message-Id: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_printk should not be used in production code, replace it
call with pr_info.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
Sent this before as part of a series (whose 4th patch was a
change that allows to detect such trace_printk), but maybe it's
easier to get individual maintainer attention by splitting it.

 drivers/staging/media/atomisp/pci/hmm/hmm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index 42fef17798622f1..2bd39b4939f16d2 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -735,11 +735,11 @@ ia_css_ptr hmm_host_vaddr_to_hrt_vaddr(const void *ptr)
 
 void hmm_show_mem_stat(const char *func, const int line)
 {
-	trace_printk("tol_cnt=%d usr_size=%d res_size=%d res_cnt=%d sys_size=%d  dyc_thr=%d dyc_size=%d.\n",
-		     hmm_mem_stat.tol_cnt,
-		     hmm_mem_stat.usr_size, hmm_mem_stat.res_size,
-		     hmm_mem_stat.res_cnt, hmm_mem_stat.sys_size,
-		     hmm_mem_stat.dyc_thr, hmm_mem_stat.dyc_size);
+	pr_info("tol_cnt=%d usr_size=%d res_size=%d res_cnt=%d sys_size=%d  dyc_thr=%d dyc_size=%d.\n",
+		hmm_mem_stat.tol_cnt,
+		hmm_mem_stat.usr_size, hmm_mem_stat.res_size,
+		hmm_mem_stat.res_cnt, hmm_mem_stat.sys_size,
+		hmm_mem_stat.dyc_thr, hmm_mem_stat.dyc_size);
 }
 
 void hmm_init_mem_stat(int res_pgnr, int dyc_en, int dyc_pgnr)
-- 
2.27.0.383.g050319c2ae-goog

