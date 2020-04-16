Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E16208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633376AbgDPLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:31:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633137AbgDPLaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:30:04 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N4A1h-1jGgZn1t8T-0103T1; Thu, 16 Apr 2020 13:07:14 +0200
Received: by mail-qk1-f174.google.com with SMTP id y3so20748368qky.8;
        Thu, 16 Apr 2020 04:07:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ0HtBnhGYMaYQOLJpCyPgjWJpQF/FPXuoNeABZ+xQ43q/4+0e/
        iwuzvD7bQRjpZ9z2IuUym61FN3Sx5xYhi/YAW/c=
X-Google-Smtp-Source: APiQypK4+pWIjTlcQKHWs83hDUiq9HrROe6p4sKwqSeztDfxIRma7taMpjWbk4MOI+E9EtZHMoCq/s3VDhbpWUliCGE=
X-Received: by 2002:a37:851:: with SMTP id 78mr31161821qki.352.1587035233142;
 Thu, 16 Apr 2020 04:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com> <CAK8P3a3FLRotVmMnBAyBKFMbXeEx760S-Cvqr19VPMi81PKJgw@mail.gmail.com>
In-Reply-To: <CAK8P3a3FLRotVmMnBAyBKFMbXeEx760S-Cvqr19VPMi81PKJgw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 13:06:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26JS4FVt5wiaRQahF+OJZp9Ot84o8GSth9Rk2skkEMSQ@mail.gmail.com>
Message-ID: <CAK8P3a26JS4FVt5wiaRQahF+OJZp9Ot84o8GSth9Rk2skkEMSQ@mail.gmail.com>
Subject: Re: [RFC 00/11] Add generic MFD i.MX mix and audiomix support
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XDrsoNce09dQF4v/GnqEBmnqKLXmtj6TBeZwkb0Q1p/Uh3G4zU2
 0k3IovXzNymJfDpYP+paFT5/eWoSFAeiBFdDU4Rni9XRQeX3O1+NLIdTwj2Pjh0XkF+TDll
 1IlwD9gwjHnD+odPwajh6GbLWG891MKN9Rx98amEyN7OMvBE52hiFWSTxA3GU6fNMtSEwOp
 pw5aRLFhsd4iHpP797jPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3ySx5qoRa0=:2HgHQY70QGwlkgI3fd/eDa
 AviZf6zFsbZjh8abcajtOMUIU8ec4suLeE1tLGe1qNYlXJjFgH5yLiRkbv7Jv119q4cGRI47k
 ulcWRrKrIn8q8Szo9gLmvZT4PDEti7XWh2lIKhsPVK5wmG8omJGghWLYr3FrrWBS7jWdVQepY
 RDOnpoo9NE0PI5Ve4r4zw6ULw/tOxe86wsQ3OABlinqTQsPMV0ExIVXaOtCgw2kasQClBKje4
 pPFNcqJYOt6zpuK2oxsd5DfMBpEM22SH5Aaiq5Zb7VyhwuHattW5vlvGQKCElDh3tcEnWV6bw
 bUnM/ZPAQNEGPR8g7m5ruTSsiozjsGUI9rSCCaCAYQHHaqjosbKgpmODs4hTwrriiOHqN60qC
 GzAEGwTGc7iZXl5EiGJEZ6JfWzW8TGY8YODikiaWEHoTd0V/hTcnn4Y4mLLWTDl0qWfpCiwXH
 PrL9XK2ktcwFXv7Kx0KD2C6hIkUnIfu5+Dz7LnCxt4YnAMiHhl/CMnJYOrzb9FCyKxslxC/wl
 ZQp5iS6c8hU+mRYOQofWdd0K8TAhHKYmCsWES7Y20KdqJxcKsNookgsSleDlMf1jBwS2EIm9L
 pJC9KqSsd+1ctOcIlpyd2KIt8ETnzuJGNRqHMF2e8wDydFqPyUHdLerbSmyn4yY1Z8EdxBxgr
 TLqzdSLmTGN8l6/aohZ8OPuWJd8wnq4CtJ3xqK6t3w4WE+lgdiZXU6mKJFmjY4x3LFvxVa7B3
 2ZZnNAzumTPVrYA2zjIF4B4eCJU6EOd24Kre/LagaFV/taRh1jkk8CT6ar3kW8A8b0W3mTrhP
 fJ0ga0Iw/mJ2kAVxV8cvOB/IdmS+TRWr3t9wjlxxb8QGyTa/YY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 1:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 3, 2020 at 10:04 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > The i.MX8MP has some new IPs called mixes. They are formed usually by some
> > GPRs that can be split into different functionalities. The first example
> > here is the audiomix which has dedicated registers that can be registered
> > as a clock controller and some other registers that can be registered as
> > a reset controller, plus some dedicated ones that will be registered as
> > syscon and used by each dedicated audio IP.
> >
> > More mixes to be following the same structure are to come, like hdmimix,
> > dispmix and mediamix. They will all be populated and registered by the MFD
> > imx-mix generic driver.
>
> Can you enumerate what functionality is in each one?
>
> I'm not convinced that using an MFD driver is the best solution here,
> compared to e.g. a clk driver with a few extra bits in it, if most of the
> code for the child drivers ends up being for the clk subsystem.
>
> Lee suggested maybe having a generic (platform independent) driver
> for it, which may help here, as it would let others share the trivial
> mfd portion.
>
> Another option that we are using on several platforms today is to
> have a single syscon node and have other drivers that reference
> that one using a phandle to get at the regmap.

Sorry I replied to the wrong thread, I meant to reply to the v3 version.

       Arnd
