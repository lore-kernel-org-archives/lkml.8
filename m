Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D31C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F4520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2UfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:35:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:35:15 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MqJVd-1iqPx30BMp-00nPvX for <linux-kernel@vger.kernel.org>; Wed, 29 Apr
 2020 22:35:14 +0200
Received: by mail-qk1-f180.google.com with SMTP id 23so3525306qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:35:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuaPcCML7I7QArqJb0NcnGUkd92pyAkQUgIAZvVxwFDfD+517jE7
        3A6/TpC4iK2uXZxjlRGSmGWhI5dD5Hku5qpvwkk=
X-Google-Smtp-Source: APiQypKmqhe1J42Dc9NNIPPjb6h2NIdLKVnO4btIHTL91FOrFIt6m/guokM0LsSiDAM68xNngDTmSmEt8UP92RQMJ6c=
X-Received: by 2002:a37:63d0:: with SMTP id x199mr276734qkb.3.1588192512920;
 Wed, 29 Apr 2020 13:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200429142119.1735196-1-arnd@arndb.de> <3943343.tW1xmJHsB6@pc-42>
In-Reply-To: <3943343.tW1xmJHsB6@pc-42>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 22:34:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1e=-H_b8_GPJW5-uufye5_6OJ6f+ZWErjKPWkxSRSigw@mail.gmail.com>
Message-ID: <CAK8P3a1e=-H_b8_GPJW5-uufye5_6OJ6f+ZWErjKPWkxSRSigw@mail.gmail.com>
Subject: Re: [PATCH] staging: wfx: avoid compiler warning on empty array
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jules Irenge <jbi.octave@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9QjL77LkDYLmgJ4/MyTpk+/PGzTHnxHnsYkUU7jwiN2MjcgIjzI
 L1ADRf7JM05B3BzLVCVeN5WIQTN2Q/jvKVhqYPID20sSaWpRIntC3qMG0ZOHdwidRiutPzK
 TGfHg91I34gmXdcc9++SfD+yyXG/N2AWF1mf1aMeywBgC1y5sb7FETwfZeuJGt7SkzFfTNV
 cKC/K9fiszofrI8zKEcJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGrjO5c+958=:h32JaDyG+MoUxgZJsP/tpS
 FCxyjgAZat4HiXGWcTAWuvacepL57v9oNfOTp7GmtJdtR75R5c1jdNCOlxxYNbW4lSCLlBDi5
 0JeoPtgPx782yx/UvjR+jHFg4PwRAHnpyhwrgewXRL/NYVQA85PZ+1bnIVakekg2KSk8/SQZV
 lJjuVdgXCX1eRb9TgxUA7UOpe+IEqo9hpko5+0q48crrwNpr3JuBzaR91tWgqalZn6qrxRlHn
 mDM0WHOo0k1FhyilEOAmZMb4MlZHwR1iiOz8XEdUcX1S+7KET4eb7061vUl0G1+y/dZ8Uwfzx
 CVKyOJ6Cl6TClNcU2rm3O10Yg67t2f4MeitLnfBu6YKLB8vpeKaWzFARuWnCrYmPKu7f/Rkkr
 mZvO3uHm73yDIBai7McrkyIE8pZItlPhDW+qt7oi6wBujxhTzQd/zIAKY07nSgETy42hH/N89
 8GusGJicwSs4StYryCxBlXgh5SRHc2eJDCkBsBvr1xX/tNho8bwwSrLfvG00PPUug7GtpJapP
 0cQd0FDW/tOj9riI8z0vXCh4KTGFN0vR9OiE69J3EPtuVNpEwTR9srEmF9yU5wsa9U7IGWs9m
 GeLyeIeIgTRYGx9cXZHmZnXk6VfHJBQRUEBSsAQ8natDzedlcqikGxgnGtxzHZ5oTAAkLZ+VK
 hixmyJxC/jechV0YH8iZWs5s6syrxh0uT0ttiz4DqgjPm+D9MC+9tuLmTmEFVaSqZ6xz7O88w
 DaDBhUogm0cST/6Q2HX7xBVZBKU5jNCMkx96zRJHZPPuHrrQO8IpLXoWuNscaNOC88W+VqWZA
 X6xUKYdA4El+zM8mhisdmqPGy0cxa7nMI5NbdzFme0/YczCyKw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 6:04 PM Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
> On Wednesday 29 April 2020 16:21:09 CEST Arnd Bergmann wrote:
> >
> > -static const struct of_device_id wfx_sdio_of_match[];
> > +static const struct of_device_id wfx_sdio_of_match[] = {
> > +       { .compatible = "silabs,wfx-sdio" },
> > +       { .compatible = "silabs,wf200" },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
>
> I suggest to keep the '#ifdef CONFIG_OF' around this definition. If
> CONFIG_OF is undefined, of_match_ptr() and of_match_node() will be NULL
> and it should compile.

I would generally always go for fewer #ifdef instead of more when the result
is the same. Are you worried about wasting 600 bytes of object code size for
the array on systems that need this driver but not CONFIG_OF, or something
else?

     Arnd
