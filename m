Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFAC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803E1206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589337392;
	bh=Qb5YxbKNqO1hjR4pk5SxGUBqWRwEltCvitcnmRDfo8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BjdGgbBje5oF/fCZf/Mjgh1hUixDvtOYsy4Oz42VCJ8ENb/W/7ulUengpwdi6PSGV
	 jpz8sJJ8eamFl28qNyGfPIBCNs4pZhTpDjtFAdD54ss8tCQsalKoE9y7M1jhyENwsd
	 xCplGXRwe9IqXOVTw2g9pY/jSS2PLpe1s6juKQQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEMCgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:36:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33090 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgEMCgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:36:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id v17so4318519ote.0;
        Tue, 12 May 2020 19:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wnpVWCP9xBr9T5vBuXfOUZYJmzKN5pB5SkDibuLBzk=;
        b=FT+1qp3jZ7RryKZn/yLsf/L3DjeWWgAnJ5VVmyKlg84ndAIFLKzbzo0LWWzQUUg/or
         S1B3nhPLpELNMtzDYOe6jvmBSqjOaX4IwCFRK7+pTBHRz8HevysjA1OlmP5kMCxSQrqE
         /+t6m6l+FC1eIt78Co9NOfwQZk6vqRGOSG0OxyK7uzMzcGb0FP61oowTp4X+5ysn4Tu6
         r2BTxx4gL+Su/NaTIzVn3Q+s9Gluj13xncxFXVFOlOJe+o4RPFT92bI6P06oU12LX+6D
         ecneM3YGOjZcYHnuqb7Capo5+h2X0dQKvNtFNPwx/oqIRggf5r59xdDNQti5RAQPiFrf
         lZRQ==
X-Gm-Message-State: AGi0PuZQO8LOlPfXC0DZsIG5QIrP4V/4jSsell9e57TAO21MEBQEDHkP
        bgJ4082dGf++37deA6d7NQ==
X-Google-Smtp-Source: APiQypKz7w9+ujTbnNAlV8a7KsmclyFkQEi30VtmO7E5fGtBxfkqysmHbHJboQKagQghmmKJ5z4EkQ==
X-Received: by 2002:a9d:7390:: with SMTP id j16mr17748738otk.43.1589337390334;
        Tue, 12 May 2020 19:36:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q65sm658569oia.13.2020.05.12.19.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:36:29 -0700 (PDT)
Received: (nullmailer pid 23099 invoked by uid 1000);
        Wed, 13 May 2020 02:36:28 -0000
Date:   Tue, 12 May 2020 21:36:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        netdev@vger.kernel.org, David Jander <david@protonic.nl>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v1] dt-bindings: net: nxp,tja11xx: rework validation
 support
Message-ID: <20200513023628.GA22844@bogus>
References: <20200505104215.8975-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505104215.8975-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 12:42:15 +0200, Oleksij Rempel wrote:
> To properly identify this node, we need to use ethernet-phy-id0180.dc80.
> And add missing required properties.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml  | 55 ++++++++++++-------
>  1 file changed, 35 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
