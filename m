Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC920702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkxOWXIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgGAMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbgGAMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039F2C03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so22261957wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJPW3QXOhHs7zWGK9W13Qhww3wag5wL/K8qzQE+aHP4=;
        b=NkxOWXINSEGLHqpysGjU6l/aLOB9D1RBUt6a9Cv/cmC44LR032HJ/q+z+4snhCTNaW
         PdMMvGuAtO6Ujsk4aFY5+ggkapbI0y8vbr63jnUFJyXL86NW5J8CQGij61gyCDHXbUvz
         q0ZXV3do+vtPoNt8BgF/Jqn4PdF42fkgGAD0WiII26VZNos1Zz4ezvQGo2YuQ6UVBJDV
         LjbxniUTQMcgraMb0BQXgE7a+gMVTa48nOSq35qfFocyo8c0E6lg3HCVEfXt60C77tY6
         reC6aeGYzXZElVG8Ik/hDOwn7VmhUGcSH3jWARgSvgWiATkKl6mXLwuzriMC6WwSkV18
         Tz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJPW3QXOhHs7zWGK9W13Qhww3wag5wL/K8qzQE+aHP4=;
        b=G4pzMgDJvnuf4LNwS/zGckDEA62y/3K4kdce8sG+uvZ/tOCNWsghxrMVCTdkpVXsJu
         8pX0IQvhlcgV+PsIHh35+Dd/mAsX97LKXC5/F8nKK+0xs/Q9Uz9QEy3/J2L+C+olq4ZZ
         zN7nI12Rd48h53rLi6QqWeOxSpuoZdb+ih+NvXnhQSrSR9ZDGkbdWx7hxQX5awkHTEFG
         /jPmGTbyluh36R9RTEcIenF3vSuEwpGrZEO4eX63h5ky5MrJ4S4swawKErMraLZ0gOEl
         1qVAt7PaLpuHypvCQSRMQvnpfpf8acXrXyovqMY99/kT98mHcK76ePb/AeCfkwR0vln0
         wDFA==
X-Gm-Message-State: AOAM530WJdFcTM+9dfIl0CVzMrfpXywk5EMxnhHbVuW7BFJ0Mm/o3WB/
        ipixY6ZZC6v7uQfmdyQ0cXIe/A==
X-Google-Smtp-Source: ABdhPJxnFAAMJptNueVPmlk8boLIXJmBHNOeNDTpH4SZs6YyRbzwAScqFRsTswPCfpzS6+CQ/Dp17w==
X-Received: by 2002:a1c:6006:: with SMTP id u6mr26009722wmb.111.1593607632721;
        Wed, 01 Jul 2020 05:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 05/15] mmc: host: mtk-sd: Demote msdc_recheck_sdio_irq() function header
Date:   Wed,  1 Jul 2020 13:46:52 +0100
Message-Id: <20200701124702.908713-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No other function in the file is documented using kerneldoc and no
effort to document the function arguments have been made.  It's a
bit of an oddity to say the least.  Let's downgrade it from
kerneldoc to a standard comment block instead.

Fixes the following W=1 kernel build warning:

 drivers/mmc/host/mtk-sd.c:1030: warning: Function parameter or member 'host' not described in 'msdc_recheck_sdio_irq'

Cc: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mtk-sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 39e7fc54c438f..49ac802ebbfeb 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1018,13 +1018,12 @@ static int msdc_auto_cmd_done(struct msdc_host *host, int events,
 	return cmd->error;
 }
 
-/**
+/*
  * msdc_recheck_sdio_irq - recheck whether the SDIO irq is lost
  *
  * Host controller may lost interrupt in some special case.
  * Add SDIO irq recheck mechanism to make sure all interrupts
  * can be processed immediately
- *
  */
 static void msdc_recheck_sdio_irq(struct msdc_host *host)
 {
-- 
2.25.1

