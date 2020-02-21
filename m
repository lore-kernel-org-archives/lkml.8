Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7E4C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9424124650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273255;
	bh=k4MAyLiQvbkcRfoaIpeTeeZXxVI0Sn7O1+qJM6lHONc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gNpbVw9y72yzu50JSOYd2+M4lO+c3B8ESQAQOL1qz15ftJrekJGgmwCvpI7C9B73/
	 VFXZQa1XkELU5fUSt0bOHNn1dxIPtEHgftjCQFhEX+bsU8zA7qZ/RzD/zBh9WxsSFZ
	 QLqnw9emXdAStRwfGrXOeQ875K80jxh9OTCNleAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgBUIUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbgBUIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:20:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10637206ED;
        Fri, 21 Feb 2020 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273248;
        bh=k4MAyLiQvbkcRfoaIpeTeeZXxVI0Sn7O1+qJM6lHONc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGW5tyB5ynxFVwYj3riM72+LaJCEnIm+StXlqbCHiEsiHw2GgEYWdUdoQt6U8YIbE
         bj56rKoWB4400JKeCAXmz0a+r9Z23pMCeUrx4W9t3JJ7dwV0SZYGkRM4am0vLfL12n
         qK5DRXzzVK+ZH07ZbVQQPwDyYScwii6suzEj6/AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/191] mlx5: work around high stack usage with gcc
Date:   Fri, 21 Feb 2020 08:41:14 +0100
Message-Id: <20200221072303.164897797@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 42ae1a5c76691928ed217c7e40269db27f5225e9 ]

In some configurations, gcc tries too hard to optimize this code:

drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function 'mlx5e_grp_sw_update_stats':
drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:302:1: error: the frame size of 1336 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

As was stated in the bug report, the reason is that gcc runs into a corner
case in the register allocator that is rather hard to fix in a good way.

As there is an easy way to work around it, just add a comment and the
barrier that stops gcc from trying to overoptimize the function.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92657
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 8255d797ea943..9a68dee588c1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -211,6 +211,9 @@ void mlx5e_grp_sw_update_stats(struct mlx5e_priv *priv)
 			s->tx_tls_resync_bytes	+= sq_stats->tls_resync_bytes;
 #endif
 			s->tx_cqes		+= sq_stats->cqes;
+
+			/* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92657 */
+			barrier();
 		}
 	}
 
-- 
2.20.1



