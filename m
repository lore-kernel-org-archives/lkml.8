Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C14920870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943068;
	bh=0FOvSCNt8UtfbIPwhxl/4xZOBKkGSXp3YeT0bc0a7Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQgEK8bH1JX485/Dbti6DjRh36WuejGBnW/RSDNJ8WIGPgvRrN4dDLJzZP8KPAqCl
	 6O5XPJeLWwZkVJGjRAK5MnKTPlKBZ3XTG8nMyn9bIKt831CNiZqCc73edm8uzFPNMv
	 S7+Xm5QAs2EXCmTDMtg1lf+HWRd1IfEuwjYBMN0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgEHNE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgEHMtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:49:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8272324953;
        Fri,  8 May 2020 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942146;
        bh=0FOvSCNt8UtfbIPwhxl/4xZOBKkGSXp3YeT0bc0a7Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArZv246rkOZXMBJ1iUJ5MijfHYeoAcrfF03XhcwhIeac/2IzpO3bac/SCffmh2948
         2dI8sxOQ8iQI2Kqbu+CHggIyjNEH1KLK3yPPKloNto+X1ByqycDdfWF1h2jBifzkPi
         c+z+6KEZ5w8sGUBiiPLjCxGYd7QS2vzQyuJBUpSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 276/312] net: ethernet: davinci_emac: Fix devioctl while in fixed link
Date:   Fri,  8 May 2020 14:34:27 +0200
Message-Id: <20200508123143.839989509@linuxfoundation.org>
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

From: Neil Armstrong <narmstrong@baylibre.com>

commit 62522ef3c399996f6c8120bfd14b94280bc9f490 upstream.

When configured in fixed link, the DaVinci emac driver sets the
priv->phydev to NULL and further ioctl calls to the phy_mii_ioctl()
causes the kernel to crash.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Fixes: 1bb6aa56bb38 ("net: davinci_emac: Add support for fixed-link PHY")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ti/davinci_emac.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1512,7 +1512,10 @@ static int emac_devioctl(struct net_devi
 
 	/* TODO: Add phy read and write and private statistics get feature */
 
-	return phy_mii_ioctl(priv->phydev, ifrq, cmd);
+	if (priv->phydev)
+		return phy_mii_ioctl(priv->phydev, ifrq, cmd);
+	else
+		return -EOPNOTSUPP;
 }
 
 static int match_first_device(struct device *dev, void *data)


