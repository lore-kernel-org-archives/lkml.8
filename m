Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE18F20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387597;
	bh=QR1PakUlj/lMWqZD6e71EiolwzkgVTbC7dDXGfQ2WCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6YzE0UjQ/pLOq3B+GD3f19gAN8SsGiMoPQvQeybZTuV+lgs1pImoVjeyNbarUkDR
	 GhDEegRmdVI0E6++JHf1IsSdCbHxesjLdvsyvZg9lPN5P993M+h67x9sATMA+yhG5z
	 5pvKauEPwgKNy4C6W9ip8g+cer/IKMh6KVF8/FNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgDTMk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgDTMkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:40:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1882072B;
        Mon, 20 Apr 2020 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386452;
        bh=QR1PakUlj/lMWqZD6e71EiolwzkgVTbC7dDXGfQ2WCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCdEP4Pna2WZHjJAqoohloi4YGkqGyFk+YoVGqqAplXBTieBVmTt2b86WVmCNq72n
         /gK12eZHJ7gPklnvtg1e2BQj0utPWjqgPnuMKdbWC1W33Aeq8y4Y720dS4/UMgW9kr
         V0/S+b5hfxq/tvDYinaIrORWOyDINOwSeYOMghkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 28/65] net: stmmac: xgmac: Fix VLAN register handling
Date:   Mon, 20 Apr 2020 14:38:32 +0200
Message-Id: <20200420121512.334989542@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 21f64e72e7073199a6f8d7d8efe52cd814d7d665 upstream.

Commit 907a076881f1, forgot that we need to clear old values of
XGMAC_VLAN_TAG register when we switch from VLAN perfect matching to
HASH matching.

Fix it.

Fixes: 907a076881f1 ("net: stmmac: xgmac: fix incorrect XGMAC_VLAN_TAG register writting")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -576,8 +576,13 @@ static void dwxgmac2_update_vlan_hash(st
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
 			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
 		}
 
+		value &= ~XGMAC_VLAN_VID;
 		writel(value, ioaddr + XGMAC_VLAN_TAG);
 	} else if (perfect_match) {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
@@ -588,13 +593,19 @@ static void dwxgmac2_update_vlan_hash(st
 
 		value = readl(ioaddr + XGMAC_VLAN_TAG);
 
+		value &= ~XGMAC_VLAN_VTHM;
 		value |= XGMAC_VLAN_ETV;
 		if (is_double) {
 			value |= XGMAC_VLAN_EDVLP;
 			value |= XGMAC_VLAN_ESVL;
 			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
 		}
 
+		value &= ~XGMAC_VLAN_VID;
 		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
 	} else {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);


