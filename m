Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5178FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C1C20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363595;
	bh=pM95nrK/ZvH2xPCEa2KhKYz52Uj9sIGd6V9yKNOB8TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUkqIu4Lez2S+bXxKVZfODtL/WxIeDNwhSjIp2K5y5P5BeQ+1mhcGPZZrxKz7q+RJ
	 a1WFir9aeMDXy7FROCsT3D4UWj4S7XPbp68d8cgdawtDuwwkT9v2rVYUGEZG287ydk
	 yOktFCzAxc6c3APbNe0qeUObosaV4XhZ/hrThng8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbgEMJxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387900AbgEMJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD18C23128;
        Wed, 13 May 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363587;
        bh=pM95nrK/ZvH2xPCEa2KhKYz52Uj9sIGd6V9yKNOB8TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBiS0J71Pw/0aAoodOaVXkh2xZgTxy8jdLwasDLPRvyc6hxU5EGWItcc8gmtgnDr7
         cyH/PUoAZg2ZPIUl4e2225Hky50ex3Jo0gu1uoyy805a/ASkbx6LagD+3W4WZJLuq9
         CH32xvVRj2M1Ss0ZjasVbtxuZ25GdiuTSajfnmj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 044/118] bnxt_en: Return error when allocating zero size context memory.
Date:   Wed, 13 May 2020 11:44:23 +0200
Message-Id: <20200513094421.147790032@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit bbf211b1ecb891c7e0cc7888834504183fc8b534 ]

bnxt_alloc_ctx_pg_tbls() should return error when the memory size of the
context memory to set up is zero.  By returning success (0), the caller
may proceed normally and may crash later when it tries to set up the
memory.

Fixes: 08fe9d181606 ("bnxt_en: Add Level 2 context memory paging support.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6662,7 +6662,7 @@ static int bnxt_alloc_ctx_pg_tbls(struct
 	int rc;
 
 	if (!mem_size)
-		return 0;
+		return -EINVAL;
 
 	ctx_pg->nr_pages = DIV_ROUND_UP(mem_size, BNXT_PAGE_SIZE);
 	if (ctx_pg->nr_pages > MAX_CTX_TOTAL_PAGES) {


