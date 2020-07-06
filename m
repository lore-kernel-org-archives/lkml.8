Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC70C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901C120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgGFPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgGFPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:04 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MSqbe-1kLaWR0xxu-00UIoq; Mon, 06 Jul 2020 17:49:01 +0200
Received: by mail-qv1-f42.google.com with SMTP id dm12so17387338qvb.9;
        Mon, 06 Jul 2020 08:49:00 -0700 (PDT)
X-Gm-Message-State: AOAM532MAbMs/t9Qa0ooHRF83kC1762/JASdhcM+8zjWbEayQt30KX5w
        k+8SkftcrwG+OvW9RwEIb6Nwl7Yc/lPqswyzyko=
X-Google-Smtp-Source: ABdhPJz+rSYwvoaIC05554xtJJcX6aTZD2CARsW1DIjZRCOBqR8GKFy2UMmQDHx3vhwtV2/lBuJ8oEELr/LATPfbIi4=
X-Received: by 2002:a0c:f385:: with SMTP id i5mr6184540qvk.4.1594050540067;
 Mon, 06 Jul 2020 08:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200630115836.1283978-1-arnd@arndb.de> <a6812131-1b40-a5bf-ede5-07a1ecde57dd@mleia.com>
In-Reply-To: <a6812131-1b40-a5bf-ede5-07a1ecde57dd@mleia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 17:48:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3PhmQ-tSHtMWVvjPzResAf6wyys--P7kcAUFGevfXCgg@mail.gmail.com>
Message-ID: <CAK8P3a3PhmQ-tSHtMWVvjPzResAf6wyys--P7kcAUFGevfXCgg@mail.gmail.com>
Subject: Re: [PATCH] udc: lpc32xx: mark local function static
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K2aEcLYHNV3JCVBibvrbPT+1Qx/n3hISrIxqZj3UaoSUws6v9vH
 0tOvvstAIWUrVTEceXHmgubFbuSU3MpnY++lFzpDrXX6GOKHkb/TL9WlY4u1XDTR6PBDX0k
 19BsgW3WVdl31ntXDU+DcoDz5PkiTk3UI9Rkj9APo4YrWqG3fOmqaXMqoj47tsLTW0XdEUo
 cedtZl5qdwNGhSrnc8LWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTtVV3TPhGc=:IJCY3o2pwG0FMTw5Cz9G9i
 k2cZZM4nMlvAky4Y12f/LE8RaNmen/W2yeeTriA2yzuvq7pRXsTROwf28o2x2PlNXVrB9zSOx
 /HPV6aB9w2W3VprvhiYEqhEjPUd/9y12rb14x8ia/cPaQzASGw94oaE9oD/b4ehDCD66bMBQA
 24pWow43VEj6lTi+nIF67Q1hxbFoKShdlHIIUcqruxZDuryPWjCsl4fKoAUlU3/cOzU8SMsiT
 PI6DAA+mdpaNoo1gOY1V0rBUhQXSbDAmY98Nwcxsq7Dr/DlKdxkaoxy4TQWrDrrPoMmj9K7mq
 B0IJoSaVxfuJtMHK1Ys4+ZUbAkcxd3bawmMvhQbuGl1s8blB7zosdT4vusPCTrzUGcbYsul/P
 1PEUSQUpzOOajtcIGNrMbqj4qtoVG3DGlbb2OMDwxUBWtaffD1cKAIDA0r7ltPAg/BVU9UZGL
 weHibNeOBOySwCtlh4ln80v7OynyRRmCH8+tPaJyLX2KK4hQqUIpPw77ypO7cJ4kIv2WXlhp5
 rOz5AAuboQFS0obXIkhRfhLX89SUazjdFRV4wC4X3CwQ9RV5rUfySxKYP80tbOlx4m6bZyEY2
 QwjROdEyviThIl0WpQwWQ4T2SupKLTQs4jBQL00GfGnDQYh4VvpOpEQsmYtYrGcTbY1YsDZ8C
 2a1l2O4oToHaGnBuoaqwgjaDb8q3fDpglyD2AsObRUpLpE/aO1R/pHdTHRKMruxk5ZXCtnoRu
 45ZRoYHOQJAqy6wLdX1lpEayJWr1F79F5Ois8XtcCMf4yKd9SqneVGiyyxC+g4Lzrtr2+44QQ
 D+6DO1bvi4sGlKSiPD7o5T8VRhkbpVSTezD+lw1OlehJN0uNMFBPGdedowejd72lABgV2D3op
 mp+piNc4VQJFnPj25HUeK+3/jjbtvv7NgN8C6W+qAP5aeO5I2XLjsjdigD1Y4q48Cm1fkXW4b
 EG8ogWWhO/L6piIlpTaZKYUJeqdU/agjoIjEMBWs/wzfPPUfsaFR/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:32 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> Hi Arnd, thank you for the patch.
>
> On 6/30/20 2:58 PM, Arnd Bergmann wrote:
> > The kernel test robot reports two functions that should be marked
> > static:
> >
> >>> drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous prototype for 'udc_send_in_zlp' [-Wmissing-prototypes]
> >     1928 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
> >>> drivers/usb/gadget/udc/lpc32xx_udc.c:1942:6: warning: no previous prototype for 'udc_handle_eps' [-Wmissing-prototypes]
> >     1942 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
> >
> > This showed up after my commit 792e559e94bc ("udc: lpc32xx: fix 64-bit
> > compiler warning") made it possible to build the driver on x86-64.
> >
> > Fix the warning as suggested.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Applied to arm/soc branch now.

     Arnd
