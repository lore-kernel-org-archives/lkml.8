Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3E206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgG3HW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:22:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3HW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:22:57 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQMi7-1kNERt0L45-00MNCV; Thu, 30 Jul 2020 09:22:56 +0200
Received: by mail-qt1-f174.google.com with SMTP id s23so19615039qtq.12;
        Thu, 30 Jul 2020 00:22:53 -0700 (PDT)
X-Gm-Message-State: AOAM530fhtgVFVvlfB1uelJE+JEgih2QNvxapO06tLFngmOEKUT/zDUC
        QObTt4DApdgH4AyADhwZPkDqh6f3cvWac6seKuk=
X-Google-Smtp-Source: ABdhPJzgEsAgdG9F1fxmndEJfU8TT+hsYPEgSAf0hp36PCR11SO9kvadSankG7qIurN5AdirVi451kJyBWRCSzEu5aI=
X-Received: by 2002:aed:2946:: with SMTP id s64mr1685167qtd.204.1596093772891;
 Thu, 30 Jul 2020 00:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <1596067120-1193-1-git-send-email-Anson.Huang@nxp.com> <1596067120-1193-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1596067120-1193-2-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 09:22:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a000jKRMM9pm72mw5a1xV=NtOT6Z-H2EDS6=5165HMt5w@mail.gmail.com>
Message-ID: <CAK8P3a000jKRMM9pm72mw5a1xV=NtOT6Z-H2EDS6=5165HMt5w@mail.gmail.com>
Subject: Re: [PATCH V8 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lTCNq6hS062jBYwG/0GIfHXkumSjMFIvurIOIr1sjAjklefzOjg
 /S9ZbtnvL1By5DV1PGooPwKuLutxGv1sdLPlSRA5T8qToxRu+RsGKj2glzxTq/2g31Akmkt
 aVCZAU1r7Gh9aQNgxZIJ8LkWNqTS5NcOPBDMNdUHDVNey4sH4Kel/etwOclYf2oV19R+fRG
 c6vk4IYKF1va9Gt04IItQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dbWKEXZ+pNs=:v9SopY0XoxPhD/hztbdTmI
 U+3Ca5dH70Dxkw8EgjIa893dTsdwVW4D4u2N1E2WeAMy1WPwUN8hSywgSg9UHp3DE0Uvv06b5
 v2wrPFl5Sv8MEVbVFxl9Y0CvnrhrVO/iELiqae1vq6kpGEfJ7k+GmfYsoLxmABDAdNYyntL8w
 XO4UUX7AyyDHSgcP0qk95lyeO2JdfVo1FWVqz/LwHoWE8uF6ocRhDb3I8Hl/4T6bFYNkQRIlY
 vQ5nzLkMN+827t0DI8tccP3/3Lc/OHpG6YWr+gva/WQj3y9Cqu6FwxcUSeMTWAcxiJvE6IrEM
 INoA/0JexkpxUUBi36Qfy75UJYM1sDbH/qyVr93/0Kf8q7FNfrZ/GR0pl372JQam5CSFuOzsL
 OUtG8+9GG3ZSU3YsEV3ntnIG/n8Au7RI9CvQm2BJHFaR6GaGBFyCLpQeUBJUKiFEDW94NVx0I
 uFUNFEpyPEHCZfGxpzMqMgBZGuiXtvjKIg25fPJtfQqLGT86M/VIhxWMpJKo4UgPrhzpwA8xT
 Nv3hw0MfQgn9149B3OJi9c0E+q5Vrxhm7fQT5lJGtdiQ+brZVsJ4Yn5ZiBKaRuTlCIK5Hvewg
 irkrurjHCFcIeHN3ItM8I36twIxtc8Uzg/nvdjEBX2UJ3N2zm3rpn2pOYpk9GMqzrcpjPFl+n
 s84uIEB75SuGRecYZ7JJB1X4pyYh63vlhj9u6hGQdAkVZzs1g7NWkYqJPcrb2ZFkOEfn5zxFU
 QkwJ32TNYkxhb8gc6IjGLyGsNV34F1OJPqrSUMeINFT8lBFF08cF1vKOIVqXVrwaW1q13N0X5
 7ckmdDCUpl4y9PXNDOW5Sj8f43LSfSAbVpr2hlz/l9XvOFTmp1BRVCQ8ITl20SaZFhURKfW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 2:03 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
> instead of (1 << X) to fix below build warning reported by kernel
> test robot:
>
> drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>      while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
