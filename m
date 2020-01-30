Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B2C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5E206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXCgN/GZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgA3KLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:11:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33410 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:11:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so1264881pfn.0;
        Thu, 30 Jan 2020 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PBKaHNbZPQSw/6pq7aba6IKrrBLpWG1Rl96OfumKs0=;
        b=EXCgN/GZcpZR8poY0LxdVM2/AuJlaC6csMBBu+fX6wHHTn0AhRPoa301cUn7AGRMMh
         +CJSBjmNDacLRQi9qNt5W5xkUhYjaEAJ/vOQfCJoBgS1PQzV3hCr7F0NmnLfA5mDLZ0G
         LeP00up7ZlMjU+4MjawxQI4aEh0DeKFYfFagfLU9ApBiaSG6gIXPSfG4xtLqlerVW1HA
         QVAJhI2IblCdCnMu1RNtk2cFPISH+S54iAO4JG6+2JelFHPTU5jcxLUHc/yQHKhU4kHr
         9ylERID5tt+O8ZyQCj3nhBu8uh6SezhQ4pBXuLjag6sREAL/4zCK3w0K7mHopLlj4pWB
         +wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PBKaHNbZPQSw/6pq7aba6IKrrBLpWG1Rl96OfumKs0=;
        b=UdTWNSEVTL2EVZwVJkPq4Iso5qhduJELeBkuIHOJ4XWinzVKc/XcllYE+Tch8Zwl+9
         +JmDIjtcNizXU10O5aJyhgopn4i6NGvGLhdjlYsj940NMQgA4tPWlbwAoaeFWzitgKZo
         Rb6ByOOq+qC4V1iexQJ/IOW8BFLDiwtopxxXISeaVIidA8qtRot/J6KYBJdaaTB7hwRz
         Nhxp0thGsj0QWKzg+QDt1C88E7tLipK0vIlHD1PNGsYG6BdYvooGf5R/2ARx2WSKKDNn
         b4GEdhcp1xqDyepfFvBYfYdFhg2kQs/606Kv7+t5UHhcOIaFKIIyJnK55UhVNotssBmD
         C4kQ==
X-Gm-Message-State: APjAAAX1BIJpeCzpEQTYM9llQPPkC51YWa0jpUiOFgc47dttdOsTmRQz
        In4fUTrsbjWrLjPadU4U/TA=
X-Google-Smtp-Source: APXvYqzN9Et5YzVy6Vg3CItCuYZGt3G1cnM8Z+1QndaFnBbyD1nf8jIGfvN2GF27lVmKUHKgxv+unA==
X-Received: by 2002:a62:1c95:: with SMTP id c143mr4092880pfc.219.1580379106512;
        Thu, 30 Jan 2020 02:11:46 -0800 (PST)
Received: from localhost.localdomain ([2405:204:848d:d4b5:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id k21sm6239683pfa.63.2020.01.30.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:11:45 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 1/2] staging: exfat: Remove unused struct 'part_info_t'
Date:   Thu, 30 Jan 2020 15:41:17 +0530
Message-Id: <20200130101118.15936-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130101118.15936-1-pragat.pandya@gmail.com>
References: <20200130101118.15936-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove global declaration of unused struct "part_info_t".
Structure "part_info_t" is defined in exfat.h and not referenced in any
other file.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 51c665a924b7..b29e2f5154ee 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -231,11 +231,6 @@ struct date_time_t {
 	u16      MilliSecond;
 };
 
-struct part_info_t {
-	u32      Offset;    /* start sector number of the partition */
-	u32      Size;      /* in sectors */
-};
-
 struct dev_info_t {
 	u32      SecSize;    /* sector size in bytes */
 	u32      DevSize;    /* block device size in sectors */
-- 
2.17.1

