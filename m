Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895F0C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A39206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JXT6fiPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCOByW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:54:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36040 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgCOByV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FhgxhvWIIVuY6B13AUlH0Smz4LynUEU/AuTeEi2VA88=; b=JXT6fiPSChn7qXiOXmjwwXvpgA
        s8s4Wg+uRCJCx5XlBEoyF6Kt31072P+FQW0bR7BJ/pNMYbms8SRs984L8eE1jqGwh0BmX3Jo0Cg1h
        p1szeizypEEEhg1Zle/Cqv3qyEJIsBjiIQplVC+xHTEO0qmMv9hM0xJo7B3KfxFLEVdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jDEBo-0002Ko-Kw; Sat, 14 Mar 2020 22:19:24 +0100
Date:   Sat, 14 Mar 2020 22:19:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Madalin Bucur <madalin.bucur@oss.nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] arm64: dts: ls1046ardb: set RGMII interfaces to
 RGMII_ID mode
Message-ID: <20200314211924.GC8622@lunn.ch>
References: <1584101065-3482-1-git-send-email-madalin.bucur@oss.nxp.com>
 <1584101065-3482-4-git-send-email-madalin.bucur@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584101065-3482-4-git-send-email-madalin.bucur@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:04:25PM +0200, Madalin Bucur wrote:
> The correct setting for the RGMII ports on LS1046ARDB is to
> enable delay on both Rx and Tx so the interface mode used must
> be PHY_INTERFACE_MODE_RGMII_ID.
> 
> Since commit 1b3047b5208a80 ("net: phy: realtek: add support for
> configuring the RX delay on RTL8211F") the Realtek 8211F PHY driver
> has control over the RGMII RX delay and it is disabling it for
> RGMII_TXID. The LS1046ARDB uses two such PHYs in RGMII_ID mode but
> in the device tree the mode was described as "rgmii".
> 
> Changing the phy-connection-type to "rgmii-id" to address the issue.
> 
> Fixes: 3fa395d2c48a ("arm64: dts: add LS1046A DPAA FMan nodes")
> Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

