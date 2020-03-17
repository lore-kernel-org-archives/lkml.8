Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7023C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E21205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584434563;
	bh=IoKaoS48Cjqtz3EXvPpCxL1bx5OpzH2wv2pbrlqhO4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kP+SjiYgMeAYG9sCaBcumzWYDCqFPY77FGzTzNzWtoOfGHUkv/wrf+6HJGca9BCAR
	 ANtdM0D/2opNSacSGDRMlF6ZDjw9KhQistGQIpiIb3keCvyocpIzqxfWwwC8+IwM/O
	 4ny0bE/zCxcWWLWXwiBEteUinZaAJwmYw3ejaqn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgCQImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgCQImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:42:42 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6628D20663;
        Tue, 17 Mar 2020 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584434561;
        bh=IoKaoS48Cjqtz3EXvPpCxL1bx5OpzH2wv2pbrlqhO4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pNhHb5ZOklzJIBs+Mk30HLDVvQoyI0ikIuQlr7KdQcqcluM8Thc1qv+SrFtFCG6sN
         4IQh2DLpQJp/vtcOlOOASHb/3rQ60/mqNkaD/zaZh7ZJ/r8hIEN9Rhk+sXx/9KA/2B
         tVat7vG6pnEfRdPbSM5o6jfrb0mMZsFtsX+rCvIo=
Received: by mail-lj1-f182.google.com with SMTP id y17so573318ljk.12;
        Tue, 17 Mar 2020 01:42:41 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3R6x589eVO9vcSRM11HwfMGfmiH1vrpujBL/VkubC/yalGWwVT
        8K7pITN+oKqBhU1jmxIoEUYcriO7rmgFqVrHR5E=
X-Google-Smtp-Source: ADFU+vsGw4leJ6Uf5P8becHc7znYz444/oKgydCNUix8TbemuH4A0iD/laSXCKIUp9XD4ychGSVZOvtwIIC+U/Mg5Ks=
X-Received: by 2002:a05:651c:29c:: with SMTP id b28mr2143355ljo.201.1584434559542;
 Tue, 17 Mar 2020 01:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-2-linux.amoon@gmail.com>
 <87lfo2f0k9.fsf@kernel.org>
In-Reply-To: <87lfo2f0k9.fsf@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Mar 2020 09:42:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf1GQmukWv16ydxY=78k=szTLnwM08R0wGoRNhHXgkCzA@mail.gmail.com>
Message-ID: <CAJKOXPf1GQmukWv16ydxY=78k=szTLnwM08R0wGoRNhHXgkCzA@mail.gmail.com>
Subject: Re: [PATCHv3 1/5] devicetree: bindings: exynos: Add new compatible
 for Exynos5420 dwc3 clocks support
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Anand Moon <linux.amoon@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Mar 2020 at 10:08, Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Add the new compatible string for Exynos5422 DWC3 to support
> > enable/disable of core and suspend clk by DWC3 driver.
> > Also updated the clock names for compatible samsung,exynos5420-dwusb3.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> What is the dependency here?

Felipe,

This patchset should not be applied. As of now, it is not needed and
not justified.

Best regards,
Krzysztof
