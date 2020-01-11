Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89263C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562B62087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738627;
	bh=0n66UfPxz7oqzcF6ms056/V0dxK9hYHMpt5J5n1dSuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VwkOUT+VgUxY/T7ysDSCnsGA7brhcIbSsZx0BvQyr0mm+gWHI6aQsIB22f2hnjhhd
	 YqaYWdcsLaBwEF6VfzHbwK5bnQQkQvcK3VL7brqQbq3L6du4S/+vZAW87dG8+iQjft
	 jyqqsV3mRX8mb5QWmuNKUxZOTORzfoYS6abh+n+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgAKKaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbgAKKaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:30:23 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4006720842;
        Sat, 11 Jan 2020 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738621;
        bh=0n66UfPxz7oqzcF6ms056/V0dxK9hYHMpt5J5n1dSuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QZLBezlhNQ8vRguVIq4RxQ5yvBAsyRv9i1T5bsKPe6VoU3A0VGKwbaeAW0teNavs
         WIeYx+Ad8Ub7ZrIhgEglwULNDnvvRXVJt1N5KfCiCUXSWRbvqRAslZloTOhyKmMhFV
         ElFdyT0qSNTClkhA9Z8HZqWi9DxgISOhAbh7p+NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/165] clk: Move clk_core_reparent_orphans() under CONFIG_OF
Date:   Sat, 11 Jan 2020 10:50:28 +0100
Message-Id: <20200111094931.213201411@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

[ Upstream commit c771256ee7a03d3fb3c0443319ae6249c455849d ]

A recent addition exposed a helper that is only used for CONFIG_OF. Move
it into the CONFIG_OF zone in this file to make the compiler stop
warning about an unused function.

Fixes: 66d9506440bb ("clk: walk orphan list on clock provider registration")
Signed-off-by: Olof Johansson <olof@lixom.net>
Link: https://lkml.kernel.org/r/20191217082501.424892072D@mail.kernel.org
[sboyd@kernel.org: "Simply" move the function instead]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9c570bfc40d6..27a95c86a80b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3259,13 +3259,6 @@ static void clk_core_reparent_orphans_nolock(void)
 	}
 }
 
-static void clk_core_reparent_orphans(void)
-{
-	clk_prepare_lock();
-	clk_core_reparent_orphans_nolock();
-	clk_prepare_unlock();
-}
-
 /**
  * __clk_core_init - initialize the data structures in a struct clk_core
  * @core:	clk_core being initialized
@@ -4174,6 +4167,13 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(clk_notifier_unregister);
 
 #ifdef CONFIG_OF
+static void clk_core_reparent_orphans(void)
+{
+	clk_prepare_lock();
+	clk_core_reparent_orphans_nolock();
+	clk_prepare_unlock();
+}
+
 /**
  * struct of_clk_provider - Clock provider registration structure
  * @link: Entry in global list of clock providers
-- 
2.20.1



