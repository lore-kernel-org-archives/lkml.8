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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D457BC43457
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17602076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB+adAIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgGQS5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgGQS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:56:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AB8C0619D2;
        Fri, 17 Jul 2020 11:56:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z63so9693956qkb.8;
        Fri, 17 Jul 2020 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Q+dOO3q6iVRsIzGKMNVG1hgYBtRW1kx4cuQ6hNcJRA=;
        b=AB+adAIuWZBMr3RcCg2EpRB11SXJYyAyiBWlxFfkT8RbRV6H09jQaISAwzOWhfmYsD
         McW107OWMDH+P+PJMvfxhIXdjfqFBS9jPRTiXOTKdMy+TvOZcaJXsFm1az0i0fwNB3il
         6AWBgYFYB3rTemCRO6CakkRqTjGxa1y+4mZQZN4oGNvrGgQ7Ddy0sJl7bli8LEokRk7x
         sblTBOuxtQ//jibOxTMvhvyW5DHcFMP6Lv5C3luDqXTvErxM3dnOUGGZN5S6AuYEvEeJ
         Oex4Gp0XDdkEUhEZueV6Gzm7/QrGHXuc/qzNfCDAMQxb/sQWCss8RHF8B6Ga4V4ZG/fs
         WJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Q+dOO3q6iVRsIzGKMNVG1hgYBtRW1kx4cuQ6hNcJRA=;
        b=oqP/axIf5yqIR9EuP3C9TDhdfBg916ZjGvgqVK0psMA3nCd2ERjctpL1VYma3UMmKa
         m9YWsfqHynQcKW6Pq7gViQEQYTQwJ8lApzW3j929ifFs58NgnX3DP8Ewf+zLbPCZhmvG
         ybPuVzsqwrMHwH6vpS9yGm1Yv5nndIzyxCCZXtVmGkz5vZsZP+G2SqvzPsz9AuXl/+kR
         lqQBO35GCVDdFXHvXhD29C7aiWmAWfeUTZ1ZtXftwWw2D3AfGpZHc+9MYK/obydKoC8b
         3mQ4mgWumuIxUrOA4GtNSOVAsOZHWXRMnaX4xnP2MZ56pbUD23rDuDURq50ciF0RrW2F
         t7Cw==
X-Gm-Message-State: AOAM533hHGzBaNaZMuS/zG8zNbVvlHCKTJBTSn5VLPyGrYtp3DTk6DuI
        wVZaBFlJUWqCRU5SGenSrm0=
X-Google-Smtp-Source: ABdhPJxiUT6XT9+fYRRiXdETF63A9GlYLI2aH0vBxBWcoFCkuuhC+mkvOaMKNt3qyva81sgEv0oQ0w==
X-Received: by 2002:a37:954:: with SMTP id 81mr10090485qkj.336.1595012218908;
        Fri, 17 Jul 2020 11:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:56:58 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] Documentation: amdgpu_gtt_mgr_del: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:03 -0300
Message-Id: <20200717185624.2009393-4-dwlsalmeida@gmail.com>
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
'amdgpu_gtt_mgr_del'

warning: Excess function parameter 'place' description in
'amdgpu_gtt_mgr_del'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 627104401e843..bc01a06546aaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -268,8 +268,6 @@ static int amdgpu_gtt_mgr_new(struct ttm_mem_type_manager *man,
  * amdgpu_gtt_mgr_del - free ranges
  *
  * @man: TTM memory type manager
- * @tbo: TTM BO we need this range for
- * @place: placement flags and restrictions
  * @mem: TTM memory object
  *
  * Free the allocated GTT again.
-- 
2.27.0

