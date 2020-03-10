Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B34C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2AA2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847043;
	bh=vGUOX+Fc8v/Nw6WwDblSI4csNM6cyIMB9lzoBuNt5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBR41lQAYh2gTQqVWKYVsQVjpcfAeNyKbQ5eMjMphDvoSZkyvUgl+xKszCzWYKfXY
	 ZBVXRZvEYGZel3Lu1Ag8+yI8VVhSWjIw71x9GRbT6xS8ISL1KyRll3iUjtUM4e17Cs
	 5FxZe/lOQc/HNd9SbHAdFY3DGeYE2jPe2u152X/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgCJMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgCJMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0227D2468D;
        Tue, 10 Mar 2020 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844615;
        bh=vGUOX+Fc8v/Nw6WwDblSI4csNM6cyIMB9lzoBuNt5d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOq8FC5ycT6d26VrbVhRk1hbfnOASlzK9SVmm5wWJ89XDZBROzdN4RMalae4zgthu
         ouCDHMQEC6gybpTAFZHgqDfKb4NRnqzIZKPwxj5D0S/QJhWcCRsypVCmU3OezCCK6e
         bpLczaQ9xmveRNkutdTwX+Y/GAj+ElEi7QmHm6lM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 055/168] arch/csky: fix some Kconfig typos
Date:   Tue, 10 Mar 2020 13:38:21 +0100
Message-Id: <20200310123640.919950800@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit bebd26ab623616728d6e72b5c74a47bfff5287d8 ]

Fix wording in help text for the CPU_HAS_LDSTEX symbol.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847b5f42e..25de20e526e50 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -74,7 +74,7 @@ config CPU_HAS_TLBI
 config CPU_HAS_LDSTEX
 	bool
 	help
-	  For SMP, CPU needs "ldex&stex" instrcutions to atomic operations.
+	  For SMP, CPU needs "ldex&stex" instructions for atomic operations.
 
 config CPU_NEED_TLBSYNC
 	bool
-- 
2.20.1



