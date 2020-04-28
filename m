Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7456C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E14921973
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098878;
	bh=IIHuiSG62cTjBNaOc+hdNDInlDXsuKMm0wNQmaLg8KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lm0wgEXYppSJ0QF4+LHfbplsANXDqyZQzJS14ryV8s9T6SU9AGvyyClHAcvwHVeeO
	 XPExd6OmeI+z6dpxQlmB/+I5hYSvokrxZ+HMdA+185XzOfz78QaohjGumHqDonLtas
	 DEU9ayypOBuLYgd4Pjd4bLIcSqEbKy1SWO4QStFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgD1Seh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbgD1SeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:34:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C686B20575;
        Tue, 28 Apr 2020 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098864;
        bh=IIHuiSG62cTjBNaOc+hdNDInlDXsuKMm0wNQmaLg8KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHCbNs3bfAxz+ND0w8EytayCxLNMrGn7E+hfyQjbyPDhKj5hCBHJ0oIUOJ3jJKMPv
         WXkLIYdsRz6FXIRnAZn3iQCtdO/tgLYyk+M2xMS2yjnLQQ62O2fVW/tfbDDi+jZQji
         WA6WAtgCpJAkC/T1Nu+FwARRB67n+0N9COgv9C8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 066/131] net: dsa: b53: Lookup VID in ARL searches when VLAN is enabled
Date:   Tue, 28 Apr 2020 20:24:38 +0200
Message-Id: <20200428182233.240764787@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
@@ -1284,6 +1284,9 @@ static int b53_arl_read(struct b53_devic
 			continue;
 		if ((mac_vid & ARLTBL_MAC_MASK) != mac)
 			continue;
+		if (dev->vlan_enabled &&
+		    ((mac_vid >> ARLTBL_VID_S) & ARLTBL_VID_MASK) != vid)
+			continue;
 		*idx = i;
 	}
 


