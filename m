Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE97C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DE22077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="EDGj7zDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgFESIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:08:36 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20426C08C5C2;
        Fri,  5 Jun 2020 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qOWKSN6fy8i1wsii+C9kQcUD/H3uhG0+JUSv3RW0hT8=; b=EDGj7zDa0TosrsbOciky1SiUJp
        hH5AbltKRt7XwbyothGG3DvtRN5/x8PcufbF4rTxO1RvJkDXpt5juFNR0pgzaRqAtBvK6KYRlAHm7
        Kx30rPWd7H71ZMLfPQfuyY+rxZOI1hF0TfFQd403uzctnlHu86hrmm5oE40bqaIhfohWWfVt+KmT7
        Utv38QoYMznVK1t/o2+p+iZLlB9JDc6t6r3U1UHQNoytKfdF7BaToc1aWs7nbZbcb5Mak6uraC29h
        2aP++vY/IOw78Vnqbum7SqfKF+pEWeXs9cl29thqP4VaVLMDx0mAmGDVE5wF50NSiJGKEJpTIfNcO
        lhTQpTkw==;
Received: from [2001:4d48:ad59:1409:4::2] (helo=youmian.o362.us)
        by the.earth.li with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1jhGlZ-00037H-Ea; Fri, 05 Jun 2020 19:08:29 +0100
Date:   Fri, 5 Jun 2020 19:08:24 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] net: dsa: qca8k: Add SGMII configuration options
Message-ID: <cover.1591380105.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of patches adds some SGMII device tree configuration options
for the QCA8K switch driver, and the associated documentation.

At present the driver does no configuration of the SGMII port, even if
it is selected. These changes allow configuration of how it is connected
up (i.e. connected to an external phy, or to a CPU, or to an SFP cage)
as well as allowing for autonegotiation to be disabled and a delay
configured.

Tested on a MikroTik RB3011; the second switch is connected to the CPU
via SGMII.

Jonathan McDowell (2):
  dt-bindings: net: dsa: qca8k: document SGMII properties
  net: dsa: qca8k: introduce SGMII configuration options

 .../devicetree/bindings/net/dsa/qca8k.txt     |  4 ++
 drivers/net/dsa/qca8k.c                       | 44 ++++++++++++++++++-
 drivers/net/dsa/qca8k.h                       | 12 +++++
 3 files changed, 59 insertions(+), 1 deletion(-)

-- 
2.20.1

