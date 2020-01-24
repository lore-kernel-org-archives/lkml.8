Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0565C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38D52070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858717;
	bh=SDDaB161FtBEIaSP+fWw8KSAAgxMEZyjIlZlrl1TXmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3PiQSa8yP25HPtne7X4Zr8q8D/1ADXihb/Z+hgC/PDaedMkLOv1nlbsYbGgLAqd2
	 3xR09tMRdJEJHVkPs0Z1BmzL2inDkLwginuYgju4qzqbo0kzS+6DFcjJc6AQBbbSeT
	 FFOQTxH2gm9QXBbgfEaN6aHZDUI4i6M0hBS1XNII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgAXJih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbgAXJie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:38:34 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448112087E;
        Fri, 24 Jan 2020 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858713;
        bh=SDDaB161FtBEIaSP+fWw8KSAAgxMEZyjIlZlrl1TXmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEr+nvjWRi/PKyqUehqz8VeR1egDoO/BYr20RNj+3c4w5tTwEd4hVNC1SsJc485OI
         suoB8rgT8FR9nSMug+kmJy80EQnbRqQ7KjXsb3yTPD/QxP45m+B2jroe5mmZcLiqok
         88tmuA6aNwEYF+6ZBe/Bigf43K2gkmbyHDr0quzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.4 031/102] phy: ti: gmii-sel: fix mac tx internal delay for rgmii-rxid
Date:   Fri, 24 Jan 2020 10:30:32 +0100
Message-Id: <20200124092810.920947941@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit 316b429459066215abb50060873ec0832efc4044 upstream.

Now phy-gmii-sel will disable MAC TX internal delay for PHY interface mode
"rgmii-rxid" which is incorrect.
Hence, fix it by enabling MAC TX internal delay in the case of "rgmii-rxid"
mode.

Fixes: 92b58b34741f ("phy: ti: introduce phy-gmii-sel driver")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/ti/phy-gmii-sel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -69,11 +69,11 @@ static int phy_gmii_sel_mode(struct phy
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
 		rgmii_id = 1;


