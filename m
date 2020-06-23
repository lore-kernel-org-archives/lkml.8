Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC170C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7425F20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592904031;
	bh=Xs7k99TsOgu0hzE+yFGCz3P3zA7V/AxXkL+HCRV3E6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vmk1K+dhVD3jxz5Wy6zsat3Ypp/7TC9cxNso4JQOFg6/5uvkz9WHJQfDXaFEkSnf3
	 IGdzKpc6KWCXDBgKvZd3e1dkUidemsYsIX40zQ/vuAJs+7TxGT5av3eyXYWourFkDZ
	 lMR7CDWZztdnevZ7d/TKsr5kZUcElNGxkEufcl7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgFWJUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbgFWJU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:20:29 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA86420738;
        Tue, 23 Jun 2020 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592904029;
        bh=Xs7k99TsOgu0hzE+yFGCz3P3zA7V/AxXkL+HCRV3E6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gGzQytR7q9QIG6t6/Au7ZRQdVDc5oRMr4aY8NYa6nwhi4zMC06Gxu7KZf1BlhcYEQ
         NGWO4ZPC+uVFQXdc7h7GtFWKbZO7dZ4mDrc2U/9y7Newo8Le3BgCGE+PEinTT9Ohz1
         mw5i5FW1I0PfVQy+9qc1Vlqj4qAEdfy6V8uw3O6k=
Received: by mail-lj1-f178.google.com with SMTP id s1so22629899ljo.0;
        Tue, 23 Jun 2020 02:20:28 -0700 (PDT)
X-Gm-Message-State: AOAM532+gEGgK45GcKUv9tSuAeCMXUYRKpg1wuxZkPluhbq9IsVvXtGh
        a0OdL94CkKVDfrcOz8c3DIK3Z3tZ8uwoWDDug58=
X-Google-Smtp-Source: ABdhPJyV3VmbaZQ13gtf4a6bK4ughLQLgVLF0ksu0UOJmt9DCx/22TnKAoKwGpKzy2WNreYJgun9j/SlLT0XuM5Re80=
X-Received: by 2002:a2e:8651:: with SMTP id i17mr10751099ljj.45.1592904026921;
 Tue, 23 Jun 2020 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200623074637.756-1-linux.amoon@gmail.com>
In-Reply-To: <20200623074637.756-1-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jun 2020 11:20:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfU-1NF+MHnyCMoXkCD4BbOwqr3s+g+gUwDqRevO=L=sg@mail.gmail.com>
Message-ID: <CAJKOXPfU-1NF+MHnyCMoXkCD4BbOwqr3s+g+gUwDqRevO=L=sg@mail.gmail.com>
Subject: Re: [PATCH] Revert "usb: dwc3: exynos: Add support for Exynos5422
 suspend clk"
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 09:46, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This reverts commit 07f6842341abe978e6375078f84506ec3280ece5.
>
> Since SCLK_SCLK_USBD300 suspend clock need to be configured
> for phy module, I wrongly mapped this clock to DWC3 code.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 9 ---------
>  1 file changed, 9 deletions(-)

But why was this patch applied in the first place? It did not pass the
review. For the v3 I replied:
"This patchset should not be applied. As of now, it is not needed and
not justified."
There were no acks and no positive reviews.

My comments from previous versions of this patchset were not properly addressed.

So here - yes, makes sense to revert it as it should have never been applied.

Best regards,
Krzysztof
