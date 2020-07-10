Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D192FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E7A2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMqhd1hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGJUiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:38:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18626C08C5DC;
        Fri, 10 Jul 2020 13:38:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so3016754pgc.8;
        Fri, 10 Jul 2020 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOMT1EbzmMVOlBWJXe5pFrEanuc12PSjuBnbId11L/Y=;
        b=WMqhd1hnf35pMXF8dLTTXWv+IvBbSRqyz33IHtL2mvT5qHhWfVCk5MBTiTRtE79htb
         fm4f1SWrUCloR73Tr84FgluDvj2MsofFTCO8NrUYI9BLrd8S59fCGEwl71aIysWqhEd8
         Vk7DMIQvQm2d8VZK5KU8/0aEjfrZXTkhaEHFWWyTEMFaUvd4uckgvPUjffTCbo7YibkZ
         BXx1z4IxNnmHYTR6PSbB8NSYfJLIA7Ftj6ptBf6Sjw3cClZDFW75ZQJ8lA+JBmEqgWcr
         Cg7SOJzcwcbYRuNnAyv58BnT7e3nFxlsvZRQv4QCzc9h9k5hOdNcu4ITSRudELVxHwTV
         +tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOMT1EbzmMVOlBWJXe5pFrEanuc12PSjuBnbId11L/Y=;
        b=pZMPT8sTmeHpiYitqyhReB3eylCm5H1iMTJM3QMClALRag5b6Ot4eLovfqc8NVhflh
         va2Ap+z8GJAOjWJYC/HAwNvB/tvRD7bVYxhqTqa2bmp4tQeSm4zyi8ZIFAHZZuygLpXQ
         rJBsFI8bQjeFsT8I5XPG9XtC06T+jjeotVobLYv6cnAPvczPddf36mcX3O9e4SoZQLJK
         PDX+1ul00a/yQanfrRJONtnphYMazROsfC+cfj52LCitJAFZkdzQEXI1O4fOwo8Gomr1
         dhyrm0zX9J+5R4ZZ+N/HUfdOT+wQXo2JIoeaKzx7DQboqrWZQ1kW6fZHzJX1Mi/Yd7k3
         CpAQ==
X-Gm-Message-State: AOAM5306siSRzKe1cHIPCiK31TBDD2FNffgnrsRUeA8QZVZevVnIjn+y
        x/tpRUojDYhtayJrPZWbYV66Ucr7oiWdJu9M9PbI0g15NPI=
X-Google-Smtp-Source: ABdhPJw/UOlyUnmgJWyAwaTlywAOmhc6zvMPHYXjjuirNChqXCtiq0mqbFjv8wuZkuQMhBL+NWT6msFZUKABp4nC5vg=
X-Received: by 2002:a63:924b:: with SMTP id s11mr58089154pgn.74.1594413487485;
 Fri, 10 Jul 2020 13:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <1594373418-24833-1-git-send-email-luwei32@huawei.com>
In-Reply-To: <1594373418-24833-1-git-send-email-luwei32@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:37:51 +0300
Message-ID: <CAHp75VeOKoZN9x9HnKSeTtbm=0+c6YQ9b1P7XUyC7c6M7nhPkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix return value check
To:     Lu Wei <luwei32@huawei.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:28 PM Lu Wei <luwei32@huawei.com> wrote:
>
> In the function check_acpi_dev(), if it fails to create
> platform device, the return value is ERR_PTR() or NULL.
> Thus it must use IS_ERR_OR_NULL to check return value.
>

Pushed to my review and testing queue, thanks!

> ---
> v2->v3
> - Modify format
> v3->v4
> - Change commit number to 12 characters
>
> Lu Wei (2):
>   intel-hid: Fix return value check in check_acpi_dev()
>   intel-vbtn: Fix return value check in check_acpi_dev()
>
>  drivers/platform/x86/intel-hid.c  | 2 +-
>  drivers/platform/x86/intel-vbtn.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
