Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE026C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDA8207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860331;
	bh=J25/JXUK4b6mmR7U9r7A6ToZsorSLCfD4+2z74cq+Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbZq7P4moP6hzTC4GubsaKEAdSOc89gc3E+eQA3uSfRoQ+jxlU4AhDnGrHnqaRtwf
	 AC/K9e4zYeBn6Tj5D0X8oeLlDomz+KqYTjnxOTysDebXAJK14MensRW3cmwiHLUauX
	 LRcbhDSPJmKXbkz7KsQyLI+Mf8hHK13yozBDyL+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbgG0OcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbgG0OTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:19:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72BD2075A;
        Mon, 27 Jul 2020 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859582;
        bh=J25/JXUK4b6mmR7U9r7A6ToZsorSLCfD4+2z74cq+Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXhYUJB8prtmZ4POyXczz6ACTXrIVD0jzC7PG9Lp/J8AIAd+7W79YJpDtP52pr91c
         RHDt6/NQhxWDY/Nu/PDn8iHNkE67T19mCZhn4jyUEGFLdGPgGb5OLoj+2TbPterdTs
         l2kvz1nBY70hKK8xO6cFJO4M8zYA+GJrbJxo1HxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 5.7 027/179] exfat: fix overflow issue in exfat_cluster_to_sector()
Date:   Mon, 27 Jul 2020 16:03:22 +0200
Message-Id: <20200727134933.991795930@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

commit 43946b70494beefe40ec1b2ba4744c0f294d7736 upstream.

An overflow issue can occur while calculating sector in
exfat_cluster_to_sector(). It needs to cast clus's type to sector_t
before left shifting.

Fixes: 1acf1a564b60 ("exfat: add in-memory and on-disk structures and headers")
Cc: stable@vger.kernel.org # v5.7
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exfat/exfat_fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -375,7 +375,7 @@ static inline bool exfat_is_last_sector_
 static inline sector_t exfat_cluster_to_sector(struct exfat_sb_info *sbi,
 		unsigned int clus)
 {
-	return ((clus - EXFAT_RESERVED_CLUSTERS) << sbi->sect_per_clus_bits) +
+	return ((sector_t)(clus - EXFAT_RESERVED_CLUSTERS) << sbi->sect_per_clus_bits) +
 		sbi->data_start_sector;
 }
 


