Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D0FC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5924125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAUJIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:08:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:08:32 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPp0l-1jFbP33f7L-00MrDQ for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 10:08:31 +0100
Received: by mail-qt1-f173.google.com with SMTP id d5so2040984qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:08:30 -0800 (PST)
X-Gm-Message-State: APjAAAX8FSIDe9mrULqWcPXyXbriKHO2WOZZqtBJPtIqdf7bh+Jd7nz/
        QXOXKUUGgGLVMcrXvqn6zoehAx1YT/lmjShymE4=
X-Google-Smtp-Source: APXvYqws5Ta5Xb3d0b1umI4PM534+95r//lC4HjVnAC6GdFbhDY1KBJ5P5kblVThGH6tEXv8s5xZXr0PSEdzNi330CY=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr3385584qte.204.1579597709746;
 Tue, 21 Jan 2020 01:08:29 -0800 (PST)
MIME-Version: 1.0
References: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 10:08:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com>
Message-ID: <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com>
Subject: Re: [PATCH] pcmcia/cm4000: remove useless variable tmp
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Harald Welte <laforge@gnumonks.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fuPhXtM/KAW4Y7freFG2H3dxxGni+WrezyP3ScNC9kKMfHVmbPs
 +hzNITgKxyeWI0v9qQiPr+sKunYsK9NIAspfI07+t7HEhYn7XKli12m2beLWH4wLN3C5F9U
 RhMWYWC9TY00b8tBkdLaePpw442YziV78y634i540FA1uD3uBlaCedRWrKfTpMIUnDm5NYG
 fmvijNDLuC8eR2Miubfqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTM6k00LoHQ=:VsnYsOKaNd5VTnq8P9jocv
 13fbPRnkKiQMaINs+g3MTHWZvPl2Q0u/Gl63q4rTK8upb7geDVxeZPzVbTFuQp2qfY9qF0IQJ
 z7An1jOkkwO+hOd6vkfMaHEyqfWEo2tSGQT0CvwuvZqqOyA4HDt+snFJYzwRAhStdOInkUC0p
 o67eKtjMnwJ2oX/2zo4Ra0FUsPW2f0lzD+uZSZmHPTcOsO6cvy+SRsy/Z0h8qyRFnWWlyiheq
 pWDMfduD+QxatWdYWlgEAx2LY9N5U7COIKeLVuShT+5RLZ0pKhp0NJGIT1mm12AVsIOhgCteR
 GxGyGRPx6kW6750G7absDyTpG2j2zp1L1k4m6JF0oTV1lEn/gVsx3O13fJSAp5eNLLvR5bzbR
 Ty7SRra9hOM74VITBdKCAzk9Ne/oGjRFLZHEUQo8UnKiJ/z+KYL9jZv1x/7nwv92TgKzwVEWh
 88rYDVMSAobNAudpuqqJXZIMMrjIa/u4+6o+BzIzLjswWyzxzQyH5xMIwW9MsUfXBJ6hnpkWZ
 35nDATfand2rECSY0dLv47osAKZDm2x1tv8TzBeEsytdWrWrKj3qiFHChzDIDBus1/X86p8E9
 NzGqL+PJT0VexqT26yf1LIbaBpHbS8vdwJkiy7Z6UCcva4JDAZCEgIekjey/PbgMesAO9akv2
 OF3/V4GYON/2cFge+sVd5DxANZ10VaJis9bMTi/PPlTeyKEjp1c4cJUcpQVePgVCBIy0R/50G
 A/PNdV51wgJzZp5YBOhBAS/WS9T/MNLAM9MPocduS5vpIZfgVIR0F7YlGuGr59vTsrM8T+KEn
 hgYMIQVsjo1yj3TNk9r983nz74g/PMNJHZFB4giFitsETivMHI4xJSDahr6hWLloYNRaJzH72
 4u51WEcm/QAj7GS5BBWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 9:50 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> No one care the value of 'tmp' in func cmm_write. better to remove it.

Hi Alex,

> @@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
>         set_cardparameter(dev);
>
>         /* dummy read, reset flag procedure received */
> -       tmp = inb(REG_FLAGS1(iobase));
> +       inb(REG_FLAGS1(iobase));

I think this may cause warnings on some architectures, when inb() is a macro
that just turns into a pointer dereference. You could write it as

     (void)inb(REG_FLAGS1(iobase));

which would not warn anywhere.

      Arnd
