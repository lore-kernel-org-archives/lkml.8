Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB35C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6241E20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgDHWrS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:47:18 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33593 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:47:17 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so8436725ilg.0;
        Wed, 08 Apr 2020 15:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fu64UL2/aZUHV4DT2tomeskLOh/+k23UcYzbE4vOhe4=;
        b=GmD1N8zqZdEorCYyjLOEUWJ+xWOO1kNSmUb0NytBxE9J3s5dUCE7MdvkO7CFk+HzRP
         +F6ljkeZe4Tcrv35qnkTlD1qy+WUE7Z2EHOqnekoGT1Pbh87GFpPKq4n2ZeQ28O6iegQ
         TngMnoItqDgnJuDpskNGTNhgDd5K8h9AUf3mOY8c8JFyPdFcB9xR4hja/iTWK4CS4kn6
         n3Qglx83JbWxETkkYo3w02PQfzOUgJ8PJ1xrFsvJgJ+edjW21/EV1EY52azCTFy/atKK
         6CyR2yk2RwRabwIYxBuGgNeVdSgfAFih0cqjz3Ry/vALrAlJjkgKCYK5Fbvuj5Dz6PgH
         xelw==
X-Gm-Message-State: AGi0PuYBuC3EKQHfmVflW+XZxE7uckjZHXFiyr8zMtfbmDKAHh2upMwh
        NoC6AaWuXc9QPQ3/r7Z9aFsEacl4lpY=
X-Google-Smtp-Source: APiQypLUjGz27KNN63XlEdZMTx8EOenkma3QyyoO0RV6oEfkyq6nlOiY3ezwWvxa3PYNEOj2ilmrJQ==
X-Received: by 2002:a92:4896:: with SMTP id j22mr9734688ilg.158.1586386035106;
        Wed, 08 Apr 2020 15:47:15 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id s69sm8577714ill.73.2020.04.08.15.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 15:47:14 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id n10so1907505iom.3;
        Wed, 08 Apr 2020 15:47:14 -0700 (PDT)
X-Received: by 2002:a5d:91cc:: with SMTP id k12mr9210587ior.198.1586386034462;
 Wed, 08 Apr 2020 15:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <36341bb1-1e00-5eb1-d032-60dcc614ddaf@web.de>
In-Reply-To: <36341bb1-1e00-5eb1-d032-60dcc614ddaf@web.de>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 8 Apr 2020 17:47:03 -0500
X-Gmail-Original-Message-ID: <CADRPPNRe=YxwjCOYbEjKg4LCOx2suK5WxZp17NJhTm76szdU0w@mail.gmail.com>
Message-ID: <CADRPPNRe=YxwjCOYbEjKg4LCOx2suK5WxZp17NJhTm76szdU0w@mail.gmail.com>
Subject: Re: usb: gadget: fsl_udc_core: Checking for a failed
 platform_get_irq() call in fsl_udc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Felipe Balbi <balbi@kernel.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 9:19 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> Hello,
>
> I have taken another look at the implementation of the function “fsl_udc_probe”.
> A software analysis approach points the following source code out for
> further development considerations.
> https://elixir.bootlin.com/linux/v5.6.2/source/drivers/usb/gadget/udc/fsl_udc_core.c#L2443
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/udc/fsl_udc_core.c?id=f5e94d10e4c468357019e5c28d48499f677b284f#n2442
>
>         udc_controller->irq = platform_get_irq(pdev, 0);
>         if (!udc_controller->irq) {
>                 ret = -ENODEV;
>                 goto err_iounmap;
>         }
>
>
> The software documentation is providing the following information
> for the used programming interface.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c?id=f5e94d10e4c468357019e5c28d48499f677b284f#n221
> https://elixir.bootlin.com/linux/v5.6.2/source/drivers/base/platform.c#L202
>
> “…
>  * Return: IRQ number on success, negative error number on failure.
> …”
>
> Would you like to reconsider the shown condition check?

Thanks for the finding.  This is truly a software issue that need to
be fixed.  Would you submit a patch for it or you want us to fix it?

Regards,
Leo
