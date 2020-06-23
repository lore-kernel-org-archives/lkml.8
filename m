Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7432C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E4120702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943335;
	bh=ZsOgunims3nAYF2Zt2Dmo9cIXJpNt3SwF1rdQ7HNPVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MvCkKOv2cIcZlMSys1PLscAmLFEh2k+TD0cWCfgiGDES7aPfvHVLLV2BhyK/xZ8bV
	 sweAJyAnAKJHo994Xk5cI348EFOS7pKhtiKQ6VT9XKitOnUK/eWp3ZQLtTD6Go8xYB
	 VvkXkcVbJ2om6nYFJachsaolPYS9/ZZrY3RIQTNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbgFWUPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388588AbgFWUP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B0220E65;
        Tue, 23 Jun 2020 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943326;
        bh=ZsOgunims3nAYF2Zt2Dmo9cIXJpNt3SwF1rdQ7HNPVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVlq7bREkq5v9g/oZYROycd175eYxRTYLXM26GwgQuX/f13joNn9H9V3k0TI1Uq9U
         pRaz6GlbspXc2ck44ZtJlC4mLj/6BS4O8c16UCHitt6klleDWOg/mf3nh0357REcuh
         P5bVo9fm7JCIGk4/5tPEVN1ulY4PppTv8VULAXco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 349/477] arm64: ftrace: Change CONFIG_FTRACE_WITH_REGS to CONFIG_DYNAMIC_FTRACE_WITH_REGS
Date:   Tue, 23 Jun 2020 21:55:46 +0200
Message-Id: <20200623195424.035904417@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

[ Upstream commit 91970bef48d68d06b2bb3f464b572ad50941f6a9 ]

CONFIG_FTRACE_WITH_REGS does not exist as a Kconfig symbol.

Fixes: 3b23e4991fb6 ("arm64: implement ftrace with regs")
Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/b9b27f2233bd1fa31d72ff937beefdae0e2104e5.camel@perches.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 8618faa82e6d2..86a5cf9bc19a1 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -69,7 +69,8 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 
 	if (addr == FTRACE_ADDR)
 		return &plt[FTRACE_PLT_IDX];
-	if (addr == FTRACE_REGS_ADDR && IS_ENABLED(CONFIG_FTRACE_WITH_REGS))
+	if (addr == FTRACE_REGS_ADDR &&
+	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
 		return &plt[FTRACE_REGS_PLT_IDX];
 #endif
 	return NULL;
-- 
2.25.1



