Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B76DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565B3206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598295441;
	bh=VIxsi6pKlUk6jLXdG3ngDMsGUa+mr1eJxnhVIzUwRdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lr4d2OzEIVvhE5DIfKsau5Agqm39mCyRi8GoexDaMSb1ZTVzlkffRSSiqKFlwrwkf
	 sX2S/gwmHDe30FhSgv5VdprDvjYJLjOtzVSuwGrcaszZM9NfCNWgyQwbj0+3wmjIGS
	 6hZQU06O/o4USBXwDMllkmzMuSq8f4NNadmsxxQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHXS5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:57:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:57:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so5979601wrn.0;
        Mon, 24 Aug 2020 11:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQhiydvyZvtI4AkndXV4Ei79Fq7h8nBWuDS5mk8A+F0=;
        b=rIfwo9rhRRh0g5TN0OIVYNVVOttzUd7Jq90/ISM444eZs5fza10r8PczEXRgs37lL6
         NLZXai9JeVYeuuqNWk181SEbnPdEi+07aytCQUQ8seYf0EeyvhMODvb8y3YRB/eM5Im0
         50Nh8bEVdEdSN/DGcO566VGeDpagcJ4ti2SuQMoZ8u4eHFvlnZg9tIhYGsvtIhsjr2IT
         Eo0TPchi3f46rswZiT2gF92cEh0WjhCD+aMKUUUnLwDmKVAEO2BIvxicbQchTbE2zZ0m
         ADmUAJFlkHFloi8962o56UMtH/I92DOHB2OB4dZgBcb89U9S1PMenBgQ7S4wKQlDaJWb
         9n+g==
X-Gm-Message-State: AOAM530FCdIFJBZANIwZs1wqg57yUTowHGVbKAyY4pjbqFLYagc74d9o
        EQvGyHatV7W+nrFvdeEEmN0=
X-Google-Smtp-Source: ABdhPJzfd8aU7PxeJTRxSoLO5DZQkOjQHVGDoK1JE/cVAtjHK+Y5r0t7NKDaj92geT9C2ktgFrgvjg==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr7302692wrs.374.1598295436385;
        Mon, 24 Aug 2020 11:57:16 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id t14sm29090484wrg.38.2020.08.24.11.57.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 11:57:15 -0700 (PDT)
Date:   Mon, 24 Aug 2020 20:57:13 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mm-var-som: Add Variscite
 VAR-SOM-MX8MM System on Module
Message-ID: <20200824185713.GA5343@kozik-lap>
References: <20200824160247.19032-1-krzk@kernel.org>
 <20200824160247.19032-3-krzk@kernel.org>
 <CAOMZO5DquPR9BmQP0kZfTqNJmRabPe1Vtc801M9CVCPFCd1usQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMZO5DquPR9BmQP0kZfTqNJmRabPe1Vtc801M9CVCPFCd1usQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:33:50PM -0300, Fabio Estevam wrote:
> Hi Krzysztof,
> 
> On Mon, Aug 24, 2020 at 1:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > +&ecspi1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_ecspi1>;
> > +       cs-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>,
> > +                  <&gpio1  0 GPIO_ACTIVE_HIGH>;
> 
> These should be active low as 'spi-cs-high' is not passed.

True, I'll fix it up, thanks.

Any comments for the Symphony DTS before v4?

Best regards,
Krzysztof

