Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D085C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7AA20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0J7Dd0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGQS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgGQS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:56:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135BC0619D2;
        Fri, 17 Jul 2020 11:56:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so8402882qtq.11;
        Fri, 17 Jul 2020 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHKyFBxmNx4T6rqbFUKdYrutI2dSkhcpOel2unUmdiA=;
        b=n0J7Dd0X7kNphPD8MMfIho7qvpUIh6gTXlitkLHN1QhAhHSIdi6j2yS49H53t4fzN+
         jgupJAEqubBqCtG/t4S082ZfXumVwC9cM3oQFFn/C7sXP4dt92z4fEfGKv80BpRyyH8p
         oqh8JReW+HRmNSxVFpXkNwOTxgtw6tzXltgwBYvEOonEyH25WqyTYwhdD/B2M2A2sZcT
         KTXH0eLB21cU3f8u59Ci2hZPQHfJ7ZIpJr249Yh55fLZbN9cGCgP8ZxQ8frYu5QHIjTI
         xYLiG1ecNLgOY40AUHFEAjNUxxHMjYtkiZ30uS/0CHn2VhvHHuzWMuZcYx8Ys0CG05ll
         YkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHKyFBxmNx4T6rqbFUKdYrutI2dSkhcpOel2unUmdiA=;
        b=Fgp4adaKel7MnWtqv4zNYo60UOJx3YkuPVYgr5bsfTx1/5g8et6xw0eTuOTWR2zaPO
         MSDNgj6Ui/J3v9E5J+V5F4QcUGqYaku7spFrUZ/xAaETE9PUp+u5eADYeQMH8CJdyJLj
         OpSPZ01fbCnYd/RjHSEdO9JfVfbatAhylMcLHOf8p0OlsF87XGGf+7OB7vvUDyFBrRtr
         OwLWnwCM1/jIGzdvXeQCMkMLlWtlWthsJF38NTN3TjPDq9LLqx+pQ7YXr1WAU6bA7FEP
         6nVIrwHE3y6VjljB+Aw3cnZ2yk0+ylzwdO7GRKY8g4UBS5m+6ilXGGR8G2A25/Sq0KdG
         ScaA==
X-Gm-Message-State: AOAM5312SbjqyTwnjqjJ+JL64DqExxn8L8E7pq2+ye61P/1q/85Xq7MR
        H4uhG9STayNW7F/wedIjREyVEwVi+i8=
X-Google-Smtp-Source: ABdhPJy2xAv04ifTIuCD0JvUwBfTJQhfojB5AQTDulqbMlPjEQtA5dlLBK/iaeegoFFpvKC0kp4Rtw==
X-Received: by 2002:ac8:311d:: with SMTP id g29mr11934964qtb.54.1595012215870;
        Fri, 17 Jul 2020 11:56:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:56:55 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] Documentation: amdgpu_vram_mgr_del: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:02 -0300
Message-Id: <20200717185624.2009393-3-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

warning: Excess function parameter 'tbo' description in
'amdgpu_vram_mgr_del'

warning: Excess function parameter 'place' description in
'amdgpu_vram_mgr_del'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index d399e58931705..97ad8ffe6c6c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -407,8 +407,6 @@ static int amdgpu_vram_mgr_new(struct ttm_mem_type_manager *man,
  * amdgpu_vram_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @tbo: TTM BO we need this range for
- * @place: placement flags and restrictions
  * @mem: TTM memory object
  *
  * Free the allocated VRAM again.
-- 
2.27.0

