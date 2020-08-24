Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2091C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F8D22B43
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258253;
	bh=wmsXOHB3I553rPukhSo64W5A/2l1xab5G6GT+DI8iYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=glqgE5SplXWEGb76NI2gU4GHv6GbKNzh3o0nc31miPKtet7oDm86LR+65MGzV9vFe
	 R4XAM0bj3FfyTMOQV2ynyQht6/kdj+rOPgFFv+/C7u14upkNeu2UlPg9dtG1/RogWB
	 Zg+7xcCr19qGLHBiCGdmi0mBHnf0yZ2Lj5PnP6SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHXIhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgHXIh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F47207DF;
        Mon, 24 Aug 2020 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258246;
        bh=wmsXOHB3I553rPukhSo64W5A/2l1xab5G6GT+DI8iYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejLFyxFnVez3K2a4VRhvJi5c7JCtUTLXR2OBWGHyIK8E8QsU0vfZSTxeDANBMrBCf
         tn8XZoTa7OD4Dwq6TlBXlu1alxJM3GiSsJTXuNO1evpdtG3eY495NXe+PVutjAiBBP
         yh6jV+pBy4SQW9uMrGTf4bkSRdwfbln6Z+vN84B0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 129/148] powerpc/fixmap: Fix the size of the early debug area
Date:   Mon, 24 Aug 2020 10:30:27 +0200
Message-Id: <20200824082420.195347477@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
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
index 925cf89cbf4ba..6bfc87915d5db 100644
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



