Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBCAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0EB214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="te/iy5+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgDSPMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:12:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48346 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgDSPMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SoRCxIvpuCeHu1TIxvBTK9F+yJrLj3NNUim4UUn1SVw=; b=te/iy5+PcILtcbIkQgl746MUu+
        BKgEXochwUq9tR/JK710+SPJEyCVzFcfDgDElOBzGPaYsA9sGQqu0NRCYCcQVdiDT5CYB3TQkV1oE
        IuCLEz/znltZ15pzz4+oSTDnGazGQ7hvzQL42YLPApSWL7RqMVQUrMkQvSuZTcJCMyKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jQBcC-003eJQ-Eb; Sun, 19 Apr 2020 17:12:12 +0200
Date:   Sun, 19 Apr 2020 17:12:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: mdio: Make
 descriptions more general
Message-ID: <20200419151212.GG836632@lunn.ch>
References: <20200419030843.18870-1-f.fainelli@gmail.com>
 <20200419030843.18870-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419030843.18870-3-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 08:08:43PM -0700, Florian Fainelli wrote:
> A number of descriptions assume a PHY device, but since this binding
> describes a MDIO bus which can have different kinds of MDIO devices
> attached to it, rephrase some descriptions to be more general in that
> regard.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
