Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA9C11D8E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3583624686
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582150967;
	bh=PPFyD2KpxHxtue/MGXXNquiMGv4B+OkDvdfFb8vDdh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iyk103sHcH7Cp0z1pNzC5ep4f1DW5atiTzJXLJ47hNaMsRlMTlFIHl17jLWhWXkLU
	 IPpT3GRfbZktWQOGJzmWDVTankioNVJO/qt8cY7wT+vnQ+buCgkgqmFYok1luQ5zqY
	 MR47iM37ZaL7fSIjhOZk/a0/lZmxLZR6YFmOd5Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBSWWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:22:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44570 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:22:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so1739340otj.11;
        Wed, 19 Feb 2020 14:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=2sNkfWb3pfIlKB+u9ML9Dfe9kkvuZVvEoC0qldkLHAg=;
        b=oI3LdgTZBAJbQgzfbrh4jTDKwNRaJ6x5WDlckhG0M57gmhBR4ogEv5qXAgi4XhHKxe
         Z7H4wc+z7ePJJBwNwyjlt9k9g6+cIGwoQiTVamuKNUm7rUN3TBDpNO6gWSVrPZmG5Ise
         NSsJxZfbv17rlM2dGLTaLoMWOiXB1g8g4kC9gzQYOZfrE57dSdiRhpOD2pX/SV5vWmc6
         ghbxwGNViCEQ5asJBbCaB6Jmt1HVLgolwJKBqKLl2nyxFmkPi3Lli5qDOh89l9dY37QL
         kyFjteZf/Eo9a3fGNl6BB5CYsdsLIViCPfxud22jKbmdiuEZivGAV2UOb9Lt5U0m4uXP
         oNMg==
X-Gm-Message-State: APjAAAW5OWsqL7P0FZ/igQ39CQhsDjMkJQpm39aqeU2zKTwyrCVaeyHk
        QWgmf5JrlHT2mntkF4gW7g==
X-Google-Smtp-Source: APXvYqz7rt85MIurXjJi9Zhc8regbA3GAy27xdpXY9iVID53QfHaCOnwuA5h4zSXeZvXkfnK6tcwTQ==
X-Received: by 2002:a9d:6e02:: with SMTP id e2mr22323857otr.194.1582150964507;
        Wed, 19 Feb 2020 14:22:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm382938otk.25.2020.02.19.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:22:43 -0800 (PST)
Received: (nullmailer pid 13215 invoked by uid 1000);
        Wed, 19 Feb 2020 22:22:42 -0000
Date:   Wed, 19 Feb 2020 16:22:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: arm64: imx: Add board binding for
 i.MX8QM MEK  Board
Message-ID: <20200219222242.GA13182@bogus>
References: <20200213144451.31455-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213144451.31455-1-oliver.graute@kococonnector.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 14:46:05 +0000, Oliver Graute wrote:
> 
> Add board binding for i.MX8QM MEK Board
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
> 
>  this patch should belong to this series:
> 
>  https://patchwork.kernel.org/patch/10824573/
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
