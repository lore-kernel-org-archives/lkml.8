Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DCC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27F024680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730299;
	bh=lOBT0rdMCmtOqrkTD8P4KrT49+XAZOvwcefk8pJTKUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z3cfUF/nzPbZc2G/+I+gwpvhTwuaPxqWCd7Mc5A2Z98g1vdZdOTa15p2dQkLz9ltU
	 YNgYooJQOfKkcGrKaF04mpreg8txQgGFFy7sbZhADMyGIV7boYt5TFvJpHLrCFXSrD
	 TU9g6xuANRbfrDVKRwKO4PwdfvgTfXrdW4Jin3Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgBZPSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:18:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32774 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBZPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:18:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so3405673oig.0;
        Wed, 26 Feb 2020 07:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYm1FLvzpWart8O8B29NpqJZu5CXwIwbKoUSVw9pzR8=;
        b=tieY87XJGSGh1enXhQfyKlavXEM6nZl3IEh8Fhg9wTKpA4p4STWSeh4FhXzPbUb0i1
         SDjzBcDAEnHcPR59ngRmDPmxXwA1Tan/y+NN/olwMpcbOT8pzn9/8Ik9Jy0qHtL+RofA
         oa4he+4jQpfuN0cngszX7PTVVsebsS48OoKl81A964chGAu6W0OPKS1VAtz7wj1wD+v4
         MbTc0aW9WfzuA26VDPd5asVHs7MM+e8Egp5L0vz4o5dunfCDWS+pkGxRqKnAnjPB96s/
         ysxauk8JconpZCs+XiEqG422EnXIoE+cZKtlJxRQVroWkkTtL5S1IpiZG131Njx32e4C
         fjog==
X-Gm-Message-State: APjAAAXvhNmFR+XCqSIFS4RAkVXKhD5uQoNCW2ATmwaF+C0iF0BIslsz
        GkQ4iC7MZEp/yaTIEy+h7g==
X-Google-Smtp-Source: APXvYqx2YW5yQL3vP6vRMKcu64GAOBwTbSvG2qgbbAZWZqs/Hl8t2xyHxllc7hnR9+UoRACfoez3Mw==
X-Received: by 2002:aca:5646:: with SMTP id k67mr3608068oib.166.1582730297617;
        Wed, 26 Feb 2020 07:18:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p18sm214800otl.70.2020.02.26.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:18:16 -0800 (PST)
Received: (nullmailer pid 21302 invoked by uid 1000);
        Wed, 26 Feb 2020 15:18:16 -0000
Date:   Wed, 26 Feb 2020 09:18:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        stable@kernel.org
Subject: Re: [RFC PATCH 01/34] ASoC: dt-bindings: Add a separate compatible
 for the A64 codec
Message-ID: <20200226151816.GA21237@bogus>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-2-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:42:17 -0600, Samuel Holland wrote:
> The digital codec in the A64 is largely compatible with the one in the
> A33, with two changes:
>  - It is missing some muxing options for AIF1/2/3 (not currently
>    supported by the driver)
>  - It does not have the LRCK inversion issue that A33 has
> 
> To fix the Left/Right channel inversion on the A64 caused by the A33
> LRCK fix, we need to introduce a new compatible for the codec in the
> A64.
> 
> Cc: stable@kernel.org
> Fixes: ec4a95409d5c ("arm64: dts: allwinner: a64: add nodes necessary for analog sound support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
