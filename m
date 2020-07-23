Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A693C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6677D207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmkS7Vh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGWNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgGWNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:40:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69573C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:40:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z24so6363517ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eegOArgjvO8rP9syB7xmG1tp8kx/F1yrwr3UNCLFEo=;
        b=YmkS7Vh4mwIp+nMV18OSIk4pf7op1uBA2TkP/ke9aZMe7v2Bo7c53f8FLIkodKBdkZ
         3tcKEQi0+gDlUUl6vIQfXe03avSwX4r0Z1Ho/SNeJNDr1nD0OrRzHWUx+4BhS+I6jcdg
         PkIxlP6R205v6/wCBRBgA1UQXA+bfQNPfyTHXkoXZdJMDZndAQuu9LozLyTLHGrkOoSM
         hLP3AYgQ28AzXbEjtCVD2jjKbdtrN15cBQPjVqD2FsThQgoX97pHT/KgLCCR8DY+hKF4
         3UhsPZi4/CGdI+2Sif+O3/1rXFoDXnFmZXbwW+b2GUh/JSOY/T92UI03ODBXOAU4kJEI
         5yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eegOArgjvO8rP9syB7xmG1tp8kx/F1yrwr3UNCLFEo=;
        b=dyujz80FUiRGOP1/ryTmCHfiRN2xsB4vPkoKD9KjyXTegkChyDD+fT7eG49XmoAJhN
         Vl19Hgvo3bbov50FGt8rZo5EIEYHLbcHolBR/zZIPgLeAfypF1kU/Txw/JEosZDhrD+N
         ObjVauzv4d77MLwnOYt09/hTR865vpuAtfptewQLfKq95j84q6dX5qvkv5WaW5ny4Sqw
         TpDyQfwt0HreW4+HB/qNZIG98+BQOoNjWyXicyd5h240RYVfbqrV5zMOlP6Fosn2V7iK
         swbu+YPrx/3UTkiokqySz0rLNxE/QvPr/aF8n90fzIP+6PbDTfCDBlkb/HqEepwqa+Zn
         8RwQ==
X-Gm-Message-State: AOAM532PWJ3n5Aoz+FMo0+t+TBABNC3Q+ie5xXldkEPZweO8SQM2MpJr
        F7Z09sylrwf/J2Jgv8dP/dnPqIT075kGlOQYJo6dEA==
X-Google-Smtp-Source: ABdhPJzkhTQiz4v4EweObFS3VjvRBHaK+7cqyFcfiqMUdnGJXvj0jmfVgVQamNi7423328Gef8C+2ZKNdMl7Uo351Ro=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1865085lji.338.1595511608925;
 Thu, 23 Jul 2020 06:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200723013858.10766-1-Sergey.Semin@baikalelectronics.ru> <20200723013858.10766-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200723013858.10766-5-Sergey.Semin@baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jul 2020 15:17:08 +0200
Message-ID: <CACRpkdZO242FC=O8nAXjKX=9VRpkkQdMA6S0L2ZWNX9D1hmcYw@mail.gmail.com>
Subject: Re: [PATCH 4/7] gpio: dwapb: Convert driver to using the
 GPIO-lib-based IRQ-chip
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Thu, Jul 23, 2020 at 3:39 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> GPIO-lib provides a ready-to-use interface to initialize an IRQ-chip on
> top of a GPIO chip. It's better from maintainability and readability
> point of view to use one instead of supporting a hand-written Generic
> IRQ-chip-based implementation. Moreover the new implementation won't
> cause much functional overhead but will provide a cleaner driver code.
> All of that makes the DW APB GPIO driver conversion pretty much justified
> especially seeing a tendency of the other GPIO drivers getting converted
> too.

Needless to say I am a big fan of this patch. It's what I wanted to
do with the driver but was afraid to dry-code.

Please look into the minor nits pointed out by Andy and respin,
I really want to apply this patch set.

Thanks,
Linus Walleij
