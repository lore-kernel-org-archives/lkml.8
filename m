Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F661C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2880B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgEKMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:44:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgEKMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:44:07 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOzGc-1jkAUS32IG-00PQ2t; Mon, 11 May 2020 14:44:04 +0200
Received: by mail-qk1-f172.google.com with SMTP id s186so7662073qkd.4;
        Mon, 11 May 2020 05:44:04 -0700 (PDT)
X-Gm-Message-State: AGi0PuaIsogpDW4q0xfIfh2nLLDItGl3HD4VDuhTGW08gi+f/xDp5E9p
        Gx9Ln2nXu7Dp2huGzlFvqP7aEMDXupeYft+tGNc=
X-Google-Smtp-Source: APiQypJj5dbLl2D8uRc+Ry1heWpkBlw/Bp5L9Wsf0VuOnzzkwLnibuXV3LsJgJmP788MknPtCTQN8rBbz17c2WDRPWk=
X-Received: by 2002:a37:c96:: with SMTP id 144mr13680641qkm.138.1589201043482;
 Mon, 11 May 2020 05:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200508100100.20740-1-grygorii.strashko@ti.com>
 <20200508100100.20740-3-grygorii.strashko@ti.com> <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
 <6614f29d-1796-18d9-9b78-214f56964a35@ti.com>
In-Reply-To: <6614f29d-1796-18d9-9b78-214f56964a35@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 May 2020 14:43:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19RC1hPZkLiGCEHFuHDNxNLiAg34RdbBZ=gxDhRg4RpA@mail.gmail.com>
Message-ID: <CAK8P3a19RC1hPZkLiGCEHFuHDNxNLiAg34RdbBZ=gxDhRg4RpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wPzum95NXpE728ysndebC9ABEw3kiSk6N1VPe2lsUP1a2SHFC8u
 ZBahnPzRO0bbtflhNvy2BOlFbakk9ShIPDNbm+fXch9yDKlcczcSVhQIX9+daJMVV5568VO
 o49K2CL0eGD60jjNtPMTPacqZCheBw3NvRpiH3gx73I09VbhJbJJYgH/P2eRVEh/dNNo29D
 /4xZc5Qvy3UxzvDwdgWDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8T/FTbHk/CE=:gqjAp2ER7SwEAc2ritTiOQ
 viTpkGFgZiU+L0k1FSywlqR/TRE4s5mQQm8w/g7XNWobZjRO0XQBn+Zhjt0fnKbLKJTVyaD8w
 HWiJxqHTiXnK1loAPZr+jeC+VDVaAvbIU00Hxw3/c0bXFWXSgwTStnDitj/mrb6lnvxmcLGm1
 LrHsuZpnhZstQaN+MjeMuOM+7bAwPnowqM8O1CnnAcB9sVM2UH6wsQE1SCRauzsW7AWqIN8Zu
 Y7j4tD46h4Aj0L6buBsLPUaZaQjric1wNA4SD7z05wCgNaB8NJFcPQKD3LKbXMST+VTuW4Pq+
 0jAXL2VhHE0ddY2Gtf7Ps4ej4vjCFyeRyTXjT7kybA0Ed4WxINBjSnv4lRtMzjzzxu4azHhDi
 H1am1CFB2+sYeUAl6iZ4yWvxpY8kIImsAi79HL/12K7ZyOvB8kbkwW+44OQ6FA+dU84ipbtin
 /7Znz/QNFDD3EXAtoVbhpwCtYOlHx59Z8tNsAhJ8Kv7vemgT/32vHdn0mA1zPjbfkDvcwDsyY
 JXsTttotUiZS4fPSvH2fW6+PDeQdlP6GRjlE5wxsmAd1nVA72RW/Zuseau0tD7n63Cgv6ELyS
 DJ6GqaXyRvDoWepa90eUunQRa1zaxhQc8hiNA9ioXo8ATOYvmMaFqAXj6/eFTjPOJHOFKG0ML
 XsMkqIPVJoAyYaYkSVMds3HKbYimesFXzzF40cNfCbXiVl3CVredoQl2iNht6rrJC3mTUBP2E
 KibVpfGiL3gwP6Xo/RhTxAT8BtZFB1j0esRgfFZpOM8xn0qnWQAIrIiNMKvxJBa14jjcIjNSm
 igR+s8K+Ua+HTl70X2IrQRtxSuI8thn0DCURg+jBGMCquELTXI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 1:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> Hi Arnd,
>
> On 09/05/2020 01:17, Arnd Bergmann wrote:
> > On Fri, May 8, 2020 at 12:01 PM Grygorii Strashko
> > <grygorii.strashko@ti.com> wrote:
> >
> >> +static int __init k3_chipinfo_init(void)
> >> +{
> >> +       struct soc_device_attribute *soc_dev_attr;
> >> +       struct soc_device *soc_dev;
> >> +       struct device_node *node;
> >> +       struct regmap *regmap;
> >> +       u32 partno_id;
> >> +       u32 variant;
> >> +       u32 jtag_id;
> >> +       u32 mfg;
> >> +       int ret;
> >> +
> >> +       node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
> >> +       if (!node)
> >> +               return -ENODEV;
> >
> > This will fail the initcall and print a warning when the kernel runs on any
> > other SoC. Would it be possible to just make this a platform_driver?
> >
> > If not, I think you should silently return success when the device
> > node is absent.
>
> Thank you for your report.
> Can' make it platform drv., as the SoC info need to be accessible by divers early.

Which drivers in particular? In most cases you should be able to still do this
right by relying on initcall ordering as long as this one can only be built-in
(or possibly only a module for compile-testing).

      Arnd
