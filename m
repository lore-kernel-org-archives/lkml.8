Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A288C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648D82074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTDBYgdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgGAIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgGAIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7692C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so21459798wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HQs0EX6y4pWd4N+iRFQEBAE/mvgYPFVjycd+tHmjaQ=;
        b=WTDBYgdocT5nrS5zyEPj/zAHNPty46Gkequ+KV4p4FWi6McNRdP8GNm0jUOWdCmLbx
         WoPja8OXAKt2z8LB/RIgiSYlSy7XNmtK4XSlqSZB7bn37/IEi+Nc9r5O24/Pf6msb6P7
         0/Y4eT3SwXys+mE67IX88KqtAae+U/SwnaYTAagojnO4MKYzrmCPJrIVCvQGE1V1nqkf
         qGqa6DnIU5945WHRScEtDpNps7IVq4J/JPuJPJJLDrllC9q87mbhDLIfKtCFyHZpGtut
         cpAX+s7yxJb7kArcbIDJw/lTuN7WQ9ydXHP71Rrq5on9BhU/gTvGQTyTphMkH2Sjpn/d
         eNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HQs0EX6y4pWd4N+iRFQEBAE/mvgYPFVjycd+tHmjaQ=;
        b=hU3ynDApY1RiBjBjqNsp/5NosxOqY8lz2zDk+KzvJvUIltBShYFGZSCfqA1jwZUb0O
         AFnLh2Qo3EcOMIdu0y/tNKpXUaZQaVPWWPvjoaImQuWFd6b5BgM5kOqrPz4BlXWQVzUZ
         Sc+4p3TvHWOS0JbSr8JJCsQxfvFp59Ik0aTlnChsOerQzefbtHNQ3NMjSor61ph64H28
         JN3e3D8Tp6G0EbWx37jizRmLldldqkefRvBcDItKI1fhJLs8mrmTqOqvLf9wTXlOhZpe
         L0iAKMsy1u3hlF+KNA64SKuH4y6nFPDEpAuJex0mIr6ATfVm7SolL/+cMDsyV1aMWprr
         XaBg==
X-Gm-Message-State: AOAM532kNeYWCPEajR4T5mgFfGcHupddvXdHx61W9+I0EmTSK5+BkOoU
        n7zjXjNKGObyrgmj4WfohlVAzA==
X-Google-Smtp-Source: ABdhPJwr/Tt462TYHkLj0p/dAeZmJJruZox9VvlEMPLf64FfV0powsQ21FKbZ1X6Fuifclp/c0x+8A==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr5425364wmc.58.1593592293622;
        Wed, 01 Jul 2020 01:31:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH v2 08/30] misc: ibmasm: r_heartbeat: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:56 +0100
Message-Id: <20200701083118.45744-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/r_heartbeat.c:49: warning: Function parameter or member 'sp' not described in 'ibmasm_start_reverse_heartbeat'
 drivers/misc/ibmasm/r_heartbeat.c:49: warning: Function parameter or member 'rhb' not described in 'ibmasm_start_reverse_heartbeat'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/r_heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmasm/r_heartbeat.c b/drivers/misc/ibmasm/r_heartbeat.c
index 6567df638ea93..21c9b6a6f2c36 100644
--- a/drivers/misc/ibmasm/r_heartbeat.c
+++ b/drivers/misc/ibmasm/r_heartbeat.c
@@ -39,7 +39,7 @@ void ibmasm_init_reverse_heartbeat(struct service_processor *sp, struct reverse_
 	rhb->stopped = 0;
 }
 
-/**
+/*
  * start_reverse_heartbeat
  * Loop forever, sending a reverse heartbeat dot command to the service
  * processor, then sleeping. The loop comes to an end if the service
-- 
2.25.1

