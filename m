Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ACB20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589929410;
	bh=MjTnNfF36TKpmvZOb7ouFby36GXdZ3ADfFP9GFuUwq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EL+nxIl1OaSMaegn02LDLPPPpg57fhACXQdjnA5LhYHuwDzxhpYE4KntIlFTZvcdK
	 eNiyZUEZ8DG4BG7ly+3cteUt+TEFA08klSHyhqExdo5AS14RoApHEM0UlXvmHE2i2E
	 vpZm8P37as++LEpdA6lNAnlLrqPglWbEV1e+GuqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgESXD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:03:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39054 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:03:29 -0400
Received: by mail-il1-f195.google.com with SMTP id c20so1174170ilk.6;
        Tue, 19 May 2020 16:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YYKFcBn0SXqCqC3JTj/787nlEe7iveNyNWOYE196YMU=;
        b=Xbf0jlX6sHLBrqwwJbTOMOoYtl/ZUk4SxbhnMVvDRX0TALwNtvEtw8ojFgKp6hIlro
         /osxA4Fnkp7Fs5XcrO8V7gXoY0p1Lcy5JvUhyF77ekwsqWMz7B1gCunk/EI5AoZmg7+n
         33e8hah6Kwb/YCX6aI00f0Vq7ryp9eprXsx6JNMF40kAck2rqw5VMgebXTF4T/Or34mQ
         mmljt8saimpHgfVZnvmKgTJySJr/As+EQNKtIyDBv+LOJWazH5uRPr5vrmGSL1Slc9g+
         QEUCj1MeUH7m42qSbqiyjBuEucrW+o8V4mZ+1BaGkqU8W5xvunVZ2Ac3axaCeb7xgd4o
         yHEQ==
X-Gm-Message-State: AOAM532B8XwHIJtR2wEYmIrnvYsrR7K1dgxxtdZWgXmsjxd7M9YX+ReR
        RfS1OyCJ5d+HUnGXRJtVaA==
X-Google-Smtp-Source: ABdhPJxrdBDMRZsMfXlcAqqKCF6SJxDXpeObfQ7NHHULwBA3poGnWuC12jMRJg/9rKFDPnbTK5zxqw==
X-Received: by 2002:a92:2801:: with SMTP id l1mr1515644ilf.132.1589929407929;
        Tue, 19 May 2020 16:03:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h10sm412676ioe.3.2020.05.19.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:03:27 -0700 (PDT)
Received: (nullmailer pid 857175 invoked by uid 1000);
        Tue, 19 May 2020 23:03:26 -0000
Date:   Tue, 19 May 2020 17:03:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>, robin.murphy@arm.com,
        devicetree@vger.kernel.org, talho@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/4] dt-bindings: sram: add documentation for
 reserved-only flag
Message-ID: <20200519230326.GA827289@bogus>
References: <20200512144803.24344-1-ykaukab@suse.de>
 <20200512144803.24344-2-ykaukab@suse.de>
 <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
 <20200513104127.GA2309@suse.de>
 <efcc6b5e-423c-8ae1-8a46-d6a06c1a1bab@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efcc6b5e-423c-8ae1-8a46-d6a06c1a1bab@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:16:43AM -0600, Stephen Warren wrote:
> On 5/13/20 4:41 AM, Mian Yousaf Kaukab wrote:
> > On Tue, May 12, 2020 at 01:45:28PM -0600, Stephen Warren wrote:
> >> On 5/12/20 8:48 AM, Mian Yousaf Kaukab wrote:
> >>> Add documentation for the new optional flag added for SRAM driver.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> >>
> >>> +  reserved-only:
> >>> +    description:
> >>> +      The flag indicating, that only SRAM reserved regions have to be remapped.
> >>> +      remapping type is selected depending upon no-memory-wc as usual.
> >>> +    type: boolean
> >>
> >> This feels a bit like a SW flag rather than a HW description, so I'm not
> >> sure it's appropriate to put it into DT.
> > 
> > Reserved regions themselves are software descriptions, no? Then we have 'pool'
> > flag which is again a software flag and so on. This flag falls into same
> > category and nothing out of ordinary.
> 
> I suppose that's true to some extent. This is indeed a description of
> the system environment presented to the SW that consumes the DT, which
> is a bit more than pure HW description but still a description of
> something imposed externally rather than describing something that's up
> to the discretion of the consuming SW. So, go ahead.
> 
> >> Are there any cases where the SW should map all of the SRAM, i.e. where
> >> we wouldn't expect to set reserved-only? [...]
> > 
> > Yes, here are a few examples:
> > arch/arm/boot/dts/aspeed-g*.dtsi
> > arch/arm/boot/dts/at91*.dtsi
> > arch/arm/boot/dts/bcm7445.dtsi
> > Then arch/arm/boot/dts/dra7.dtsi is an example where we should map everything
> > except the reserved region.
> > 
> >> [...] I'd expect reserved-only to be
> >> the default, and perhaps only, mode of operation for the SRAM driver.
> > 
> > It will break compatibility with existing dtbs.
> > 
> >> If we can't do that because some SW currently expects to be able to map
> >> arbitrary portions of the SRAM, shouldn't that SW be fixed to tell the
> >> SRAM driver which parts it's using, hence still allowing the driver to
> >> only map in-use portions?
> > 
> > User doesn’t need sram driver in that case. It can use genalloc api directly.
> 
> This sounds a bit odd. Without a driver for the reserved region, nothing
> should be touching it, since otherwise there's no code that owns an
> manages the region. If any code needs to consume the region, it should
> obtain info about the region from some form of provider code that can
> handle both the allocation and mapping. Anything else sounds like some
> consumer code directly making use of DT nodes it doesn't own. But since
> I'm not familiar enough with the SRAM driver and genalloc code that you
> mention to fully understand the allocation paths I guess I won't object
> for now, although it does still sound fishy.

I'm fine with the concept, but I don't think a single flag is adequate. 
If there are reserved regions within the SRAM, then define child nodes 
to mark those regions reserved. I don't think you need a new flag. Just 
a 'reg' property and nothing else.

Rob
