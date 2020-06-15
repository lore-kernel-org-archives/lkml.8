Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CFE206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592261750;
	bh=xPHAwCZIAPJVGzHpQB3l6luKINCFqlaCcm5gNh5hL+E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GmdSb+/NL3gqNv3r0aW2GA77vDAOV4ub9GZnN3XbCRB0X6bFVRP3D4leJCiRb1OgW
	 sT/VYpXI4LJR0wMlkwFD0h93ATymnnobn2L1k4hTSD3ONKhQ+2NbMkhDTnabv/s/OH
	 4I4lXdTc9QaFhgi2Zoy0upslRfoxSUg4Y5a/tLug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgFOWzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgFOWzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:55:49 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A95520739;
        Mon, 15 Jun 2020 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592261748;
        bh=xPHAwCZIAPJVGzHpQB3l6luKINCFqlaCcm5gNh5hL+E=;
        h=Date:From:To:Cc:Subject:From;
        b=qCFU9jnYLGZIWG0mtaUgc4Ep/qP6Cn37gcSHY9i3ELgXUPfBUdY3hRF57ATvlQRFq
         LjNWRGzscKDCcBFeImcibqZp8HgOw6jKTVYDrC/PHI3kkIqPY6pLOCp8uGVQ8Nj2It
         SE3dnhpp+OyUNbhtE1uNkgoabDymrqp62vcXBRew=
Date:   Mon, 15 Jun 2020 18:01:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] ethtool: ioctl: Use array_size() in copy_to_user()
Message-ID: <20200615230107.GA16907@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in
copy_to_user(). These sorts of multiplication factors need to
be wrapped in array_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/ethtool/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index b5df90c981c2..be3ed24bfe03 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1918,7 +1918,7 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
 		goto out;
 	useraddr += sizeof(stats);
-	if (n_stats && copy_to_user(useraddr, data, n_stats * sizeof(u64)))
+	if (n_stats && copy_to_user(useraddr, data, array_size(n_stats, sizeof(u64))))
 		goto out;
 	ret = 0;
 
@@ -1973,7 +1973,7 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
 		goto out;
 	useraddr += sizeof(stats);
-	if (n_stats && copy_to_user(useraddr, data, n_stats * sizeof(u64)))
+	if (n_stats && copy_to_user(useraddr, data, array_size(n_stats, sizeof(u64))))
 		goto out;
 	ret = 0;
 
-- 
2.27.0

