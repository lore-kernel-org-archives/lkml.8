Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB95C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FCF20888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e7NOJWPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgFROpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgFROoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11827C0617BD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so2521705plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=SizPTgUtV3iXJFQF9neCUoo2HH9dTA+Tsyik+Qs6Rtw=;
        b=e7NOJWPgpDilY8hAgu/E3UR0koeaR+7iSH91nRdwNwiag9SfhIjXt+DofFu1kfxmld
         sonG2ndDZmPtvlzTnmdVx6QC5xI0mKU+4Aw8UB4nmkxFWzScSGoM7yga5MuFL/2PZJnh
         Pi2uLHZ7iG/+7QjsmbzNkUTAyheEYTR5mB2REZBiiFdN8gvdYfMgHGneVhhGnbnz7xqE
         NBqAPOV/8kOoplTYc3iFVcW/Ztt8ElL2AgGcFfzG4+02vqZh/PMroO9cQupkyyW6unos
         0oclD5apnWHqq9iEooOIUY0aKLpEh6E4q1f5yO/zY9SvBTrL+8900x9yRlsIPiwznjZd
         LoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=SizPTgUtV3iXJFQF9neCUoo2HH9dTA+Tsyik+Qs6Rtw=;
        b=N4iFQL7h1Gw+G2hvH+Y7Z0QHtDt16VFgAtqeeuYHajOonWahI0tLXtPPmaZcDhhFqT
         CvIzJoh0/qag5K4xkkdjNGl3DGyMf7SggRh42JvXVNI+RS7VHcrJm2inrw6g8fqi4lMI
         vr3qAXIBn2w3z0RP7kNrDUMDDNlsI39VUAP2GZ7tjTaqOMdbBsIpiFC25kTVOAbWSIOg
         eaSGckmHRrkHxUCs6d891wRy9DGpLc7tnedUx2+eigmIajQ04vMWSEgDBFlSvefYZiLT
         pAuDDcRWUEp1qmoJjDjQ9HLgcgBPR/NR7qvaNGtFMsJPIndDsuuSbq+ulkq0zBani4IK
         fDvQ==
X-Gm-Message-State: AOAM533geT6DT+1VPdfpPfCPRV+fbTDaPMkN61bt3y4eVEJc6dwYPihq
        y/8y1ZykbyjrYrLvKNx1FLdW2g==
X-Google-Smtp-Source: ABdhPJytALdF6/WXpXXo/EALA/GzyJrmCsd6yIDilF8kXfMl19bKdv+RXhHgzV2NYKcaqUbkTdgmNQ==
X-Received: by 2002:a17:90a:b013:: with SMTP id x19mr4762711pjq.229.1592491451503;
        Thu, 18 Jun 2020 07:44:11 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/15] fs: add FMODE_BUF_RASYNC
Date:   Thu, 18 Jun 2020 08:43:49 -0600
Message-Id: <20200618144355.17324-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ac919b40596..3f9de90e0266 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.27.0

