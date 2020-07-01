Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5837E2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/961bqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgGAIcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGAIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71899C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so22891915wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZzcRr+il6B7Wb5szs9514Q011nYXDt2b1eWYEXToMg=;
        b=T/961bqfLhKvkYLxSnHHWpEfPBVLQHZP8JmP9cDGKQgDJKxp2PSYH0sNvAslRP8Rh6
         Qio/3x7UgE+n4G1rJQwVtFnLhuw7mQ+0ePSBVqN8owOWFqgwtKTWvGJ0E3or5afJYfaK
         +R00WyNEkoWOvADs8PSOfJyZq43uqzhUBensqR5HWPyo+RV87EKZKeRwzFACq9/qV7cm
         hEQVKgbV6U+0Pl8qVpufSrK5d7z3Jc7qb+hQp9w2Dhxv1PQqYkkwDsdlnPzyfjCntTlN
         dR+47xS8X/mdxH7P6m8ibWTUdPuHGDfzH/CM+HkuJ0GrNoOAEwxTqqJHKRQ2e6TZAKjl
         2kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZzcRr+il6B7Wb5szs9514Q011nYXDt2b1eWYEXToMg=;
        b=hgkb+4AS890O51a03me1cX4O62xJp47aVfO41C5cRI8emBJQVUKWjz8DiZT8z5jmRq
         wV/Wf2/aEMFCbOkkjiwcGajfThI8QyleqjF4uHl0pTv73ZutOP0/2y3pmjUQYQIbmck1
         ZKGJ2E+b+wtFIusN9xk4qjo5G4arXniWRVJqtkwme+hJO6ZOPifKBbf+WIjq/I2SF3Aj
         hSa53O4sLWkFeBhuywyTGcOUHqhF4pEwHWUdiZg+nttxTv23lWnlQ5ec/7N8N0tDSazv
         NNBGehjGnt9XTLbKEvYKcaHPI0fmx+dqHokduHhNwxOl+HtW6ubrPquo4kEilBi2Rmkl
         sjqw==
X-Gm-Message-State: AOAM531i+tYaaDvjcWqtTMWxhdf98VMikyGzt1SL0QG/Kn5qDVVzoJ7R
        JOfrrNY8Y44CpKWb2Du4L6mkow==
X-Google-Smtp-Source: ABdhPJxqVgReTrmNRgeGnposdJbFETiC9GzH6pknz4+2saBKDurPy8FBUajeS2RPoThNqCEbqUTLtg==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr26072060wre.260.1593592306136;
        Wed, 01 Jul 2020 01:31:46 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 19/30] misc: mic: scif: scif_api: Demote scif_accept() function header
Date:   Wed,  1 Jul 2020 09:31:07 +0100
Message-Id: <20200701083118.45744-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'epd' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'peer' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'newepd' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'flags' not described in 'scif_accept'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
index d7faffdd87e92..9cc6b2a6cf229 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -713,7 +713,7 @@ int scif_connect(scif_epd_t epd, struct scif_port_id *dst)
 }
 EXPORT_SYMBOL_GPL(scif_connect);
 
-/**
+/*
  * scif_accept() - Accept a connection request from the remote node
  *
  * The function accepts a connection request from the remote node.  Successful
-- 
2.25.1

