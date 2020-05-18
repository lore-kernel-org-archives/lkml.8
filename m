Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1780C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862AB207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsCWq4UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgERKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:41:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3593C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:41:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id 50so11191017wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ikyr+WGHg8huJGIaXBToPakGl31dMPTElNM/T3/AsyA=;
        b=CsCWq4UEjwCH+yiYQDD4ynwlz421ZgsXOQhWh945mhdfeF2OpwrBYP71U999eButzs
         6zUQe3lJKazONDHRJQ/90UT0XlCmm1DzsUJyCEwxcdma+ztv4UiMLRIVfHF8c1ZIwQH9
         /zFBYdMTOUFjymmYvz7SCb/q1mfBlqzuRQvqdRabqvvQT37rBVPhFKRl0HS4s/8ba8Oc
         RZKDR7q3KrMIAW4A4QSwEn5S5xiNBaLlwqUdZGah3bf2FSGzLWZLTLPr4sk6ChN1oNJc
         1ThvkQJqacI34dcyVXrKD2jjXlwkuifXql9afLeRGglpo6cqbIcDoJhM5ikahtCCXJWr
         FOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ikyr+WGHg8huJGIaXBToPakGl31dMPTElNM/T3/AsyA=;
        b=Kw+l4eU+D0sCmiXySi7oCrMbrDlIVDAJetpHjYXun1cJDl1y3NsMnXBo6R8op4f73v
         m2rd8AZKJgBhgbnMrjqAXScryhAGJfyFgdX263/EPt67uZOiqBuaSKS/igomJ+hvhxk0
         IedtWFhod7FA/Xo4I6dDkKuK3M1r8cb2JSmzL6AgoTGoHqnfW1ptoPRa5db9OzmlHbBJ
         mqhxnzRCwIPNG1X4hwfz35teWoaYrNAJouWDLzLZKKNjEkcZ1fXQyX63sSKE1D/fhNNA
         Hu3I3M9Ip8Bjcif324FIu75WjWRwDlIzgQDsSSVOsYJou3FWa+IsSStMlBw29LHf/PTv
         koZA==
X-Gm-Message-State: AOAM531Zxbn7dTdbJ6bepu5yAwmpPCu328xXN1mRxzEpKHwCucb4id/T
        36cndunn7wr8EGbI1h2jvllHfg==
X-Google-Smtp-Source: ABdhPJxJpfJuRoJfvHNiUbAVudTa2kS7XT56S3+kDTzC9GuaST7R/l/FinfyiKCOSKj3r4ODuckhIQ==
X-Received: by 2002:adf:fb08:: with SMTP id c8mr19427696wrr.421.1589798469654;
        Mon, 18 May 2020 03:41:09 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id z12sm14434852wmc.6.2020.05.18.03.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 03:41:09 -0700 (PDT)
Date:   Mon, 18 May 2020 11:41:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Message-ID: <20200518104107.GS271301@dell>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020, Vaittinen, Matti wrote:

> Hello All,
> 
> In short - I consider adding myself in MAINTAINERs for the ROHM IC
> drivers I've authored. I would like to get your opinion as subsystem
> maintainers on the area where these driver belong. If you don't care -
> then no need to read further :) If you do read, then I would appreciate
> hearing about your expectations regarding reviews, ACKs etc.

It's fine to add yourself to MAINTAINERS for this purpose.

Either as M (mail-to) or R (designated reviewer) is fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
