Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59461C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3281220724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623755;
	bh=xlUjYRIuYNPJuBZPFfCmPTqX05y7TNXWJ7R46AuUThg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xtPQtntUAmqC4djb+A7EXjdbkgIGlPscxSywnhSH7yYJnIe4Rz4FDoqF0Uy7NkbTz
	 /i4iAMgDDAhcxmZsRLdRlchaodj5ZuPOzVwn5XI0mEeYcXVUAKodz9CZmE8pI1N5Xu
	 p0Y5tKkG364rQET6NXRLvbATpreAR+XnJDicboBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgCSNPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgCSNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710E5206D7;
        Thu, 19 Mar 2020 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623750;
        bh=xlUjYRIuYNPJuBZPFfCmPTqX05y7TNXWJ7R46AuUThg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FH/4RX/CN28Z2Ey75bYpLxC9kgIX/KIToxCISsrWbGES6F/AMtOnfMSeNLJRufzL7
         gwCzcqsZcTVAb/Efa3cHqrfUW1200aihOrod8r4eFvNs6oreVNMIuSGgdifN0AkKiA
         vmjDtGfitKUeQZioZFwXYd4KIIlBXpBViAEPCeIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Bogdanov <dbogdanov@marvell.com>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/99] net: macsec: update SCI upon MAC address change.
Date:   Thu, 19 Mar 2020 14:02:47 +0100
Message-Id: <20200319123944.274945210@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dbogdanov@marvell.com>

[ Upstream commit 6fc498bc82929ee23aa2f35a828c6178dfd3f823 ]

SCI should be updated, because it contains MAC in its first 6 octets.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2871,6 +2871,11 @@ static void macsec_dev_set_rx_mode(struc
 	dev_uc_sync(real_dev, dev);
 }
 
+static sci_t dev_to_sci(struct net_device *dev, __be16 port)
+{
+	return make_sci(dev->dev_addr, port);
+}
+
 static int macsec_set_mac_address(struct net_device *dev, void *p)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -2892,6 +2897,7 @@ static int macsec_set_mac_address(struct
 
 out:
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	macsec->secy.sci = dev_to_sci(dev, MACSEC_PORT_ES);
 	return 0;
 }
 
@@ -3159,11 +3165,6 @@ static bool sci_exists(struct net_device
 	return false;
 }
 
-static sci_t dev_to_sci(struct net_device *dev, __be16 port)
-{
-	return make_sci(dev->dev_addr, port);
-}
-
 static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);


