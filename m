Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC20C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7569920792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595884058;
	bh=+DV1VqXMSLwGSkvyDM4svsa8s20e4wZZygQXAMSbYYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUZ17ux42TsVKKQsUZFy/e9fgXnBcWHPSShYpHF8LzoUsk+fpl6bBj2CHRxVjolOj
	 +oZHmbQyGxbWDb6PnVz3Z+56tjzANaaMQCUEI4EzNoqftgPeW3Mt+IP/3JdWeZNY1B
	 CVe4AVvzYhBiiuqs2YCh9ZOtWrOHp2Ec8/fHoy80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgG0VHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:07:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45728 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0VHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:07:36 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so18482458iof.12;
        Mon, 27 Jul 2020 14:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d20d52Vh1H5WJTbYe8ZshNKaAa96Fqv+heEfun99jyc=;
        b=kIaUZO8+clkXTaKOE4ay1b51ALomh/NF5JUnoHtszWL87wAGBFVLLgWz8+KGXZG48/
         LO1mJeXxrXqhoW4ALs/V/mLW6UnH+9ddOCJKv5qmdJWCJebwZXbF3EtogHK/o2uNx/oO
         NXDUWa3uw/erGt5o+a2vUuTxLo2KAPa7fEaWzCSEiZefbV3YqMzcWWuH4a1TNaUNfaUM
         adk8gqu5lzPPRzfSKrYnuNWgoLC+1EB//XokdatIJVrAuYDoHQvmCB0rDeQtTwItuHVv
         XGGeXOGMuaTrr23xOGpvcQ9b6hGcjZpYZHo8y6BL6hXXYFC9NRICtdvluZK5Vb42zhEk
         a0ZQ==
X-Gm-Message-State: AOAM533QsaikNQjUbpGAY7/g4X9XXbTgw6k72R08xISRThroDs9knyyW
        fYVrDGkl+heivlzMf/3MSA==
X-Google-Smtp-Source: ABdhPJzLGLFrSBW/vbv5TmB+90vWRHbO3xB2xUfCw2M90EuwbcMOhWmtsN4UyHHFPAN/Bth4Gx9xpQ==
X-Received: by 2002:a02:3f41:: with SMTP id c1mr28428069jaf.29.1595884055787;
        Mon, 27 Jul 2020 14:07:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k204sm3240594iof.55.2020.07.27.14.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:07:35 -0700 (PDT)
Received: (nullmailer pid 873800 invoked by uid 1000);
        Mon, 27 Jul 2020 21:07:34 -0000
Date:   Mon, 27 Jul 2020 15:07:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
Message-ID: <20200727210734.GA873757@bogus>
References: <20200724234415.1651639-1-saravanak@google.com>
 <20200724234415.1651639-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724234415.1651639-2-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 16:44:15 -0700, Saravana Kannan wrote:
> Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
> to add support for pinctrl-%d properties.
> 
> Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
> are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
> (9486) are made up of pinctrl-[0-2]. 'pinctrl-8' is the current maximum
> found in dts files.
> 
> Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
> unnecessarily complicated. So, just add support for pinctrl-[0-8] for
> now. In the unlikely event we ever exceed pinctrl-8, we can come back
> and improve this.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> v1->v2:
> - Clarified in commit text that pinctrl-8 is the max found in the dts
>   files.
> 
>  drivers/of/property.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Applied, thanks!
