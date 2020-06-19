Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB5D20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgFSNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:23:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39132 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbgFSNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:23:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id a9so11461300ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/TRBC6roif3JRfR0eyS1Twcm7a48T8psf0xx78VupM=;
        b=XVPsDm+7s2P2YAk/NpTntK+gfNAwBj18+coRFPXf7MzTIgFenroCj1lr4t/Kw7ya9E
         EDRoB/ZxIz2i62zDkJTOk+K+dm9x7xXiONRiyjadEZ9PGXLc848A4L1aj+7BKsgD8nep
         rk7T6e/JVwlH10t0c/rv5omggD4Oi+UYadqdswsObtKITerUPoyurD0c4hT09kz4f2y0
         Nk5j+AKNtYaabM/onwARZmr4Negk1hr4HWxD0UWUL5HERKpN2aDpc1ZV1G6RceEGaEz7
         2nsGcqSmGmglWObzP/E1mSBAsxz4YiZ6o80jON3uU13GeJbjOj62BcOIQx2qpARFVjCF
         HemQ==
X-Gm-Message-State: AOAM533xgqaTq8KWJpMrgbpWxEKpX+B3wHCzcHb7gS7sbYUi4N9fOMhi
        pie2A3jXnUhrF6maTXpICOXIYlDnYSf4BQ==
X-Google-Smtp-Source: ABdhPJyDmos2erRDWIlEDAeX01T8RHF9cvr8rL7N4KSNa/VmvcUvm8MuMKsymrWUrrHGxoTzj6q3Ng==
X-Received: by 2002:a2e:b615:: with SMTP id r21mr1773433ljn.1.1592573000818;
        Fri, 19 Jun 2020 06:23:20 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.195])
        by smtp.googlemail.com with ESMTPSA id q11sm1398026lfe.34.2020.06.19.06.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 06:23:20 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api/kstrdup: fix coccinelle position
Date:   Fri, 19 Jun 2020 16:23:07 +0300
Message-Id: <20200619132307.16612-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in rule r2. Position p1 should be attached to kzalloc()
call.

Fixes: 29a36d4dec6c ("scripts/coccinelle: improve the coverage of some semantic patches")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/kstrdup.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
index 19f2645e6076..3c6dc5469ee4 100644
--- a/scripts/coccinelle/api/kstrdup.cocci
+++ b/scripts/coccinelle/api/kstrdup.cocci
@@ -66,7 +66,7 @@ position p1,p2;
 
 *   x = strlen(from) + 1;
     ... when != \( x = E1 \| from = E1 \)
-*   to = \(kmalloc@p1\|kzalloc@p2\)(x,flag);
+*   to = \(kmalloc@p1\|kzalloc@p1\)(x,flag);
     ... when != \(x = E2 \| from = E2 \| to = E2 \)
     if (to==NULL || ...) S
     ... when != \(x = E3 \| from = E3 \| to = E3 \)
-- 
2.26.2

