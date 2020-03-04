Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E952C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18A822B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583341180;
	bh=D3DWAzE7lXzBXa6MkDZ1aHSTdDK/3GCq1FpOc5RvoQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b0v14/sIoxkCYuHa8y+J/dWf4N1NJ0NsEobKJdxOz/m4RS2BRQatLys7mb9H158ia
	 2vDObv1akSFu5zm6CciNqqol2Y5ZKj2/hT3IovVd+d2jryPEIkKWFz8plqeEPeMqU5
	 D7U7HoP4booNwZIp7LioGh/cnS4YvPjFwVcnVeOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgCDQ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:59:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43920 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgCDQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so2767392oif.10;
        Wed, 04 Mar 2020 08:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5qYk5LV2HvuAA3RTvLtS19iOY2vZnT+j3lgBzg3rO4c=;
        b=buQk3IbGrVhX3hiDhYj8wTpE20naBpN5eBF7DpN0rHW57XbOUR6GV0qnzW5e863bv6
         50QmPY/PIRouDrVW10bPjvrGBN1sLE2555Loc1boCZK/Hr3jJSCEnhukDrSC3J4lYOy5
         JBAzcf/dB90Rtx4m0+4jlOEnoiGlFP+hJ1Yql0C0Dab4raVtQ0XGUb9oLZVhi9Iw6XbQ
         h4EVUvjYikrz8EZ+wm18cwspCxDjY4Eu9NzrE3mzR2pX6ERu7/pfM9hSW9/qmsDYa0j2
         w7E0g6eyRxaTyDKnfdfC0tbHQYTtFUlm+FYHUXi4atRMsrxQTNk5Pm6KjmchLGqMVEVD
         VI6g==
X-Gm-Message-State: ANhLgQ2ewS4jz2Onr8+IO6eNMvtu5Y+8H6ZgmVThMNxrVMffkxdcub95
        YRHwR0bINESGecJ2E+Yhcw==
X-Google-Smtp-Source: ADFU+vsKQFMOosgtut1nZId+XHZ8todM3IQNc5Wao4BclwyECDbEk4J28eYRkQGV/GnWhctr6BaXdg==
X-Received: by 2002:aca:b7d5:: with SMTP id h204mr2357293oif.130.1583341168216;
        Wed, 04 Mar 2020 08:59:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i10sm3415857otc.8.2020.03.04.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:59:27 -0800 (PST)
Received: (nullmailer pid 23363 invoked by uid 1000);
        Wed, 04 Mar 2020 16:59:26 -0000
Date:   Wed, 4 Mar 2020 10:59:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: Document JZ4770 PHY bindings
Message-ID: <20200304165926.GA23292@bogus>
References: <20200229161820.17824-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229161820.17824-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 13:18:19 -0300, Paul Cercueil wrote:
> Add documentation for the devicetree bindings of the
> Ingenic JZ4770 USB transceiver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: No change
> 
>  .../bindings/usb/ingenic,jz4770-phy.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
