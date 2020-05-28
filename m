Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C5DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD06208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbgE1K0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:26:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbgE1K0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:26:10 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpDRp-1jE1Rp3PpP-00qnDC for <linux-kernel@vger.kernel.org>; Thu, 28 May
 2020 12:26:07 +0200
Received: by mail-qt1-f181.google.com with SMTP id j32so6809790qte.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:26:06 -0700 (PDT)
X-Gm-Message-State: AOAM532hXxlaVmdkWdMRmG+6TNUk/HiP+d2I1ZrKDFk+nKA67Sl0oxhM
        dl+DdCUnULdTAPGpW7wf7zTqtq7E87pTj/fXpZo=
X-Google-Smtp-Source: ABdhPJzZDzCqFPei9gCeAOoruNGiztHbqxTx7mAfeb8dqjxHRA7W1V875BfSq9ThfnHKfXdXDTVICVEKmIsGV5hdYf4=
X-Received: by 2002:ac8:691:: with SMTP id f17mr2257635qth.204.1590661565700;
 Thu, 28 May 2020 03:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
 <20200527112608.3886105-2-anders.roxell@linaro.org> <CAL_Jsq+vrEE2DBY+c3iVyMLf9oOaGVHVvdiMgdYEGCjJwX7Hcw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+vrEE2DBY+c3iVyMLf9oOaGVHVvdiMgdYEGCjJwX7Hcw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 12:25:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1P3bFC=cneCR9CURgYis6Ue7oPXKAEAQ8TpxQQYUPwgA@mail.gmail.com>
Message-ID: <CAK8P3a1P3bFC=cneCR9CURgYis6Ue7oPXKAEAQ8TpxQQYUPwgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] power: vexpress: add suppress_bind_attrs to true
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        SoC Team <soc@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:s89PGBfFbpivKvIclG9aePUmjQFOUcAHrSdHPfLJ4svnNplAO6M
 3FPS/RtYwqByhuVefiN4eF19nwPC4fJEC/txMpewFQHBOp+kufQnJCaLMCLMbe+GGqcwRcM
 CS7cQn6jAyrL6KlhDA8bqF3K2KAGrM77dfTGq9wpdS6erhezQ9HDrD7OHz3iWk5728aCJF5
 O8YJy5NcnD+B2jl9+5nig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+fQvlHe5zmI=:vJeEuznbvEshnp5WJK5Qti
 TG7VncQOje12ZUFtiN2LWiVsiG9yhDjSEbroA5k9b6GPW5zh2cOMemcRjvwTuBHhclFfDPI6x
 p6BPPIpb81rmfaGywBExln/WQ7rWySEBU/7RMTyJ7yq2cFs/kPweawo1a4tD2LqDjuaThk8wC
 eNVltnQhdAyjju8PCZQLEk+RmXa8tqVg3qXZU98GTv9TykjhZ1Y0QF1RCQkmAkOETY4ATKnHi
 bK2KPKXotaJUf0DxlPInkV3TECSi9/G6Q39aRgKJQH8xFuVIoECLBX115YYvgNOKDc2AxeAi9
 VdN2DJtnl3HlA7v9OVhDcdUEGB3d3lRYCr5YtHjiy6mlUaaqMoFzSj5bVlB1MZzeqxcajd0jr
 xhNY66+sg6uEFHEAgctUqNuKggvBAOZfsxez0hkRm7jTbzN9UKwQMZ7kkRZuql+tem3rTlGk1
 qtOUs/4Rb7+FfYjTJmRpBxKOnK3Zs5rRlPuKHEJAqeUGIBIh3UQ3BBkyKTbhZwpDdpU4m7K1o
 xBOaZEMCgtuSK+Y28M1DvYYWGqtHkdKU0xuKJjahBA6ldQSIuR4qhIbVwYo+pvhC5RH6JWkBK
 MFog9kvdXeT2w/ug6g9saQZt8f/moFatkEkATCB8qMYeLg1wlKzB4gDeVKfUcyuwlAqGwk1Kc
 EpEOno5ppPLkZjN8iWYrfQEHBNYnjtKytCGcsYd2PmE/HgzKlDKxbOZn6BP8xrD2kR/qkPUVu
 2z7Yk3FVbmab+mT2EQqo6J6sHpwESn3TLWSCtDEFdWSGBi/ewae0SrKtDceOk6VMe7c+R3t/H
 SX5dbG6Pfg1jU+VmC3iwH+Q1PKr1nGXPwXA6WQwHfE0bfOWGgI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:27 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 5:26 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Make sure that the POWER_RESET_VEXPRESS driver won't have bind/unbind
> > attributes available via the sysfs, so lets be explicit here and use
> > ".suppress_bind_attrs = true" to prevent userspace from doing something
> > silly.
>
> This doesn't really make sense if we're going to make this a module.
> Module unloading and unbind introduce the same requirements of
> cleaning up (undoing whatever probe did).

I still want this change as a separate patch so we can backport it to stable
kernels for correctness.

Also, as long as we don't have a working (and tested) .remove callback,
we can only allow making the driver a loadable module but not also
allowing the module to be removed.

      Arnd
