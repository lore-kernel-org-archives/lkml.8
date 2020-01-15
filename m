Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4943EC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1F92053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579101929;
	bh=fXHwWrM70vqgMiNEcITYA/2VoMaOOkctg8qxw/jut9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jC9/ELh8cpECwODMu4F3ISdU8c5O8vI8tssTa6C1MqfOixR4YjtpdfQJxt9euStul
	 wex97TKvDflLeN5U+wK3IEvZGFFBpbqaYE47fAgjbmWr6S/54HD1lpB8x2zCVcwdDn
	 OI18/xhGQQV6c4Q+G12JLK7AwL6oZpbZAy9uYsPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAOPZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:25:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38699 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgAOPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:25:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so14296209oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFi9eiSujdmRgUALnYgUAdNpHS3NpE41hamHBXYiuxI=;
        b=dxue5j6S0FArJ1t/i4Ca7hoRW2gCVp22oHSQ5ytUjiFFjOkwkIdm/tcaeYjW8Jwrvp
         GRCBekR2Vu/6t9wcFmrn9GBGuiB8iOvpGxRjLQnTO3j66whtzfgbYCgZfRGBMU5/rajk
         Nag4DYkKFJi/vEIaeKjuCR4ghP1FOxHn59dR7uMahYIKcUHyGmG+b+FZCUkichf7HhqJ
         gBWegjY2d+toU6cM4sNBZX5p15DuOyYmNf/dx45zwhM3DBqE7GIsa86l0eFjID2Se1zm
         nNXZDAArWbND/0UNy7qKs2s8MmPSVz+4d/sHEO9OBqHtOne0Cs4p/NJr5K3iOJVcLAMP
         P9gw==
X-Gm-Message-State: APjAAAXtdoQ/NvbJ1pW30DtQg3tO65Dq7l1DyZoZnaX6Pda3F45HoPcs
        vJt4ouEkisYxkFZ8Ad/7alP2wM0=
X-Google-Smtp-Source: APXvYqxbvTLnARgPUediqb3CMuoMub/gZrv57lgIAo/wn7U9reLTQJ51v4mzACCKYJLI0UH/PWUU8w==
X-Received: by 2002:a05:6830:c2:: with SMTP id x2mr3211022oto.8.1579101924512;
        Wed, 15 Jan 2020 07:25:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r63sm5687292oib.56.2020.01.15.07.25.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:25:23 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:25:22 -0600
Date:   Wed, 15 Jan 2020 09:25:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: input: touchscreen: add compatible
 string for Goodix GT917S
Message-ID: <20200115152522.GA15943@bogus>
References: <20200110162608.1066397-1-icenowy@aosc.io>
 <20200110162608.1066397-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110162608.1066397-2-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:26:06AM +0800, Icenowy Zheng wrote:
> Goodix GT917S is a new touchscreen chip from Goodix.
> 
> Add its compatible string to the device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index fc03ea4cf5ab..c5447b136eb3 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -8,6 +8,7 @@ Required properties:
>  				 or "goodix,gt911"
>  				 or "goodix,gt9110"
>  				 or "goodix,gt912"
> +				 or "goodix,gt917s"

This binding is getting converted to schema, so you'll probably need to 
respin. In any case,

Acked-by: Rob Herring <robh@kernel.org>

>  				 or "goodix,gt927"
>  				 or "goodix,gt9271"
>  				 or "goodix,gt928"
> -- 
> 2.23.0
> 
