Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA24C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAF6207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 03:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HYBVSsZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgEXDqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 23:46:25 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51290 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgEXDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 23:46:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49V5k760prz9vYVK
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9AAoe_F6bJ8r for <linux-kernel@vger.kernel.org>;
        Sat, 23 May 2020 22:46:23 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49V5k74RYgz9vYVh
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 22:46:23 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49V5k74RYgz9vYVh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49V5k74RYgz9vYVh
Received: by mail-il1-f200.google.com with SMTP id f65so12310643ilh.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2t9s0DwevmWJTHcbCKM1B0BY0FZ9/xbKiwLnDDABmQ=;
        b=HYBVSsZzTUiOAKEBXh4AEyJQML8TgLiJb9gqAWCrDSXfFtOW/q43Mtbi5IjQ14Pk/i
         L4T+ww0XRpfoU/gY+WudDS4BftM8K0WMe/0krvj+yu8cumuFDl5b9GhvvY2F6Q/jc7zu
         BImcpoPVI4MH64fOmcq+L1gyWY3u2qjcAB6JPMw7vfQ4rAd03gkonh919/0DUhcWBHPU
         ot1d711bIuAeEydfN6XWj6hzbuGSqtTx/nm8N71kvYmryyLkZYPEakoBKS1AgYo5BnDS
         MtDF2QRLJGav9t3JiMleQ2vQ6FZmh4FJoY3+lPheGKDybUudeWHeVYOd5L/9K4+q73Zl
         mvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2t9s0DwevmWJTHcbCKM1B0BY0FZ9/xbKiwLnDDABmQ=;
        b=sfy4Gvr9EyyFwjvllRLNmkxeZPfGxq0Ny4QMeM4+nnvt6+O8kFBWcs3xePjfbTuc4d
         ToqyqrUgMkI8omKdHOQ2xJ/6BhKEwdr1o2XtRyKktXCQBK92J9IvutJHHnFFMqLp6DDx
         iaLxFUYG5yta2uzXnAiQO7DLjMOOxBs28UvTGwZK0fAtUs9KdyAOPNL3WYd+nVCMxb+Z
         DexzMc+wroCD5d6hMFQ+EdEU89Hikwn3sRtZx9qOd0xZa6Sr+niUGn7sES17MpPq9f+x
         a4J8sgVUki9+uVHv4tKTNgHSWnmiffqKUGBtAiqOa47a94L7pZBJ4xO9XoK4cRu0n+kO
         1/Nw==
X-Gm-Message-State: AOAM531fq+R4qHa3sPyLFCuU16hFgpqv0ANXlQ/mbrlmoexmyThWUmba
        s6eHJ/CoDEv1Auw5OZ5+aXJX7dtJUWrBVKe/kh28Y9xe8Vf0c8dCzft83Q7LwMv6Rtz3q2XFveN
        xPNlFAIQBD3exjCe3bcot3aLypkk3
X-Received: by 2002:a05:6e02:686:: with SMTP id o6mr19039607ils.280.1590291983126;
        Sat, 23 May 2020 20:46:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfyg+Rnu6GlHWCG/+kmbS/tsUTytjIAPq63m/9v6dt18hUHnlXMuVCjoAfpRscXHhLXbpoZw==
X-Received: by 2002:a05:6e02:686:: with SMTP id o6mr19039595ils.280.1590291982781;
        Sat, 23 May 2020 20:46:22 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id j14sm5752392ioj.26.2020.05.23.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 20:46:21 -0700 (PDT)
From:   wu000273@umn.edu
To:     sylvester.nawrocki@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH V2] media: s3c-camif: fix missing disable in tegra_adma_probe().
Date:   Sat, 23 May 2020 22:46:16 -0500
Message-Id: <20200524034616.31625-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

"pm_runtime_enable()" was not handled by "pm_runtime_disable()"
after a call of the function “pm_runtime_get_sync()” failed.
Thus move the jump target “err_pm” before calling function 
"calling pm_runtime_disable()".

Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---

V2: improving commit messages.

---
 drivers/media/platform/s3c-camif/camif-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index c6fbcd7036d6..12ee49638f44 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -500,8 +500,8 @@ static int s3c_camif_probe(struct platform_device *pdev)
 	camif_unregister_media_entities(camif);
 err_alloc:
 	pm_runtime_put(dev);
-	pm_runtime_disable(dev);
 err_pm:
+	pm_runtime_disable(dev);
 	camif_clk_put(camif);
 err_clk:
 	s3c_camif_unregister_subdev(camif);
-- 
2.17.1

