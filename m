Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D04C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13FE2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="gO3m2cAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgG3JDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgG3JDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:03:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205BC0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:03:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so3971504plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaFCt3p70PhPdpfYX4VplxwSDGJOv+7O6cVdHFqJo+8=;
        b=gO3m2cABUKQ0JZFSXpIPxZZMapd15KMvmgHC+Z9d/KpK1KfPTw8SF/N8TYQIgfOPRH
         I8T1RLTezCgNI8h5pAqaHcDCPnzM2S2k4GdHYDabcm82ZK9UvHYtfS3WD5wK20kpyQxy
         xurQQ0N/RnZgPdODXJRshuRxeT9dDsW81XxM772UhSTAgAHchnSzqVkkP9BO/IfDk8mL
         sNvABzgewox5KDCrR/IEjETXHP+Y1tZ8k/ouGj/W6Lle8R8Ih+LTaVeaM/YHj+w/mKR2
         50FqsrGJclCoHecx1ZQ/TLYTh7JgfPkkTsh0RW7In8Nje65jCjyZlrQ7XkBGxrYJeSYl
         qY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaFCt3p70PhPdpfYX4VplxwSDGJOv+7O6cVdHFqJo+8=;
        b=tTl6G1DF2YNIUxKMkWg9gtkykVmf4SVyeQUscZ8LjQi2kGwvIBUQtAuRxf62c2aX8H
         /05uTIzXbcoAVEgIqZL1C/4VMt8fEZ0g+G6RUD6qAYPECgXVyozZF8zS1mb6ZOezP0oX
         6pz/Qd0O5gvCU1M5oGkKbyZnR3X9rytrWdUYur9O/OvfutlHvwGHL3yAm+5klmeVF79B
         jeCoVDAv88862hMJG4ZU5y7mVT8lNWRVpXZppftL4hIVguIj5z4MXlhiJms6GxBCMkDn
         /JrbD+EvrNNce5kUPDe4/Jdn7xRWHQomfo5f+TS+1dLM/KufOX2f55DoBzqr4RKvJMah
         i+ew==
X-Gm-Message-State: AOAM532Mc6bFh9dlzgrZ97Xyfg/fzSHCrltoKLnrLvWb7499H23QMCAk
        ENZQsGr13268Gl1dvXmJ2Zm0/Q==
X-Google-Smtp-Source: ABdhPJyKgxSZ6enRMtBSL39zsPd1k2zp+c5GqSn6zYTw17+/9PB2UapxZRNc1CS/IFHGPSkmJuJcTg==
X-Received: by 2002:a17:90a:1fca:: with SMTP id z10mr140054pjz.209.1596099813408;
        Thu, 30 Jul 2020 02:03:33 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id b185sm5217080pfg.71.2020.07.30.02.03.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 02:03:33 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com
Subject: [PATCH] iocost: Fix check condition of iocg abs_vdebt
Date:   Thu, 30 Jul 2020 17:03:21 +0800
Message-Id: <20200730090321.38781-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't skip iocg when its abs_vdebt is not zero.

Fixes: 0b80f9866e6b ("iocost: protect iocg->abs_vdebt with
iocg->waitq.lock")

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8ac4aad66ebc..86ba6fd254e1 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1370,7 +1370,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	 * should have woken up in the last period and expire idle iocgs.
 	 */
 	list_for_each_entry_safe(iocg, tiocg, &ioc->active_iocgs, active_list) {
-		if (!waitqueue_active(&iocg->waitq) && iocg->abs_vdebt &&
+		if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 		    !iocg_is_idle(iocg))
 			continue;
 
-- 
2.20.1

