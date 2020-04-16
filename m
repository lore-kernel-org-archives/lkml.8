Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D5D21D79
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895173AbgDPNUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:20:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42627 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895129AbgDPNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:20:37 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MVNEv-1jrMQQ0thX-00SPpT; Thu, 16 Apr 2020 15:20:33 +0200
Received: by mail-qv1-f54.google.com with SMTP id di6so1934605qvb.10;
        Thu, 16 Apr 2020 06:20:32 -0700 (PDT)
X-Gm-Message-State: AGi0PubvQ67eAdgyNnfw/JMZpR+uJR+auBT3a30y6WPdI/eE2o/2bGHg
        y+kiYvLUsclUlg52JEhDNkjsgIdT3zn+/OB3uCI=
X-Google-Smtp-Source: APiQypKHZDxipZPAWZYdCIqDu16HNzhscAsVQ9lmrMyp9kN+/tCK/He2321isOUyHo5GRU/I+lGChb4COn0weT3yGEQ=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr10311429qva.222.1587043231971;
 Thu, 16 Apr 2020 06:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com> <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com> <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com> <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com> <20200416135711.039ba85c@collabora.com>
 <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com> <20200416144036.3ce8432f@collabora.com>
In-Reply-To: <20200416144036.3ce8432f@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 15:20:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
Message-ID: <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        cheol.yong.kim@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        masonccyang@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>, qi-ming.wu@intel.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, Hauke Mehrtens <hauke@hauke-m.de>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xRzS5BQhwIf37a09RNGN+lmx3JZwELEWk5+0D+a9gizvafoflXD
 r94Dkw+FQ01316F4Gy5FEd5sjhc8HuLpa/9EKXhMPplg4YD1X+8BoyAYfw1TsdJ1KGxi4TT
 BOgPT/L/ERP5PiMFAmWBPP46eIHfII2hBIkqAqneUvEPQPEDOogquYGOu4zVN5Y6P8DU9r5
 nO16kvulsdSpVvJdWlP6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjRWNxMmemg=:MGl6E4WsyUNVQsGJ0QkDgK
 boUNkLWv1nznhzGI4f+vRSiliyZpJUXuq7vy4VaNFEgnBmLKO0BKR9a6S+7e7NVFTyPPNS6sH
 j4CbAqsjHKE/BjbogF34UjZpfq/OQDlgFm6vCjbiWmiKeU8aRVzNDfYqUVTB6x38Kq0Taeqil
 h3pxMz5Y4dNZBbRDnirGYgeXzUjr7uvYtys9yBuEIMwbnqOfJU2RK1EBupnkAy7w8NV60lK7h
 oPzryeDWrNvGQVj6J2Ngi8lC1uInCem0M4ltfiVw9twBaEmYfvsFRDL+sNjZmb70ZFOVsu7ka
 C5hHBYS+1nhHjcDn7AX4GdNbPKW2Gw+gbTV59U8cJ/mC98q+5CCT7vcq36RUYpl2Vc/JE9xXu
 Ymgo5usfl3pRMKsGkMoVvThWhOSM6IpWtRmFcEVSlCTM+ZmZ/baojmCB6IZb41xVAr8k9zCZH
 04rl51uzxwiWx2+1PsSDjfSJwcFe2igouqzuCZohSDwQ+xKvkh/pouKYH4UgNNSaVio9gyfN8
 A7sxZL77bJffcSJRrIlpBIGNu2XaHlQh6LJDC9DgUUv2fVipQ2n+jRrLMnnHwQ7A50BcCylPE
 kpHYfVe+SZrc/KB/ggPBuWAxWTPwaC/pwbkzunWSp8pz+/0XaMJnolZqdLHzvw/bW6cgDnecd
 pdxOq6ZSE0xKkBtQp+SK6AYKHu1ZQC8L0DII1OYW8b0ncbn7D8N28jofagO8FnCAJ/z6WKFES
 IDjpKu5DqJ6qQ4BiCGgK71VkVAD4GXCs00KkCgJe4sv04j8WJy1aH1slRS+A6zMq+lQRWZjV1
 oXSTlMFufnPqieTZI/ct2iuFv65BQUAmmZOJXp/tFTy/R6rKws=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:40 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Thu, 16 Apr 2020 15:26:51 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 16, 2020 at 3:03 PM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > > On Thu, 16 Apr 2020 19:38:03 +0800
> > > Note that the NAND subsystem is full of unmaintained legacy drivers, so
> > > every time we see someone who could help us get rid or update one of
> > > them we have to take this opportunity.
> >
> > Don't we rather insist to have a MAINTAINERS record for new code to
> > avoid (or delay at least) the fate of the legacy drivers?
> >
>
> Well, that's what we do for new drivers, but the xway driver has been
> added in 2012 and the policy was not enforced at that time. BTW, that
> goes for most of the legacy drivers in have in the NAND subsystems
> (some of them even predate the git era).
>
> To be clear, I just checked and there's no official maintainer for this
> driver. Best option would be to Cc the original author and contributors
> who proposed functional changes to the code, as well as the MIPS
> maintainers (Xway is a MIPS platform).

A lot of the pre-acquisition code for lantiq was contributed by Hauke
Mehrtens and John Crispin. There was an intermediate generation of
MIPS SoCs with patches posted for review  by Intel in 2018 (presumably
by the same organizatiob), but those were never resubmitted after v2
and never merged:

https://lore.kernel.org/linux-mips/20180803030237.3366-1-songjun.wu@linux.intel.com/

        Arnd
