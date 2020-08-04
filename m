Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C58C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5195D20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+/m0VdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHDSRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:17:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:17:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so23609925ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4tfCnzr4+3Vx6rPZIuq6XqGtDYKgl1/4YSkrP73Ea4=;
        b=Z+/m0VdDjhfO3sTKjHjfXRkxKWgUFS7YMUFyEubDOG82kpiOKCuzMqtEadaKhvrr4f
         EuC3pjHVo6WqhHwjS0Ijcwk5s+SQfUN75TB5n45iMclgUHoZ11rmuaPn5wwYjlHvUGcX
         lM73YXE+VN4fdT0MbELvujQBHlgiIostnMSRgS9Nh437nTC59TJ6JqhQIGXa00qS6t5r
         Np+G+Wf7G95S055gNuoZjOAl6kqEZOZa1KPNYzBpde7DZrFBx0RD4GhZc6FisVRa9Xum
         3VCvCa0DclVbD/2CEGfkMQc7gg1z+oO7S1KI8JaxhezsErWYn8nJOe3NmFasCd2YrV+j
         5DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a4tfCnzr4+3Vx6rPZIuq6XqGtDYKgl1/4YSkrP73Ea4=;
        b=U8KpgA8uGRcuBOG6Iw6UKth95wxzsw/obZOdTGcDDLVYIfzuoYd4QwgQyV1J5sE2gr
         YTN8C88eM5E6E2c58wT2tL652Yvh3C8gXgwS0C3kBmQb8j/lCieFoFEaieVKWg4gJ9mW
         nYkK4X/0FMAoSeALo2eX96Fl2s1ml0+Jdnky4K2+7Gsq+TbghhucKhtFp4mVgxh5PiVV
         kSQD5XKfhtB0+SBG7GdPGmb4FXfxWqWuk25jUzXsXnzNq5Z3shKK7D8I2ToYtFcFykrF
         AUGifJ2uuKxECeAgtwhFgFJmN3otTjD1QuBmsm004xdBArlmAuZxrcy5HxTFRrixqeZ0
         WYFw==
X-Gm-Message-State: AOAM530sdCOrzLZpPyRyNTvX5RyMg4gIcJ9lWguDEThejQYFoRfWaPWw
        sJKV0cBQ9guoX0Ntgc5w8jc=
X-Google-Smtp-Source: ABdhPJyFGGZ0oNMt7juL0+U0n+sUKltwVR33pI2Fkp6Gv/xOdoV0hiVje9tkeWtWo6h0FS2alHZWZQ==
X-Received: by 2002:a17:902:ee02:: with SMTP id z2mr20278515plb.291.1596565073765;
        Tue, 04 Aug 2020 11:17:53 -0700 (PDT)
Received: from aditya ([139.167.61.143])
        by smtp.gmail.com with ESMTPSA id o2sm23729722pfh.160.2020.08.04.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 11:17:53 -0700 (PDT)
Date:   Tue, 4 Aug 2020 18:17:47 +0530
From:   Aditya Bansal <adbansal99@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: fixed misspelled word in comment
Message-ID: <20200804124627.GA3348@aditya>
References: <20200804145816.GA3823@aditya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804145816.GA3823@aditya>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Bansal <adbansal99@gmail.com>

Subject: [PATCH v2] fixed typo in driver/staging/wfx/hif_tx.c file

Correct the spelling of word function and careful

Signed-off-by: Aditya Bansal <adbansal99@gmail.com>
---

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
