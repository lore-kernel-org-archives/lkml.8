Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EC32074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qf8ULyJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHZQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgHZQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a8so940029plm.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBjkd/nhJw+5eFsm4c9uEVXQEw9HU2zN9X5gsAn0rmo=;
        b=Qf8ULyJn2F0iIwf8dA+aVpTzmLX0NtkKs/Jg3rzWujRiqTX/BHskaLds1G56xa3F29
         FTRgUuV6keGhWYBXOPLaqAXhI7qkN7cMWY10ZU6ejxCHlUV+8K6bP9PuHM3NEASjyvJE
         nBDfvDxgy0jcWkglP3DTRGGkN7DLsjFFis7JQ5SRvPY+4w4XSdpm4GzCerzPaturE5KD
         +H/uDvHagHaN16pGk3gDL/jHhsQJD7wPXm1Xe6oSEnUTNbVWbqE7xIlmRXN+SsOGczdC
         3/sjiH0qrIOqBUdxrw2KKAvnUK1YNxOFkaowjK5A78JQuwO5/7meLRB6Qjcnaf23tqFV
         k+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBjkd/nhJw+5eFsm4c9uEVXQEw9HU2zN9X5gsAn0rmo=;
        b=d9n4rA7yRWLEhLdGYzHaTqhca6yf+VQC1lxYfqT8IHkWa9m1UrDAQ3zZ9tV6vtVlGA
         qgloWAede6iE2TurV7KTnzQIO1limIN/P8eLHJbEFAfy3iHD1DFsoWODs0iQnRDgt6Oi
         A7pZlcTDkeFe5kMkJxH+s/n32QWm5I995u8IglH/EFcSl4fh8DjsOFzp3Xn1m+Nf6PaJ
         2nWeI96M3SPE8ZYB3WRos8oa5AGRiR/3bnRn4d9LVrnfvL30kHDIS9JzN8Z2UXaALHft
         q5TOxlSvqh2f0P/ag+wfGe223KXgbBkhwETSaoAZxjsiHKNojP2ZnRWgnlj8qBjkrH26
         V+jw==
X-Gm-Message-State: AOAM533RHtDUmsyxRBqR8JRaVqTSX6P4tDRW8BMkxeBcWau+V3/GEZzl
        oOA0Un3sj8NB7k9+mbhkGIJpsePpMLmjhA==
X-Google-Smtp-Source: ABdhPJylZ5yXv125kk5hDT9ig5MisH34jLUAAF9+rT46jI+xNbUFWx4mK/gKw6o8/rZiB4tbO9QS2A==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr7075859pjn.87.1598460333569;
        Wed, 26 Aug 2020 09:45:33 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:33 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] remoteproc: Remove useless check in rproc_del()
Date:   Wed, 26 Aug 2020 10:45:18 -0600
Message-Id: <20200826164529.224476-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether started at probe() time or thereafter from the command
line, a remote processor needs to be shutdown before the final
cleanup phases can happen.  Otherwise the system may be left in
an unpredictable state where the remote processor is expecting
the remoteproc core to be providing services when in fact it
no longer exist.

Invariably calling rproc_shutdown() is fine since it will return
immediately if the remote processor has already been switched
off.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fb2632cbd2df..7d78c9a9d88f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2260,10 +2260,8 @@ int rproc_del(struct rproc *rproc)
 	if (!rproc)
 		return -EINVAL;
 
-	/* if rproc is marked always-on, rproc_add() booted it */
 	/* TODO: make sure this works with rproc->power > 1 */
-	if (rproc->auto_boot)
-		rproc_shutdown(rproc);
+	rproc_shutdown(rproc);
 
 	mutex_lock(&rproc->lock);
 	rproc->state = RPROC_DELETED;
-- 
2.25.1

