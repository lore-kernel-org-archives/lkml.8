Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98161C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E8B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594937372;
	bh=n04WlQh2KrQ2rgHTRtdKBZH8KEwlrcLQlq3ED7K3LMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=neAfzqc+bZLHiMfY0xdmYkLVCctC2DS06SPOWwnIXK7/MBKtJMA31tmJs2yeD5eTV
	 nUfY9bu1e4jsYasqPmI3VuAs5s4u4xH9xcuqYPUK3uKpKU9DrOa8lspF3MGpmuntyt
	 bJ8K3tfnMgRAVbcVUGBC4qVCW5XcUMKQmYxtidJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGPWJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 18:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgGPWJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 18:09:29 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA8420853;
        Thu, 16 Jul 2020 22:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594937368;
        bh=n04WlQh2KrQ2rgHTRtdKBZH8KEwlrcLQlq3ED7K3LMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wPdJ8JHXePyNrzqg2JLYyWBVT3UqOn7zAiWgefK9thDfzA0he1IzLu7565joxYL5X
         CQkYXp8iwsn3enreTjX72DVTiSZ2Feen5pNKHTfDzBbw00ZLvWUOp6PGikD0+h2YBs
         LNvGB2sIQdLn1cWYJS9Mo8tigD0rtM+toCNyj98E=
Date:   Thu, 16 Jul 2020 15:09:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Matthew Hagan <mnhagan88@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Jonathan McDowell <noodles@earth.li>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: Add PORT0_PAD_CTRL
 properties
Message-ID: <20200716150925.0f3e01b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <ea0a35ed686e6dace77e25cb70a8f39fdd1ea8ad.1594668793.git.mnhagan88@gmail.com>
References: <2e1776f997441792a44cd35a16f1e69f848816ce.1594668793.git.mnhagan88@gmail.com>
        <ea0a35ed686e6dace77e25cb70a8f39fdd1ea8ad.1594668793.git.mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 21:50:26 +0100 Matthew Hagan wrote:
> Add names and decriptions of additional PORT0_PAD_CTRL properties.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/qca8k.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.txt b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> index ccbc6d89325d..3d34c4f2e891 100644
> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
> @@ -13,6 +13,14 @@ Optional properties:
>  
>  - reset-gpios: GPIO to be used to reset the whole device
>  
> +Optional MAC configuration properties:
> +
> +- qca,exchange-mac0-mac6:	If present, internally swaps MAC0 and MAC6.

Perhaps we can say a little more here?

> +- qca,sgmii-rxclk-falling-edge:	If present, sets receive clock phase to
> +				falling edge.
> +- qca,sgmii-txclk-falling-edge:	If present, sets transmit clock phase to
> +				falling edge.

These are not something that other vendors may implement and therefore
something we may want to make generic? Andrew?

>  Subnodes:
>  
>  The integrated switch subnode should be specified according to the binding

