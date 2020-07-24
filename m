Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCA7C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181172063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595606084;
	bh=OC8jdFaf2cMlkgGOGyuvAEHcq5r5d+ApcGDGmXRGHgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k3ihjzzRVHegZPHy6+1PDQP4C6tiLkfXF/wdy0ubEXRmCiuJZlGlhX3iuOlsPi86a
	 MUG1ubCQQq3BCKPXb3uRxt8IqqMFuF4w9pWjpdo1vKs+EVYN0w2QcplahGwDejMaZY
	 EmEg5ihBs927m2bejmZFxr1sy37Nhi5RmVm5G0lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXPyn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:54:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44904 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:54:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id b6so8745890wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kf1dseeXdq4ZJ2MoLlLEkkKYqnpO+uVX6RfAe0LBuXo=;
        b=GMjuNwEhyGfLRf9DsbCPRjDFrsFVydSNuFhWReZN/LUtTcorghQBzw7Yrxs23cObJP
         ZATuxHutzL8LH9oQ4LJpBK7hyvF8YU7X23EQzBSR1Wym49pZ3xNoJ+58aXaS91e50CTB
         +YyWO8UG7TDSBOIL89IqhfUtj6NUcFnQYzkQzmNV3aNzDmDLDFebEnL7YiT5pt2FV0es
         xzDVQiTuQB/Qy23gSfC1rJN15GX/g26YWoo5pJrFOmjZS3LuohyBoPNzeEAxw1mmlLxW
         xsklgzwRsxlUFUeEDAsaDInGhKPQ2i9A2ijHPkOmI9f2N1ivgB2/o5MtLlELGDSEu0Cx
         N/JA==
X-Gm-Message-State: AOAM531A59WmMpkjhKtHlYAQ2AsiLrdKK+oOks0RBthWfPSqo5fxcThW
        A75doJ7BI/7pXl3xpKgDQmE=
X-Google-Smtp-Source: ABdhPJzsiL9xPZnqIRsa4EplqduajKhlOCqgC5oKJrL3jFja6/El7JiIO6RbHryhbxCCV6naonW0PQ==
X-Received: by 2002:adf:de91:: with SMTP id w17mr9136332wrl.108.1595606080536;
        Fri, 24 Jul 2020 08:54:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id 78sm7983174wma.31.2020.07.24.08.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 08:54:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:54:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
Message-ID: <20200724155436.GA7460@kozik-lap>
References: <20200724145401.2566-1-krzk@kernel.org>
 <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
 <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
 <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <IBDZDQ.K28R5FAI0BXI2@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:50:06PM +0200, Paul Cercueil wrote:
> 
> 
> Le ven. 24 juil. 2020 à 17:33, Krzysztof Kozlowski <krzk@kernel.org> a écrit
> :
> > On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net>
> > wrote:
> > > 
> > >  Hi Krzysztof,
> > > 
> > > 
> > >  Le ven. 24 juil. 2020 à 16:54, Krzysztof Kozlowski
> > > <krzk@kernel.org> a
> > >  écrit :
> > >  > Enabling the MTD_NAND_JZ4780 driver makes sense only for specific
> > >  > hardware - the Ingenic SoC architecture.  Set it's dependency to
> > >  > MACH_INGENIC so it will not appear on unrelated architectures
> > > (easier
> > >  > job for downstream/distro kernel engineers).
> > > 
> > >  Disagreed. It was done this way so that distro kernels can support
> > >  multiple SoCs.
> > 
> > They will still be able to support multiple SoCs. Nothing changed
> > here. The same we do for all ARM drivers (SoCs are multiplatform)...
> > Unless you want to say that it is possible to support Ingenic SoC
> > without MACH_INGENIC?
> 
> On MIPS, the SoC selection is a Kconfig "choice", so you can only support
> one SoC family, unfortunately.

Let's say someone selected then some other architecture (MIPS_ALCHEMY).
They could select this MTD driver.

Does it mean they would be able to run it on Ingenic hardware?

> I'm the one to blame for using "depends on
> MIPS || COMPILE_TEST" on ingenic drivers, maybe it should depend on
> MACH_INGENIC indeed, but then it should be made possible to support more
> than one SoC family.
> 
> That's something that should be pointed out to the MIPS mailing list, I
> believe.

Somehow JZ4780 entries in Maintainers do not mention MIPS list...

> 
> Btw: Does that mean you are the new maintainer for drivers/memory/?

Yes, that's the coming change.

https://lore.kernel.org/lkml/20200724140345.GB13472@kozik-lap/T/#m91ca20920a7ec5f228a595f1816c15b6c85b6a09

Best regards,
Krzysztof

