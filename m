Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B720767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7n1kBQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGJJyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGJJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so5309733wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wIuyTvTvTJehZ+ep4u+btSK7FBgl8Se97pFISO/LVI=;
        b=m7n1kBQLnqX0x0Z7KrLWKLon0R/jEGObo3tJKl/M3JR8hO1NFX9rnFsRRlyfAAL8S8
         oIoC/bpgVvUID7qcVpfqmSRRV7vmDDdxUXOvRk1H+06seBYGR9oWV2dHbJ9IgbBzuDpR
         RVQ50jVglHfhFUgO6+tLYVwru6EAE00YPLHGiPfoXMgHq7WvkFhywyPKZ1ORe6OD9hpx
         2vtXnnxt4ulVkxs+SRpQMCwiebfSV4SxEolRJvg1pJrQO7FIHJDDZuXjU3sGX/doQnRr
         6EuD6+r+zLFPvRsQd3TvDNyJPC9VR2bU3cQgUm29daIpKMfANgXSW1Qv4L5QZXhO5Ql6
         nCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wIuyTvTvTJehZ+ep4u+btSK7FBgl8Se97pFISO/LVI=;
        b=AC+zR21yWF5gzcps+ppUA7b63W49+1oZPPKr/Ebn5qYGrssnt8uPfTGeIRtucd3mmJ
         mzhGAZQCqjK1yfk4SagZ3y6mojg7IB6Jy7cGNbiYhdd2ijoGRWdFOAVboa7oNVFn0uzy
         4zjr5mEGI1M9iLpD//Zp/MeFclXp4GjwB7ZU6kxsaA+5tvcduLWnEe+/mFvRrpzlXwZC
         kM9gRM4oOtq5SyNH38+R3f5ob0l9bMnA4cHZj+i9NmCvemB6b2RTQOAH2QWHT3VnC1Hp
         XggbbHU7L+FS6I0Js4fdjd4VYK2tqCCemYiBcn3zDrc7SQ8ogYDrLGUnOrZdKQpz8drM
         afyw==
X-Gm-Message-State: AOAM533i4NLl8n6THtCFRrfHFETAh4M1S07UWbhAweMm316GcEt3kg4R
        5Bvd/x1Nl3uiattIxhV395k=
X-Google-Smtp-Source: ABdhPJyLvYZYbHbkm5E8+fZ5ImyFxvJCgcZRFEN/DyaV7WIJ2KvUwkLKLlR8oyebgiUcvxC2Od5cVQ==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr71801657wrv.394.1594374855952;
        Fri, 10 Jul 2020 02:54:15 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:15 -0700 (PDT)
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
Subject: [PATCH v5 03/14] drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
Date:   Fri, 10 Jul 2020 11:53:58 +0200
Message-Id: <20200710095409.407087-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
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

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 360146f6f3d9..4c13dbae68fb 100644
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

