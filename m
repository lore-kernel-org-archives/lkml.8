Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331CFC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FA82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD3NWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:22:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgD3NWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:22:09 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxDgs-1jEX1a3Y1g-00xYq2 for <linux-kernel@vger.kernel.org>; Thu, 30 Apr
 2020 15:22:07 +0200
Received: by mail-qv1-f54.google.com with SMTP id v38so2928626qvf.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:22:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuYnk3OhaRd7IypGWvuIdgiHhwdggiDqv/xx14+X7Q/rhEEGB5Ey
        vpZTT6nKQJ+le+mZuY9/e8+T5SxrhFLc9BM4NHM=
X-Google-Smtp-Source: APiQypLuqw7/v6Gh8dAGdkb3SrT/lgJqjVQEkm7oovSCJMnVMwaKvPbW2WJQKu+eMQVtBvXDbWBidCWN2fMbtSmOSbU=
X-Received: by 2002:a0c:ea43:: with SMTP id u3mr2739084qvp.211.1588252925601;
 Thu, 30 Apr 2020 06:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200429142119.1735196-1-arnd@arndb.de> <3943343.tW1xmJHsB6@pc-42>
 <CAK8P3a1e=-H_b8_GPJW5-uufye5_6OJ6f+ZWErjKPWkxSRSigw@mail.gmail.com> <3063047.NHY2raB2sq@pc-42>
In-Reply-To: <3063047.NHY2raB2sq@pc-42>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Apr 2020 15:21:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Per2f3noAzgN7brQ3g_4EN-vNLcv40k7_vtH+qZG4wA@mail.gmail.com>
Message-ID: <CAK8P3a3Per2f3noAzgN7brQ3g_4EN-vNLcv40k7_vtH+qZG4wA@mail.gmail.com>
Subject: Re: [PATCH] staging: wfx: avoid compiler warning on empty array
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jules Irenge <jbi.octave@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z4gsk05gIMp0as8i2ysNFlhuuNJL43gpbTlAmnMJRyBYK27lGyC
 gOkFiXKCvdT6ih7VTOwv/0Zn5RP/8l0F5zkEdkfTYNtygSZoewKDNFsA99EHKuc7wYINL7W
 7afOMRI8KQYdV7QaLdq2KvXxfYygaaQWuYj8N6zLnpzrD6Iqd2n5RFp1wtChY2g8E7RySuG
 LKKLlqQgzI6ixyY63OXFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hAVG9Yq1+GE=:DjNNyxwJ8r3124YJi6UNwW
 oFjsDHPsF9GypxcdNAzPy2hCTe+Y9p4gqKhQACjSaG5OwRnQtYdig2wbAVT15KZb2D1JHxjn4
 eax4tNFFfzSzQ2bO1Xd/QEOBSUv1wbdLBsARhHz/uAvj30vUS1LdlrHWlieBskC0GBsqLTYOK
 QsqeGm39hPdQo+ERZbPPufWSIkJU97dCai+H1sfixJNfu5sxwpcTkQmHYG53IpruPvW5ll50p
 shzi0KdJGHi+Um25r0AeBcZzyuRIwR7aN343QtlIht7Weth39Q7qcfMPlFk7YyYGCHBEmeeGX
 pMENr1ivAWG+PiW0DqsS+qE8sPNjDt/ocsnLEsO0kaQ9r0erl6OgTNHzYl0FpDx9Wwzze5Bsj
 cRpWrEZat0rvpDPFULJRgLspVAiDLoaO2IrWgiiQTzcn8Nac0FaVpC7NOKZG9P6Qs/neRf76i
 MQuYJjWRzH4e1e99hZ2zgEwAzqRrxbB9QyXAcKv8HMOmn0hsoQHAaqhL0mVpElbg0d6eztWy/
 xETKetKybSHu6WhCBLRtuve9L72qQ/NkP5m7rfoExT3VDllM8nzcUH7goC2wqUbQhzqedL9ao
 W7OyqwSHnVaRWwilwxM2SYJTxcZicSkhb/leJ8jv3eaxca0gx0/A8GzsQoRQmVVrg5omMg0De
 rOn/fUob6ojECTTQlCAni/87yzqNA/W6HAaMUlCR4UDVxD9VU+pIJUoRz9d5kFbBu7g2GMdQl
 sMzXtQvh+2+C70N8kwbP772uAWiAuKoBRtsC4wI/a3ELZ+FlsukzmkdSctXpHlj//71J8QVIB
 kVxxtpML2YOH2Xhnm70mx7YQRZPnSelYb8dnraqTEtCuU+vvXY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:42 AM Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
> On Wednesday 29 April 2020 22:34:56 CEST Arnd Bergmann wrote:
> > On Wed, Apr 29, 2020 at 6:04 PM Jerome Pouiller
> > <Jerome.Pouiller@silabs.com> wrote:
> > > On Wednesday 29 April 2020 16:21:09 CEST Arnd Bergmann wrote:
> > > >
> > > > -static const struct of_device_id wfx_sdio_of_match[];
> > > > +static const struct of_device_id wfx_sdio_of_match[] = {
> > > > +       { .compatible = "silabs,wfx-sdio" },
> > > > +       { .compatible = "silabs,wf200" },
> > > > +       { },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
> > >
> > > I suggest to keep the '#ifdef CONFIG_OF' around this definition. If
> > > CONFIG_OF is undefined, of_match_ptr() and of_match_node() will be NULL
> > > and it should compile.
> >
> > I would generally always go for fewer #ifdef instead of more when the result
> > is the same. Are you worried about wasting 600 bytes of object code size for
> > the array on systems that need this driver but not CONFIG_OF, or something
> > else?
>
> I am not very concerned about the size of the object. However, I think
> that all the modules should apply the same policy regarding the device
> tables. With a few greps, I found 3954 struct of_device_id. About 500 are
> inside #ifdef and about 1000 use of_match_ptr().
>
> Should we consider that the structs of_device_id have to be defined even
> if CONFIG_OF is not defined? And In this case, should we drop
> of_match_ptr()?
>
> Or in contrary, when kernel is compiled without CONFIG_OF, no modules
> should contains OF entries in its device table?

I think the drivers that use an #ifdef here just do so for historic reasons.
In the linux-2.6 days, this caused build failures, but just leaving them
defined has worked for a long time.

       Arnd
