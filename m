Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA32C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5CF2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096907;
	bh=3DWxiYd0wuNeQbwCV8FC1RVQySn9TwCsOmu1TqHsW54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1uo1wVOtmKDFVv+bDY3oRKfnM+fvia18H1c6IyH2ycRvsuHKBBt8+iruHqAr0nolG
	 vh0p3GJ6pJqz35zK4sk0Fxrx6+cujJQV+QvsD2OKio9bSdi6SzOe1Gfb3toZWL104u
	 GvzAiXJXVhPF1GesPjv/K0rOWczOoA6sJ5vASJtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgG3IPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgG3IMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C835620838;
        Thu, 30 Jul 2020 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096729;
        bh=3DWxiYd0wuNeQbwCV8FC1RVQySn9TwCsOmu1TqHsW54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=af7n+eIs57tJy3Jxf1V2gsRELsqcX9uFIh7Zt0ooOehzl0ibrwF79g5ifCMYHVUdd
         lX4JfsB613pnufMD7aUdB401K1JHuSoV3nkTTOWwKPGEkxrhPKUx0JZZ2l4KT7oyGa
         QMzQwoNzQAfUdMWUufJgRy/Y/ZR+wVbmEl/HPk9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/54] net: sky2: initialize return of gm_phy_read
Date:   Thu, 30 Jul 2020 10:04:46 +0200
Message-Id: <20200730074421.574627193@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074421.203879987@linuxfoundation.org>
References: <20200730074421.203879987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -215,7 +215,7 @@ io_error:
 
 static inline u16 gm_phy_read(struct sky2_hw *hw, unsigned port, u16 reg)
 {
-	u16 v;
+	u16 v = 0;
 	__gm_phy_read(hw, port, reg, &v);
 	return v;
 }
-- 
2.25.1



