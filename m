Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF11020720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgF2TKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:10:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbgF2TKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:42 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MN4ux-1jZ2rM0CP7-00J2oD for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 14:55:37 +0200
Received: by mail-qv1-f42.google.com with SMTP id g11so7553578qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:55:36 -0700 (PDT)
X-Gm-Message-State: AOAM531AddKxbPCElwxBeXP8CG6S0lt+aGjjVypushYSzpM4yk1xkddl
        OOzCNwJic9tFwX32lc0Hnra1+7ZMUN0RjrBf0Wg=
X-Google-Smtp-Source: ABdhPJwTUgWBKuCYHhm9IfBDK7FIWMaC5caJVsnREcVoFi6MO3w8Y1aC9gRnZGddm1b731YJ/OBzbCxzjKv7KsI7YTw=
X-Received: by 2002:a0c:f385:: with SMTP id i5mr15431499qvk.4.1593435335949;
 Mon, 29 Jun 2020 05:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com> <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
 <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
 <DB3PR0402MB3916192607A09C7061740087F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1NoyMGNK90WzbgJ7opPbiVL8vwnMEuBeeNPNyvB+5sqQ@mail.gmail.com> <DB3PR0402MB39162138624705E5A296A047F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39162138624705E5A296A047F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 14:55:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3n6c5i_RqxxO9N4SdBswmyXbpu3LBi4udfSUHy3mJPsQ@mail.gmail.com>
Message-ID: <CAK8P3a3n6c5i_RqxxO9N4SdBswmyXbpu3LBi4udfSUHy3mJPsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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
X-Provags-ID: V03:K1:rSY+zoLBo+mwL1X7TzIIpQI8/fd7K6+NGn4xf8+tddJ6ggX+Yoz
 2cdpWv9puKYj8LGWQ/jwHLkatFvui2vMLY3LdEU3Jv5w/vMqjYZHSXSOBzwsD2etOsn9rWP
 fKL7qDR9IsUnheQlUg8DhMr1XUne0in4K3YHdqqu8Ugx2vAwT0ut2fvaG0ZyPTXQLPtG0sN
 1Sm3/r7rV90o502vju47A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y44tv8Ismyo=:ccWvjKYeZjh1aZQpi6seDN
 e92JgIO60xnSqOmpzDJyeRglqq8E/xqtFRpeT9yr+K4jGOXkh0SOq6XMCSfcidc/MbMP1xuxZ
 MRxK1S3QwPgLmUdrNGpislA4KO4ownQu+eSFek2bgRpLNNW7CmxsWRud6TbPqvq7TuNxohNbA
 8036bjuqTLFkzoWbSvKWUD5oJVDvjZKJOs+Ok9poKhXEWyarPgiuGKAmzw+M5SsqUR9BpI6An
 IrLAM74lnGhR+1KrLWGXzPfb7dOerkb6HfsyxznUnubystYkulBBQlUn40kVZczidH4qCWH9+
 8JotgytQfFzcE+nanvDmF4jOW/rtE9jyxdmqx7ZenXjwZpdf9Q4wealEWeM8C+ZLRZgyBZH3F
 O1jDJux8w0OWVKLJzYlxE5mdMtfKyi6WNgbxzqeSQ81D16Zvak1UfRpW8S2Nbyj1+q1CqDQeo
 BGx2l0+aOmeAFmB+SYBcG++cpVVkNmkR9zyx59kICGDpJiHvvvBtvcdyCp7jsGMt8jFeGKaOo
 yGMlkRO6hYsqT2WyM0Hj5LIDv+xC26TRrFXRVazbqCvqVRkhNITxDdkXXoFxmKuBH0JYi/GEu
 atvpGY2OhW4FOGdQ/Qjxj43oA7J8ujiMHbYuKNMZ9vBHpVsHx/QACuWdUVnx/PuJUCbuZcIGF
 yjXiYoNunGSeOCowG/IDdcEA2JAe2HzEXfKGOfO+6PjS7xDnhM61qMYGsCl0JHfOPeF6g2IqB
 OuGcLn5OhtXi+GJlPPZxVRBJlSlTD4kddG38vuwJuifpYoYPNUyaZZCNR3UrVw84SaUILVHXe
 VYvaTtYTivuRjhwYhSLU/Ks9EptLpZQGhC+67PfovAcrci/YQHgZdP6m7abZObLpOrpx1hWc+
 GMGS7iv5PkDsVcMbsUHN6m0MLpBIr3avocpgJUVmk9uFl6an56ohDLd74NOIUR6hTyHeDK23G
 ifSg3KeKGxf/H5QzJYbsoKivQSPZBtpMwALtyErdNFYSqdjM0LTff
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:46 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by
> > default

> Thanks for detailed info about PCI loadable module support, I copy our PCI owner
> here to help on the support of i.MX6 PCIe driver to support loadable module. Meanwhile,
> in this patch series, I will add the short-term workaround as I described upper, and then remove
> this short-term workaround either in the i.MX6 PCI driver's loadable module support patch later
> or adding a new patch if necessary.

Ok, sounds good. Thanks,

     Arnd
