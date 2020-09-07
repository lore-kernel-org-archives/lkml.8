Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7662080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497075;
	bh=sCSX/hkS/jZYAfpuxjYlfWkuz9jej7DqloL+c37m8TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=seNQGApQjKFjiDxc0luUoDo5lX1ENxgUHWf2/aDzzM/U+I4OdsJRBXdUJT3KL8f+8
	 FtVVigVjqowbr0dH4nB+ait0iACyNT0cOJliQJt18hfrvcjT/D6bNQac2uO+ng8QbG
	 cCKegmFPrI2L4wYkve4meVoq0Ug8r2TC9gv30Ddk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgIGQob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbgIGQfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163A421D82;
        Mon,  7 Sep 2020 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496546;
        bh=sCSX/hkS/jZYAfpuxjYlfWkuz9jej7DqloL+c37m8TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+xDGslEf/KluX4yxRqekzlB10Dh3nGh02TicbncYYiXSoFwWlg/1HlXwnIG7NpQk
         dkK7fLHuGvAzYGlQCGzCHavva6qyM9LoNElD75ymoTjnGroWBb/jdfrtmlmeSEfIi5
         7RBPVW9at9f/dmSNstkcE6ZQUsi8a0M8cxsFMKQs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 02/10] firestream: Fix memleak in fs_open
Date:   Mon,  7 Sep 2020 12:35:35 -0400
Message-Id: <20200907163543.1281889-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163543.1281889-1-sashal@kernel.org>
References: <20200907163543.1281889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 15ac5cdafb9202424206dc5bd376437a358963f9 ]

When make_rate() fails, vcc should be freed just
like other error paths in fs_open().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/firestream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 04b39d0da8681..70708608ab1e7 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1009,6 +1009,7 @@ static int fs_open(struct atm_vcc *atm_vcc)
 				error = make_rate (pcr, r, &tmc0, NULL);
 				if (error) {
 					kfree(tc);
+					kfree(vcc);
 					return error;
 				}
 			}
-- 
2.25.1

