Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A05C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E820578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273846;
	bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b/CVs7dIc5nA3wZIXof/R/Kqjd+Usd62XFz/HQUG4LqRzWyIke0t4CaCe2pCnll0G
	 +7H8yYfFbgBNQ5DgXAg/OUY6LP0fSipU7JZzVVyghePwkC6RWvig5cAOF683020Zyr
	 y0E/g0s4l81JkujE/M1bc4QTAt4FscDPr+n6G/Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgBUIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgBUIPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:15:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A0B2467B;
        Fri, 21 Feb 2020 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272937;
        bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaaPCfRoFfUN+62z89gSFXNzwY2K9qzJBy03nUQcI7b8brV9tG/9cOuPwqkTTOaIX
         F6dCDV5lG/eNgk1cAWDDI5A58ZejUA1g3aGIMuqngraY2Bf2DgpOPJBjR2tC3Kxq9L
         PBc4Gx7jURUBqqRXainZWZqwy/8PARM7L/HpP5uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 295/344] powerpc/pseries/lparcfg: Fix display of Maximum Memory
Date:   Fri, 21 Feb 2020 08:41:34 +0100
Message-Id: <20200221072416.668300071@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Bringmann <mwb@linux.ibm.com>

[ Upstream commit f1dbc1c5c70d0d4c60b5d467ba941fba167c12f6 ]

Correct overflow problem in calculation and display of Maximum Memory
value to syscfg.

Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
[mpe: Only n_lmbs needs casting to unsigned long]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index e33e8bc4b69bd..38c306551f76b 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -435,10 +435,10 @@ static void maxmem_data(struct seq_file *m)
 {
 	unsigned long maxmem = 0;
 
-	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
+	maxmem += (unsigned long)drmem_info->n_lmbs * drmem_info->lmb_size;
 	maxmem += hugetlb_total_pages() * PAGE_SIZE;
 
-	seq_printf(m, "MaxMem=%ld\n", maxmem);
+	seq_printf(m, "MaxMem=%lu\n", maxmem);
 }
 
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
-- 
2.20.1



