Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62433C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB912071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBW6G+nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgHaSXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHaSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:23:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so1624858ioa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=PBW6G+nlGXgOQpoptLz5sm4ZDo136nZIWnQVcvABR+pJTjK+ALtxqdfYFWUbcR6J+E
         /oMQRGR5vN2iwpfAAHhZcDpCLJH4+6b23qQgS4Vg7wrhmN6YK1+dCgWGhcRSyxnV5PkY
         qxzafFVOlo05a2VMv3s/BOUHz1NRnJMPy344JLwDLxiuYujlxjd9lS8C8w+EzNXR+hD+
         01w8WUujNy2pffR6xrmeWW/dEKtj+xPOMSKG1/cVVSxMgjpx70je6QpfP0mynxYDZ5Dl
         GrOSuFTydMBI9axo3m7yFhC7izEv4apZJtpPUcHf95e3wZQmQJOS8c3zvQodqzr/SalZ
         05Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=rVnCUI4LeMNq33gkreM4VFCzXMhxg/DOUYNJqmRKonUb87mkaRXoKEgvaVfJCEhiX0
         v7u8iKGB3KwVIxwjTG85Ug2vQh2ieKfRwEcz1GKmGAzZMAD76WNsBFp1ywNuTfjU13vF
         UxGpEKDbbK/qcNubTmQoPi9O5y9p3TEsFEavXTOtvnXPDAyPHV/Uq4K1WgLqKE53SScO
         kQFQxEP+ej5L7RkJVGeIEifW6Qgw+XP85lTZlPBczNeBHua4cuQHD4SL+DldF63rNGHg
         qIgFbwxNnkUVwI1EOT4bfQTikZ3HMkTiOZdEG+Z25XlNxqGN/WfWZX4at4DT8MhKqCQv
         qF7w==
X-Gm-Message-State: AOAM530usfPulwEgPcT71jxaahxTMHXl7q86Sik/7mF30HZDFyIBvf4W
        O+bhB7apx7gAyApkriiLnEw=
X-Google-Smtp-Source: ABdhPJwMi+yDXFXMLjXrI8bJNS+5WCOq4Mn3pA1o15eiUD/9NWTrqvhVxs+bX5CQ3+p95cvSPH0kMw==
X-Received: by 2002:a05:6638:76b:: with SMTP id y11mr2379318jad.29.1598898181807;
        Mon, 31 Aug 2020 11:23:01 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::dc2e])
        by smtp.googlemail.com with ESMTPSA id p18sm4129017iog.1.2020.08.31.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:23:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 1/3] dyndbg: give %3u width in pr-format, cosmetic only
Date:   Mon, 31 Aug 2020 12:22:08 -0600
Message-Id: <20200831182210.850852-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831182210.850852-1-jim.cromie@gmail.com>
References: <20200831182210.850852-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the print-width so log entries line up nicely.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..01b7d0210412 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -947,7 +947,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.26.2

