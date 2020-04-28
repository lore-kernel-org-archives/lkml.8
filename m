Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8800720575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099243;
	bh=zj1ucqAnFWab6s3lvbpafxI8eN5LcI4OKuLu8l9+6Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z2qvZlKXTjM2HHWTLSl4fKaUwGOC8jh84ogLxo+Nh0LRHMniLcqH+kO1vo6zlCB6S
	 wEWvS+fB7cX/biRLUYSIB3XcFxQumbmIizuv8jM06xKOfM3CU9/WEdcjZ/6R4sKAyZ
	 tn4c6RQhzD4kKbxY+vmkLVCU7tF+lz/nxIPGddBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgD1Skm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgD1Ske (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA902076A;
        Tue, 28 Apr 2020 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099234;
        bh=zj1ucqAnFWab6s3lvbpafxI8eN5LcI4OKuLu8l9+6Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UboVY+x6kOmWUuH4gSsl7R90WJT0Iz+aKlHSvgXd2eFpbSwB9LiFHCs1+8vjZx88k
         /PCilgTtvL00zLuyzVu6aHaVONMvwivqdSUYKcD95mfObCmUBAP35i7PXlBVChNFVk
         aVvvPE/T1x8Bkn9VoNGZWWd2I212Wd4hu5u8FhCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 078/168] net: dsa: b53: b53_arl_rw_op() needs to select IVL or SVL
Date:   Tue, 28 Apr 2020 20:24:12 +0200
Message-Id: <20200428182242.018362141@linuxfoundation.org>
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

[ Upstream commit 64fec9493f7dc9bdd7233bcfe98985c45bd0e3c1 ]

Flip the IVL_SVL_SELECT bit correctly based on the VLAN enable status,
the default is to perform Shared VLAN learning instead of Individual
learning.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_common.c |    4 ++++
 drivers/net/dsa/b53/b53_regs.h   |    1 +
 2 files changed, 5 insertions(+)

--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1441,6 +1441,10 @@ static int b53_arl_rw_op(struct b53_devi
 		reg |= ARLTBL_RW;
 	else
 		reg &= ~ARLTBL_RW;
+	if (dev->vlan_enabled)
+		reg &= ~ARLTBL_IVL_SVL_SELECT;
+	else
+		reg |= ARLTBL_IVL_SVL_SELECT;
 	b53_write8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, reg);
 
 	return b53_arl_op_wait(dev);
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -292,6 +292,7 @@
 /* ARL Table Read/Write Register (8 bit) */
 #define B53_ARLTBL_RW_CTRL		0x00
 #define    ARLTBL_RW			BIT(0)
+#define    ARLTBL_IVL_SVL_SELECT	BIT(6)
 #define    ARLTBL_START_DONE		BIT(7)
 
 /* MAC Address Index Register (48 bit) */


