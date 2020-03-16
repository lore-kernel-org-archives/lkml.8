Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93C7C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB50205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FJzh8th/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgCPMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37771 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731079AbgCPMf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkt4J4hz9tygr;
        Mon, 16 Mar 2020 13:35:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=FJzh8th/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GMjIff4u6kXW; Mon, 16 Mar 2020 13:35:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkt3GnDz9tyg5;
        Mon, 16 Mar 2020 13:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362150; bh=e+HaGRwJA4h1ZHHXQXo2FxuOxEHgrouWi93xpDPcAQ4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=FJzh8th/kQwomINA2rAb5azdSOxpiN3RYxSnOk92vK4bIZvutaMyY5XVL7XOj+cvD
         kZF0KBAuJ8Ki0Xx6XLP7sl2CC6K2jQvnz3iRS8zVmA6GzMv4+i4DPk5EOf3Iat04/R
         OVD4YlBUu0eq9MABQ8IC7xJrmQPLRCb5I03nCBpU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BFAA8B7D0;
        Mon, 16 Mar 2020 13:35:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fmTFYGXM8RnJ; Mon, 16 Mar 2020 13:35:55 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C7948B7CB;
        Mon, 16 Mar 2020 13:35:55 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4162665595; Mon, 16 Mar 2020 12:35:55 +0000 (UTC)
Message-Id: <4f0be21691f2d8d02efb63766f0a548375efecd2.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 10/46] powerpc/ptdump: Add _PAGE_COHERENT flag
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms using shared.c (4xx, Book3e, Book3s/32),
also handle the _PAGE_COHERENT flag with corresponds to the
M bit of the WIMG flags.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ptdump/shared.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
index dab5d8028a9b..634b83aa3487 100644
--- a/arch/powerpc/mm/ptdump/shared.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -40,6 +40,11 @@ static const struct flag_info flag_array[] = {
 		.val	= _PAGE_NO_CACHE,
 		.set	= "i",
 		.clear	= " ",
+	}, {
+		.mask	= _PAGE_COHERENT,
+		.val	= _PAGE_COHERENT,
+		.set	= "m",
+		.clear	= " ",
 	}, {
 		.mask	= _PAGE_GUARDED,
 		.val	= _PAGE_GUARDED,
-- 
2.25.0

