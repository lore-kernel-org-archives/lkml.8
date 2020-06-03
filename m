Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D25C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5C52067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFCK6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:58:36 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:58:35 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7sQ6-1jbV9P1WyI-0055F1; Wed, 03 Jun 2020 12:58:33 +0200
Received: by mail-qk1-f172.google.com with SMTP id w1so1626049qkw.5;
        Wed, 03 Jun 2020 03:58:33 -0700 (PDT)
X-Gm-Message-State: AOAM531GNkAykDmZlCPVa7raVspMYFLllQXfoob+9r8VuTsUxFHauHfT
        FaAu9aE2jJ8P/w70z28O/tqLBdR27VYyr+18tjI=
X-Google-Smtp-Source: ABdhPJwp4BruVv7x5KWHmKJY0GqISo7xEiXCSVQRm9DX9mEfuj1pqEjlD0cOd9acGIKxlDiPqlWzDUxi/5J33dKl6LM=
X-Received: by 2002:a37:6188:: with SMTP id v130mr23821454qkb.138.1591181912135;
 Wed, 03 Jun 2020 03:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160044.2550437-1-arnd@arndb.de> <CABOV4+WerpJqsy0-uBPBZfpnDaPn56fn0Zvv1aMUJJSjEqGhAQ@mail.gmail.com>
In-Reply-To: <CABOV4+WerpJqsy0-uBPBZfpnDaPn56fn0Zvv1aMUJJSjEqGhAQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jun 2020 12:58:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ffn2wtWB=bogi78MmW_8ZvNTHneVMicPU7AW+s2tmCA@mail.gmail.com>
Message-ID: <CAK8P3a0ffn2wtWB=bogi78MmW_8ZvNTHneVMicPU7AW+s2tmCA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EV8OvwU5XuotSB7OvqwP+OpfsQxGeVOp+NthtyCo4zRG/ryxbcR
 w1HmiTM3ciy7AepEbYIf1UP11fUGUaIW829w9wNz5osaVplOcZwZPSqI4t3tRZFGmbbwSqJ
 E05v+dpnNj5xUD8G9sEUKKKI0k6TTD80frZ9F+/tljf9qp2dx3HtmlIRAyOiZzu3s7+diSe
 GUjbs3YMxT+5cPRy8pjIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GuVXV3OYUGo=:gt5Z4Cym1Kci0IAd01vcbI
 LIATeUrFyIOm/natrAR847ba+lHHn3p2jDxTj2uS98pYj5xyAT4G5d1gMkGgMdG1Dnqu5ag3u
 qRgQrcjXBpd05pFQhxHD/r4B7tkx5mCc+9vWnpLpG2LOIRfzUdYbRF7PEVjwDGmJJ0ySaOCvC
 mdwH17+g35vGjbqlnTYYMDR+6kawuFZjSmN59NeY/9S+kXiHwXKWv8maAhP7wt8HNBufRSJXB
 fI6B5qbcZIJrAX/8gyYCUY1tCrSfMoZ8v46fWIyecfkIPrRxaiGSW/miDAzka0rRadb6iyvSg
 JvcLw8UVyNr4XMOvw9xf+CMGA2OZZla4Wjw7p46gD2T4hvfUUA5Lkhs0FUzAcJwykacRe1Znj
 5EVjFBbDsOMrxi0VMxhaNsKChDGIf4dNuBAqO9o34Py6tsPQXC5VPGgiry4mGAiTzf4yHnXfd
 srssJc6Q2JVqvgY5CR0utVnUYnf0FCyukHOC5UyaNybuCLpqbt0QbIlIWAfMjpE/iBWWqms0F
 U8XYf6/6mdcwI7NXYJ9b4iPw+lMuIor6V965bTxQTU2a5HOH10o73kx6bTb5QuefCAT6N84hE
 d9KaaXzUSG9J4CFYWL4jXDhstri3C+6IwC2Fw8YUmIJmkxyLYcuKCI2d5UXRJ2r9Yz6u+uI2X
 XWn34Cq0SkY75O7m/SAOMUn98QoH2ZQk9nHVPD56q9QEeb7jdq7czGy3tC4BwJBCZirM0Vgke
 dd66O5zHmvnDLIV96YD4FAgwsMjzyHsmL7b+lfDPaE6wo3IRoxPxdWQ4fNEu/e+++PSOnM8Ah
 jERZaXZy4+rw2MqpKaEuQ15icQj1lI97KUarf4jcNOKouLBwHk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 11:17 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> On Thu, Apr 9, 2020 at 2:57 AM Arnd Bergmann <arnd@arndb.de> wrote:

>
> This patch seems not been applied to next branch? I haven't seen it on
> linux-next.
> Arnd, can you please pick it to your tree.
> In case you need my ack:
> Acked-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>

Ok, I applied it on the arm/drivers branch now, thanks for following
up on this!

       Arnd
