Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEFC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFDF2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552105;
	bh=JqfIlilzAtnYw9GMvTatNQzCJGbLyz2Z0an4/12Cf7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3j2wzYCV95sG81nDYmx/pvhITMtK5gd0uM6zsRlQh5avu0ZM5SPxoOiKzuqaXZHy
	 5YKNYbPkhD+6kGQcWvkwDnEByRhmLuHLtPagbYBSRclBZ1Z9ti0L9uon9Y2hKoHefz
	 3gmso2VEAT7DfQcv/W21+/UlMYRAouPhoCKCaXaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgDVKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgDVKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:20:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D65092070B;
        Wed, 22 Apr 2020 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550810;
        bh=JqfIlilzAtnYw9GMvTatNQzCJGbLyz2Z0an4/12Cf7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S149Y/beqSN6kNU/w3/nqG8+hYWFoUe6Q6k0OPniNhjokxENuVk+f5Upb+w0L7eA1
         oOViojjHTy2D5HiU3p0ua/9yFVyMsCkxpnbOnhRdqqKPa3f53/Ces9wL88EQOxOUz/
         aqlBJFimFXMvlmJx7v9FJ3J3gJ6nZc3LRsyJYGqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5.4 102/118] dma-debug: fix displaying of dma allocation type
Date:   Wed, 22 Apr 2020 11:57:43 +0200
Message-Id: <20200422095047.991429728@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 9bb50ed7470944238ec8e30a94ef096caf9056ee upstream.

The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
type2name string table. This causes incorrect displaying of dma allocation
type.
Fix it by removing "page" string from type2name string table and switch to
use named initializers.

Before (dma_alloc_coherent()):
k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

After:
k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable

Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/dma/debug.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -137,9 +137,12 @@ static const char *const maperr2str[] =
 	[MAP_ERR_CHECKED] = "dma map error checked",
 };
 
-static const char *type2name[5] = { "single", "page",
-				    "scather-gather", "coherent",
-				    "resource" };
+static const char *type2name[] = {
+	[dma_debug_single] = "single",
+	[dma_debug_sg] = "scather-gather",
+	[dma_debug_coherent] = "coherent",
+	[dma_debug_resource] = "resource",
+};
 
 static const char *dir2name[4] = { "DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
 				   "DMA_FROM_DEVICE", "DMA_NONE" };


