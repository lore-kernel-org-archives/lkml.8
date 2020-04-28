Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64085C8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420DF217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099221;
	bh=+ih6MphER0J1zqqkZ6A8BsDxyML4CcO5wlpDOSwsHwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mjvc8fLWNZ2xxs2kaQD/r8xiYza8dhpKBX6At1+PG+1PcCPrxf/mbTLbKZOgzGaqT
	 qOX6YudE0xt7stQNuyS7Gb7x62QMJVRDeDxEWsUGdO2Sssf1zPlLVTo3l+bdKPoX5N
	 SlXWI47MiJwoPbMcZfYwFwd8B+yhnRx272bt237Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgD1SkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbgD1SkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48C120575;
        Tue, 28 Apr 2020 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099212;
        bh=+ih6MphER0J1zqqkZ6A8BsDxyML4CcO5wlpDOSwsHwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gt3v5TcnorVpsGtM342W1kKnSGm63dIBYGcmXnVLSc5pzcQwenW/RzZNWChvOWtkj
         u2rlb3agpX2tpQcPSB3A4xTHkjCkledkbjjk5uYudgUR19kRAOCe7G2iGWRwloBQdr
         JppixJCHjp9dxFy2kWRO2omwjsLHQr2Q/PMU4Uco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 074/168] net: dsa: b53: Lookup VID in ARL searches when VLAN is enabled
Date:   Tue, 28 Apr 2020 20:24:08 +0200
Message-Id: <20200428182241.449034633@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 2e97b0cd1651a270f3a3fcf42115c51f3284c049 ]

When VLAN is enabled, and an ARL search is issued, we also need to
compare the full {MAC,VID} tuple before returning a successful search
result.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_common.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1472,6 +1472,9 @@ static int b53_arl_read(struct b53_devic
 			continue;
 		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
 			continue;
+		if (dev->vlan_enabled &&
+		    ((mac_vid >> ARLTBL_VID_S) & ARLTBL_VID_MASK) != vid)
+			continue;
 		*idx = i;
 	}
 


