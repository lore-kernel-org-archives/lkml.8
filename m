Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25602070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgFZOh6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:37:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgFZOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:37:57 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MzTCy-1itrBk1WDo-00vL9G for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:37:56 +0200
Received: by mail-qv1-f42.google.com with SMTP id g11so4585886qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:37:56 -0700 (PDT)
X-Gm-Message-State: AOAM531EVzHfX5WdPmL4qSLTyKtNAqGEgYv5bQjAx/D9gLdCkpIVCXZE
        RlgBnCf34o8d1/CJLFk45QqHE2ZrnXGjj2cR1Ok=
X-Google-Smtp-Source: ABdhPJyfuQEYBa5MgOiBy8bbX63hjSU2tNfkceBKI1Vd8sPd8rCYB1PvDeCJCf2TLn2908S5iDQx2pZ/HBZU9pmuKJE=
X-Received: by 2002:a0c:f385:: with SMTP id i5mr3580097qvk.4.1593182275276;
 Fri, 26 Jun 2020 07:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-6-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-6-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:37:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0f1mojUw3jwuZWYcVRB7u9THt62vHe-jS2P3L=PKTV=g@mail.gmail.com>
Message-ID: <CAK8P3a0f1mojUw3jwuZWYcVRB7u9THt62vHe-jS2P3L=PKTV=g@mail.gmail.com>
Subject: Re: [PATCH 05/10] misc: lkdtm: Always provide prototype for lkdtm_DOUBLE_FAULT()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Wohm3fhlLguIrcTt0zsqN5SZMg7n/fBN7rHkHv2J09vid5ngTJM
 ebubAYVS2+8i6Qa4owdKoiS49QRI3JxPyXRcZqmdS3Rv0ZfHVbon3G8XjRA1etJ3uzCsxPs
 Hkh9rxapRRunXmeeSmeZgD9iai2Z7tcBgKzHnjS7w1akoZwzPJp+nCnmSjmd9825hOPEIsK
 qK5BiQzxKFeBfNmqb7CHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6PBN6WgPis=:pXet1GDyFEoFIKskEWLZQv
 cwfd3iZxRiGt4xDoF351ie+7fX/gApz3VGTKh8+ZDAeW0ahgeGEWf7NicRSsb38feLmzYHKES
 8Kx3MJ/c8UrBUiQkYxiOm1Br2IAu3z20Cw0SGs/+etorQMch6vNc/yVxGIkBQ6bNE6eeZddzj
 dP7OHERVK21C7NMpMbwYcxX931tF0eZzCABaI8BTB4SXd2SKaobIQpr1u9TNy2mRhndHrfEOs
 Yi/86erWFbO0KlZYGV5a/KLIbDuZf4+NtUmUh8gYh3OD+zNY7DSM/ywTcNYTbjNWNlWn5uzz4
 gUrWODyjOE9VaiE74rUn6gOsJrIWCrskKUrDqOE2+krmLdPJ8iaO/4Ahjq/jmJJJahL/pi4jB
 61WR6xyzW5E5R9EV/ZFmD77nyP7uTcbutbhavU8SqXxJq5MHMSNyzkNat4vdyEsVntYadnjDb
 rBMOWiRdstPFY0ibwUl32jY9o04sW74sq/YkXt3JmI9MAyvSyGfSjyaE8GfLA8kV52vjDcK4u
 57eou5dpQ4qFZTKA+fdtVX9pVcQXqVWrSvRI54l+GIPvhDCOHlUAqlKBB5sjRRLgwQ6Cm/K9q
 lSe6kgu+twL3m4lqqtgolRmnif3I/Vk93C3D2Zz9VrRuJ3UXbeqWzo2os7AgMT/lcBhMbb550
 ujLvChPDI8Gy7pVGUMb5Y76WrVgPDUPW1twlyBDUlJhvWdmMyzpbG/63GOfD/yoNb2Isi3KiF
 gpAV4BcMCHiuC14UPfQeyLVd1nIDeH3SlV72aMdqLMKh1K7Vpm9U0a6l4Os4ZbP2Kg7+UJ2EP
 HLp9xH0u86sNSiP2F1erriJH/gMsMJL0cJ6DRfDb6LT7MQCpSk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> lkdtm_DOUBLE_FAULT() already has internal logic to handle
> !CONFIG_X86_32.  Compiling out the prototype actually prevents
> that logic from being useful.
>
> Fixes the following W=1 warning:
>
>  drivers/misc/lkdtm/bugs.c: At top level:
>  drivers/misc/lkdtm/bugs.c:420:6: warning: no previous prototype for ‘lkdtm_DOUBLE_FAULT’ [-Wmissing-prototypes]
>  420 | void lkdtm_DOUBLE_FAULT(void)
>  | ^~~~~~~~~~~~~~~~~~
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
