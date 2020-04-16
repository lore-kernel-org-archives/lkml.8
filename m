Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C71520656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633736AbgDPLei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:34:38 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505994AbgDPLG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:06:27 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKuGD-1jfrsG1L01-00LHUK; Thu, 16 Apr 2020 13:06:21 +0200
Received: by mail-qv1-f41.google.com with SMTP id fb4so1757613qvb.7;
        Thu, 16 Apr 2020 04:06:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuaSvvMp9m1tMfteBe4olxFcPVlNYZujxRfIpxWBlTH6vmgHoldJ
        kLHJKJr/iRBTpYsi1xsZ1UMJ84o9XdDDn232gxk=
X-Google-Smtp-Source: APiQypJzY6wdNpssRHLhvMyuGwgKaiwvITbQDAj2pM7kuaKPd0vFoDCisOpCP9I71XZKDqhKEbCeSABwbe+DZEKENjM=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr9731166qva.222.1587035179954;
 Thu, 16 Apr 2020 04:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 13:06:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FLRotVmMnBAyBKFMbXeEx760S-Cvqr19VPMi81PKJgw@mail.gmail.com>
Message-ID: <CAK8P3a3FLRotVmMnBAyBKFMbXeEx760S-Cvqr19VPMi81PKJgw@mail.gmail.com>
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
X-Provags-ID: V03:K1:17TGPvNG4k9uXehcE4DgfleCdpohxRcC9Bv50dxRREvMID4VOFk
 W10UrfBa4o9XD2UjLI0OoLvqXi9XvfDUf9ylEKkN4a4nOikfC2UdxWmBk+TlBmvl1BWlMVr
 izIkHPvlGHg2gUzf/Tn3USImvLr4ln5qniXLxzIh6q2xC17IzZpnG6e5AdZVYZ+sRgKMVTd
 jOHqByw1u3bE5NMomnOGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+ZgWz7O4f8=:+Y+jf8jYbd+WpdgieuC5RR
 fM5PfyAclvuvByjZ+VkyoG3ORzjArAbnN4YGduzJZ3sWTf+VShgzDzXbPB2eiWemuDIVDdyBx
 kp+UKJfnSyHgacSZ+b3nI0zkIPWBSAvCpBixqNr6TLgmQNEBFt7g2rZFIvBYkGVSL/fulNLcX
 wrJk92pS3ZYqZGyNuXgFCcbMjRfkpQd2zKf9/C3MHOz4cxU2HQ8EFs4fwaHe502omgnAQRV76
 HUgXx6RSibsxRFtSr+A8a+NtingdnR6Teo4RRxOjIHrPDhjDIPx8JAYtbudy6TnR55PhDDsdk
 MaQ7tOQbTi+aDWM4UL7ASf5HIsmPBR3pc4CbHokd2t6CG2C83xSg2P7d0iQRU6JuKnyMHG57y
 fJom1YdvA0mh+PFvNUsl1wcNfPFxt/Ow6y+IrL+L0njjRa7rOKf3nW/grBbUsEfYJh1jbe7lr
 znlY7o/oceBjJNf3gi73S0MrCsQ78zzbuoHf6eqaPKy5f63qK+zZ6eVeeeHp8Pu3cGB0h2XWq
 HpQMwkXfAeyp8HTgA/HX+8FmybN2zfTDWQtuf5XKJ+Gp4eejqiBo7bWUuspDL0XyLyM0W7NZP
 qaJ9H2leaaZisUEYlBfQTik0LUjy/BDITUt2TKqZ+zMuZC4ksn4Alo69hroiC3KCpOesR8BFA
 dsTxmktKJJAXLjTKldEO2H6QXOElhu/Jz7JEY1e3CZD1P0eXp1H1OZ4O61XnCBVm+eDVz9Ilh
 shiShYDCOUvTyNVduB61pZHxthNqicRi0zZf1+WvxrEu69E9XPN9cYTEXlu28TwSySH6MzDHW
 SeBvSO+Nq4dw36cSIEar/yBAIElqtpGFMMsd8Gkf0vgyUuvCMs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 10:04 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> The i.MX8MP has some new IPs called mixes. They are formed usually by some
> GPRs that can be split into different functionalities. The first example
> here is the audiomix which has dedicated registers that can be registered
> as a clock controller and some other registers that can be registered as
> a reset controller, plus some dedicated ones that will be registered as
> syscon and used by each dedicated audio IP.
>
> More mixes to be following the same structure are to come, like hdmimix,
> dispmix and mediamix. They will all be populated and registered by the MFD
> imx-mix generic driver.

Can you enumerate what functionality is in each one?

I'm not convinced that using an MFD driver is the best solution here,
compared to e.g. a clk driver with a few extra bits in it, if most of the
code for the child drivers ends up being for the clk subsystem.

Lee suggested maybe having a generic (platform independent) driver
for it, which may help here, as it would let others share the trivial
mfd portion.

Another option that we are using on several platforms today is to
have a single syscon node and have other drivers that reference
that one using a phandle to get at the regmap.

      Arnd
