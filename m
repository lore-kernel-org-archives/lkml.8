Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF436C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80BC22B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753418;
	bh=jnp0t6ErVSfA+lpTQq88zRCWkkjlAaptnMPyR4Wd4Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XOe53/aSuWkcugidOTP5nI0MiqUkTRSAnq/XXY7UHHo0QlXC51pMD9KvOUpjWcFUZ
	 lbXYSc3j6SdBkzTFhXXB+Imu5gRqU/GXxz/ScyYXVerIYfbktSjfB1fuvqP+TviuAl
	 Cv6+L6RXRR4rH7eetYB52bNhBRkOCI7BFrO7IO1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgGNTDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731148AbgGNS5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16172229CA;
        Tue, 14 Jul 2020 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753041;
        bh=jnp0t6ErVSfA+lpTQq88zRCWkkjlAaptnMPyR4Wd4Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPz9lbTHa+YCCBQHu0IEyvLszQ4lsm+fpkCL2b2bSYk0JT6peudLuTydywVUXTL5D
         2+Zh1PEp9HB7CvqOyyq890oy12rwIn8nsZtLQCRwTKd5lAzQ30UsrI0x/3kqRCrm41
         hE1fmXJsEHg37AlsqpHjYgGN5UiTPNz5VGkLSzBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 090/166] cxgb4: fix all-mask IP address comparison
Date:   Tue, 14 Jul 2020 20:44:15 +0200
Message-Id: <20200714184120.150771598@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit 76c4d85c9260c3d741cbd194c30c61983d0a4303 ]

Convert all-mask IP address to Big Endian, instead, for comparison.

Fixes: f286dd8eaad5 ("cxgb4: use correct type for all-mask IP address comparison")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 7a7f61a8cdf40..d02d346629b36 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -1112,16 +1112,16 @@ static bool is_addr_all_mask(u8 *ipmask, int family)
 		struct in_addr *addr;
 
 		addr = (struct in_addr *)ipmask;
-		if (ntohl(addr->s_addr) == 0xffffffff)
+		if (addr->s_addr == htonl(0xffffffff))
 			return true;
 	} else if (family == AF_INET6) {
 		struct in6_addr *addr6;
 
 		addr6 = (struct in6_addr *)ipmask;
-		if (ntohl(addr6->s6_addr32[0]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[1]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[2]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[3]) == 0xffffffff)
+		if (addr6->s6_addr32[0] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[1] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[2] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[3] == htonl(0xffffffff))
 			return true;
 	}
 	return false;
-- 
2.25.1



