Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AADC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D23120661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607701;
	bh=atrbgGSKKVNR11OMB27M3lgoyMgUhLBuBnH51g4kaTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2fJwDRg2e9YNq9orcBk2GlIsZMlJgmtWv9heW1pmv6jwevI5ibtWfDVopWXhglck
	 waBxY8J90ARETSHzPEkKWVK3rxOYE7Igma07wbFhb+VUDNK06tvnpnDj280XsyDBeM
	 EDH01mGFsdX2bA8D3N93MUkOSz1GBgBw/NQpbrWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgBMP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbgBMPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6A020848;
        Thu, 13 Feb 2020 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607550;
        bh=atrbgGSKKVNR11OMB27M3lgoyMgUhLBuBnH51g4kaTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1B08JkDvtVcvma9A3T16fTpVV0uRPABrMMSkXHJQq11pexImjglcfb5843Lk8qLK
         DGAY6YBfhgN+2nZa9yQRJT3fGvpgFGbuhKwmVeWe3dVjU6C3PTZf6hjC3XTKP0va6c
         pU5kye2OCwUeZMq7JdEMMqOimOSjVuwyjyCtGcBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 114/173] net: systemport: Avoid RBUF stuck in Wake-on-LAN mode
Date:   Thu, 13 Feb 2020 07:20:17 -0800
Message-Id: <20200213152001.224479411@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 263a425a482fc495d6d3f9a29b9103a664c38b69 ]

After a number of suspend and resume cycles, it is possible for the RBUF
to be stuck in Wake-on-LAN mode, despite the MPD enable bit being
cleared which instructed the RBUF to exit that mode.

Avoid creating that problematic condition by clearing the RX_EN and
TX_EN bits in the UniMAC prior to disable the Magic Packet Detector
logic which is guaranteed to make the RBUF exit Wake-on-LAN mode.

Fixes: 83e82f4c706b ("net: systemport: add Wake-on-LAN support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2329,6 +2329,9 @@ static int bcm_sysport_resume(struct dev
 
 	umac_reset(priv);
 
+	/* Disable the UniMAC RX/TX */
+	umac_enable_set(priv, CMD_RX_EN | CMD_TX_EN, 0);
+
 	/* We may have been suspended and never received a WOL event that
 	 * would turn off MPD detection, take care of that now
 	 */


