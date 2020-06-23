Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91989206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944167;
	bh=gq5ObQNE4e1Wgot0BPPIi7/5Q016PqRJyq9xK54erqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xN1AFa5sUl6Sf4dYgDPm5P5hjMQdFLEWaVlJpBNncZxYO/OaA9f7VIXqe0GT1d4sK
	 JXaJ6mZCQQORQkxp+XBWW8nkTb/zOURa6KotWH91vFhgn31aIA4n4A/IakR+UvC0Ga
	 IRfCdWWrJiNSMUV2eiy57Ox2sUOvmD+8arhVprks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbgFWU3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389433AbgFWU3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:29:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5E0206EB;
        Tue, 23 Jun 2020 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944156;
        bh=gq5ObQNE4e1Wgot0BPPIi7/5Q016PqRJyq9xK54erqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRvl96XaAbsCz7+gVdHjq4Pg+gbLyA3wPGfDiOGw/r1Y41pdk71/eFwdQGQzNg0Ce
         TIgqOW4qHxJeuijUiTB6Jte5Q37cz9Q023omVubnuVyiOPLFxGbpjclc6CQswvZ6DC
         ThDzajdN8fKlevDXhJrrAxhfvCOhMC+qjfdwHdxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 193/314] clk: sprd: return correct type of value for _sprd_pll_recalc_rate
Date:   Tue, 23 Jun 2020 21:56:28 +0200
Message-Id: <20200623195348.121336008@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit c2f30986d418f26abefc2eec90ebf06716c970d2 ]

The function _sprd_pll_recalc_rate() defines return value to unsigned
long, but it would return a negative value when malloc fail, changing
to return its parent_rate makes more sense, since if the callback
.recalc_rate() is not set, the framework returns the parent_rate as
well.

Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lkml.kernel.org/r/20200519030036.1785-2-zhang.lyra@gmail.com
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sprd/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
index 640270f51aa56..eb8862752c2b2 100644
--- a/drivers/clk/sprd/pll.c
+++ b/drivers/clk/sprd/pll.c
@@ -105,7 +105,7 @@ static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
 
 	cfg = kcalloc(regs_num, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
-		return -ENOMEM;
+		return parent_rate;
 
 	for (i = 0; i < regs_num; i++)
 		cfg[i] = sprd_pll_read(pll, i);
-- 
2.25.1



