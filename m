Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF921927
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPSqjFvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCKC5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:57:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34363 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCKC5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:57:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id s13so614289ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHJo9jwMYPaGt5B4QvwDpgXAg2phkjBbDHGzsQU+N3I=;
        b=aPSqjFvWjvdtvp8nVXfAoj+kYZWu3nVRyQ/p2DoRhOKX2zIof1/W9HuOfjtGrhEGo4
         bTFVId/1UJUexP0vZx+GLFATndJeJVGjdNhylTAZEBrB9UgSVpeDcY0fbd2URSPeYcAl
         uln5TeOcLUBapk8RcBr7zH8fXVeJOekRmKyEvK47RdG5LZ3ocCVMNhKNjZ03DENuk6He
         bJmiSgv6cySFXzmKebaDhjhnLhOwRDhTvJ0AgMubjeXowbLQfIakEXUutx4lQpg3Q94B
         Z/2TJ35EkOsIWZ5j8j3QTWqq0f5Eg/ApTvcCQFe1Vv3LRkP2drM+ML2uT6oy1bfcG9p1
         F90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHJo9jwMYPaGt5B4QvwDpgXAg2phkjBbDHGzsQU+N3I=;
        b=LAB8HRVrh0ZqI3iiCLTZXePJofcTpRgdgJLLGGw7odf0451msTFX2PRbAxbhc/ugnZ
         5F0dJ5/LMptk8edWQ3E+RWo3J42Ccs7yqfjqbiK9tENyQr9X7CBm4/tcLw/HrnBs4xO1
         5rdPJXZjO028Hnn4whTqjoYX8NNyFi/3N3gLiBAnKnlup52R0gs3/uDZm2wtX0IrZdCY
         QH2ax2fmI+uonpXcZa7q+qRf5d7BihETCEYT0pF6Nda96L09fClwhqloS0H7NWy/f7zf
         IB7To8rWsBk7VKIetjXrIUKuTaIi8D1a7jrkyoqHS2U466HQ9j06+LupDjRacG+rNZBh
         PBTQ==
X-Gm-Message-State: ANhLgQ2OFx8UuZL1t9/etfPGUihQcSjsMgRjrHzkFd1N7b3sT230cU8j
        6m4kJFtbop6lryt+Zp2V+hKtCr6QuekSt5JSZOE=
X-Google-Smtp-Source: ADFU+vtshCj9Q46hlfgr5TbhM+vuzc2+J73V4+7Gd94s/qMzp0Krh6P6wbjzZlyrgRoXzp6uwiFGbcKdgYSlllh+tYg=
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr670025ljj.10.1583895456295;
 Tue, 10 Mar 2020 19:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309021747.626-2-zhenzhong.duan@gmail.com> <CAK8P3a2jy3+7tPFPjN5pfrQdfkhReCdPFjAnw144pXzpHCGDdQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2jy3+7tPFPjN5pfrQdfkhReCdPFjAnw144pXzpHCGDdQ@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Mar 2020 10:57:25 +0800
Message-ID: <CAFH1YnNe6MELofTJNdtS3cxJOiFB8vco0oGTj3t7ZERUQA5gHQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file
 into miscdevice.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 9:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 9, 2020 at 3:18 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> >
> > HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> > unified RNG_MINOR instead and moved into miscdevice.h
> >
> > ANSLCD_MINOR and LCD_MINOR are duplicate definitions, use unified
> > LCD_MINOR instead and moved into miscdevice.h
> >
> > MISCDEV_MINOR is renamed to PXA3XXX_GCU_MINOR and moved into
> > miscdevice.h
>
> This should be PXA3XX_GCU_MINOR (with 2 X, not 3).

Will fix in next version, thanks for pointing out.

Zhenzhong
