Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF0C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5815A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594628415;
	bh=JYqWxpo4yL4jdbOLhB+e27SzzzPd6sbYyeUSppl1MN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WyMQTrw5DFhb4qYKaI/Jp7ZvsTEeDncDCoekaPVY8CNznHWqaSIc5bRlnbPW+FlU3
	 OA5XZBlWjUwVJo6VDtaMesXt9vY2I9AkFUuzBegP858FQ+AFGZAdLc4u1oqwd+wEmh
	 GuTcSYo7CDlINADsnCxtCV0x6zh95jZVx8jQx9Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGMIUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:20:12 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8F920674;
        Mon, 13 Jul 2020 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628412;
        bh=JYqWxpo4yL4jdbOLhB+e27SzzzPd6sbYyeUSppl1MN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3iwQbCB0B5amG/93J+rh/B6llfUmsk+8uU9Q3+T7uXYe8H0185I9f2O1eOMcshW9
         OG7EypxhY/MAW/pl4HDzJ/JS6Uu0H3F3SUB/OAEAAkh7OmrXnpNcxhlWuKC/xnh2pS
         r4jqKIiHc5MjvgPH4TciqCAngcLgUE1B2cYGIiAI=
Date:   Mon, 13 Jul 2020 16:20:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH v3] arm: dts: ZII: update MDIO speed and preamble
Message-ID: <20200713082006.GN12113@dragon>
References: <20200708011627.7427-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708011627.7427-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:16:27PM -0700, Chris Healy wrote:
> Update MDIO configuration with ZII devices to fully utilize
> MDIO endpoint capabilities.  All devices support 12.5MHz clock and
> don't require MDIO preable.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

We use prefix 'ARM: ...' for arm dts.  Fixed it up and applied the
patch.

Shawn
