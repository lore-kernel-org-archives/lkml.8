Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C802C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B58B2177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmaw3dQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGSXLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgGSXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E459C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so10772973oty.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=cmaw3dQRAtHMt+2E+yl1tYZBdRQ/3msUFsLjOBj1nxVBkJxkMO/oU8xv9yaUFqRWlR
         xv/kniDCmSFzA4e/Ae5vqMW1t2akWTcculKNbONbzY8FmjERGRdoNUIV9odsmrs2MvzS
         67o+/QNEYB8sRC9SV9DB82+2PtiUnuTzqPPQW0Tj1Gw/aV/SQdvghhDlyisyVyAGoJOi
         hGQ7/5vBuzkfQwYTeIJEhlOvchVecBPfZz0MONEtcSsUD+w9rSTmUszmKeDRVkgEkk3g
         8h2Mzos++eYMjzRYKItQ9Xktmd+xLpzPjscH6egKLiNWS4Sfj4wR/7zu/Kb8YKJ2RceS
         jJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhcAoXPW7ZRiM/8Q3ygWBvgF6djv95EaVmKQGesqI94=;
        b=kLzogMLbqOM+qrcGcPNJp56FI/Qzub6zVxwImqHDCIrofGhMkdDoeOA+iY/ivAbG4U
         W+bV3d/6Wu5M6gVDABq0M4z8h1dpaVlseypcT8yGde+GD7snYXhLo7UVP8K485//TTGg
         V21jWWGPZ24lScpAt6O+FonyLslXyAW91XmYXfwl4n5mKFD6s+aNE/O33vIbNEk3auW6
         PPxrLZUbHZp0SnW0k+0rh19+zeYMMRdzgDdXLDQe6hGPFftmpV+ch6eQoqBk60ty7mGn
         UbD+Qp+TuN5uqRn2Z7yzd/drfoLwEU8zKVaGZpBu+gA2CXTvemjS13k+2mTBRuKYWtTs
         8aPw==
X-Gm-Message-State: AOAM532/WYAq+MerY4DT38xcUJ2N+jmFlSVxTSsjomkVEm5Qu4IuHvOo
        86EoSAC1RdQSXTcfRJuFDto=
X-Google-Smtp-Source: ABdhPJybVuqaC7ItywiUhGXX6BbHSHRfnorRn8ln1t7pxqqVvDu78o/Mx1oD3gPJ6/nsAJtRnOximQ==
X-Received: by 2002:a05:6830:18f6:: with SMTP id d22mr17701947otf.243.1595200297880;
        Sun, 19 Jul 2020 16:11:37 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 10/18] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Sun, 19 Jul 2020 17:10:50 -0600
Message-Id: <20200719231058.1586423-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loadable modules are the last in on this list, and are the only
modules that could be removed.  ddebug_remove_module() searches from
head, but ddebug_add_module() uses list_add_tail().  Change it to
list_add() for a micro-optimization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index da3ed54a6521..e879af4e66e0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -895,7 +895,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.26.2

