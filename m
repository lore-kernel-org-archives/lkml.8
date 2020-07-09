Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12900C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD6420720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/WomoT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGIT4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGITzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:55:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FFFC08C5CE;
        Thu,  9 Jul 2020 12:55:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so1250507plo.7;
        Thu, 09 Jul 2020 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f87FobS5tphZ53TIg74HP41DCxPjF/CnQ052D76Odw8=;
        b=A/WomoT7zM/utL6mitFJEdY5DidT6+KDI5BDIeU4+tvRX22K48TRyogqwhkY2bMMT3
         5g1DJy4N/9IcSZRX5mqraUxJfzV49gjBdzptVGAeyNPzoq/OF9LEnAFzpZo0Q6YkraOs
         2gxrnlm3zGD21YB0jkL0vtwIoc2hXezDHT9ksvWSmUFFq9khY4KuwX+y/73ghuKsRr4o
         qKjqrqlxk2hjR90GYCdp95CdfyYwV1vqA7zxgjV3+vUcXYfW0ti+sUAvzjj0yphbXQm1
         MnCuklsI3U2FxXdBZZ+0ShsAMZ1jJ1IxTbe0PssGYr3hD4K+SKtobrGbpgszXA93EZuK
         +z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f87FobS5tphZ53TIg74HP41DCxPjF/CnQ052D76Odw8=;
        b=JcU6JRSdhiu76xcSneLCUGvHAmykejd/MjQHpZWs0MHn1FI+gJLphrR2oVAGvkTTUQ
         7RvXrcjiWIjDiwvb4FYG8HnBpzxyLN/gK+QSqq7cc0zAFi9CNOoxDsXa/emCe8mzs1f6
         WuO00QE67WMVwMIguEGTiQ/TQ03uxjnB4G/m9ftf1N50HZ8TLbtzgJl++rWlEzUHjjEs
         f8ykRN/RPHV3NuVPdOUu+ReKsSUaxE2OUS5OmJ/ffjfHlBKkK+b75lpEhf2qRXSyBYf9
         JmqPQrQE4q3iAdpMm/ac88arDJXfwQqNON1aGheXMi830i951eO5P6ZlqeVcSJBpYp5K
         ALNQ==
X-Gm-Message-State: AOAM532hPWSLzb9sujvln8RoD7mycLp1ZsPjnVmo9SA6O88yYNQhzbWN
        O+1v2bfy2BN47UyCOPxARt/VcZZ0X+GiS7LcnBA=
X-Google-Smtp-Source: ABdhPJzzpHNljQSLJRqWviX5BN4OFyh+arip2qjIx0kJw4q5bpS8BMzu0J5dgHTJodnrU0rzBsU1kveAm2qMGJAg0Jk=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr1862373pjb.129.1594324511348;
 Thu, 09 Jul 2020 12:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1591357094-39850-1-git-send-email-luwei32@huawei.com>
In-Reply-To: <1591357094-39850-1-git-send-email-luwei32@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 22:54:55 +0300
Message-ID: <CAHp75Vci3KCT0J_E9S2odgTr0aDXcjRe=s=-rZGGzrbUV3N+5A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / platform: Fix return value check in check_acpi_dev()
To:     Lu Wei <luwei32@huawei.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:42 PM Lu Wei <luwei32@huawei.com> wrote:
>
> In the function check_acpi_dev(), if it fails to create
> platform device, the return value is ERR_PTR() or NULL. Thus it must
> use IS_ERR_OR_NULL to check return value.
>

Thanks!

> Fixes: ecc83e52b28c (intel-hid: new hid event driver for hotkeys)

This is not the correct format. Please, fix it in the next version, thanks!

>  drivers/platform/x86/intel-hid.c  | 2 +-
>  drivers/platform/x86/intel-vbtn.c | 2 +-

Please, split per driver.

-- 
With Best Regards,
Andy Shevchenko
