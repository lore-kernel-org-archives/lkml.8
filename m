Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73915C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D98B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737653;
	bh=RiqL0kh5PZlsQnAolTnvcMwR8V+5KN0H/iwTkzcMAjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nq87jDCLsv0tSw2X4tkaB6wq5h5fw67hyMKsE3mzOYv0khITNyGnIlHWaVcaN0Ar/
	 Cdv9yIxl5+9Wah8nMZivZWKLk+l6Zl026wGYDfwXSiXQm0odd1BTu1JF1fLAwDpweg
	 x3NYlpzcDzGRHKPQaag6POvtnk78pcOrNoqaVg08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgGNOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbgGNOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:40:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068602242C;
        Tue, 14 Jul 2020 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737633;
        bh=RiqL0kh5PZlsQnAolTnvcMwR8V+5KN0H/iwTkzcMAjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFUnTWYYOhxAMbV/AkzLPsPCczlWsCQZx9VCjrL9WkgpUnlRcLoNTFm9zWUhUO6t7
         pQUtIVB0JnhJX8aNsUbSYwdWWWShH4/grb8kmrfCpum+nq0rb7ZiR1mUy5flAXe/49
         52W/hNVG6K+JYSCat8TrF3hCGG8NM+W86e1KSh1k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 8/9] net: sky2: initialize return of gm_phy_read
Date:   Tue, 14 Jul 2020 10:40:22 -0400
Message-Id: <20200714144024.4036118-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714144024.4036118-1-sashal@kernel.org>
References: <20200714144024.4036118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 28b18e4eb515af7c6661c3995c6e3c34412c2874 ]

clang static analysis flags this garbage return

drivers/net/ethernet/marvell/sky2.c:208:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return v;
        ^~~~~~~~

static inline u16 gm_phy_read( ...
{
	u16 v;
	__gm_phy_read(hw, port, reg, &v);
	return v;
}

__gm_phy_read can return without setting v.

So handle similar to skge.c's gm_phy_read, initialize v.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/sky2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 8ba9eadc20791..3fb9cbdac3bf0 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -215,7 +215,7 @@ static int __gm_phy_read(struct sky2_hw *hw, unsigned port, u16 reg, u16 *val)
 
 static inline u16 gm_phy_read(struct sky2_hw *hw, unsigned port, u16 reg)
 {
-	u16 v;
+	u16 v = 0;
 	__gm_phy_read(hw, port, reg, &v);
 	return v;
 }
-- 
2.25.1

