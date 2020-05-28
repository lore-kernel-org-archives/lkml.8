Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A33208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590628430;
	bh=nJ+OlQlFiclXQXrwSoo6jw5QuuCZENaXlRnmg76bdVU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=JDFupWDV5ZwmPZrbdtC41tdONlymn98YVBAe0iThNCZDVM5g2IxH1gHb1YVAOo+jG
	 En8DmXdP3NUdas5y8tiwvcFdcEFcjMtx3PDxhGGNKiSDuyL3FvqHp24sn0Cq+omD3C
	 3BTKYQmdeyzVqV+Bad5QcNGsw6tezKFsrhfIsUy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgE1BNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE1BNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:13:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECA120C56;
        Thu, 28 May 2020 01:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590628426;
        bh=nJ+OlQlFiclXQXrwSoo6jw5QuuCZENaXlRnmg76bdVU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2D/F+K0OpuE2eplGl0zNvlJLvETSAOyub7sxF7k05vU5XdghXDCw0pBI9DPkvSvzx
         ij21J1CMgSKM70EkJdMeFGKbWt++ODVfmnYweG/PQYzPBaFRExlRZA5PP+ccx7RVgl
         QpFQolwgRzmarIV4udP/tIb/D/xnBe8+yNoe+cys=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527175635.5558-6-zhouyanjie@wanyeetech.com>
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com> <20200527175635.5558-6-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH v12 5/7] clk: Ingenic: Add CGU driver for X1830.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
To:     linux-clk@vger.kernel.org, Zhou Yanjie <zhouyanjie@wanyeetech.com>
Date:   Wed, 27 May 2020 18:13:45 -0700
Message-ID: <159062842562.69627.2356351510003565560@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Yanjie (2020-05-27 10:56:33)
> diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-=
cgu.c
> new file mode 100644
> index 000000000000..29a637f4a2cc
> --- /dev/null
> +++ b/drivers/clk/ingenic/x1830-cgu.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * X1830 SoC CGU driver
> + * Copyright (c) 2019 \u5468\u7430\u6770 (Zhou Yanjie) <zhouyanjie@wanye=
etech.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>

Add linux/io.h here.

> +#include <linux/of.h>
> +
> +#include <dt-bindings/clock/x1830-cgu.h>
> +
> +#include "cgu.h"
[...]
> +               return;
> +       }
> +
> +       ingenic_cgu_register_syscore_ops(cgu);
> +}
> +CLK_OF_DECLARE_DRIVER(x1830_cgu, "ingenic,x1830-cgu", x1830_cgu_init);

Same question about why this is DECLARE_DRIVER.
