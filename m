Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFBDC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5B120678
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738658;
	bh=9H8K6f4WS4+g2eMnG1nF+EqrYI6JWZs1AM0EN2HuTHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VW2lhbyWvFmLu0GJ6IfoIJYO99yYxI4d67G04vlBoaF1EzS0cUgSHKkpJ3CQZRCWA
	 xbDg8Dic0xdQe1ODBHwbnuWYDI8wzJQHbJOu2JVPvUOO56v1ihByumhVYaVGTl7GWT
	 6DV7vDEBLYuFBEgEENJ4wd1mwyM2AOjR8H1ICl7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgAKKa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgAKKaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:30:55 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E4920880;
        Sat, 11 Jan 2020 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738655;
        bh=9H8K6f4WS4+g2eMnG1nF+EqrYI6JWZs1AM0EN2HuTHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiXSOxfjOvJYE7oU/rvMDsVuY4WwuLKy+4fkGx3lJ8W2taxVhQ9tYiEwb85UDev31
         IHk6CTrmB1Uw4FOM07psG0msr3CF268z9EYxSAi2kxqQgagtGtcCR21qonp/bTu1OD
         LvUTfxEzw8pugXEmAxIj9GJUOZPsmWjaP0fSC2R8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/165] net: stmmac: RX buffer size must be 16 byte aligned
Date:   Sat, 11 Jan 2020 10:50:33 +0100
Message-Id: <20200111094932.133123759@linuxfoundation.org>
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

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 8d558f0294fe92e04af192e221d0d0f6a180ee7b ]

We need to align the RX buffer size to at least 16 byte so that IP
doesn't mis-behave. This is required by HW.

Changes from v2:
- Align UP and not DOWN (David)

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1b4968e4a313..cfb60b20e625 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -45,7 +45,7 @@
 #include "dwxgmac2.h"
 #include "hwif.h"
 
-#define	STMMAC_ALIGN(x)		__ALIGN_KERNEL(x, SMP_CACHE_BYTES)
+#define	STMMAC_ALIGN(x)		ALIGN(ALIGN(x, SMP_CACHE_BYTES), 16)
 #define	TSO_MAX_BUFF_SIZE	(SZ_16K - 1)
 
 /* Module parameters */
-- 
2.20.1



