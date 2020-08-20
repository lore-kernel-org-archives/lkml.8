Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03406206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/AMsDWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHTIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgHTIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:52:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF3C061757;
        Thu, 20 Aug 2020 01:52:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so804610pgi.9;
        Thu, 20 Aug 2020 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42LHFfcuO9OCjNNDenDSDBxfXF+eWcdOYM33HnzRkkA=;
        b=D/AMsDWMmGjqPOmGzc/ZrcVMnXBlKKxevHtTRrXrCFS470G8yvkN2lrQNQxSDd1gPY
         +cSKVPDhYWEpC8+aQHLvEKU+16Dk/TfVtTHrfYZMqx0clBut1kHlMq6csIOMXhc0TUvE
         XEKWfa6tdomxl5Xh9HlJQ/EgcAK8VAMpbag97nX0BbhxQ6ef4OaTqo2Tpf+2HGQL+dLR
         O3NlatgEdA01dTzYREmPl5nnNSKMD1qJpLVa0b+HCw1SKdFxgIkUSsFW+i0ulq7QJt4q
         Qz+PAYhiiyqrf/cygKg2IeMyXuLWXUE2oSj2WXWe7479y3sW+W8z6FU2WZpeRc3tshTR
         S/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42LHFfcuO9OCjNNDenDSDBxfXF+eWcdOYM33HnzRkkA=;
        b=kYlhwFLKh4cTnCuuMEvJhL9AQazfYiJnl4LRsCqM/zFmYIWYm/8bES8PJiXvoJGlUH
         /9V83pb0wOuYhwDewZNfTMGtTPSW+7RFwmUJpwcf4jGkU1FlDSiwNG3hV4LIvt1tekpY
         6YyZsOqbUKr+2UG9L08HcD7rLkIlk01Uz8gUZFQy0qX14b8p2jnkwBYWRfNHtSa45g5b
         /Pj4fpsuWHhWs/eaZx6KKUCBFz/9Ze+PMszvDF1rDV7pXjWHMUH/ZYSrZjxl1CnMUzjF
         0oknAMW8hwkT1kDj6EHu34mVYZ0J7BwvG7y+Fvy1YId+u/emP8wdOPYAJWHZIqZ8SDK1
         wZVQ==
X-Gm-Message-State: AOAM533+v2kZiLew+I38QLVNMFIps9pr0x9K64BDnYlEeIuEa7y+RNAm
        OCB08GX1EDNx+B+roMI2JDeQ+HAWKqylAOoP
X-Google-Smtp-Source: ABdhPJzNiuiAOv5HpPKi+OcC2h1oicHKgHcdYtsQkbme88/1JmARxKFJgi1V9VMZX+Y1s2FYEdZLKg==
X-Received: by 2002:a62:158e:: with SMTP id 136mr1639419pfv.36.1597913522755;
        Thu, 20 Aug 2020 01:52:02 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id o7sm1025906pjl.48.2020.08.20.01.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:52:02 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:21:49 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 6/6] staging: wfx/hif_tx.c: Fix spelling mistake "carefull"
 => "careful"
Message-ID: <45b7f521c7d4c9ba09786930909414942fcedca8.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/hif_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 5110f9b93762..fc12f9dcefce 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -125,7 +125,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
 
 // This function is special. After HIF_REQ_ID_SHUT_DOWN, chip won't reply to any
 // request anymore. We need to slightly hack struct wfx_hif_cmd for that job. Be
-// carefull to only call this funcion during device unregister.
+// careful to only call this function during device unregister.
 int hif_shutdown(struct wfx_dev *wdev)
 {
 	int ret;
-- 
2.17.1

