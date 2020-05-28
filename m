Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24201C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D91208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgE1Ked (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:34:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46279 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbgE1Keb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:34:31 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MjjGV-1jAjXB0U0p-00lG0I for <linux-kernel@vger.kernel.org>; Thu, 28 May
 2020 12:34:30 +0200
Received: by mail-qt1-f178.google.com with SMTP id x29so8556199qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:34:29 -0700 (PDT)
X-Gm-Message-State: AOAM532T/3Bu6n9GsClpO6tytPBuD0pOLxxKWFZqJ9ESJNXqmRTQz9ja
        A4lE0lr/jVa+S1BDEmya5pxaHkp10VzJhvXpNos=
X-Google-Smtp-Source: ABdhPJz3yBNY0Y1l2GQgmddAe06/aLT/EPVNAi3qA1mW76+pW3uJJs+SQtKuVU4z4oIEEx0O1wqMAz/VPSEinL80rBs=
X-Received: by 2002:ac8:691:: with SMTP id f17mr2292393qth.204.1590662069005;
 Thu, 28 May 2020 03:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200527112608.3886105-1-anders.roxell@linaro.org> <CAL_JsqKDfcX1YUTmkMbMNfPHnW5YcB7FaAmvrb42wgmsdfTqng@mail.gmail.com>
In-Reply-To: <CAL_JsqKDfcX1YUTmkMbMNfPHnW5YcB7FaAmvrb42wgmsdfTqng@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 12:34:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Y51exEP146yoZmcfti1-ihwfGk0Z8pf3SAX9gH43QgQ@mail.gmail.com>
Message-ID: <CAK8P3a2Y51exEP146yoZmcfti1-ihwfGk0Z8pf3SAX9gH43QgQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] vexpress: modularize power reset driver
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        SoC Team <soc@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5vR4c2juF5ptiL9fh3Myo5VC/CC8C7jpUGR+te6D6AtY9H7eeWg
 Q4FoxCyYBtNi+8lu4AQzTJbruT1twyaemJ9TP6p1ucFkn+zVXFQsJaTcX6o0c5O80BeipRy
 406nmg/jjRuOtMZbh3Sl0Zk3bTwwY2A3eg104D+n8N2DS5T7nIxlTAUnbEcokBK+P2JBGTt
 YcRC2ao76Uvc1uPyZkooA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:55TFgZHvrR8=:dnsKJCQr4uF2/zwL/6rI9H
 IlEl7gjAXCg/t5JI2rtOB3R/1yNMuvixpwpaErVkYQy7MX8SjyFmbfp1ZyIBDqV8ZgbkevsY4
 dnzpQE9vRdPm+E5p5GzBQIupUTegg9PfRG+/Bmu0pVkX2sHHJRHG5ogMaeP0v21yQqGyURDOA
 wIFhVJ2y3UcJaR5l/Diz8k+vS/aCV8UbyCfpPdNtvLsDfhZO34TZXCO1t43UgihDi2OZB5Kvd
 /v8crYoES4XdwRTJd9nfS9zvM45U0k21Z+dmsZ3BRcdhNQ5aDc4R5PVd+jH6V4h5gBcoFNloR
 riz6XQ+Ub2frrLTWjdmCoMBvhkIvoJFgmtfZ9XVDIgbiVVTidZE6JER7/eYnxJS5OSR6Bl+vn
 1iL3/vF9dfr3iR7ES2+CqvEL3AwkDKRd43mv2PmT+bPkSlvPbztNQSw+jPuB6LyD5ZqP24+mk
 8qCZsOHc6ANQE+/0Tm6H1llP3uwZ+Kg1qJtdvxm2nvkj70+gHd8m98xFPlrch9HJCgxp6a7Ac
 Jp/GkfxxpxUzdE56lPKehwMk4Veipr3WHjiYqIsOyDde36C06lFZ0okXT+xdNzXpfbdU8p+1v
 Lov81zxURcnx2+ii6r7E8e9KqK49udIVxil9pb/x42GrXHx/oSax/ZRMYLjQSBZHf8oub0Yvk
 ALJMegila7surNecVWW68BBlAHWBwMCmAuAnn0cDRRhA1DLgzRAOOGoShcxdt3rt+XwhXZhBZ
 7uYUU+uuInC7bQeJqPm7r2O5aKYeaM5EPKK/CxTcIoLHHXJpHIRQdL6kb7koCpqfgTLM9U+QL
 CeVtYwIeY1COzj0IBtigv+44XRhtONvgmMfXV9bfNM2WbVCCEs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 5:26 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Hi,
> >
> > This patchset contains a bugfixe, a cleanup and fixes allmodconfig build breakages
> > on arm and arm64. Also making the vexpress power reset driver a module.
> >
> > Cheers,
> > Anders
> >
> > Anders Roxell (5):
> >   power: vexpress: add suppress_bind_attrs to true
> >   power: vexpress: cleanup: use builtin_platform_driver
> >   Revert "ARM: vexpress: Don't select VEXPRESS_CONFIG"
> >   power: reset: vexpress: fix build issue
> >   power: vexpress: make the reset driver a module
>
> IMO, patches 3 and 4 should be applied to fix the kconfig issues.
> Making the driver a module can be addressed separately.

I've applied patches 1 through 4 now but left the last one.

If we can find someone to write and test a .remove callback,
I'll prefer that for v5.9, otherwise I'd consider taking Anders'
version instead.

     Arnd
