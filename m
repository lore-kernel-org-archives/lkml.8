Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3821D2534F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 01:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU10kany"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgFVBtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFVBtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 21:49:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 18:49:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so656990qtr.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=milQbbNtg25HvJnw3aajH4rY+1fsRuhl2iPlB3gIymE=;
        b=TU10kanya/k3trxwUlM7nxKtLbvkz81e8+zhBICR8XKAZGIr5FYQQpGNmgeuTVAjoD
         uahZXscPiGlmVwRRGgC0GkmvKWJcdmER05VmCTNpm7Yve6uwxTkVgKLZUT+jdoujRJUY
         lWjrB9bFC3LL7lU7q0cQ489rI2EwV4XpuXDANb0btJdSZGIFRymmm57A50HX37mDdnV9
         3NOBgOZuJjU7No0tEpbHJl4YEjj7J7d34hY1ARkteRnICfELraLU+szuEy4FhJagK8Sy
         /Nm7B2i4TNbGfxVhIaTYo51wnOTxHJzFhDUPb5hB5N3KMavdqKyGYnwGea1F10LFFuex
         kdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=milQbbNtg25HvJnw3aajH4rY+1fsRuhl2iPlB3gIymE=;
        b=IICF2TEGSldVV3jIsnK3/PLq8c7pK9ydNSmlwwHlfl4CNpC/gkwE+9F10WBacrClYp
         XxkVeEQGFPyT+J/kjKSa2ed9EgttApcSKWwpj+Khmz5zor/liDKvYn60Z/V1XWID8QKy
         Jm3to6ZRzJPyvIsXW5KpffkInksZWKgj2FL+7kgEAjvmQlCPX9A4mP95WA1Td7wolJ8o
         HOnVS8lIKfrM43EDdRdLkZmCtkTBCq8TVAOL7cPoS0GLWvXV0BhE7Kk2iO0/zHCbNYl4
         UVx4so4tkvIr0o0QgC53vGnvaSVZoPVrvXOqokOBtMnCTYLx5rlYiOD1FhhrMVmiZkDb
         O1zw==
X-Gm-Message-State: AOAM533d3L3oX+RHYAZzl7fDzUhRGxMq1MGyRJ9HTaSK53eoCXaKdvgk
        DRS6qOoI6DQAvFBT6tu0ESM=
X-Google-Smtp-Source: ABdhPJz8Cygxb0Xs+/XHqadPniBVtTKuLafjoNIeSeT7MG3RdHzR07NKuPwJV/rWPtEEIjIb+Cn3KQ==
X-Received: by 2002:ac8:4507:: with SMTP id q7mr12849455qtn.142.1592790546288;
        Sun, 21 Jun 2020 18:49:06 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:c0e3:b26:d2d0:5003])
        by smtp.googlemail.com with ESMTPSA id b196sm3202312qkg.11.2020.06.21.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 18:49:05 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        linux-kernel@vger.kernel.org (open list:X86 MM)
Subject: [PATCH] [x86] overlap: cleanup redundant logic
Date:   Sun, 21 Jun 2020 21:48:33 -0400
Message-Id: <20200622014857.17829-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In overlap check, same expression is repeated twice.
Remove one of them.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 77e04304a2a7..7d44b4863ee5 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -388,8 +388,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
 		     unsigned long r2_start, unsigned long r2_end)
 {
-	return (r1_start <= r2_end && r1_end >= r2_start) ||
-		(r2_start <= r1_end && r2_end >= r1_start);
+	return (r1_start <= r2_end && r1_end >= r2_start);
 }
 
 #ifdef CONFIG_PCI_BIOS
-- 
2.17.1

