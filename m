Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE409C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D05206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589235982;
	bh=OUNODua/XP+uGHleC63oQoqv7mGwj75LS3PC2du8rMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rd/d4rIacbl0n0wUa/URPUSP0SqxKS12Yr4ptpfmW0ZMbrSBlUfNHbrDKbnrlPAgB
	 bGGvYmDB0+9h7+FF9Hr+i61MRTHh/8ozEo97wCk3a+/zwUSjz68YYHxO0Vpb8SLM7M
	 AT+7jh0SN4nKG2eIs/vzvRWqPHFrSfR7Vg10y85k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEKW0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:26:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42294 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:26:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id i13so16560937oie.9;
        Mon, 11 May 2020 15:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GeCkeYpXNX1z0Dt2MixWzuFP/3nex9jVFyoU5cNVRLs=;
        b=OM6Oh6PGW43GnXmicyCH/b5IqW+zYrnMwnX3pb/ot9gvBy3vAAZG/0PbkqF/0J3Ftb
         KzjqufM8o4j6yIi4yx1wWv4UiPnl9YLIFkeZqJsLrIjrN1M1sCM/o3VHRQx+xw9/XSKc
         li1mGItovLmRmFf6CeknYEZt882dpieskD10yWV18GtNCQ7kLTBRGV9Fi4x7PtWhjhr6
         s3dS11WF0vmv9fo2as+u5Ykkfp+AwhBC9gHfgypi4ArMFjyKPVN5SFiuCNyxDP6Iy4hW
         j3NtD3TAkd4b22MsgmfvZrAKRZCirYXC/FdVHXrHXL5pIT6CwcpghOi0P5b+2dPNmAx9
         DL4A==
X-Gm-Message-State: AGi0PuapcyF/fApqYCFRo1j4WTTfMCprIrB4uEcGFl8IJoiQTMia8GNb
        hOQqaGZtdZcYQwW0i1ikiwi/rJQ=
X-Google-Smtp-Source: APiQypI7l3460K6I+pSKo5GqHd8yXHAenw18v+/L3BoW00FvQNghiaUyqF66BrvnvvqyVBwfHGm+bw==
X-Received: by 2002:aca:4a0c:: with SMTP id x12mr21205361oia.19.1589235980743;
        Mon, 11 May 2020 15:26:20 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p17sm3180892oot.17.2020.05.11.15.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:26:20 -0700 (PDT)
Received: (nullmailer pid 27324 invoked by uid 1000);
        Mon, 11 May 2020 22:26:19 -0000
Date:   Mon, 11 May 2020 17:26:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Message-ID: <20200511222619.GA27288@bogus>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426104115.22630-3-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 12:41:10 +0200, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 I2S is very similar to H3, except that it supports up to 16 channels
> and thus few registers have fields on different position.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
