Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4770F21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jru5qnT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgHDO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:58:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78ADC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 07:58:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so4667315pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CxN7Czk8Q/fjw3b2OK/Eu1Y95h805YTwH9VxKqGhCAo=;
        b=jru5qnT7fx9ST2x/KOLl/kvsCn/g45/ledxil45Vl4N+Ge/ny9q5E5mgRPmVmFLXxW
         fbngSWkODodtOID37BCP6yMPvZvPA9qsxnnlc/Xuc51KAIOAf7SgpmFgp+YjylD1c3Do
         zAYZhXAX0OtsnfWwCy/mDSSAER3RBBgg7qhKPVqkFjrI5CnqYU9DnSo1I/Difx6LS+1O
         MuxRPHyjkVyp6bFhSCcn3l+/vuKizYJXrnQsP9Hn24jXE+XgGB5QrYa8w3ceKt5UdHzN
         kcH925AQ/1GyoVladVbuqO3B6Lb3aVrBfdqWxgY3/xMkHmz1mHnztJxw1RK4ueU+7Py9
         F6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CxN7Czk8Q/fjw3b2OK/Eu1Y95h805YTwH9VxKqGhCAo=;
        b=oscophDWq3cuJe4rCUXGBorxvfGU1znaiCK813kG3sh8Fl4/4x+Gt3EP8+hxSf6qVO
         6N2NxdAhNMxe1UHU8ZsSWrt0Bz/0llRBlLHATJWV+4HLc7p4Y77mA4plWKrWvNLWZ/aa
         Xk9BBe2vzByJBXQrZLWxHPq8Yu4/reLdCgSI8s8GnIifuObeS1Vfu/SYHVRPW3c4T/mI
         uyyQ6jdsAC9UP8ZZGTjWTeTDGGaPXWrS+FsCu5iJlUrKdwWGktNy/bywpVRATil0o2Of
         vPiA0BV6UTJWTiyujte2CRAuvpHIoYNdy1wtAMeFkh4bm2oA+1s9ZcylzI6yGlpnlaGE
         E37g==
X-Gm-Message-State: AOAM532LAJmeVAsL/K2Ihj3qXmmMnQOOFxbWmsUPbWmv+8UIXA1IBcam
        99XX+lb1ie+gGd2ROglp3Mw=
X-Google-Smtp-Source: ABdhPJwuhINGBfY5nsK2kvG0IomWiTrH6vzMJ6AcEutNSoXYsinQjejRyHJem+tIrvh3h/wq9pLSlw==
X-Received: by 2002:aa7:9493:: with SMTP id z19mr20942709pfk.190.1596553101344;
        Tue, 04 Aug 2020 07:58:21 -0700 (PDT)
Received: from aditya ([49.14.130.231])
        by smtp.gmail.com with ESMTPSA id na14sm2518023pjb.6.2020.08.04.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:58:20 -0700 (PDT)
Date:   Tue, 4 Aug 2020 20:28:16 +0530
From:   Aditya Bansal <adbansal99@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: fixed misspelled word in comment
Message-ID: <20200804145816.GA3823@aditya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Bansal <adbansal99@gmail.com>

Subject: [PATCH] fixed typo in driver/staging/wfx/hif_tx.c file

Correct the spelling of function

Signed-off-by: Aditya Bansal <adbansal99@gmail.com>
---

diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 5110f9b93762..6a485fa5b72b 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -125,7 +125,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
 
 // This function is special. After HIF_REQ_ID_SHUT_DOWN, chip won't reply to any
 // request anymore. We need to slightly hack struct wfx_hif_cmd for that job. Be
-// carefull to only call this funcion during device unregister.
+// carefull to only call this function during device unregister.
 int hif_shutdown(struct wfx_dev *wdev)
 {
 	int ret;
