Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC20C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB6A206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589249028;
	bh=Muu4VhhqVZDslhmbfFL8Lp1SgYdkj3IilxcG/iL08Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n/wP03VeUdqPHCkPS8pxm4o/1r5AYYR1ShNR50QHhliFcJLfJpi1ilYjWX4NuHWcX
	 Tu4g7UpCPSwtittHmk4d9BoU21oXMKtGJTpzVxy5ga13zd9N2e8egkkm2T3ZBkBFxG
	 NeqLtHCVmLNEoq+LvX0EvkhVewj044dVV05REGFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgELCDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:03:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36176 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgELCDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:03:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id x7so16035351oic.3;
        Mon, 11 May 2020 19:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SKTqH2487aYveoMwIVxq6ys5R52y2QbI8FHInFwCoT4=;
        b=k4x6ooGN2IKYwWa8FW/wGpdAB5FHc4+p4rQp0oii0ZHAvuLnFSO62TfxsJiS281rgv
         1pid3ULANe6vvZqfCJwWGszsnslngbaMwQjNRSAaW5vNEoKoH5lYI0bGtCRMR91eEYBL
         5jMGv+8tOQUwndjNzbG/7sH9PJtYtqQCbYrf+cKMNTsKTm5mte0pFB543oPQiR4y/Lox
         DFEVBI9uchgtnhCcj+BWc+g/693k9mw4UcVs9aL5QSW54SNOIB/pIJosfNlllAE7rk6/
         /kkhcz8TefaPaQRpC55vP9IPigRafNR7XmFNugYy9k+UMSRHCvMjdG3xO3DFu3DfpheQ
         vIHw==
X-Gm-Message-State: AGi0PuayLfJZeJYAfDRdZUO3qWbiWaH0vhXG7WzgaQqsPwQmbebo+Or5
        j/ywFN2Dv090H4IY8sBiOQ==
X-Google-Smtp-Source: APiQypKThoh2f0v295jotzN8wWr1UIn40NjN0R+gI2MP9rKPJO9N+mWi5TbzOR3yOCKuun401ZoJVw==
X-Received: by 2002:aca:ba05:: with SMTP id k5mr21268052oif.35.1589249025962;
        Mon, 11 May 2020 19:03:45 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i196sm5230653oib.8.2020.05.11.19.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 19:03:44 -0700 (PDT)
Received: (nullmailer pid 29821 invoked by uid 1000);
        Tue, 12 May 2020 02:03:44 -0000
Date:   Mon, 11 May 2020 21:03:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: Convert UniPhier PCIe-PHY
 controller to json-schema
Message-ID: <20200512020344.GA29755@bogus>
References: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588055690-13200-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 15:34:48 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier PCIe-PHY controller to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-pcie-phy.yaml  | 77 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 36 ----------
>  2 files changed, 77 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
> 

Applied, thanks!
