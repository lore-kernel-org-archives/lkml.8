Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F542205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587405536;
	bh=NRW3AWSjrGeG4w4V/j4axxIQ+GlqGoEyiDhqJxBsRSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BW7OW2vPmikXmPB3nUKwI9olLY2Lz9cuuJChQirnHKb9nC0zupge3rlWvZVYCYlI4
	 wZW7mekz6h3Frc+Yuao292cRe4+JtIlnRje6I+fVv0HD2D47vmVOXgSPgACyV6Afjt
	 8mtBwE76VsEzIxGzDijUTSnHXS4yCNQpkHI/5wiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDTR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:58:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45057 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:58:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id k133so9585558oih.12;
        Mon, 20 Apr 2020 10:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5W/lQ34ReMbXEDzAwXh6BEJq3UIgkv6eyC5gc3Bzrc=;
        b=DCtJIGOOq+iLeyfXoqlKonov6uscXH2dVocB7nTZINfqAIVN0WbrXHdNbIL/bJvdai
         oVQMVNw+60f2vEFZw/OlcDZ7bKk9ELCpEmfpvyq/BxrbvfdycFLYgRDrA7uzcwqZcmf3
         UNwYx2O6g7UowndWjb2BzBP9siWPJAn+2C0q/KYFuApLkffjZBG21nvJapkBb3xSX4zK
         c1pymcxm5aIom8+aiPzKDEtLa0x3c176AYXbRtxof/651OX7ND0X/9buReTS9TyI99DX
         M4+4IVByT0Mv84DcTFpRKixgMVb7Wnw0T5gsjKAhXPhkmM1akLuaUpA9kG2DQlvTSkrl
         5MVQ==
X-Gm-Message-State: AGi0Pua+8udAhR8VxEiTG1O4lRL92uJCMMbhk4ougb1/mZ1l07w/IzoO
        0oY32BkkZCqyO+YSYEXYHA==
X-Google-Smtp-Source: APiQypJG2laHDj1gFHJr/T8u1/7WLO1L1HK3oDn1rmL0PRluF7lKVfIH0ZzkLa/bWiGt+rj/5P4Hsg==
X-Received: by 2002:aca:c68b:: with SMTP id w133mr422169oif.175.1587405534277;
        Mon, 20 Apr 2020 10:58:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm33636oos.13.2020.04.20.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:58:53 -0700 (PDT)
Received: (nullmailer pid 5416 invoked by uid 1000);
        Mon, 20 Apr 2020 17:58:52 -0000
Date:   Mon, 20 Apr 2020 12:58:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, gregkh@linuxfoundation.org,
        loic.pallardy@st.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/5] dt-bindings: bus: Add STM32 ETZPC firewall controller
Message-ID: <20200420175852.GA5063@bogus>
References: <20200420134800.31604-1-benjamin.gaignard@st.com>
 <20200420134800.31604-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420134800.31604-4-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 15:47:58 +0200, Benjamin Gaignard wrote:
> Document STM32 ETZPC firewall controller bindings
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/bus/stm32/st,stm32-etzpc.yaml         | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.example.dts:17.5-24.11: Warning (unit_address_vs_reg): /example-0/soc: node has a reg or ranges property, but no unit name

See https://patchwork.ozlabs.org/patch/1273431

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
