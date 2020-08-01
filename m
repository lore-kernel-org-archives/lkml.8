Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8842087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596244512;
	bh=GIYWipI/QvIPQg5KsKE2fSSSDx7ZhbpnX0QsvkF7nt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lEl30XqSUf3oV74tJJFoU2T8AV9UAzx9LPWDcs15fQYYWpflourFQT6T4tc8qfZw
	 L5gbxOYyHmVqTNQmCiFC1LSma5/sNvTIl6exn/xnC5fU+UmLPPOrEF3v3BI6jeLBiA
	 lJD1Mgq5Qy/mh6k9oUL9V3S3apfHTjmZC8TiQAqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHABPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgHABO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:56 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E816421744;
        Sat,  1 Aug 2020 01:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244496;
        bh=GIYWipI/QvIPQg5KsKE2fSSSDx7ZhbpnX0QsvkF7nt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3Jvmub/Xi7Chd2GWhbTshKJHCmyuAjYR6whFbr2+S8qoJEyXsT+YTzMn5g18iaKV
         U+biR7w3PPLSxs8DPXKk2YaLJLd6ThpNR+AwU3O26bjw9cIadVvcHzAxU0UBqQGCKR
         +ZlnrRfYMTUmprO2SZNWbpshyktk6Aa4+Ux17TgA=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 10/13] csky: Fixup warning by EXPORT_SYMBOL(kmap)
Date:   Sat,  1 Aug 2020 01:14:10 +0000
Message-Id: <1596244453-98575-11-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This a wrong code, and no kmap symbol for export.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/highmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 89ec32e..89c1080 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -19,8 +19,6 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
-EXPORT_SYMBOL(kmap);
-
 void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
 {
 	unsigned long vaddr;
-- 
2.7.4

