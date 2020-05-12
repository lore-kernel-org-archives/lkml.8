Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEEC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D86206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589249044;
	bh=hZ03HRpGmcBkgGRf1gxX/+ZoRNxo5YsA4sD36zxCUw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=McPWZMNX4CtnXFTviA71+XSXk6S52oXpAKqoYcLHEwxfgNL4siIKtVzZ9Dnq/t3uZ
	 S356kMGa03ZWI/PkAj86UJwrRTpy/ltJu0aKru3LqjxHZMHoCPIVKeV6zpXYA1Jg3r
	 r0iaqawt0bjWwMvjTcT2syNudZUZ1tPFU6NDeO70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgELCED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:04:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40639 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgELCED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:04:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id i27so9262771ota.7;
        Mon, 11 May 2020 19:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDu4mmV11tyVPsQh5Aoz3L4z3EhAcUk4qA1JhtuLKlg=;
        b=om9CN63hY6DAYrWDkkmVd1ymUBedA4MnHMv343ESZEeBcnfj68LeNPSmnPcXcrRV/k
         FXdQ1bPU7aOOFC74m5H+b4o6eb6yD6/vL6QFb5IOBV+HUrtb4eZFHMWlyojYUOTH3oN9
         I819fL4TFWwNS7og7E0InjS+KaFnteQ9WRLvMHEo9qMd09UEK1abwvx/HQDmF+bKH5E8
         Q6Ms+JN6C/52/hbCKMx31OCZ+UVPhFId5jTIKzEDgLf1l5sJD0k3HLEQvq6NvnZtqiPm
         iBH/ayO6B3G7fHWIFq9o4Ha2yWzR+vmiJox6zQXd7Tm/pyHJ72mlJZ7VCynvpHYOn/bE
         84iQ==
X-Gm-Message-State: AGi0Pua0Hjs1XcmGTLHG34RQQSB1vO91iJADdNB1u4hK/p+hYjEcBhVW
        +KU+gFhs7iJG/II5boecHdX3EuU=
X-Google-Smtp-Source: APiQypJkVVYlpiJlep8gi7WUwcLRNXzQDKQDB/F8V0m7Gmj0RuB3DwwvNOM5CnokbIqtZlU73PSD5g==
X-Received: by 2002:a05:6830:2439:: with SMTP id k25mr14529338ots.76.1589249042366;
        Mon, 11 May 2020 19:04:02 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm5107068oih.14.2020.05.11.19.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 19:04:01 -0700 (PDT)
Received: (nullmailer pid 30407 invoked by uid 1000);
        Tue, 12 May 2020 02:04:01 -0000
Date:   Mon, 11 May 2020 21:04:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: phy: Convert UniPhier USB2-PHY
 controller to json-schema
Message-ID: <20200512020401.GA30368@bogus>
References: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1588055690-13200-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588055690-13200-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 15:34:49 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier USB2-PHY conroller to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-usb2-phy.yaml  | 85 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/uniphier-usb2-phy.txt  | 45 ------------
>  2 files changed, 85 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
> 

Applied, thanks!
