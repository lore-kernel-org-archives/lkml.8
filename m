Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7024C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6784321973
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586261;
	bh=K3eI6LMy5f0gL5/OJtNUhVXe7P76Th8BY6Pj5CVWRsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TixBzpJVAQg+KkaPO6hEwnM8TrbQjSq4Qx7OlECU3SbsN88k2FN9/BU73l/DSSbWx
	 s2RsxekD+hwfmZ6irUOnTHeNiIysuknmwxICUZ0LKbSLaK/Szmi0CTaVd7H9aC4zGV
	 lRTZcrraZfdNpIKwwUZ4SvJKUUEdA4PODiquaBJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgIHRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbgIHQPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:15:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CA924819;
        Tue,  8 Sep 2020 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579832;
        bh=K3eI6LMy5f0gL5/OJtNUhVXe7P76Th8BY6Pj5CVWRsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDPSwTmuFZCjiTg7AH7y6dns+bcfd+mvD6Zj5EUYy/OiVmQx0ZWW82Lt6lnywKI6g
         ka/TLhFnaHcAH/fwaGl5YcAzMfF6jESCj6HCRRIZXwApU7gEjO75ocZ6SEF3/dE3dt
         SWVzssVdypA86+lVYXwsZV6KzIeh1Ll6i0i54udY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Landen Chao <landen.chao@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/129] net: dsa: mt7530: fix advertising unsupported 1000baseT_Half
Date:   Tue,  8 Sep 2020 17:24:53 +0200
Message-Id: <20200908152232.310727712@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Landen Chao <landen.chao@mediatek.com>

[ Upstream commit f272285f6abb9178d029375599626baf3d5f4e8a ]

Remove 1000baseT_Half to advertise correct hardware capability in
phylink_validate() callback function.

Fixes: 38f790a80560 ("net: dsa: mt7530: Add support for port 5")
Signed-off-by: Landen Chao <landen.chao@mediatek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index dc9a3bb241149..00d680cb44418 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1456,7 +1456,7 @@ unsupported:
 		phylink_set(mask, 100baseT_Full);
 
 		if (state->interface != PHY_INTERFACE_MODE_MII) {
-			phylink_set(mask, 1000baseT_Half);
+			/* This switch only supports 1G full-duplex. */
 			phylink_set(mask, 1000baseT_Full);
 			if (port == 5)
 				phylink_set(mask, 1000baseX_Full);
-- 
2.25.1



