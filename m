Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F4EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E4E206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 07:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGYHzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 03:55:50 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGYHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 03:55:50 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MD9jV-1k7jML1PeL-009ACv for <linux-kernel@vger.kernel.org>; Sat, 25 Jul
 2020 09:55:48 +0200
Received: by mail-qk1-f172.google.com with SMTP id b14so9140241qkn.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 00:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM533FZsMaxvtaFJW5G3GSKpTVgOMqYv+TiE1LAHsULGfRfv+Uo+EM
        GQ6hk72BONuZDHsFA/54wEZVV7hpsnjROL5fNoE=
X-Google-Smtp-Source: ABdhPJzToR548WnL6ZB7feF90HK4q1mB8a4NG7XrTVGvaCzXkWQdQXbRdFuR9BBz/Cb1ddMZGPMfx23JQdF5c4F7q3Q=
X-Received: by 2002:a37:b484:: with SMTP id d126mr14259716qkf.394.1595663747218;
 Sat, 25 Jul 2020 00:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200725063639.1221075-1-daniel@0x0f.com>
In-Reply-To: <20200725063639.1221075-1-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Jul 2020 09:55:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ec1OgJc3oFueJEPPTAR4KKyFateeb54xya3NZajrxFQ@mail.gmail.com>
Message-ID: <CAK8P3a2ec1OgJc3oFueJEPPTAR4KKyFateeb54xya3NZajrxFQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: Fix dts filename for 70mai midrive d08
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v8nnUGuYIouL+5kDwDabCyWT+Xk2nT8A1rONXgFwOK1lo9ddJzG
 PmJ2yRr1nMBe+41bqEZLRHjm1Tm3ACd5Hlh41PtCJbbBybNdiCe77CL+oMIejWesCi0WzON
 7dIzLNuAnGklRP8QgUuDvrJhfYFMa/xS7hr1VpRBHeyreDwDf4ZndhCChOE134zmVSZK9RF
 hquFslXrJ1/NwIIqGW75Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9NsrCv4n3Cw=:ahq83x5CzacUtxi/p8PMPs
 Sl3erTPXaxiJdTYsDnSytU4OODCablgWyWNZjLYzfgNg2rSIBbL9Cefo3rVyescc/bAfEyvul
 GfBRWVLpF8K/Zyt9njvgm0GVepb2hxEcCf/UpmkWNvrW2zA5GzVaSQ8XEqpjAWyT+klgfmT06
 S+JGHJtnSQkd+JDO7OthWhWnU+qGahVy3bLuOvBsWRcth+XQVm5X961O3T5ePx7I8bdCw3ia1
 hF3wSm5IMjfaMngneZUFeIESS5/eDvpJgNXosTrucTXNkglPM0li648E8JzclIjpiDGDmE3Ll
 PNZ2/QONNlDmaOimnPnvP6mhnG/zlo0xgjTWemXCInd6ZY608Y+aH0fjgWj/8m8M+aOJH+YeS
 NxSXM+QK7AjLTTZvrpnphuG1ZpkHVwp261brFQixw8aLcgrYFRUVf+QNJ8p/lAA+5v5LULS62
 JFd6/zZzAH5q3byMXgOu7f4pAA/9Owg59VXBARnb3n8Q024QHbXTBYhdD9iIohwYCDlvpWNqV
 O4oma8txy0mMnvbDl3zW7tzdotN1NmGCMM0h+sztxab60V1jbRkr+9HKqbH2gbZRhzs/Bzkkr
 yPvKT5wCETA4R85nv2zt9me5Mfmw1oOjNiE14FH23iwrGLoxVPAzUcZSYQZovqc2x9Ybjxa5j
 sRDnh8swFq6ZiVmZY5dpSEK0OiaYHEw5obqJ9s9bjeSCe5LYnkyv7u0F2hDaqaVLRh/WT4Mhx
 XIqUMxTcHnEgxeU704XxHnxSYLgZJi7D+VwxQT3a705+PTZZjtqsArOcuS78vqugxNCL/zLkp
 WpDwv+/uTtaxBKHt2fcNNbYhXDoS8dSDYiDnjGS0D+ZDDiLeJut7gRHB0WL8hl5mxQfoYOc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 8:36 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Fixes the filename for the 70mai midrive d08 dts.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/arm/boot/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

       Arnd
