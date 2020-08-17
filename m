Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA0D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690310;
	bh=YjfSUPal4nQVgLYdU8tmjzxp1u/sjv9OzIFU/D3XKvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aodvDOvJSwNg1NRsLOEm6szrQaFadEEdWM/EGdLubhGvWm7fByCGE3yA610pFzh/y
	 l30w/689QROdL77wOG2E/jbc47G/CTVbUq9/2/Qu+xuyQ5KC0DZdp5bV1PO+g4huxJ
	 CCF/MSo+ETdNbQED29tqeT0FAzGI8U4xVjGOEMxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391762AbgHQSvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387639AbgHQPwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1A82072E;
        Mon, 17 Aug 2020 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679570;
        bh=YjfSUPal4nQVgLYdU8tmjzxp1u/sjv9OzIFU/D3XKvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYQWmS1A84ww9nEI+fIlqAt8yGxVakvjHRR0YuHhTSozgOfSy/oPammS9oLVkCvOX
         2OQ/JR/LlH+LkckdrgrHQAnMuLiS+sqOAvtnkcVoOZAsYvluylcWsVp9om2HuKmneo
         wfIHgD+rgAa9mQ8rNUPwN3qNx6TLFrE0+CGKoGZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 219/393] powerpc/book3s64/pkeys: Use PVR check instead of cpu feature
Date:   Mon, 17 Aug 2020 17:14:29 +0200
Message-Id: <20200817143830.247271431@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

[ Upstream commit d79e7a5f26f1d179cbb915a8bf2469b6d7431c29 ]

We are wrongly using CPU_FTRS_POWER8 to check for P8 support. Instead, we should
use PVR value. Now considering we are using CPU_FTRS_POWER8, that
implies we returned true for P9 with older firmware. Keep the same behavior
by checking for P9 PVR value.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200709032946.881753-2-aneesh.kumar@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/pkeys.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index 268ce9581676a..fa237c8c161f7 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -83,13 +83,17 @@ static int pkey_initialize(void)
 	scan_pkey_feature();
 
 	/*
-	 * Let's assume 32 pkeys on P8 bare metal, if its not defined by device
-	 * tree. We make this exception since skiboot forgot to expose this
-	 * property on power8.
+	 * Let's assume 32 pkeys on P8/P9 bare metal, if its not defined by device
+	 * tree. We make this exception since some version of skiboot forgot to
+	 * expose this property on power8/9.
 	 */
-	if (!pkeys_devtree_defined && !firmware_has_feature(FW_FEATURE_LPAR) &&
-			cpu_has_feature(CPU_FTRS_POWER8))
-		pkeys_total = 32;
+	if (!pkeys_devtree_defined && !firmware_has_feature(FW_FEATURE_LPAR)) {
+		unsigned long pvr = mfspr(SPRN_PVR);
+
+		if (PVR_VER(pvr) == PVR_POWER8 || PVR_VER(pvr) == PVR_POWER8E ||
+		    PVR_VER(pvr) == PVR_POWER8NVL || PVR_VER(pvr) == PVR_POWER9)
+			pkeys_total = 32;
+	}
 
 	/*
 	 * Adjust the upper limit, based on the number of bits supported by
-- 
2.25.1



