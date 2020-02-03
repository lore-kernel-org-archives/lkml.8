Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF74C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7AA2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748330;
	bh=oQU8j3iGAB4O7b8CkHV1klO/M50wrpvyCF2KqP6rjQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2IRvSYF4WV7E1hwQ8Kw3MPXnbPiYm0lg3PacSGE/WmKYunVFoVu9ovjO5eV725csp
	 ReH1/1u+oidI1yKb9mozBjk3WH4pnGbNYVnOOdEz1JyDrg9IeC/CiGCPayphTUvM3I
	 bcyL6mICOFTiRAussXHMlJr2P3IZKKfjn5MFDq8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgBCQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgBCQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:30:11 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A702051A;
        Mon,  3 Feb 2020 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747409;
        bh=oQU8j3iGAB4O7b8CkHV1klO/M50wrpvyCF2KqP6rjQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWO43R/KrVY60vvpytcJwWL/neWMGuXhHNPqbnnyjKD6YUUg5mTCFengmt732abte
         lFIiSSE679xMmnO2kuSJQZQ8Nsp/4lTEf5PEQvMtGeimEycj+YuLVoCzi/j/o4c8vW
         OBhmdpYbRM6fj98oxrnt3J9+4KPd2SI8PIV5y4Cg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/89] atm: eni: fix uninitialized variable warning
Date:   Mon,  3 Feb 2020 16:19:12 +0000
Message-Id: <20200203161920.477804135@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 30780d086a83332adcd9362281201cee7c3d9d19 ]

With -O3, gcc has found an actual unintialized variable stored
into an mmio register in two instances:

drivers/atm/eni.c: In function 'discard':
drivers/atm/eni.c:465:13: error: 'dma[1]' is used uninitialized in this function [-Werror=uninitialized]
   writel(dma[i*2+1],eni_dev->rx_dma+dma_wr*8+4);
             ^
drivers/atm/eni.c:465:13: error: 'dma[3]' is used uninitialized in this function [-Werror=uninitialized]

Change the code to always write zeroes instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/eni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index ce47eb17901d0..a106d15f6def0 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -372,7 +372,7 @@ static int do_rx_dma(struct atm_vcc *vcc,struct sk_buff *skb,
 		here = (eni_vcc->descr+skip) & (eni_vcc->words-1);
 		dma[j++] = (here << MID_DMA_COUNT_SHIFT) | (vcc->vci
 		    << MID_DMA_VCI_SHIFT) | MID_DT_JK;
-		j++;
+		dma[j++] = 0;
 	}
 	here = (eni_vcc->descr+size+skip) & (eni_vcc->words-1);
 	if (!eff) size += skip;
@@ -445,7 +445,7 @@ static int do_rx_dma(struct atm_vcc *vcc,struct sk_buff *skb,
 	if (size != eff) {
 		dma[j++] = (here << MID_DMA_COUNT_SHIFT) |
 		    (vcc->vci << MID_DMA_VCI_SHIFT) | MID_DT_JK;
-		j++;
+		dma[j++] = 0;
 	}
 	if (!j || j > 2*RX_DMA_BUF) {
 		printk(KERN_CRIT DEV_LABEL "!j or j too big!!!\n");
-- 
2.20.1



