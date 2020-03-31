Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B4320842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585684666;
	bh=8btu5p+gtZ79iALhpL16Cyw4ZkiVjxY3MxwdNTyM8EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uwS2tKiVFCSCgG8jgycVIcFht26wFCmEqE3GyuHVh5Em3ENyzZI1N1NboYK3CAKmT
	 U6jj41Rymu9N1XT7Q4inraW5XKiGWl0hw7KMxCmXmb/lg3txXB9NbZatZQ+HuuNvzx
	 L5EsrOjDI/GFKjEBB04hRGc4IBlba8tJfcw4ZLzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgCaT5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:57:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36421 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCaT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:57:45 -0400
Received: by mail-io1-f65.google.com with SMTP id n10so9042972iom.3;
        Tue, 31 Mar 2020 12:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4MVejpKXdUvf3pPVBrkNWcFoXIpak/ROd8AjzEbfKY=;
        b=a95HKWe6oxpNecmvI67Mc8PvzzKGOrOUZM5/SoCI2NgJyOhQW5xtenYN5+YDd9gbyC
         adtYP6a1na66nlHbaBC2pjOIcXaOtVASOQ764kEsCSND856mc2jMtfoBPgVjDlasHWYs
         U6tm+cocr7AiTYa2FcYeBoNRj7Xg6ley0Zs35hzAt9jpN1wdfAG3NEztiLni+eTolKRU
         N8J8dbK3hZob52XerxB2WBJmxTcKu7XdSyQY3BDZFUyw+kmFRNTJPTDN5m9XhN46JNpY
         YcLu6jw1qJBijNOVmvRci3cGvhof/ULJ3WrOiaVbCaEc7L1YYe5wpnN7dfzKx34aCFxh
         +fRw==
X-Gm-Message-State: ANhLgQ0YffB4Y49LKw8jm32EC+WxiI/FrS+mh1bp02FLRzJcZAXyoI8k
        4gc+PVX5Jak9YAukUXaBlw==
X-Google-Smtp-Source: ADFU+vtc5oUJqWcdHGbZePzerMkO7IsVV4rSImDoXIrm0C537o3o03dpCu4eAitRh3oGSvNBCV8CZQ==
X-Received: by 2002:a02:2427:: with SMTP id f39mr12183287jaa.7.1585684664392;
        Tue, 31 Mar 2020 12:57:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f74sm6145627ilh.77.2020.03.31.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:57:42 -0700 (PDT)
Received: (nullmailer pid 441 invoked by uid 1000);
        Tue, 31 Mar 2020 19:57:41 -0000
Date:   Tue, 31 Mar 2020 13:57:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Lu <david.lu@bitland.com.cn>
Cc:     jungle.chiang@bitland.com.cn,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: boe,tv101wum-n16: Add compatible for boe
 tv105wum-nw0.
Message-ID: <20200331195741.GA26161@bogus>
References: <20200324094525.4758-1-david.lu@bitland.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324094525.4758-1-david.lu@bitland.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:45:25PM +0800, David Lu wrote:
> Add bindings documentation for BOE TV105WUM-NW0 10.5" WUXGA TFT LCD
> panel.
> 
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
> Change-Id: I450c0e52aae080728d4794bdffc50bb0d2f39f40

Drop this.

> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)

With that fixed,

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 740213459134..7f5df5851017 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -24,6 +24,8 @@ properties:
>        - boe,tv101wum-n53
>          # AUO B101UAN08.3 10.1" WUXGA TFT LCD panel
>        - auo,b101uan08.3
> +        # BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel
> +      - boe,tv105wum-nw0
>  
>    reg:
>      description: the virtual channel number of a DSI peripheral
> -- 
> 2.24.1
> 
> 
> 
