Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FEC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642F520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nL0vDzjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:55:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lOcI8Zi5LeCS1BdPtCo3QiVZNBZ3qarrO9TcCKZ8aHM=; b=nL0vDzjEYZK5OP88hU8GYks/ZA
        U9h2djz9jcEw6F2yN5Esibv1M3xw8GMa7BJ0ntttsELSI2MDL3C6VuUZdIsCG5x1zl+km3LiQieBV
        nM6TRqhHqjjXTSZVkm/r4U96npvYKMjlHiLn4BGGTlmDvmwGxg31u/YgeGFh9Siit0vEy8tyoYwLo
        W1k7YaBWhIUK3FDtMvYCIGKjwPGNtwq6ustnr8Xs58CRPgZ0rH8Ziauwy/zm5pMKoyjTjT8HwrD3K
        j4eu0yLVlYiRKUTMcqtuMNq/e/dPgwLl+4+cssysqVUupmPVucSq3LnRjuDBw0Zc7N0nczwawTXca
        QYf8BnHQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHXfE-0001UR-Oe; Thu, 26 Mar 2020 18:55:36 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     Zzy Wysm <zzy@zzywysm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: jump_label.c: fix gcc inline keyword placement warning
Message-ID: <078747e1-863f-617a-bcdf-ea9432b19c6f@infradead.org>
Date:   Thu, 26 Mar 2020 11:55:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix gcc warning when -Wextra is used by moving the keyword:

../arch/x86/kernel/jump_label.c:61:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static void inline __jump_label_transform(struct jump_entry *entry,
 ^~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
@Zzy: do you want a Reported-by: line in the patch?

Reported-by: Zzy Wysm <zzy@zzywysm.com>

 arch/x86/kernel/jump_label.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200326.orig/arch/x86/kernel/jump_label.c
+++ linux-next-20200326/arch/x86/kernel/jump_label.c
@@ -58,7 +58,7 @@ __jump_label_set_jump_code(struct jump_e
 	return code;
 }
 
-static void inline __jump_label_transform(struct jump_entry *entry,
+static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {

