Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12F0C33CB2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDDB2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q30T6ANA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBABzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 20:55:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgBABzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1PKGGrJbH+yDuKFV2kginutGKJI4kg35LvNPD/VL3Mc=; b=q30T6ANAPJJ1W8IMvG1LTwEZc
        jhMQUwJ6wAyOGARcu5yOMa/ttVmD8ACirDDqzoJ9O3/sqew6Lkf6GIirmH8w+JKWU1GHE/llWElGw
        FYIQ1y6ljJVsfn6rMjBIMvSGKoAUExx0bCpbW+fI+b25ZHoem+GWmI6T3gFpK878pWnnYgsgIAQ10
        RziY73nq7KRHkNAX7f9po79Pw9EmZPoOTd8m6jffIJfFIeLpA4zsKtgm827jkmUkMsxMmv5J5sK7z
        wbkYFKvX6q+W6+OKKWfy7iW7dNuZtHNa9hIDswdBu76VvOWJ6P7n57iMeYQbZrWOkAluvrD8FD1ao
        jAmrcS6Lw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixi0e-0007DO-Kc; Sat, 01 Feb 2020 01:55:44 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/mips: change duplicated word in NUMA help text
Message-ID: <8e127f9a-6c73-e0f5-4fb5-f3ab3656221f@infradead.org>
Date:   Fri, 31 Jan 2020 17:55:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix wording in NUMA help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/mips/Kconfig
+++ linux-next-20200131/arch/mips/Kconfig
@@ -2676,7 +2676,7 @@ config NUMA
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option improves performance on systems with more
 	  than two nodes; on two node systems it is generally better to
-	  leave it disabled; on single node systems disable this option
+	  leave it disabled; on single node systems leave this option
 	  disabled.
 
 config SYS_SUPPORTS_NUMA

