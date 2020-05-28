Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0DD2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DTZmwKCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgE1N5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390569AbgE1N5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:57:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2469C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:57:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so29994387iow.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjZuoVgOlAA2kTVO/8YMAq4g+uCFT1z5qrdClOZg5xA=;
        b=DTZmwKCR4ekoBMQbgF98VezGQAaJUqzcUPcTLqzEOk97y7hIN1ih08J1Bmvh5GFOQH
         qIfMbduWKyvcTUWj7p/KqqP0TmgtmZ0jpCa7P6dotvleAkJ1hagecaJ9alBmuP6vbcMP
         5aaqPqo9jrIHnpkagd1Qbkvqzqc6b58tprkfmSRcPsg8yNdjsCoC4q/8bSCDNAsQHqns
         8JHrAq1PMSpwdCwaElyr1wJTJOC4GtK9IH0QwCua6VK5HGLM2xKPVD52sOHRUndZ7NkI
         DDPOPWpRzUMOf1dKXTDe1mbMtEREzBPsxxJC9ia7xa1Ky8uMFkaq7l7w8RoCAPepY5L6
         btiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjZuoVgOlAA2kTVO/8YMAq4g+uCFT1z5qrdClOZg5xA=;
        b=GYxlzWbHG1Wt2/VlPXm6A02kdwDaL0LWtE9kA9tP6J4ri2JxiB/Q/8AS0eYZPXPQdh
         wHl96mYEhb8q7dveuJ/dxN6Rh9/6Xd0soq03u/A2TbQIJ4R1XzQShIEhOeobtfH1Ufmv
         Lk5VxodT1TnDhDfuOkNC4h2VU+CJs8S3dLqiNi+fYm209U0SZ5D/aII8e/QWmLKnQaif
         kUl1F1xY+bVMgtjmnTZYRfGktz2AjJ0LGgMvViDUoHkSenyjDXhTonxNqLX0zDjSuPAb
         YQHoPNoK2coAC97Jxx5vkzwmxYt5AHQeLsdMxNGEo4ma9mE/hN1SBOep2RuMMb4m2mS5
         rEhA==
X-Gm-Message-State: AOAM530iwsyPxwGg3R+5uRUqSIWYhKfzcbeTaEoIM515ZUtxS9WItPO8
        bk4N4fNFE3sJuq5mXFOkeJt8FdGJ0P3ixDIZ0WYo9Q==
X-Google-Smtp-Source: ABdhPJzQW8lIGLBPiATGOcgXj5v+CggE9v61MrxTSOTkP57BU/mh8b7hB7ruXavpQvozs6X3Thlkzu1OTQMUtqwGRc8=
X-Received: by 2002:a6b:5c19:: with SMTP id z25mr2382470ioh.119.1590674255097;
 Thu, 28 May 2020 06:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200528123459.21168-1-brgl@bgdev.pl> <20200528123459.21168-2-brgl@bgdev.pl>
 <20200528132938.GC3606@sirena.org.uk> <CAMRc=MejeXv6vd5iRW_EB3XqBtdCWDcV=4BOCDDFd4D0-y9LUA@mail.gmail.com>
 <20200528134802.GE3606@sirena.org.uk>
In-Reply-To: <20200528134802.GE3606@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 May 2020 15:57:24 +0200
Message-ID: <CAMRc=MdL5dkJ+BPzvYXTnLQ_sGtU_7n=8jeSa5=hf8u9Pm+0FQ@mail.gmail.com>
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

czw., 28 maj 2020 o 15:48 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Thu, May 28, 2020 at 03:32:40PM +0200, Bartosz Golaszewski wrote:
> > czw., 28 maj 2020 o 15:29 Mark Brown <broonie@kernel.org> napisa=C5=82(=
a):
>
> > > Why macros and not static inlines?
>
> > The existing regmap_update_bits_*() helpers are macros too, so I tried
> > to stay consistent. Any reason why they are macros and not static
> > inlines? If there's none, then why not convert them too? Otherwise
> > we'd have a static inline expanding a macro which in turn is calling a
> > function (regmap_update_bits_base()).
>
> Not really, I think it was just that they're argument tables.  It'd be
> good to convert them.

Ok. So I'm seeing there are a lot of macros in regmap.h that could
become static inlines but given the amount of regmap users: how about
we do it separately and in the meantime I'll just modify this series
to use static inlines?

Bartosz
