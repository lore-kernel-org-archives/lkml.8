Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138E220644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607730;
	bh=V95yCoTcpXvKvc9AZwVut5NcTNGJwYI7B6vPWp1OYV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYal6AP8eG9ST2jl70ApzD4iOsgIkPG3KmvFHfvcvdTwKTYjOs47pQlIHetsgWGKd
	 Obfr3fbqJPtEy6pRDv/qkEeMRHhvXlBcvIjdQHvqp0/w2rbMA87f7U6mJw5v4lHjKB
	 73Nrq3X5kl7Ou20tcsUSjVdlOTy+AJoIkb7so5pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgDKMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgDKMVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:21:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBACB2084D;
        Sat, 11 Apr 2020 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607690;
        bh=V95yCoTcpXvKvc9AZwVut5NcTNGJwYI7B6vPWp1OYV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ie1Az/YJw5pX6Ug/1Who05euvBgMHI2tBhljBs9SSQG9TWPeSQyOUuq1zgTJJBh6N
         2UMgSAVBGdzdsZm0Z2IHCPl2cheAfZT2Q89Ty2ukeHNfREFGue/rh44oc+u8uzkmKV
         ybKjNPxkTpBbU8DzINKalY5EZfSM5cOahixN3aVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 09/38] net: stmmac: dwmac1000: fix out-of-bounds mac address reg setting
Date:   Sat, 11 Apr 2020 14:09:46 +0200
Message-Id: <20200411115500.287772847@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
References: <20200411115459.324496182@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 3e1221acf6a8f8595b5ce354bab4327a69d54d18 ]

Commit 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address
entries") cleared the unused mac address entries, but introduced an
out-of bounds mac address register programming bug -- After setting
the secondary unicast mac addresses, the "reg" value has reached
netdev_uc_count() + 1, thus we should only clear address entries
if (addr < perfect_addr_number)

Fixes: 9463c4455900 ("net: stmmac: dwmac1000: Clear unused address entries")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -207,7 +207,7 @@ static void dwmac1000_set_filter(struct
 			reg++;
 		}
 
-		while (reg <= perfect_addr_number) {
+		while (reg < perfect_addr_number) {
 			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
 			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
 			reg++;


