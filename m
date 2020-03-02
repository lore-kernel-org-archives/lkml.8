Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1843C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1E208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIC8CzGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCBWnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:43:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43648 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCBWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:43:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id j5so1013949otn.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKkYrMHc3NgZY6dbFAxdV/unADRxNvh4mhPtiaguI7A=;
        b=XIC8CzGuyPBHte2kKanC/RDwY5VvcDxMFGRUM3q2+jBbOW2li3dBerBSC11xv+DH9e
         GaeGJz5+Yi3CFcQKM6fJTlQVDJLWvA35qyKbAs989RGnw1qVBS1wwggMGwSakNTsJnxK
         u/Fdg+4TI7KlyqZERL4iiw2haAvtgnFFLGTct4PqKkg95i4WmVULc9aMsm8hNxmW7NC4
         8A7Pt0CofzA5/KWr+6FKzyaIZQ6RBb89Eih1mBTHMrpdNE3CFclukXnFxiuz8Tpj25l9
         KUex2dMzeDDGf4GWRSLcYFJylM1Chg/72lLAsMOQynwsHVdrMZd6WL1VdY4PBtF8MdPY
         LbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKkYrMHc3NgZY6dbFAxdV/unADRxNvh4mhPtiaguI7A=;
        b=PLKu5RKFV4PrZ1BibJL50JqKMfyziMZkjOZ2rL17q4ltCLJtiInu+tlS7yCYtEHnNz
         aDoTsIhRk7QDrBhADfKg1hEZyQyZCA3C7UDrDT4pcKbPjnJMskL34uVJm9uCKx9hIDAW
         +NVLKI5Ptz3Mzlru7kU7CtowOkBhDl/T6wfjMbPOEA3nx9Fu8YSaBHe1k6POp1XHU/07
         ZLSOLxJ45BPtZ7wCbc9O8d6tq5hN6a1yZkHe/bPK1ps/3dHsNXsA1Kk3VoDaE9j1VvNQ
         yZDM8sUjfbaK2OG+U/pRJ0XHmdojd+H7UTNnEyoJb0Nh57stnoexlwl8POvEotlgjYAk
         XpjQ==
X-Gm-Message-State: ANhLgQ24M4Nx4p3UTYSbE+3JFpL89ExjHOyt2tTxRKGDZ8Ys2Jq4t3lF
        fbF9mzdo/EiC/NyRmOvdR7c=
X-Google-Smtp-Source: ADFU+vty9MCY56f8nz95gUPIYIdOBnALry7IQ1WdGNOz6pwfhseTHVUiUMvHy5m82PlJErnpCTe2Hg==
X-Received: by 2002:a9d:21b4:: with SMTP id s49mr1078062otb.294.1583188980093;
        Mon, 02 Mar 2020 14:43:00 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z23sm2746739otm.79.2020.03.02.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:42:59 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Remove pointless NULL checks in dmub_psr_copy_settings
Date:   Mon,  2 Mar 2020 15:42:17 -0700
Message-Id: <20200302224217.22590-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:31: warning:
address of 'pipe_ctx->plane_res' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
                         ~ ~~~~~~~~~~^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:56: warning:
address of 'pipe_ctx->stream_res' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
                                                  ~ ~~~~~~~~~~^~~~~~~~~~
2 warnings generated.

As long as pipe_ctx is not NULL, the address of members in this struct
cannot be NULL, which means these checks will always evaluate to false.

Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
Link: https://github.com/ClangBuiltLinux/linux/issues/915
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 2c932c29f1f9..a9e1c01e9d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -144,7 +144,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		}
 	}
 
-	if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
+	if (!pipe_ctx)
 		return false;
 
 	// First, set the psr version
-- 
2.25.1

