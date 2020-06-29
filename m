Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E6521582
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390964AbgF2VWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgF2VWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:22:11 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MDv1A-1jiCrd0EKK-00A1GE for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:54:01 +0200
Received: by mail-qk1-f172.google.com with SMTP id e11so14934554qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:54:00 -0700 (PDT)
X-Gm-Message-State: AOAM530VGvvB5fkMRMjDUeJj9aDLE47Y+6lLHa+oUn8CFAkbksOym1Er
        76fNb0cx8XAOeXkQ+4a8n+NcRl4669mfr8rlViU=
X-Google-Smtp-Source: ABdhPJwtBbHqFdSpCDwcXLaF0RSEsXGs33hzlBafcTQfeX/aXKD8IfSc9Jxe9Akfl5VitHcd5Y1zZ6gLJV9ZpAZ843A=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr15063847qke.352.1593431639955;
 Mon, 29 Jun 2020 04:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com> <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
 <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:53:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
Message-ID: <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NIOSdfESoXFSE8b/DuYR3KL4+W+WZjWDOStjhIIYEq3ceB+isZb
 Eiq1GkmUNJPAj68nWgC7PYKycit+ZrxUAdM/2CKx1wrGKhXDtCi6zlwSOl69jUHNXsEmCe7
 R25isb36HglKPLXxIIzWGVRSKQXj2BzB1KA0dkVL9LmYThRrK0f0MkdH8tQhHMOvxffyHVI
 blL85jSVrgafEUnJ8rSFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GIwaNzaF97M=:6INQF6qF6yeJQlhCQ4O+W1
 +AHvlspnFmowebU86qfyDbkZ3+rGbzf1hIIOQUxo49v8CbDRRcVGEqZpM17VzHrP7ID4cHCXA
 Hhghh+z8FrdvEXG9YGWWFbOdww6AFpaFfDNPq2GwT47CSz6K6/bnN7d2DgwhW3IBpdYAoERiB
 foAW/29+wgSomKuLULrWbqMtT2djCiZ44/iZmypUCa/9V7m0R8FEkbEGOIO81RyV10BemSiS7
 TnhUoOgzXQb/JXVtnIwW7y7UsOt99CjwOvuD4sxxcgiQT29TfBDb/V3ysGyZ2sLOl/XwtnR8d
 vMB7UDoHf1Cs5bBzXePg5LP7KOElbG2R++/PNPoV+BXNGfgvLt5VZVZCL104qcN481OfREmDb
 i97qTfbSDR6Qey35DA+8DfGf5mf/sjImXRnmgAWUVerilm6W5jeSq5lynyResp5wMp60zI/2g
 7BW6OUpXwdP4lT9CLeYdYSD+yKPA5txOE2TevkFd0f7ohBv8/k6B4oIUgqHsv6kjhSCoFGTlX
 9FpE2liUP0jkUBOi/kNf5n7VWi/rdgCVkcAT7vzaPlWm9ImUPLj10PrbqIhGi5Wxc+OHzjnbx
 z4kaRn+qbeCgNNOkCW+m5IogeP90bvOraYqWoP1eccXrmkxcwpO/g2y9iF120MrwAEnGLu0fv
 xmTmYqwnpFnyXnIInkPj1kRP2QDn6aBoeV2GEHMVlmlmVgNwgEGsOj4/nhqDIWSeyUnta2OqQ
 vWbJIXF5ucYKAMckXSgGTrTKj+3KUqLT5NzBw8QeaULfxh8ooMSewdgyiVZTkgUOygEjZBgDk
 Io2XUNYzZZckSiQKw6LIi7JAVQNebpxSl4/g1+tWe6FrwZ061k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:34 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by
> > default
> >
> > On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > i.MX7 reset driver now supports module build, it is no longer built in
> > > by default, need to select it explicitly.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> > Why not make it =m now that this is possible?
>
> It is because some drivers depends on this reset driver to work, such as PCIe,
> If by default make it =m, it may impact PCIe's function, adding module support
> at this point is try to provide function of loadable module for Android, but don't
> want to impact any function which is working previously.

It sounds like your patch 1/3 is not ready to be merged then.

Please make sure that loading it later does not break other drivers
that depend on it. Other drivers don't have to be able to deal with
missing dependencies if this one is never loaded or disabled at
compile-time. However before you make it possible to turn this into
a loadable module, anything that depends on it must be able to
deal with the modules getting loaded in a random order first.

       Arnd
