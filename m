Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A65C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8020738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262254;
	bh=/DMNXdWyR44RKoBGbBNhca/NOo7MsflkjKpNszxYWNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZyLHIhHG1gKfxTIWJahD/RZG0BamAvwlMzf3QnSSAToeRsjTL5keipXdWCuFmPqf9
	 8e/xwjPD7DS0+8f/7e+7mBl4QSScmJyDOnQ3DWgnZXL1dTG2JlyTwfImfvyZr3Nyp9
	 +AULFqqL5d0Mz2cfv5bVGWMI9lInzLKCFubB9eXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgHXJoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgHXInb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:43:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D2F2087D;
        Mon, 24 Aug 2020 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258610;
        bh=/DMNXdWyR44RKoBGbBNhca/NOo7MsflkjKpNszxYWNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM/8/7e8z26W8wqDEAD6Tbeb+GoKU90CEeScQiANPbCgHg1mXNQndirvVn6g1v1nI
         C9eLYRVNq/U9Q/X5Ns5UztvKx5roM8pOQGxvxFVD01bGhH8BWH8VMklsiaDqlH7JFj
         Gj2d4M3aLuOFO0mNt50oPZ4Mu1oTxrKvo2Cze/zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 108/124] powerpc/fixmap: Fix the size of the early debug area
Date:   Mon, 24 Aug 2020 10:30:42 +0200
Message-Id: <20200824082414.719735807@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit fdc6edbb31fba76fd25d7bd016b675a92908d81e ]

Commit ("03fd42d458fb powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when
page size is 256k") reworked the setup of the early debug area and
mistakenly replaced 128 * 1024 by SZ_128.

Change to SZ_128K to restore the original 128 kbytes size of the area.

Fixes: 03fd42d458fb ("powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/996184974d674ff984643778cf1cdd7fe58cc065.1597644194.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 77ab25a199740..e808461e6532e 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -52,7 +52,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 	/* reserve the top 128K for early debugging purposes */
 	FIX_EARLY_DEBUG_TOP = FIX_HOLE,
-	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128, PAGE_SIZE)/PAGE_SIZE)-1,
+	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128K, PAGE_SIZE)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
-- 
2.25.1



