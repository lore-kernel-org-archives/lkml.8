Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6FC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271907;
	bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alfzY0G6gmzZAABeclqPnivPndZJjPWmlay3tIcxbmAWH52Hpc0cYQ43vcD6oDqnA
	 GxlwqAXKu5N1QeSiqi0Co7OvWiB/NlD0tMRhMfulHZkVnUp6hTXjrDj3sGKWUXhe5l
	 x8sVbhdk3PEZLNvn2+F5VHTmaxBNn+Ti1jdvQMlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgBUH60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbgBUH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:58:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09842465D;
        Fri, 21 Feb 2020 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271902;
        bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ8Pjgv7FEhqNu57O1hkFDlounQg1b2IMP+gDTsX2pZALhMRipLBmCIUTEo7GiY/n
         lyw5RCHbctCue8MJPHh8+sLg6PZqUcLmZVLWSVwLdyBaxaptx7LabWteYc0q7A1Teq
         K1NKUM0byEpwMPXyG2lhUrAGs0qDb8qDKrQqj4ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 341/399] powerpc/pseries/lparcfg: Fix display of Maximum Memory
Date:   Fri, 21 Feb 2020 08:41:06 +0100
Message-Id: <20200221072434.013134363@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
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



