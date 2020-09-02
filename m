Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9B4207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599077495;
	bh=qpUUTP1DBHnEm8/HRtX7DQOGMS5vufGPfKlftXB+p7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cMT1H0AB9eCnawiMroU08vt/9/MZ/VTUoFZCgiPF349Ml50L88KXlul+4zaJQyErO
	 vSiBVE1bENHcJfi8iv5DF8aiXdy4jGtRUyjacdYt3037Z6xeAL2fVQ4vNSe/Qnplf7
	 7FipMB7IRHFNs5eTfeSDgXhp9TyAl4FfRjlKIAa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIBULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:11:35 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41302 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:11:34 -0400
Received: by mail-ej1-f68.google.com with SMTP id lo4so462739ejb.8;
        Wed, 02 Sep 2020 13:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QIIG488RewWIV6fZ1YyUiiA1gfOjB33gWTwgLTvdpk=;
        b=pQMDzUC7/Ld9YlcneUfTBickEGtC/OLxk1CGfO6gLt/x3XkYv2BSmyim20uvkmlmd4
         TQK7hJ25jyiR7ybxvACVzcoBVfMcjPoo1xuy53pJLpZQ1Tq1boGfCj0ydnSIrGH5d+1H
         vWUY0YhGcWoDOiWFK+4JABegqpxpiym9wMm2iggS5XvMWvHNfYVWQixkIO432gWTxVNb
         f/sI2fOfb77PaF9NjQskERR7rkRnZF/of/RM8jqybKRCK/MgRI0bowQivWh4OnzD7ZgJ
         zUsPK1v6RoGxlz3h2sFF6/k4gW0GK3IHapHCfx6BbDCHsvJBHxNnxX8IXFWVs5SAJDoD
         iSqA==
X-Gm-Message-State: AOAM531/07t+Kh2m1X72ocJpwQBMX/FcwZmxGdiQUoJO+VV2YFiW5HIL
        JlTbEM2E8dxtT7SryaPOsDo=
X-Google-Smtp-Source: ABdhPJz2DxULA55daC+aYgKP0v9NC+Adj2VVDd/+P9M5UwP8nqX6GSc+9O+cvMhJsAm+Th1nwnA0xg==
X-Received: by 2002:a17:906:1542:: with SMTP id c2mr1810821ejd.533.1599077491970;
        Wed, 02 Sep 2020 13:11:31 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id yh29sm628951ejb.0.2020.09.02.13.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 13:11:31 -0700 (PDT)
Date:   Wed, 2 Sep 2020 22:11:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: s5pv210: Enable audio on Aries boards
Message-ID: <20200902201128.GA29361@kozik-lap>
References: <BN6PR04MB0660CFA802E03E73D58029CCCB2F0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660CFA802E03E73D58029CCCB2F0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:38:58PM -0700, Jonathan Bakker wrote:
> Both the galaxys and the fascinate4g have a wm8994 codec,
> but they differ slightly in their jack detection and micbias
> configuration.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi      | 10 +++
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 98 +++++++++++++++++++++++
>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 85 ++++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

