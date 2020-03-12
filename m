Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5A7206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srPbt+3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCLN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:56:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44577 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgCLN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:56:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id u24so3703305vso.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JRXwTxIAB5j1j2NCMCzDecPYeTmxsCx4GXTA9BYABo=;
        b=srPbt+3Nm45Swo/WvJq/xcZocTAX3qu3mZ3mKOg1oDFlqsbIVsGgXtrctkLHAauqce
         k1Hg+IPtfqpvwG/ABUKq8oxPpZor5Y5qjLq+ke77Yz/a+guNZwjOc3VqrJNSSEWaItvz
         cdK67hgqWvPCBp7oMco8JUX2sEckN41BAU+yjxZnnlRED7ce2+gGBt9CdWYBsaxS2RRg
         yLOnXNcvK592FBqKAn01hx4cwNa2O8vsjB0mh8hkFYoS7bXy8roviwrGXxIwtR/khaVZ
         KxYQVduEseN+FTWHhMUqF5tEXKgKxdj1Oynj0XdpU6TMmCRmxVHj8sOJGGNigQLSQLz2
         j2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JRXwTxIAB5j1j2NCMCzDecPYeTmxsCx4GXTA9BYABo=;
        b=TL3uZPfVeeBl0VdMNIsVAQsXyY2wHe4BXK26im/Hi/2Eu4cZ5W5qYIw6/v210a8htq
         3B8fOcH5DHnpYGKKBoJrOoBHsAA1ZhSOwFclDF5Ralb+h7ryveD/7vq+3Nx2N6ftnEpo
         BB5kkjjn3xhSS4wTV/wMzbbN7MTR0VXyW0dfcNKD+QNVw+pg27AjgpoH5iKmmkXZKSAU
         ox4XXzOUTXNd+3IPvghUsyPXfExlHzY9xGBlIazULZwOVtaT/i6E+/RIdsELs/9j/P3g
         WU7pzKc6U74lIQrOOc+5G0qYQabbNtRCdZmZPEntn2y69nft+Pa/yTOYOmi9ab8peM0G
         4bWw==
X-Gm-Message-State: ANhLgQ2S2OTRcTAiMeA+hAr3kTyn7k3Zlvo8GrOjRvuWlEqKdlEwOlyi
        +yHCpiY/ZU3hU7hDXVhNU9nQmHfSkKvw1PJfd8HGzw==
X-Google-Smtp-Source: ADFU+vv2QE24rtdwpGiavUKVuK+pRsxP8SX+w/0TbmxxSMm2UJ3KpJcmCMQ1vu/oVFsf31gBRdaEmQG0MLPwFr39t0k=
X-Received: by 2002:a67:cb84:: with SMTP id h4mr5414843vsl.85.1584021388328;
 Thu, 12 Mar 2020 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132448.13917-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132519.2AC268030797@mail.baikalelectronics.ru> <CACRpkdaU1f_RM8GDPxj_2qaiBsJ5JLnKp=ryZxAYMp2YhTDKWA@mail.gmail.com>
In-Reply-To: <CACRpkdaU1f_RM8GDPxj_2qaiBsJ5JLnKp=ryZxAYMp2YhTDKWA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:56:17 +0100
Message-ID: <CACRpkdYWWQXMhPxRR=tEShr8+=Y4mkEqRsiCg_qCK0qS2i6hBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio: dwapb: Add debounce reference clock support
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:55 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Sergey,
>
> thanks for your patch!
>
> On Fri, Mar 6, 2020 at 2:25 PM <Sergey.Semin@baikalelectronics.ru> wrote:
>
> > +       err = devm_clk_bulk_get_optional(&pdev->dev, DWAPB_NR_CLOCKS,
> > +                                        gpio->clks);
> > +       if (err) {
> > +               dev_info(&pdev->dev, "Cannot get APB/Debounce clocks\n");
>
> dev_err() again.
>
> > +       err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
> >         if (err) {
> > -               dev_info(&pdev->dev, "Cannot enable APB clock\n");
> > +               dev_info(&pdev->dev, "Cannot enable APB/Debounce clocks\n");
>
> dev_err() again.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
