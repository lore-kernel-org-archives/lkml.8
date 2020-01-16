Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF602073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217386;
	bh=crauBlMyJ9CkIEHb5/hCZFFpb1CH0hpS+gwPv5Gr3lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcQpkA1V/7sq4JVhw8cDbntx3RIalNBBu2Rx3j+2KrC9LhCLeolk1IoZCHHV8QoiL
	 8z3yNzqTyOfZ33awfBYumA+1VsW/ecbOn+jfOZC71hdIQnODUqTaxd2xxJbl9o7MoM
	 2Pb7tfVKZHa9YydYFHPE5OQhD/CYUA1lfKOmDkUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbgAPX3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391316AbgAPX3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2B1206D9;
        Thu, 16 Jan 2020 23:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217378;
        bh=crauBlMyJ9CkIEHb5/hCZFFpb1CH0hpS+gwPv5Gr3lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4jQC7noFSc2qlUBmkCTGf009d/e9Gc60MBdz+tzARRKNP7UZvqUsatNW+lNtpDnW
         eoXEgRPv55+7YpB0dl6G10OpmRMKB16+QOEpc55M4HqifZTnMn+x3NJ+xFyo4l5rVB
         SzCxNB+ev1k07vNXARJNpR2hf1/5CW9p+2q1VsYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.19 32/84] drm/ttm: fix start page for huge page check in ttm_put_pages()
Date:   Fri, 17 Jan 2020 00:18:06 +0100
Message-Id: <20200116231717.499584577@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

commit ac1e516d5a4c56bf0cb4a3dfc0672f689131cfd4 upstream.

The first page entry is always the same with itself.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_page_alloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -732,7 +732,7 @@ static void ttm_put_pages(struct page **
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			if (!(flags & TTM_PAGE_FLAG_DMA32) &&
 			    (npages - i) >= HPAGE_PMD_NR) {
-				for (j = 0; j < HPAGE_PMD_NR; ++j)
+				for (j = 1; j < HPAGE_PMD_NR; ++j)
 					if (p++ != pages[i + j])
 					    break;
 
@@ -767,7 +767,7 @@ static void ttm_put_pages(struct page **
 			if (!p)
 				break;
 
-			for (j = 0; j < HPAGE_PMD_NR; ++j)
+			for (j = 1; j < HPAGE_PMD_NR; ++j)
 				if (p++ != pages[i + j])
 				    break;
 


