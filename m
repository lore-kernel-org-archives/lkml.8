Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530ACC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC0206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ifuIIkzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCGCbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:31:11 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34857 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCGCbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:31:10 -0500
Received: by mail-ua1-f67.google.com with SMTP id c4so1446891uaq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 18:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9Ya/C98kfpRZg4gkqMvlKooVGFLI5x92xi8P3qorPM=;
        b=ifuIIkzS+6sRYeh9R+L3aZMWngxePK4Ae1v8J8XTPBIzJ4o6wTgmY1C3gLSOmf6N8C
         MIi0O1CXFXA3kIriIUYp8S6VhAaJMTdjcvoSbHxYxZpfUaDpbYgYl0hrthO7jCa++Nnk
         akDN6T8Del1H9aV78YCbmUigBlh5Cmp48bjIK/8KoV6EM3gOkrIEZMzy+MR33nUvPrMe
         rSOqUg7PlD2aY+v5wVmOHrgDnORH6DM8/UiIKctJji/LOPfvXjqgrkkB+oFMNyrAZwjP
         vhaXmDCDC0BULFNNfA6YyFzsAla65DUnN49ac8TCdFWVqMdzelgncvDX/Xb8npJqwYVz
         Ei/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9Ya/C98kfpRZg4gkqMvlKooVGFLI5x92xi8P3qorPM=;
        b=Qy3IFsjwKPyY2u+5V3MQaHVOZ9Z+lZKAY9nBz6YgzTy73AMNrokDPV8xn6WUdsAYRS
         3FB7AhyMthUXOczmI6pOK2pUT6lauXIMsdohK2XQ8cfpBUwfA0zndTAb6ntj8my3M6V2
         LEdW2QGgfATAOyJ7tUW0qXbD3em6Ko3BCC7BbtQ2Fj6jmGHtUNOsHl1oJTsbQ8b8A2f5
         25B+PoK5aysJeAwn/DiSjpFFuE4DXs3wf/utvgxs5IsqMQmrFr0z+580kjorYYXYqoeY
         pB9oleWpw1PHwvaEc2xX7uKTT8zsvEJMCGGkXIl+RqYNkDPSWkjHhBJ6Bebdwjj4YI/T
         Etzg==
X-Gm-Message-State: ANhLgQ1PV+ANg8dtA5yzschwM28Cfc9NDQlH64Jzsmuw5UKxmlW4cbQg
        Ev06feQAFwGCf/smf2WXKvqgFdp/YFCps0CKrvyDcvW4K48=
X-Google-Smtp-Source: ADFU+vsGYeX8deeFTiQUXBM84EbN9XuUAeO3QMuQlbxbcRkUEgsMc+zWB+stKd0Nn+CFFbGOxaT4ggue64YY108z+Iw=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr3482116uag.77.1583548269719;
 Fri, 06 Mar 2020 18:31:09 -0800 (PST)
MIME-Version: 1.0
References: <1583509057-8197-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583509057-8197-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 7 Mar 2020 08:00:00 +0530
Message-ID: <CAHLCerMYdFVbA+Fqw92uAVjjKWaMGS0Fq6Vrmy8AxDcnTX4L-w@mail.gmail.com>
Subject: Re: [PATCH] thermal: add COMPILE_TEST support for i.MX8MM
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:13 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add COMPILE_TEST support to i.MX8MM thermal driver for better compile
> testing coverage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4d6753f..91af271 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -265,7 +265,7 @@ config IMX_SC_THERMAL
>
>  config IMX8MM_THERMAL
>         tristate "Temperature sensor driver for Freescale i.MX8MM SoC"
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || COMPILE_TEST
>         depends on OF
>         help
>           Support for Thermal Monitoring Unit (TMU) found on Freescale i.MX8MM SoC.
> --
> 2.7.4
>
