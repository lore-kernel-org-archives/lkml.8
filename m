Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A9720B80
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645526;
	bh=AlHW95CssIqsx8U4u/AbjdIfdvzK5ovjHTD8W6WJLuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OV/of1Jtmm/sji6+dnTapMNcz1nUN8hob+tqhaeDp1dQPzrZhPpC64+hK6NXUMx3o
	 R+/l4pGD81hy+9TpuYjJ6EXTpheQ0kJypVOndIRLF8j6Cur9vCZJjiLfM2ahABCrR4
	 L9C4SoqUZCdyjciLZYWJfXwHS6kmPbf6QT8pYhCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgCaJFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730470AbgCaJFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:05:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC46F20787;
        Tue, 31 Mar 2020 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645518;
        bh=AlHW95CssIqsx8U4u/AbjdIfdvzK5ovjHTD8W6WJLuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3jwnaK1dSiu2dY5JvnJP4ptG0sAr5YqdoHH7ZUKQkrM+w3nuEYB9+UGjOup5SCIO
         bgIs6SRLoR74qACuTVckfO5TN0fa+17i9GxJXWUrGFeI8ZyXo2AkaAyR5U52eZU7Zn
         xuH6mzo1EssMcncDStK1Wl82oxwbeRPeojxLjTUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominik Czarnota <dominik.b.czarnota@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 078/170] sxgbe: Fix off by one in samsung driver strncpy size arg
Date:   Tue, 31 Mar 2020 10:58:12 +0200
Message-Id: <20200331085432.618157886@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Czarnota <dominik.b.czarnota@gmail.com>

[ Upstream commit f3cc008bf6d59b8d93b4190e01d3e557b0040e15 ]

This patch fixes an off-by-one error in strncpy size argument in
drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c. The issue is that in:

        strncmp(opt, "eee_timer:", 6)

the passed string literal: "eee_timer:" has 10 bytes (without the NULL
byte) and the passed size argument is 6. As a result, the logic will
also accept other, malformed strings, e.g. "eee_tiXXX:".

This bug doesn't seem to have any security impact since its present in
module's cmdline parsing code.

Signed-off-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 52ed111d98f4d..15e3f668218b1 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2279,7 +2279,7 @@ static int __init sxgbe_cmdline_opt(char *str)
 	if (!str || !*str)
 		return -EINVAL;
 	while ((opt = strsep(&str, ",")) != NULL) {
-		if (!strncmp(opt, "eee_timer:", 6)) {
+		if (!strncmp(opt, "eee_timer:", 10)) {
 			if (kstrtoint(opt + 10, 0, &eee_timer))
 				goto err;
 		}
-- 
2.20.1



