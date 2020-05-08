Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC8C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCBF2145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942084;
	bh=S8DKXB9PEAxLvWBWOyJyiuxF/b8JR1221vT76XoCgLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h3URwcFL8tFWnprdgMSCbblPaxZ+VuqUSQLAHi5goVEXlJk/SsKdpLHEmA/nh8u4/
	 kphbUDS99orRxzfzawlNB21m4p+R5dMhUgJadsoS+aFQgbL6HKX6EIdeI/7ytXdyvY
	 EAVj+EntbDIMiqFjcyD5lfFIwRSnSZw9Sb27121c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEHMsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgEHMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF4D221F7;
        Fri,  8 May 2020 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942078;
        bh=S8DKXB9PEAxLvWBWOyJyiuxF/b8JR1221vT76XoCgLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8ejE8RueF2C1NDwgCfUfTEiidQQ1IRTBPDLzhptWPwFOKaWTQx9E9L9lE7pCmcGm
         uaLHphNHxtOZON9/ScqGvKCgOAZf1dXIxB5FloU32a24Z+V4C7oh37hQwFntcZqfHg
         hNozkGtxgjudqZap+7wpSbTjEmmtsuUZsHpDmF5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 289/312] ravb: Add missing free_irq() call to ravb_close()
Date:   Fri,  8 May 2020 14:34:40 +0200
Message-Id: <20200508123144.711327872@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 7fa816b92c52e2c304f2ff6401e0d51e1d229ca5 upstream.

When reopening the network device on ra7795/salvator-x, e.g. after a
DHCP timeout:

    IP-Config: Reopening network devices...
    genirq: Flags mismatch irq 139. 00000000 (eth0:ch24:emac) vs. 00000000 (eth0:ch24:emac)
    ravb e6800000.ethernet eth0: cannot request IRQ eth0:ch24:emac
    IP-Config: Failed to open eth0
    IP-Config: No network devices available

The "mismatch" is due to requesting an IRQ that is already in use,
while IRQF_PROBE_SHARED wasn't set.

However, the real cause is that ravb_close() doesn't release the R-Car
Gen3-specific secondary IRQ.

Add the missing free_irq() call to fix this.

Fixes: 22d4df8ff3a3cc72 ("ravb: Add support for r8a7795 SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/renesas/ravb_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1528,6 +1528,8 @@ static int ravb_close(struct net_device
 		priv->phydev = NULL;
 	}
 
+	if (priv->chip_id == RCAR_GEN3)
+		free_irq(priv->emac_irq, ndev);
 	free_irq(ndev->irq, ndev);
 
 	napi_disable(&priv->napi[RAVB_NC]);


