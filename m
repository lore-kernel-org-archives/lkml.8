Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E702074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590698998;
	bh=7aBAkBStrQpgLaED1qWf+keYdTiiz7bRX4+GDC6E6II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mboOP46WQk6NjJ+j+cGnliZ1MzzFQyrMLh58q404Oi47SITeuh80tPPw+9xjljHGS
	 5/U8KqFXG2zzJfdo7oHgZ92/URo4ZlyEwGfUPycUj0n58nLcsBIqT+Q3qRnmTk8j4x
	 YRCojwiVCpb4HTfVMuDb28eVVRCnRHDyzHeYtboA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407417AbgE1Ut4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:49:56 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46602 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407344AbgE1Utv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:49:51 -0400
Received: by mail-il1-f194.google.com with SMTP id h3so268003ilh.13;
        Thu, 28 May 2020 13:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nSZ/8oTeGMv6mm5ev1BizJPaVqmDK8O3m6OqeHoCqSM=;
        b=Bout/g2wmFeVKj3pBzFQhAHx9sAxyw2zAIMcYXbTG+CLJvtmrPNBTxr8kD6yvMhuRE
         La2UKxFNe+4PEV302RTqtV+Z9Zh6KlRvWgw/k24gp2gw84+7RX2pl1+OZA0QpSbDAStb
         FO5Tma40z5vbuNSPzfkECZUZmbrrYjqcxv/44ZV8uwteBiuM3H53xlucrmcQJ8WE7Wm5
         piyfgBV20yZUqchqrhAbZ0Lj1XodIniAeaa7cmp+iy1uL1NF9PjpX50LUOPxqnielHyZ
         XLiWC9qMyXa5a3qh3GqwQEJ6UVXj07yBkvCloWYBEcB1WjayGok9AoHZ1wxJ8DHFbdux
         5P7w==
X-Gm-Message-State: AOAM5323lDjPZzKVq142vyDMc9si5mGJ5g1cjriW0rHiLCLExVHsVhb7
        Sf1H9sU1Y5bjaSsgvipuqQ==
X-Google-Smtp-Source: ABdhPJw7/NSMKWDXcM8J2GXfV1LVjCAv7PFbVY4HduH122XtdzecNPaZbBNJXvaB2WOxTkpJtUWWXQ==
X-Received: by 2002:a92:de02:: with SMTP id x2mr4659376ilm.267.1590698990861;
        Thu, 28 May 2020 13:49:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 129sm2825664ioy.0.2020.05.28.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:49:49 -0700 (PDT)
Received: (nullmailer pid 652010 invoked by uid 1000);
        Thu, 28 May 2020 20:49:47 -0000
Date:   Thu, 28 May 2020 14:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     devicetree@vger.kernel.org, airlied@linux.ie,
        p.zabel@pengutronix.de, thierry.reding@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, sam@ravnborg.org,
        mcoquelin.stm32@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, alexandre.torgue@st.com,
        mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
Message-ID: <20200528204947.GA651938@bogus>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-6-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589800165-3271-6-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 19:09:22 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Add documentation for "ilitek,ili9341" panel.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
