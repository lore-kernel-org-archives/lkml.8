Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5489C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC53206F8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrFJh1K/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDDPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:17:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36211 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:17:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id c23so5177734pgj.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lkx/PDRUrbuIL8ZH/z7Ipoul4vzVtKjRl5EKv8ZnQbg=;
        b=IrFJh1K/98kXxSDXGPejYN4e7zKLkA6OGaCSCAZYxtA57gT0+rGVywLPYc/ce4dQuo
         k88bemNyVWr7gwc6flBvONIBiH7ZMh8l9IeD1UqNJkHInBXCqjIa5+nAV7KeO/YyJQAy
         dfCjhOLc42+0xS7hFt4zHO37GeuxI893KEip4wUXAlOBnutz/Z7kgP3izLyA4sbH99n6
         9l4eraPTVmsE+TKXI+LDoXVlQya0A7mdgVty0/WiYfGUFpPOPwEisX07t94GrfEmga6K
         w+yUzHBlU7xQbVtNnk17kqF2XjipPPURQGx8PFYREzAbnpb46MkcvdTBo7nVonG8czhj
         Kvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lkx/PDRUrbuIL8ZH/z7Ipoul4vzVtKjRl5EKv8ZnQbg=;
        b=LkGRstphNHHAuZGt2R6vsrzGtUZFmGWCzQ+MWARYO+f+RN5rjVVa7aXCGoGrBLkytT
         0cZe4zfzAulKK/qNye42QZXqbGumoH3qvay2CKZRObBgblUKTM+DkPjPdgGpxwv44Jj9
         J0/cPPGfdv13n7nsgEsafiY13LApV5ZoMKE+1xBEkrRuS9RH7uuHMZAMzR2UW8T4IZTW
         Bz8NmE/ws9VE8BwhR1NrzELHBRnfvpVOyHneP3/6rdAwwt+4l49UD53SmYekGpLSFgcl
         D0NnfD0qEFKPDXr5BERE+5MDQP6RtwrefTzB2ROko/Zt857P5k7kT1DdkSCOwMpmZCvn
         k2Jg==
X-Gm-Message-State: AGi0PuZyCShDjJpdVKaJLyHvNL26VeFqM4A2sKVWA4xMQIRxJlmqXpLo
        foqKkx9/3vxkHrGr1W6V/z7U3aW2C124ZmxYx0U=
X-Google-Smtp-Source: APiQypKYFZLwu2/QO3pceJcENh5As9ISGvBBZd3LrD2FLAhfckw9T5K7GuM0sThal21sOy41LEWm5A0+19H5hbVZgxc=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr13808647pgb.203.1586013433253;
 Sat, 04 Apr 2020 08:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <524ae90a-a7cb-feee-6107-743c52c2b1e4@web.de>
In-Reply-To: <524ae90a-a7cb-feee-6107-743c52c2b1e4@web.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Apr 2020 18:17:00 +0300
Message-ID: <CAHp75VcBKEJtEZg9wUVdqnSHWb3gaOx493GGWMtisdTAwxmGkA@mail.gmail.com>
Subject: Re: [PATCH] ARM: pxa: ssp: Delete an error message in pxa_ssp_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Enrico Weigelt <lkml@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 5:03 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 4 Apr 2020 15:50:10 +0200
> Subject: [PATCH] ARM: pxa: ssp: Delete an error message in pxa_ssp_probe(=
)
>
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.

...

>         ssp->irq =3D platform_get_irq(pdev, 0);
> -       if (ssp->irq < 0) {
> -               dev_err(dev, "no IRQ resource defined\n");
> +       if (ssp->irq < 0)
>                 return -ENODEV;
> -       }

At the same time we can unshadow the error code, i.e.
  return ssp->irq;


--=20
With Best Regards,
Andy Shevchenko
