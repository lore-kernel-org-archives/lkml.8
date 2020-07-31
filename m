Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88731C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581C52245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgUyGPBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgGaMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGaMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:51:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C177C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b30so16780139lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8zgpF044pgTW1uK5Q8AXrv/7bel3rEWKcAtjS7WDeo=;
        b=WgUyGPBfwmJ9bTlFZ1iykzmaC+/eyxO2mETTCyh0EN7DEuu6cfihmRQOfjN0UX17KJ
         1XK/aClkr4jouIfR2Uq33SHtLP56E4y8DgZ87NMJDRnE/5HMKnL0qQRmTaRqEurFsoxI
         D/R3+eHgdIAl42+OdJRKAhPJheLy6IATe2ljDZKS9Ir/9TnHfgeT9ND6Q078g/e5NeAs
         I2W7ZBR4JYFb7XWCyVQlSdl0Ydv93Ytn/B8SI+DrRwYKxIF7FMjE6FYcroqJuyHyrA1S
         e7Z785IPUZkU0urptiMhDbgonuN0KgLkpcNKcT+5pvixgh0YZDlTJ29FOCn97utl+t8+
         hahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8zgpF044pgTW1uK5Q8AXrv/7bel3rEWKcAtjS7WDeo=;
        b=H894F2bk6Yn3Pq7QQU/bYRpdyu80j9P+EnobJTaoV+HY+HCG9fudD4gHUoXVBqs+OR
         DQMFUK54ZoUMQ4bPsiKIdjn/rYoNi3l5K1fA3RqCXgyN05XdGPRtS7oIs1/ri7+TH2T/
         C0q60GfgOlVSq5Ue/3NU2qSZ1DrqPXVxzWoLzFan7QzBEKXZIqn2Ya6qasrm+yvrGH12
         MnX8M1qomR/o1jnaVSggDQTGYwMZRJ1mrLV6Sti/neVtp7RePzFuts/M8VmU6+DGoPxz
         lNYYIkpencfCoJSy7c6CT3e30FudLhZWW8SwU1jZaI/Ig4VW6v5IR6YPooKW0IolvVej
         8rhQ==
X-Gm-Message-State: AOAM533x82gWZrORc9cKdtVqlykSfBjZr+7LUPoK06Es1Kf9HY0WnHve
        IIaaR0V8kOkJF/b4rlt1S4E=
X-Google-Smtp-Source: ABdhPJzATe0fCD2sbhssHSnUfNXc6kWFAY41kSspFrVQTiQcz0U9VH0isUKE3+W9ohrCIfVkdQXBSg==
X-Received: by 2002:ac2:5683:: with SMTP id 3mr1948307lfr.69.1596199873919;
        Fri, 31 Jul 2020 05:51:13 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id s2sm1923362lfs.4.2020.07.31.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:51:13 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 1/6] xen/gntdev: Fix dmabuf import with non-zero sgt offset
Date:   Fri, 31 Jul 2020 15:51:04 +0300
Message-Id: <20200731125109.18666-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125109.18666-1-andr2000@gmail.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

It is possible that the scatter-gather table during dmabuf import has
non-zero offset of the data, but user-space doesn't expect that.
Fix this by failing the import, so user-space doesn't access wrong data.

Fixes: 37ccb44d0b00 ("xen/gntdev: Implement dma-buf import functionality")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev-dmabuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 75d3bb948bf3..b1b6eebafd5d 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -613,6 +613,14 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 		goto fail_detach;
 	}
 
+	/* Check that we have zero offset. */
+	if (sgt->sgl->offset) {
+		ret = ERR_PTR(-EINVAL);
+		pr_debug("DMA buffer has %d bytes offset, user-space expects 0\n",
+			 sgt->sgl->offset);
+		goto fail_unmap;
+	}
+
 	/* Check number of pages that imported buffer has. */
 	if (attach->dmabuf->size != gntdev_dmabuf->nr_pages << PAGE_SHIFT) {
 		ret = ERR_PTR(-EINVAL);
-- 
2.17.1

