Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F12C20825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgESNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:19:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:19:11 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MbAYi-1j3tBe1AYi-00bfUo for <linux-kernel@vger.kernel.org>; Tue, 19 May
 2020 15:19:10 +0200
Received: by mail-qv1-f52.google.com with SMTP id v15so6423321qvr.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:19:10 -0700 (PDT)
X-Gm-Message-State: AOAM530zjBq/KmuOaW+0qaDR/kp7JTGhAe714GbmUpXNcvmPxzqCQrbn
        lNtmu2sebzRemwhPxjxQ8CkZel0I2sLIVJs6Q5w=
X-Google-Smtp-Source: ABdhPJwXcZ4W0HNo2WBr6MHyEJ9rPG+mSGWqTjamOgy6YXd8BvhllfhKsDXKQZtVYhj6yUfIQv1/qQLyK4SXVUuU9fM=
X-Received: by 2002:a05:6214:905:: with SMTP id dj5mr21157587qvb.222.1589894349208;
 Tue, 19 May 2020 06:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589623456.git.baolin.wang7@gmail.com> <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
In-Reply-To: <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 May 2020 15:18:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38RVe0=i2pObgaOn+HP8cpdKefiac6DcyXuKnyH4xOyA@mail.gmail.com>
Message-ID: <CAK8P3a38RVe0=i2pObgaOn+HP8cpdKefiac6DcyXuKnyH4xOyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mfd: syscon: Support physical regmap bus
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MKVmt9Nk6FuJhdmIo5owxyQ2BwHyi4hfUcrGfQYDEsrVstz+2uH
 l7jrC5EFW6qNpas4hQjfdUDbT9vY1tqYR/fvyFAXlapaS4xtJMUtYn99kTzj9YUs4JLG9dh
 /4fuboBblmF8X+TwBf1Q6t7dVAIysK+kZGKTPrq2v/dwvLIiC+901yibwX98egXcYoEJAbk
 KlrEEAldUzQGUsGj2gmnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gOLRx7FBe8o=:Hn2Xc6MnYLmB6R/47eE4rT
 PRu7Wk3J6xQj9lnclCZFlIl8Z5BWEOMdlOXOx3a+ZalvrnO2J9uDA5xTsFuxacQmfH4JvL/D2
 eF7BU6oowy+99n5/f9PSk9hsVhhm5GXrE7Q1yKYSlFkRB/Xsn4HYYIUc9KKhyAL4iFZqilo+e
 Mpm9E/o6T+RnSZcuf7VsrHC0PVlwLicIPUMqiiKoO8oEv11YfekcS2kHn/+zBHXYwI1HYqLlb
 XOcBLah+pK2kKi6jScGAhScX1b/KHAKUqGDgnvQlr7KQEbodVZo+H0+BipKHsXm7vhq92gb9s
 gtkk29k5pfyzN4vTzD+Knk2MZ6B9x+SwfpWB7iXOmisE+epvxsKreqrD+9PgTBQ0MkM6yrcYJ
 Sb0egCH8whQmEjKc2FDd/mrXnyw88mQir8Q6fQytUkEnyPVWoL+cU/rQC/hvCW8SQFI+5taYe
 axNN4ACCw/ctoXDddVKoVEo0OgCtp2cFi/WTxWmygcJEdzZ/lE2Ge7MhIew2GmlndkdU7R5fR
 tsCrtjAGBGzi/LWcXLyBSDVfKm4/NIRxpqcJW82a1xrAOCLRSHegPjjQWrFfj0FvwbghxBJ8A
 62zbnXJ0AogRr+ZbAg8gxOBlfPh+gG5873MnQk9PRS4O9RBpC/Xz/q8QjM+W/7aGK6Pnx7xzH
 oE2bKeyWp/Vjb0HSGa7RvMzQU8GMBJ1TTn3RoiEZ3BWDLFZsVf1/2M09hS4esrq4AMqiTqqqx
 u2jGdzeCqEU446N4JCKlpHu13VgrXUEHG/9dYJonnh1JOpet/tZWSzs0qV32yNH1TKXt9d8FZ
 hbLPOA96BcoDsjnAEzdagOZAe5LDo9B+S34oe6nOg5Zl9gqhww=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 12:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Some platforms such as Spreadtrum platform, define a special method to
> update bits of the registers instead of reading and writing, which means
> we should use a physical regmap bus to define the reg_update_bits()
> operation instead of the MMIO regmap bus.
>
> Thus add a a __weak function  for the syscon driver to allow to register
> a physical regmap bus to support this new requirement.
>
>  };
>
> +struct regmap * __weak syscon_regmap_init(struct device_node *np,
> +                                         void __iomem *base,
> +                                         struct regmap_config *syscon_config)
> +{
> +       return regmap_init_mmio(NULL, base, syscon_config);
> +}
> +

Sorry, I don't think the __weak function is going to help here. I'm not
sure whether it actually does what you want when both syscon and
sprd_syscon are loadable modules (I would guess not), but it clearly
won't work when syscon is built-in and sprd_syscon is a module, and
even if the module loader knows how to resolve __weak symbols,
I would not want to rely on module load ordering to make it behave
the right way.

      Arnd
