Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19E820870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVl0MBp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGDKZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGDKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B82C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so24036315wrl.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLa/udBRiowVJ35/Uw/nPH/NJx9A1pXdMfcVlQ9GEAU=;
        b=VVl0MBp7pBir+NBNWsZUpHtqsOKb3OiYuCBScYawkUgbIas/8oGM1B+TfZ0PeoVTgg
         3DbA4QlV6xV0+pav9N2+A+rgTrMxGSX3Zqk6WwqFWlAkmllNsI+OCNhmWZtCK0yl5Y+G
         q6r45D+mJVbM+Y0T3aKhGpVEPFwNbz/IUP93462kW+2pAJVhbiM4MAoIim34p3zAbDdP
         OCceF0g7rhBkKYnIAO7CQRkc6KuHG6KePJfWeNDYbUaKzr5y5ap9T7Pn9mL/5l1DZ+zM
         beJwPvMKoPGmXYzAXXg2umCgf9U3vbu81G1kYaGLkAAeFMBCaPX/qe/6tiUbucFVF8wd
         5wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLa/udBRiowVJ35/Uw/nPH/NJx9A1pXdMfcVlQ9GEAU=;
        b=LmJUXx1XxPp9tX5K1NNhNiEN5UHibrG3zySOwipW/91t792rNeslZvMndJ6OOY5F5C
         XXVfU/UezCKkiITLI3JEwE19q7TL42AW0MZ9Y4O83/02dh47y8PbCVNLtL3cTX21j/k9
         wtE/H0XDm0ke96Ybb68s/bdh/N8ePb8XiXc308gTY1XdG3T/UbRBbfr9orQC7Gh8YF/j
         PAMAFBWFFqVUSbSi5Dn8a3O8cNcFiwHwjJqmeuRQSlEVWI1usKRga8eaVwFK9yNXMHW1
         UW69BwCkDSLJpUPjmLbWiP6JcFXlyouvYPBGqSNT6wv+pEBxTmcOnjVtl0NiTQzbVG/b
         fwag==
X-Gm-Message-State: AOAM531br3K1BPOyxHqbtlqHdO/zq4kvDFkBWBx1SZxwKKnhhS9WYiRG
        MW1e4aadVA9fxPv6LXQRFMk=
X-Google-Smtp-Source: ABdhPJzDuEfCwuvlJkpmWNd1MaGX1GIjG8W6x5PL/vM3PbaH17/Rs5W3IFG15toS4gEpArJKEqxkUQ==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr5446186wrv.328.1593858345457;
        Sat, 04 Jul 2020 03:25:45 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:44 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 03/14] drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
Date:   Sat,  4 Jul 2020 12:25:24 +0200
Message-Id: <20200704102535.189647-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This use devfreq variable that will be lock with spinlock in future
patches. We should either introduce a function to access this one
but as devfreq is optional let's just remove it.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7914b1570841..63e32a9f2749 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -581,10 +581,6 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
-	/* Check whether the hardware is idle */
-	if (atomic_read(&pfdev->devfreq.busy_count))
-		return false;
-
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		/* If there are any jobs in the HW queue, we're not idle */
 		if (atomic_read(&js->queue[i].sched.hw_rq_count))
-- 
2.25.1

