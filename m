Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0532B207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1mghf72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFDGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:48:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808AC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:48:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so4060526wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lPbxhCZC1S78UwHjSdvJaYwwZK9tPy6vHNcwr54qelI=;
        b=T1mghf72v+LvwdNkNm2YgkGMFDzro7fYlSZiAEGEs4deAtuLBir48vkbwGFQkUX96x
         ZRXwuuZ8gGmo0T+PsQ+mkV/0bhq8VwzyYwcdaoMqwzjkyQhkb6jBeJdnklGOrafZS9s+
         EQ4SdIykqK5USRIok5GuKSva3m1k79RORz3bi1MqYMxVbnkTP1UCq9SyooPPJ8hRXWUO
         jf+FAYdC1gv6th5jREwI6HRuIqIl6n0y7tSLvXmI7O5Iqtfm1JN2koxFpaVYlxznbkyq
         2ikMHL6BLKxIpvRj6sUqbUj5pSetcRfPc+f9nby0sCFMtVgta7EwxZN16DVCZ/nKHnt7
         /2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lPbxhCZC1S78UwHjSdvJaYwwZK9tPy6vHNcwr54qelI=;
        b=fdX1v3pGxbStq08qSSwoPbp8vLcq0582e/Wa6DMssvuDa1bos84z/vCMsFCNVEorgb
         p7HSRnbBK4+EYPQRn69UvDIhspuICH0ba4Fv7Es5MlkJmHhyXIWDPUitoody1WkT9KWK
         nteclIn35aCuOjWpkus3QyiAFr0nNIbCRQuOFgvOiHBrE+oyyRlNXrhurk4csz+dMsEf
         bZvfHCA6QFdUWusirG1t38Du5L+QY7Qr83jrc0JQblWrI854nxOJle15LuFPDGAjOmEC
         rHtaHqJFvdOhTNff6pQv0z91nFJX4oRlq4fylJJ2PeK3MN9q7qiaOZOf6rQxgHmGyhCH
         hhMA==
X-Gm-Message-State: AOAM530eMuh2dcpV48g3F2EyCGFxQRJbGqm6Rr+K+U65gc9BodQ3Uh5/
        RKYg1y/74d66GLxJhE003lZNgg==
X-Google-Smtp-Source: ABdhPJxcQxZP7UCCJCdtizYPsWdBfPxsgabsqnrrXUyqWE0baxICvVYEfFbGVKx5PXZFpycK/3mpWA==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr2474575wml.24.1591253291865;
        Wed, 03 Jun 2020 23:48:11 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id a6sm6002228wrn.38.2020.06.03.23.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 23:48:11 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:48:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: Re: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
Message-ID: <20200604064809.GT3714@dell>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-3-luca@lucaceresoli.net>
 <20200604064734.GS3714@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604064734.GS3714@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020, Lee Jones wrote:

> On Wed, 03 Jun 2020, Luca Ceresoli wrote:
> 
> > The "Required properties:" section is copied verbatim for each of the two
> > supported chips. In preparation to add a new chip variant make it a common
> > section and keep the two examples to differentiate between the two chips.
> > 
> > Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > ---
> >  .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
> > index 41671e0dc26b..b75ae23a1ef3 100644
> > --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
> > +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
> > @@ -1,7 +1,7 @@
> >  TI LP87565 PMIC MFD driver
> >  
> >  Required properties:
> > -  - compatible:	"ti,lp87565", "ti,lp87565-q1"
> > +  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
> 
> What happened to your tabbing here?
> 
> All the other entries start with a capital letter.  So should this.

This is also an MFD patch.  Please change the subject line.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
