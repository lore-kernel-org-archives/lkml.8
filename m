Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A21DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0273F2145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942080;
	bh=8IU9kdrEQ0c5hh0E+m9pmCWJ57MAWCHPc/qLlwvzDlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpXCMMUeox4plCwZeF9AAyMV1Tfmy09mdZj1ypSccmLj4DKQkzPJ/Mvvz+SSTN9Dm
	 pnsM23VeofXrFQtrZLFxf7wrrUgMNAN8llSzMAUxzRoEKpl7MEHPEr0qkNRS2fYN/K
	 Z8dFpgwBt+PHvJp1svdwvVplfw0jimM0IIZoSCCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgEHMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgEHMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DED4221F7;
        Fri,  8 May 2020 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942073;
        bh=8IU9kdrEQ0c5hh0E+m9pmCWJ57MAWCHPc/qLlwvzDlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaI6v5aBkuGwdV1jhAByBfnyy+sIE0ZByzMTubZqXTyAVWDFTrtrhDwfEnOV5wQCW
         cFyBDloPGeDidCOHaEj/MgUBj4qk4YOlhwhm6rNVS9C+d9IO+6A4aLwK3XRwssh1yA
         pDKvpnJBzORX16X0/GPgPnPkGc3Kje4KcmbrsncE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 287/312] net: mvneta: fix trivial cut-off issue in mvneta_ethtool_update_stats
Date:   Fri,  8 May 2020 14:34:38 +0200
Message-Id: <20200508123144.576159921@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@marvell.com>

commit 2c832293e09be2f998ea916650927c8ccd5b4b3b upstream.

When s->type is T_REG_64, the high 32bits are lost in val. This patch
fixes this trivial issue.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: 9b0cdefa4cd5 ("net: mvneta: add ethtool statistics")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvneta.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3058,26 +3058,25 @@ static void mvneta_ethtool_update_stats(
 	const struct mvneta_statistic *s;
 	void __iomem *base = pp->base;
 	u32 high, low, val;
+	u64 val64;
 	int i;
 
 	for (i = 0, s = mvneta_statistics;
 	     s < mvneta_statistics + ARRAY_SIZE(mvneta_statistics);
 	     s++, i++) {
-		val = 0;
-
 		switch (s->type) {
 		case T_REG_32:
 			val = readl_relaxed(base + s->offset);
+			pp->ethtool_stats[i] += val;
 			break;
 		case T_REG_64:
 			/* Docs say to read low 32-bit then high */
 			low = readl_relaxed(base + s->offset);
 			high = readl_relaxed(base + s->offset + 4);
-			val = (u64)high << 32 | low;
+			val64 = (u64)high << 32 | low;
+			pp->ethtool_stats[i] += val64;
 			break;
 		}
-
-		pp->ethtool_stats[i] += val;
 	}
 }
 


