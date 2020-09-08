Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C9A20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594834;
	bh=Nlb6PMQ+/rxBZwsrcxH1F/mJAmYV/dDxE1otVQrU4fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FVCvqi95rX2QdwTZ5lePfzR9SgfYf0uqsKkujBe4Y5mb6ZeN5HKURyFR5EE7S7sDy
	 4kN7ygsOMufCAg3KDudt+fbBTJWIUrZt0nlqbKaaFEeD0mRRE1CrXqyvJmZ6XbgZ6B
	 FHTK4NCJ+WpCacqNQZKRs+wtOKHZEbQYwmuLSLhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgIHTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbgIHPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:42:33 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DBE22CA1;
        Tue,  8 Sep 2020 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599573425;
        bh=Nlb6PMQ+/rxBZwsrcxH1F/mJAmYV/dDxE1otVQrU4fY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ysKrBTL0aVtHER0C6nREvCT5i7bCJNKHt5vIDFQa/AXN/GkdMPbQCRt+CQMpGVhy7
         pcNR/ll6hCNdA+6fIO0QWqFi4PAH7uGFv03RXgTvMBxBHDBb9aONpD0qMZjIqHFnDR
         U44LpeiJKNPRcjLukNI0vWll/S/plDkC4wuoqVGM=
Received: by mail-ej1-f42.google.com with SMTP id i22so22665206eja.5;
        Tue, 08 Sep 2020 06:57:05 -0700 (PDT)
X-Gm-Message-State: AOAM533nTNSMB3oaPlh9q/j+1ETOTbklqnLStP4EJ0S4uXFs8+ZGxTET
        PWd8H4NbuK2KWPCwc6+y/nLh+gTlINihhUS55v4=
X-Google-Smtp-Source: ABdhPJxw+CVnvHvS0mxWVnK6lDtq/Q+r0QWlwGxtDfUXEv06P0SO8wK83EymMr8l5SGfDRCjuUgniQlH27jDHyXS5c4=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr25369176ejx.215.1599573423778;
 Tue, 08 Sep 2020 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200907105254.31097-1-krzk@kernel.org> <CAPDyKFowS-psoJqVUChU35Xp92nrvH5r5eY=_8bMKU0SVBxLcw@mail.gmail.com>
In-Reply-To: <CAPDyKFowS-psoJqVUChU35Xp92nrvH5r5eY=_8bMKU0SVBxLcw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Sep 2020 15:56:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdX7UOkTNMVS_uLi7sG_h0bHCs_b6R0uL2B241y_+niqg@mail.gmail.com>
Message-ID: <CAJKOXPdX7UOkTNMVS_uLi7sG_h0bHCs_b6R0uL2B241y_+niqg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 at 15:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Arnd
>
> On Mon, 7 Sep 2020 at 12:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Multiple MMC host controller driver can be compile tested as they do not
> > depend on architecture specific headers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> It seems like this is causing build errors for my next branch when
> running allmod config [1].
>
> [...]
>
> >
> >  config MMC_S3C
> >         tristate "Samsung S3C SD/MMC Card Interface support"
> > -       depends on ARCH_S3C24XX
> > +       depends on ARCH_S3C24XX || COMPILE_TEST
> >         depends on S3C24XX_DMAC
> >         help
> >           This selects a driver for the MCI interface found in
>
> [...]
>
> The problem doesn't exist in linux-next, since it has the
> corresponding cleanup/rework patches for MMC_S3C from Arnd.
>
> To fix the problem, we should probably remove COMPILE_TEST for
> MMC_S3C, for now. Then we can add it again and send it as a fix for
> v5.10-rc1.
>
> What do you think?

Yes, better to remove it otherwise it will pop up when Linus merges
your tree. Do you want a patch for this or you fix it up by yourself?

Best regards,
Krzysztof
