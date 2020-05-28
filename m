Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B558C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A30120721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NJ0ybiSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbgE1Ncz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390303AbgE1Ncx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:32:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2704C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:32:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c8so9580744iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W6Ng+4krUrmarKse2LeV5TbqCd00mWN+CVVq8JMM5SE=;
        b=NJ0ybiSwbgGo1ahGYgAEwAdeEVE39Up4uZ5A1HFgeBFSeLdYyEjBoxzLaGany3U5qV
         tjyrvq25hqP+szOxI6JhW3xweR3C+uklX69AslmSgzZCTItj/lE1GwHfTH3xcf08EAt3
         mIwE34/rwjc7maTJJIaEZzx9+zgsTJyg16wtDEVvAZDos92VaeKTKyLujiHiG6B1cOYc
         KIuFtxHGqOtrjVeCdhdPy1poHODMArChjps6RUTUQ889ANVor3RtIvsULAyoI9a8m+lM
         yGQ/vmJQnyAURdQlFeawVfHk0vmYbLrVgpgL5isYwZKpihaGQitPE1wijKFtYBpDmHAO
         jbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W6Ng+4krUrmarKse2LeV5TbqCd00mWN+CVVq8JMM5SE=;
        b=tLmWPcjQF6WakqqdguMCpcOSZ0MMkU9U/N0WfsgR+p7Lte7dxQeodBqafZHNRgv0he
         epO07GEyDLiPiCxx5tACqK/8VLscDbfdmXLnjBeADxbmc9+8V3rKBTRTostPbGbGysBY
         oJlDJAeSddQqJ11t3wIiY03Cw0lgcwQtNQS6gN8IGGVDUPy3kT4idHLlw31xgEhnv+Hw
         nLNMdocxiewF/HmYGRUxdnThA7VY9aoqdHqUnv+JvrJyEKEKy32obAcR4ls/IkPMvw9U
         4FR2FwVY4/5nz6YoyNM6BoxSUSn8HOxd88sHAPuZ8mRXigZSXbrbRa9uKYJr3zXZv+MP
         sAjA==
X-Gm-Message-State: AOAM531oxyX2/nyGCvoM3vJED+4b+OcnOPJ8WmaRL1hFFp6P+bZc6GrP
        qfRa3LJL9lB9Jy97i/5AXUxfU0kWXaGUkbRY3yKr5w==
X-Google-Smtp-Source: ABdhPJzo7KSXJqLmG4j0rLnWfVnluS/E9w7gshGux7pMtHXApV9skQgthF60OVdfNho6c1thzgPYEEykEs0OHoviWNw=
X-Received: by 2002:a5e:981a:: with SMTP id s26mr2322972ioj.131.1590672771135;
 Thu, 28 May 2020 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200528123459.21168-1-brgl@bgdev.pl> <20200528123459.21168-2-brgl@bgdev.pl>
 <20200528132938.GC3606@sirena.org.uk>
In-Reply-To: <20200528132938.GC3606@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 May 2020 15:32:40 +0200
Message-ID: <CAMRc=MejeXv6vd5iRW_EB3XqBtdCWDcV=4BOCDDFd4D0-y9LUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regmap: provide helpers for simple bit operations
To:     Mark Brown <broonie@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 maj 2020 o 15:29 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Thu, May 28, 2020 at 02:34:58PM +0200, Bartosz Golaszewski wrote:
>
> > This adds three new macros for simple bit operations: set_bits,
> > clear_bits and test_bits.
>
> Why macros and not static inlines?

The existing regmap_update_bits_*() helpers are macros too, so I tried
to stay consistent. Any reason why they are macros and not static
inlines? If there's none, then why not convert them too? Otherwise
we'd have a static inline expanding a macro which in turn is calling a
function (regmap_update_bits_base()).

Bartosz
