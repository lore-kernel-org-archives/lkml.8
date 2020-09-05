Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E60C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAC320797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599349032;
	bh=rpeS5XHUij27LdjfSXTm57hB+BZoxEGDguTEGPPB1XY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Oua+JUWgzhYK+LkIQpb1PCBbDfeBeeO4cK5xrlVh+46s16B/cD8fofbpicqB9M5v6
	 tV90QxF4yUERZ8oxkMJzvc5jhu+IQXoebAP7IJ8MpxUzWRezXAGOQ0NuyalYKRPVZe
	 9AJ6wm55sFCDppzC+nwVGBAl6rISuR0hSXU/RFPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgIEXhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 19:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIEXhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 19:37:09 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDAF20760;
        Sat,  5 Sep 2020 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599349029;
        bh=rpeS5XHUij27LdjfSXTm57hB+BZoxEGDguTEGPPB1XY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fj9AGwiRHUE4yk+KXhFmB7MuGeJ+yfwxEs9krALrdFd4z9ZKrxI0PT0F4w0rslDxS
         gbsrnSN4Ln61IQLrCV54Zb5BjSyKCV4zsvP4YD8x81rLVcdNTit0lornd8uUS2w0+i
         E2AP8cR6ir1bgoY37X/fOh4Kyf/7cfdOP2P+jmDY=
Date:   Sat, 5 Sep 2020 16:37:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Landen Chao <landen.chao@mediatek.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <frank-w@public-files.de>,
        <opensource@vdorst.com>, <dqfext@gmail.com>
Subject: Re: [PATCH net-next v3 3/6] dt-bindings: net: dsa: add new MT7531
 binding to support MT7531
Message-ID: <20200905163706.60cdceb5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <4ec3c9e6a219c09fc90d1be8d3d63da587ef6fba.1599228079.git.landen.chao@mediatek.com>
References: <cover.1599228079.git.landen.chao@mediatek.com>
        <4ec3c9e6a219c09fc90d1be8d3d63da587ef6fba.1599228079.git.landen.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 22:21:58 +0800 Landen Chao wrote:
> @@ -32,10 +33,13 @@ Required properties for the child nodes within ports container:
>  
>  - reg: Port address described must be 6 for CPU port and from 0 to 5 for
>  	user ports.
> -- phy-mode: String, must be either "trgmii" or "rgmii" for port labeled
> -	 "cpu".
> +- phy-mode: String, the follow value would be acceptable for port labeled "cpu"

... the following values are acceptable for port labeled "cpu":

> +	If compatible mediatek,mt7530 or mediatek,mt7621 is set,
> +	must be either "trgmii" or "rgmii"
> +	If compatible mediatek,mt7531 is set,
> +	must be either "sgmii", "1000base-x" or "2500base-x"
