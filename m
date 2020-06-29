Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2137821D79
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbgF2V0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:26:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391062AbgF2V0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:26:10 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mn1iT-1j99130zRf-00k9ZW; Mon, 29 Jun 2020 13:58:34 +0200
Received: by mail-qk1-f175.google.com with SMTP id k18so14910846qke.4;
        Mon, 29 Jun 2020 04:58:33 -0700 (PDT)
X-Gm-Message-State: AOAM532L/5LO5TUz/wOFh/8bn+/7Oaq8qHC/H7WmOHrgpLBUdtx5rwV2
        vpmir8ijxbtzgSXzO2S7eSTcJEj985na/+iZUuc=
X-Google-Smtp-Source: ABdhPJxw4aQcyyOjqz6zdloYX0Zg8NLEiVrSGqKIRrgeB6TYwmUcJuTIitYyWyx3icLmYS7sF9chjW5BSGykMBVcb8E=
X-Received: by 2002:a37:a282:: with SMTP id l124mr13904809qke.3.1593431913015;
 Mon, 29 Jun 2020 04:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:58:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
Message-ID: <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for module build
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3UBpymz75L77s+ZBkM6AxNezIczom5vTWMfpVWjT2zNNZ2uI+Jk
 gUwDS7fCBHdh7KRWiQV3MvL+yCDTKPuyeZEPTyce2r+BWozsosOwrahHhucAUaZAE4Tdxtn
 Pvqq3EiEfKrWCUdaLiDDdHC1xtVJabUfX50XNDWg9SxBJVhfW8nT71NqP+u+UhGXckJQHbH
 72fapY9XfA5r0MDbF89LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5MMYrR6kRDY=:5GXOgJLK93AGgu6E0y8kq9
 vq0Fe+QJg7M+5vTz8nfKpeJvQ2aMUMKc/IGtM+qNzpR88DcKmcFWiqbRbAXUAmFF+UYGY5SLv
 saAbHJD7HwTwNNeSV1ozIccPaP2YORPy+hCl9Xvfkdpm1E95+uDQ4cn1LqA9AsRiHwQnJx6d9
 yWEyviDEUCB2+1wlxzfXq2uW83PJGswPMlmEyc9nWLNsnp3YXBwb+6581pv8+dTFnUHcMV83E
 JQqU+6OKEtJ5ZqAhi/kLECRXfKLgpCwSvYR2m+N80I2r7K+X537xXwh3Tze9I5lDIq/cnd4+A
 9D+trY8GQCMeEz0b7IwRAvwjMMPXEPXyAQs9Df25WKt5eIZduAqYtzd9jue8NgnpO7FeVD7tb
 r0iNLmD+iuLFTbYHOTmyFPgHDFUa7o7HKa2inZ5yQqBLixfT4hUXWMDi52zBBC7kJyHPz8wiV
 H6t6lhXaET7WBC5CZOybuSGVAZx7RBmcqLzXR5EE36misXQaBW/R3s5AECcfiebj9zgCpQ6JP
 jUarJrGCF99zAZT/IbaFgWZob8zs77H6ULxd5G6sWiWJzK7nvU+edpfRMwWf0othSjmR5Ox7y
 fyioPFAnhY4sy8Qw3aNtV3tzYxwYF4pNT366oY6mKGnKTwciwBjyhh9nAyrASj3uZ4BgJYMfC
 v8bwV6uLMhx2phd/nifmLjqWcA4o37Ckj0rPrLwMo3IViBhx+ZGBYjo71P6+7l+F+4FhABP/k
 yUMSL4TEwesQOhi9MIXhwBrdxPpocjrGXTq8OogudK94VGTx/1pEsqbe9fIEgrxb1I9obmQ9C
 DrpbclHNtx3V4Xj4aSxn/0XHE4ZKEyXSR22Tjb3i6klmZMBFus=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:40 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for
> > module build
> >
> > On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > Keep __setup_param() to use same parameters for both built in and
> > > built as module, it can make the drivers which call it easier when the
> > > drivers can be built in or built as module.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> > I wonder if we should instead drop the __setup() and __setup_param()
> > definitions from the #else block here. This was clearly not used anywhere, and
> > it sounds like any possible user is broken and should be changed to not use
> > __setup() anyway.
> >
>
>
> It makes sense to drop the __setup() and __serup_param() in the #else block,
> just use one definition for all cases, if no one objects, I will remove them in next patch series.

Ok, sounds good. Note that there may be users of the plain __setup() that
just get turned into nops right now. Usually those are already enclosed in
"#ifndef MODULE", but if they are not, then removing the definition would cause
a build error.

Have a look if you can find such instances, and either change the patch to
add the missing "#ifndef MODULE" checks, or just drop the __setup_param()
and leave the __setup() if it gets too complicated.

       Arnd
