Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61405C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1520791
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE6fAWhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgHOV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgHOVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DBC0F26E2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so9970825wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=3Dsr0Yy5xJaA1gocXEUrCia+DklzUMLBvu3KE2Ccr3E=;
        b=bE6fAWhW5P2lSSZB3qxYlXC4bc+7IiGKIPbBc5vsOZXEraILW4YnokRhL8zXOzdkpR
         BmE/AodF8dwW1RGO6NZa0jzi6WkvUM3/FPT0KDABLRFhJ4kcGIEVE9JjhiodUJy/ulPm
         eSDFGGv0/WgNvSsbLIPZkYLsQxcyxFK5zeEkAYZmFSWhHD5M1Aqp1L7y3kjAeWp8P8nx
         ShCJ6Me6p6LJ+qCzVygvQ+ttGWoOqWU3nb/Dd41jAk8dy1tnda3kvLu2g2sbGRaZVvTj
         IgL8YLlMXrqhXbtNUNCUnIY7nMPd0mdkD1y+Xtbfrnsdw6GwSHmG/yaDRCmUF9+W41yN
         FP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=3Dsr0Yy5xJaA1gocXEUrCia+DklzUMLBvu3KE2Ccr3E=;
        b=lkht4dcto5F1aFoLSW0AfoNdLH4w8c7RuEFA7J9urfWd20+qQ/zjLQNul9lIx4BQ0f
         wkVaR6x/X489PgBk7WJFHDTTFgG5PtLddTX2qTuNObVNDjNpv/nwBzPE8H1FYOCuW4uB
         t+K1VbnavBZ3Xqvz6m73k+bf60Tus04sxq0B0jwfmJTcH2q9v7fW80zriq4qaQRMKmaC
         Xc1Za6qhQpC0o0dsXr32pmHJy8X9G6tZjgQmxeVLUONQ63p5Rx8bBf8icfC4vDurlumj
         CzRxCLD0i/BRpiXITyJCya7ICFuVgwOwEcCDukdhb52yzT4BBoc4FKvL3vq28kEHUEI5
         f23g==
X-Gm-Message-State: AOAM531Hb6KflA58IF2gbMKvAk3Y6Zltxr27mPXDHcS11dXNL9rSXkK/
        5LgnQ2GfHl4pSUSeRzm9PVP5PJmmJ1Y=
X-Google-Smtp-Source: ABdhPJxt2pVVX4FmKqdHcsNKWhP44boTusPcVDAhNPZj67cljfkrCR2KHRNBaFFWXFbMFsiw1yi+Og==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr7761683wmc.117.1597514384276;
        Sat, 15 Aug 2020 10:59:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 3/9] habanalabs: eliminate redundant else condition
Date:   Sat, 15 Aug 2020 20:59:32 +0300
Message-Id: <20200815175938.16619-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both parts of if-else are goto statements, we can remove the else and
put the else goto statement after the if statement.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 2b40aa85bec9..58327cdb6a2c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -686,8 +686,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 			rc = -ENOMEM;
 			if (is_kernel_allocated_cb)
 				goto release_cb;
-			else
-				goto free_cs_object;
+
+			goto free_cs_object;
 		}
 
 		job->id = i + 1;
-- 
2.17.1

