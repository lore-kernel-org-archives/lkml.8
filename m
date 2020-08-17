Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C635C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C5820674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693049;
	bh=NQ9HpT42qKnDEik0gl+C4Tbq0zOJHb+Ya1GpxXLw+DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zf4DChU/t8ZEDI0psvn2PaZUupFj+GeQ8MwJQRdank9a4zEFzRMrMwlocWsdUNjdn
	 H+CzdK0dDTeyOoJg/bztXqwQragKlQsxrLcb07vjH8I9hY1irBKZ/QLbwhan9TpInd
	 6J4RPobxo0FKgyIrcKTplhD6YqsilETdhfCouRLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgHQP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgHQPZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:25:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2C92053B;
        Mon, 17 Aug 2020 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677950;
        bh=NQ9HpT42qKnDEik0gl+C4Tbq0zOJHb+Ya1GpxXLw+DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVN30oDMov0djttFgHFSCXQf0bZVtGDADzWbGfptx2C+/5oy+lF6z8aj85T29ShaU
         flN5MAz3P7jOAc1Iub+2MzJz2ofH7XXeagAmzpOZNc1oTY3Z5uvU1wrten2EU6oGbM
         ohOa390HfB4WpGJMJuUtSwEt22XiLr/lnC92lE0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 167/464] powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k
Date:   Mon, 17 Aug 2020 17:12:00 +0200
Message-Id: <20200817143841.816014420@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 03fd42d458fb9cb69e712600bd69ff77ff3a45a8 ]

FIX_EARLY_DEBUG_BASE reserves a 128k area for debuging.

When page size is 256k, the calculation results in a 0 number of
pages, leading to the following failure:

  CC      arch/powerpc/kernel/asm-offsets.s
In file included from ./arch/powerpc/include/asm/nohash/32/pgtable.h:77:0,
                 from ./arch/powerpc/include/asm/nohash/pgtable.h:8,
                 from ./arch/powerpc/include/asm/pgtable.h:20,
                 from ./include/linux/pgtable.h:6,
                 from ./arch/powerpc/include/asm/kup.h:42,
                 from ./arch/powerpc/include/asm/uaccess.h:9,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/crypto.h:21,
                 from ./include/crypto/hash.h:11,
                 from ./include/linux/uio.h:10,
                 from ./include/linux/socket.h:8,
                 from ./include/linux/compat.h:15,
                 from arch/powerpc/kernel/asm-offsets.c:14:
./arch/powerpc/include/asm/fixmap.h:75:2: error: overflow in enumeration values
  __end_of_permanent_fixed_addresses,
  ^
make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1

Ensure the debug area is at least one page.

Fixes: b8e8efaa8639 ("powerpc: reserve fixmap entries for early debug")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/ca8c9f8249f523b1fab873e67b81b11989d46553.1592207216.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 29188810ba302..925cf89cbf4ba 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -52,7 +52,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 	/* reserve the top 128K for early debugging purposes */
 	FIX_EARLY_DEBUG_TOP = FIX_HOLE,
-	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+((128*1024)/PAGE_SIZE)-1,
+	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128, PAGE_SIZE)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
-- 
2.25.1



