Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA85FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973F7206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0AVdN59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA2Q3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:29:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgA2Q3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:29:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so27925pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pJ6lw+kHZCCqUAYW/nHhif6D82azVCJsjJV8R6pi2E=;
        b=H0AVdN59WwEINczIw8FoMCkDhJTg7RoTWIPGOBpBLwYQKPf9hs8eRhvnVAuqFLJ/so
         0gdNXuqWE7cDOygwRYedHEtxhS+0r6evt00y7NHCgAqgSa/oMuT363qs7YX1u4ny1UnD
         eU6AgMrdnFItU226SM25RVTnkHqhgEQikkswOE3UoYtoWkHqleIoBP1JvWW/uSVY5X+A
         o7ypJH8CFbRGN3qDcHVwrYU/86Pxx6P3Zbc1ctKcpbnjGRjyl0U3rBrzCqqe8MozPNaK
         tX01oewx4SvQ+lq1DIczCLkevIdBcP0aePLl7g80EeumojWwj0prMuvYY9GI/500Vd/i
         hNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pJ6lw+kHZCCqUAYW/nHhif6D82azVCJsjJV8R6pi2E=;
        b=kmN5E8f3VornzgSZhjf6sCDujvBFB7C35joReZRrVfCMgNQfC9Km7uS3P9AzHFLWWJ
         JPfmfMrFgC1mPIDXTMnoNpL6bkbh3WhVTrIWbJeeSHMxvPvnUvGQFvoAhW5/Siog10hH
         JGsooUN9IoLrNMT+wSxyLt/nnhUuDXkVYG8VdW0VG+Jkyt6sHO1fRWIcnlN8xelKe77q
         BauUVTe/iLS+1nPrqo4G/y0AqCo/ikepRiC43fgOPBtw3AyZys6Spr4ROWz9Ukvw9K0a
         462JKRtCp17KU2GVH5Pkvc3/F1YUowm9oCWGCj8h++x/M6XQn9/QxKbDRp1wbe3MBHWs
         kJGg==
X-Gm-Message-State: APjAAAWeNk4ad9NqRaLL+h6iH4nSGSQ1YdyKlEl3lrzJZzVEEc991d7B
        kOdu0It6EQZOFeT4TgatbHw=
X-Google-Smtp-Source: APXvYqwyBuNImL6II3iSdnqF38gm3jWr1P8PK6zfv1Kspi7e42qa7c13fQmqcgmB1TC159zxo8IFqg==
X-Received: by 2002:a05:6a00:2a3:: with SMTP id q3mr360552pfs.230.1580315374255;
        Wed, 29 Jan 2020 08:29:34 -0800 (PST)
Received: from localhost.localdomain (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id m3sm3299686pgp.32.2020.01.29.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:29:33 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] x86/boot: fix kaslr-enabled build
Date:   Thu, 30 Jan 2020 01:29:26 +0900
Message-Id: <20200129162926.1006-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both pgtable_64 and kaslr_64 define `__force_order', which breaks
the build:

ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order';
arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here

Make KASLR use extern pgtable_64's definition.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/x86/boot/compressed/kaslr_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 748456c365f4..274df8f9e659 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -30,7 +30,7 @@
 #include "../../mm/ident_map.c"
 
 /* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
+extern unsigned long __force_order;
 
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
-- 
2.25.0

