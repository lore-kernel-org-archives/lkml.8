Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCAFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0171A208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519362;
	bh=n8JzTrgt8/GRTvq0YxeCtfXMInbGbWxSeb5qkncRORI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hd7dHvbMVYuyBbTvbvsNFoAx5/OAn009zY3OCnVfaPiCiXti9GSyhROPaZdp8IbDW
	 DGtefUZu5TxfhUs2E9/OoY0d936XWkUjOGVjHp+uiMmLvW5U8zF/j01T3aN1Zls7Yy
	 BGVG9LTbvOfrECotp8uyHwJBtRKe7b7hT/Y1ZSFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbgEZS4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389656AbgEZSzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5BB2086A;
        Tue, 26 May 2020 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519350;
        bh=n8JzTrgt8/GRTvq0YxeCtfXMInbGbWxSeb5qkncRORI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwTWq3tatA17Ap5lbjuRcRSPb5UByjSEUGhObHAWojI+yYlSTCWSdy7lBVf38lZHW
         CpYh3EsRvY6ruYd8nCQEjXAo8BT/NyoKtDMsJryRLauqL0dNLf1Jpx9Fb9MPMsHqLf
         qD3tEeQcb7WcdsV8R3t1ldgJgE03tr3Eb6UtXd5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 33/65] libnvdimm/btt: Remove unnecessary code in btt_freelist_init
Date:   Tue, 26 May 2020 20:52:52 +0200
Message-Id: <20200526183917.991691326@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishal Verma <vishal.l.verma@intel.com>

[ Upstream commit 2f8c9011151337d0bc106693f272f9bddbccfab2 ]

We call btt_log_read() twice, once to get the 'old' log entry, and again
to get the 'new' entry. However, we have no use for the 'old' entry, so
remove it.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/btt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 957234272ef7..727eaf203463 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -443,9 +443,9 @@ static int btt_log_init(struct arena_info *arena)
 
 static int btt_freelist_init(struct arena_info *arena)
 {
-	int old, new, ret;
+	int new, ret;
 	u32 i, map_entry;
-	struct log_entry log_new, log_old;
+	struct log_entry log_new;
 
 	arena->freelist = kcalloc(arena->nfree, sizeof(struct free_entry),
 					GFP_KERNEL);
@@ -453,10 +453,6 @@ static int btt_freelist_init(struct arena_info *arena)
 		return -ENOMEM;
 
 	for (i = 0; i < arena->nfree; i++) {
-		old = btt_log_read(arena, i, &log_old, LOG_OLD_ENT);
-		if (old < 0)
-			return old;
-
 		new = btt_log_read(arena, i, &log_new, LOG_NEW_ENT);
 		if (new < 0)
 			return new;
-- 
2.25.1



