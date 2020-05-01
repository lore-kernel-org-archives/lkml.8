Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46267C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2520A208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588366046;
	bh=K1UJbScijRFcCXajmpVTvXO859c90gVQ1HbYYQy7p0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cw4llS+BRFm0PbkXj6zriSsBJLfz+6GRz1IGJ4NnjRdt3+EtVToWn38XuaEq2Skmq
	 tV28G1MN8olDSD7ELGJwQv8m5MoK/nQ2ls5UXeKNzjP3nK4gtKrJw1k/AWP7utfi7J
	 BKLYHxU2E31+0wZTVU5RNZfAzNZE1bXJy3E2+tUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEAUrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:47:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33983 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgEAUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:47:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id x10so859270oie.1;
        Fri, 01 May 2020 13:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fY2wcMRDvaDdEsMuW+EbzLJIuWO2/jSW7iWLuYHZGY=;
        b=GhbLjvR1ppXSKpolyiRflb6/slQ3SrKabvI4Y8TVRQyVSk8VYpMv7XoZIKTeg0sOFR
         qtuMKiiNO1Vj4wDDz+Gr0YWFrzOrCt6o4kjSM/v6y9E4WVzTdjqwu+wW1ihL89uWCu53
         6lK7fxbrurQ00blqkzAlfc59061BivZVxHPOz64o4Pw1PJE4uiOeM74S01kXIbm9IAjt
         sIxqYvYzBFdrX/U/6Uog+b16sxME5zupIwu1A48q+FB5ob1uBBRY8eG8LpsIUtilGt1w
         lcHNx9Hd41gufRJQS6gM3LcXllJYCgaHTBr8MmoqA5C4eYyuM8paspfTGHd8hUna0m/E
         aWQw==
X-Gm-Message-State: AGi0Pubv9UOaGr+Y22p86MrVgmeHK3eFolbEaGrpTlGv6wQYM/OYYWLY
        gcHhsqvUZIRSeQQVx3gY3g==
X-Google-Smtp-Source: APiQypJGlQX0wY8vCyWjfX9DVN3x/OlvBqDwk3ytJGursRufoKviEcoZGmJlbzOHYMKi/ZDA8mGgHg==
X-Received: by 2002:aca:1007:: with SMTP id 7mr1115114oiq.139.1588366044000;
        Fri, 01 May 2020 13:47:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f16sm229631oib.25.2020.05.01.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:47:22 -0700 (PDT)
Received: (nullmailer pid 26260 invoked by uid 1000);
        Fri, 01 May 2020 20:47:21 -0000
Date:   Fri, 1 May 2020 15:47:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 6/6] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200501204721.GA24163@bogus>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
 <20200427103614.GM44490@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427103614.GM44490@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:36:14AM +0000, Charles Keepax wrote:
> On Mon, Apr 27, 2020 at 11:28:12AM +0100, Charles Keepax wrote:
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > +            lochnagar-pinctrl {
> > +                compatible = "cirrus,lochnagar-pinctrl";
> > +
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> > +                gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
> > +
> > +                pinctrl-names = "default";
> > +                pinctrl-0 = <&pinsettings>;
> 
> This seems to cause the following error:
> 
> Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml:
> lochnagar@22: lochnagar-pinctrl:pin-settings:phandle: [[4]] is not of type 'object'
> 
> I think the schema is correct and the problem is one of tooling,
> I have been poking at it for a while but can't seem to find a way
> to silence this one. Any advice would be greatly appreciated.

The problem is the "^.*$" patterns to match child node names also match 
properties like 'phandle'. Ideally, you'd have some pattern to match on 
for the node names.

There is work-around doing:

"^.*$":
  if:
    type: object
  then:
    properties:
      ...

But I much prefer to see node names updated. '-pins$' is a common 
pattern.

Rob
