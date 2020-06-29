Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74643C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E8020720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgF2U7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:59:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390056AbgF2U7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:59:00 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1McHQA-1jFRrA1qBQ-00ce1G for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 13:31:20 +0200
Received: by mail-qv1-f52.google.com with SMTP id a14so7440963qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:31:20 -0700 (PDT)
X-Gm-Message-State: AOAM5308l507zbMa2ZQ0GcjZj2tqmv/tfKKppLar81SlWzK+jf6eWPxH
        e3ZWebSRy5vFMWQKs6OGYCI0b1k2/63Z081MOTM=
X-Google-Smtp-Source: ABdhPJzLDVrEKQ0RXFpDoEkLY9qnujNgHbMgU9hIQBerWflFs7aWuPkyYqKtG/A+3+fGgK3hLwO/TW0eSdce/TZJPHA=
X-Received: by 2002:a0c:a992:: with SMTP id a18mr5896548qvb.211.1593430279342;
 Mon, 29 Jun 2020 04:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com> <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:31:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
Message-ID: <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        oleksandr.suvorov@toradex.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ENfp5QlzDknHjn75URmVPMXECyz+2Wky+VuhDNFUQms/Z8CB6kC
 JIEQHyvbU9lnpMLNlFZlDgvI6cI2tT+4rzS+uiWl94Rcr7QAy2WcegX3UT1J8ct4peopbbM
 UxY232fQtaYZpHOHP06ms5ivmQw3WKMnSdxHJ7iMq04ma2u5MelDqCDF+vq/1Kjoc+RoSCH
 c+2pblAmD5KxC6rFciEgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M89Yk+J5LGM=:+fHLPCr8qtI3Lbk1sQUzwx
 03PXdA+1UcBWfzS4kjpHu7erprdxUCamYOTT1EpSiohDOWOEhU0iSFtMjvXk8rcm4ovDfD9Yi
 FagG+drzR6BX7n6BNzlCSRAgD4/3VyULbxOM5CsQv2ba7e2NDfF0aNaE0WdWT+WHnAgViIbNH
 LDnMmoJq4r56RNqKT+YiEy5VZCvkpsnUlXKEafT7Fk9uBDulOYQvk5VqjXPBMtVmCAQU53SGc
 m23HcBF1ynq78kr5ErZAfmbsl5PyMKQcTxsaJasz/yL8RcnhYZeLdUrpbzpx2c7ibGHGXUuQX
 TPDsa11rugon6Yzee9YccsDdFqlSlIFQiXG2n43GSnE6/MMVtbBvoJsentYL9b0GfFaKP6WiT
 eGKjItzD3/OSMmaTxqujIuzeoVfp0YQjklVQpPzhpIDZYRUmV0mJj2zx65blbptE2Kr6kIyrC
 SyH3Lzza7Owb+OGK/mJZ8nXXQEVZJblQBUNUOD6aeb4e0cWMeEogBUANZahjhcHgJvgohoZCv
 Gm5zRRVyB58JHnapQHmTyJNbxprQVY7YgOsMK7+FF4DuFpQTWS23kTUbImlVQMwhhOBhQC2bD
 27SubEbzda5BHz7vpT5RZYVOqCPTeQOpMGa+d3qObo519E1kGgtKsfYI7YrN1LEITzDyPP1qu
 pw8WKkyPfNkDbomS/gRxm20FynFHFPs26zEvqoiL0bXwQeyJSCMG94SwGxFs47qxu1TbWvCIH
 G8B3afNGzw7axdTOMbR7rqRQ1x93lV83k8A+rZIWJHakq3Yb8/ThRNw9VFsW+5nzMpk4+UakL
 lUrCHp0rt/K0VfXjJkU3cNyMRZsfHQT9eEEGvcbpTGcnJA5iVE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:25 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX7 reset driver now supports module build, it is no longer
> built in by default, need to select it explicitly for i.MX7D.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index e7d7b90..3540483 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -561,6 +561,7 @@ config SOC_IMX7D_CM4
>  config SOC_IMX7D
>         bool "i.MX7 Dual support"
>         select PINCTRL_IMX7D
> +       select RESET_IMX7

Please drop this patch, it breaks the intent of the first one by forcing
the driver to be built-in again rather than a loadable module.

        Arnd
