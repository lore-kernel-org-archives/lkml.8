Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7564C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE24246D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203638;
	bh=w4Vph8L0Job0JGTl/V9A4ULdLn1PgStBJDbEJ0KONhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHdVwF7A+bNfkobq5EjN9tZlamiWPbMyWfGQLdr1lpe1o0bh/XETZ3UOJFDowU7z6
	 jkVptpBYMhGqEqk/8FDG9FCoODYSzxy1Bk4CbpRAPNgYKb06vfd4lXRf/zYMACyZa0
	 PuTKy9PAl+9QhSNQrX2Kft+ubTJ+/8eivffhuzN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCCCrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgCCCrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ADC246D5;
        Tue,  3 Mar 2020 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203634;
        bh=w4Vph8L0Job0JGTl/V9A4ULdLn1PgStBJDbEJ0KONhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYlVZbSFxDFVDYVQbW2GDEhuuZg2vHPXgWrTUVZCf2o1agGbe3LZB19/y7AJz+kFC
         ouVyMVOdIRGOimAntxGiG4Cgg9QkrjpROVeEpxvEbEphS+vdVK9Tqwla92G7ku2pD8
         lmoSvHyZAoHQvCQP1iyieMnM1Gxl/1Kzt3jAK03c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 47/66] x86/boot/compressed: Don't declare __force_order in kaslr_64.c
Date:   Mon,  2 Mar 2020 21:45:56 -0500
Message-Id: <20200303024615.8889-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

[ Upstream commit df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc ]

GCC 10 changed the default to -fno-common, which leads to

    LD      arch/x86/boot/compressed/vmlinux
  ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; \
    arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
  make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1

Since __force_order is already provided in pgtable_64.c, there is no
need to declare __force_order in kaslr_64.c.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200124181811.4780-1-hjl.tools@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/kaslr_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 748456c365f46..9557c5a15b91e 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -29,9 +29,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-/* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
-
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
 	unsigned char *pgt_buf;
-- 
2.20.1

