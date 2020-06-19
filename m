Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB45C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BF521548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577403;
	bh=0Kk4exPKBCvNorayPAfo/KDmWOa7KJcKQRFDySXXI7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xg/pp9gzjImDcExiNjq5vM9vsSQa+XWqJsbn81WI5CAdyWpawV2bJa+gLE87j0nPD
	 0ijTf2oB0AsfA64MaBQQgZFApel2AmADUOwv572tdVfcudUZclwZXkW7kWegogIbFN
	 cUEAWzMa5MNJ06kbrMuG2CuLwf0VoENiQ7o8WFno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgFSOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbgFSOgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8F221548;
        Fri, 19 Jun 2020 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577393;
        bh=0Kk4exPKBCvNorayPAfo/KDmWOa7KJcKQRFDySXXI7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wseALY8QG/DgesL6p/I0PpUhrEf3lv9L56RGOxjj3PSMWWCfp3oU+8lu9ROPWXdjW
         cH/yESqbTxUU2sWWp07bMiAZFNIz21099/RZzkOD8rtrKHfo2m0jpB0cmF6O2b9ksK
         tC1O3YO0RejG+LEORAwUCa/YPVLmlaiDGvgPUHVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 004/101] net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.
Date:   Fri, 19 Jun 2020 16:31:53 +0200
Message-Id: <20200619141614.239459471@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

commit c505873eaece2b4aefd07d339dc7e1400e0235ac upstream.

88E1145 also need this autoneg errata.

Fixes: f2899788353c ("net: phy: marvell: Limit errata to 88m1101")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1091,7 +1091,7 @@ static struct phy_driver marvell_drivers
 		.features = PHY_GBIT_FEATURES,
 		.flags = PHY_HAS_INTERRUPT,
 		.config_init = &m88e1145_config_init,
-		.config_aneg = &marvell_config_aneg,
+		.config_aneg = &m88e1101_config_aneg,
 		.read_status = &genphy_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
 		.config_intr = &marvell_config_intr,


