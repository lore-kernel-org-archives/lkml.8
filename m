Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC2C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54842070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585001514;
	bh=0SFNX+KNG0mT1qcnYA/8qXz0HxLAOipFcFinQJJVi2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mms3s6ESnQJSpl6y2cZSR/JSLPm6p6q84NFcvWDOKi85DJ96L3mglGu7LRfgyhljG
	 BYzY+axKeyFVSlZr5zTu0DahALdrsyjTIm/vt7bFP16Ps0LdRZJa/jBjyKMGm8iSXA
	 wlaJSolaekYimS8qqqSz8TicIfwrDu+5+IT7Ts5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCWWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:11:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39650 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:11:52 -0400
Received: by mail-io1-f67.google.com with SMTP id c19so16082678ioo.6;
        Mon, 23 Mar 2020 15:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U1+vG2jcfIWPGJPzyBp74dMfazPVWUvbyc5a9UEJny4=;
        b=epj38hrD/ybOuH/WcTBJWwpzQMsVscA9iCZqnkA+UDCixXGADj4IJm0PI3mfyjR71T
         gNhhGiPQeFNN2d//pPaYiddu/MO461SDdgXA3b7W530zF7UCeYA+kr7T7Z9uEr60flYD
         DxEPjLjdLF8jqWu4Y/M1dbB2F2Bf/o8QSdooFH1j1A/pV49Is5FR6U3GEs5f+rc7ver0
         bu+2I4tfHWKduHCzZcSK/pJeItheI1N0I2BNfy1buzt56VzFRs04pD87usYv2rtcpxlm
         8xoe+fK2sV8NkA/x/HR2pcTET9czhxH7giING8G6x9QsGeVo73+leOSdmJZBCqV6dlQO
         bbNg==
X-Gm-Message-State: ANhLgQ3/NpeSoXbuq0qHW0b01A5DCwxuPCtCyHYHoo2SiG59X7jFOa4K
        4AOtXFpJ99r7NNSxxQ8UEw==
X-Google-Smtp-Source: ADFU+vvetfKAazjwYEUQHArdmRpyTlu8v3T8bGybvvKdNYFA44bdB5Y0qTiQGUn5qPEk9T9rFv8mPw==
X-Received: by 2002:a05:6602:2251:: with SMTP id o17mr10228130ioo.101.1585001510153;
        Mon, 23 Mar 2020 15:11:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l6sm5745706ilh.27.2020.03.23.15.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:11:49 -0700 (PDT)
Received: (nullmailer pid 29035 invoked by uid 1000);
        Mon, 23 Mar 2020 22:11:48 -0000
Date:   Mon, 23 Mar 2020 16:11:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: sound: rockchip-i2s: add
 #sound-dai-cells property
Message-ID: <20200323221148.GA29003@bogus>
References: <20200311174322.23813-1-jbx6244@gmail.com>
 <20200311174322.23813-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311174322.23813-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 18:43:22 +0100, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property,
> so add them to 'rockchip-i2s.yaml'
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
