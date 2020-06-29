Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63572C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D120775
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbgF2VFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgF2VFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:05:02 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mofst-1j0tDQ1GIb-00p4cK; Mon, 29 Jun 2020 13:37:25 +0200
Received: by mail-qk1-f176.google.com with SMTP id l6so14871500qkc.6;
        Mon, 29 Jun 2020 04:37:25 -0700 (PDT)
X-Gm-Message-State: AOAM5316NKX+qTNj84k+pnnAbrw+5/y3z0doj76V5dvfxnvpdvWBZZxA
        oPBAKeZOuefuW87vz3MvtjheK4d4eFGXVOZNWe4=
X-Google-Smtp-Source: ABdhPJwGCaTaF/6lDsrwnIDXUL4eFvWm6Sxzf0vyht5U7St+DoN5wF2vfKmThITTZuTVI5ngfEi0EaDM8L8TwiPm6us=
X-Received: by 2002:a37:a496:: with SMTP id n144mr14536437qke.286.1593430644096;
 Mon, 29 Jun 2020 04:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com> <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:37:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
Message-ID: <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, oleksandr.suvorov@toradex.com,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fFz7B6CKzVGMcNOoqhEQ+Q6zaYdSbNLhT5RYA3WT73gjqRLfv3G
 x7gM7jqWl0DIDuUE2yeUfaY4Q6j4CH/U5slfRIMwAtxUWXQG9znYWhecwuWQAAt3obh02PH
 nAVFs/46bBHnM6Wnkra55WG0vQlGd5xeRMOOtcD4b57A6Q0f2WZfsewPe2YNGRXOYbeUMbq
 4+1nzXnBh9Mn//puJkazg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/dLsAqa9/LA=:J29ItYNPuOs7yVt7PmEaOm
 2v2y8akWwVq7bOTB2Vcf4yZ/oIoVEuk8+LJ8hrU0GB7yWvrX98hlqxZgHgLk6vc0FGYY6Qtqd
 DvvNXvEVI4dFqtgax2DQ4HfCGWxl7/BIzD6ZNHXCL+iwMV4w46fGzneUKB+kG6vKVtrx3BDcY
 s7hWyqTQIOEt9xiZKl7wT98Kw+LymsQwC8bhhy0nHMeou0VSjC/1LxzmyGDXp8khga3gSZDAd
 8xsbNvJDtvTy66DvQuNQjqt4FFchgUe3LqPGtPGW4ijDh9DR/WqN95ArmdQV7p1ngJ/tEeRPT
 0kGF5oevsi1jlBHmhfqaXtkCx33l6xYDfFLnUSGroQ6f+V1pthqD28lEwYdV7IxEtgpcCRATU
 9maTfhYMr0hf/mxSpXXjT9IZ3vGZlDEa5x8tRwoFh74SQxETdd+1OGUNC1O9sHSbG9N0uJYhE
 hTz+DPwTWMNDA58pVwlGeyrhT1NVMSHf/o81B1u+iJIAwE22C6bNsHZy5JzaIpipkTd4MTyJM
 0UFmaTl0Vhie6wRyYgSkPlpFt1feGcyUkcK0viTTGG4AbxglJd4p3vhKI43BCcsH+0DE03k8s
 EYvt5+aCpabCeS5Mjec+CxzFGsP9LT9P35VHD4aghfdY451Ua2rhA5djiNgLZFDZjj1LiLus2
 ECJ1H0qq51Uq1qZ0AqO1yHUnU5UnmVKLuvJhZ1T9U4yRLydFpTZpibPcIXqeWRAf4MDaXwwYJ
 J0Jv/l/XojF1cCaIo4YezUaifpf49tasTY9UapyhoddqJ3MMt6RYQuNbE8kLXRLmjVPJMo9NR
 k6sKxMiz66ma7v98h2709HyGWpfxuA+9aQ7Bhw4KzQajkV45lg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -21,9 +21,9 @@ obj-$(CONFIG_MXC_CLK) += \
>         clk-sscg-pll.o \
>         clk-pll14xx.o
>
> -obj-$(CONFIG_MXC_CLK_SCU) += \
> -       clk-scu.o \
> -       clk-lpcg-scu.o
> +mxc-clk-scu-objs += clk-lpcg-scu.o
> +mxc-clk-scu-objs += clk-scu.o
> +obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o

It looks like the two modules are tightly connected, one is useless without the
other. How about linking them into a combined module and dropping the
export statement?

      Arnd
