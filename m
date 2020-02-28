Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD89C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DC824699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582897812;
	bh=AenvJB04PGqxvh0r1u1fNLP1JQNsy7lc4FSuIxM11sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hXCN/lxEdBy58gaRJ8KsIasU5zgKKcSMgHpNriMQKzKbWukXRpwrtqMLmBjyeQYBa
	 D+0eAWkqz3kAyhqtmGyzRZ3Za8sh6DGxZYaU7J7suFNHHBVLPWfsFTNKYi1yDU2/rU
	 FudOWxMl93rRqxX1nv5C26ynatLlg3f8SVxGyiKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB1NuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1NuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:50:10 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E839A246AC;
        Fri, 28 Feb 2020 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582897810;
        bh=AenvJB04PGqxvh0r1u1fNLP1JQNsy7lc4FSuIxM11sk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mUnZCSMM9LEbGnCEw35f28QV3pBkme8CDwX4/BDxk9H2Ji7Vi0TObAnCYbe9XEvQC
         +95CGAuJPQXEVGi8dnTZP0Q+EbYIODpIFXLzn+EcKT/Zd47JHc412n1RGzMq3KHCPa
         EC+gibBft58i3mw0DfO4DyUeBXAHiskz1n0IrR98=
Received: by mail-qk1-f179.google.com with SMTP id p62so240972qkb.0;
        Fri, 28 Feb 2020 05:50:09 -0800 (PST)
X-Gm-Message-State: APjAAAW61S2/+a8EkfiR/oSS+1Tv/vpJDGBjkAAsbFf8mffVeKOjJYzj
        lxPD5BbkRRpGbv3GFeOsg8vsb0WQYjV1wynrfA==
X-Google-Smtp-Source: APXvYqwry3YZZtRR7flSe2amPBy5GQiHkF7TBWOS6WX5oOexYDr8PBVvzsyChsK1MHT6pg1W2sd0lsr9Q7kb3XcqETk=
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr4606535qki.254.1582897809072;
 Fri, 28 Feb 2020 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Feb 2020 07:49:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
Message-ID: <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts: dtc: mask flags bit when check i2c addr
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:48 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> Generally i2c addr should not be greater than 10-bit. The highest 2 bits
> are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
> these flags if check slave addr valid.
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  scripts/dtc/Makefile | 2 +-
>  scripts/dtc/checks.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)

dtc changes must be submitted against upstream dtc.


> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 3acbb410904c..c5e8d6a9e73c 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -9,7 +9,7 @@ dtc-objs        := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
>
>  # Source files need to get at the userspace version of libfdt_env.h to compile
> -HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
> +HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
>
>  ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
>  ifneq ($(CHECK_DTBS),)
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 756f0fa9203f..17c9ed4137b5 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -3,6 +3,7 @@
>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
>   */
>
> +#include <linux/bits.h>

Not a UAPI header not that that would be much better as dtc also builds on Mac.

>  #include "dtc.h"
>  #include "srcpos.h"
>
> @@ -17,6 +18,9 @@
>  #define TRACE(c, fmt, ...)     do { } while (0)
>  #endif
>
> +#define I2C_TEN_BIT_ADDRESS    BIT(31)
> +#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
> +
>  enum checkstatus {
>         UNCHECKED = 0,
>         PREREQ,
> @@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
>
>         for (len = prop->val.len; len > 0; len -= 4) {
>                 reg = fdt32_to_cpu(*(cells++));
> +               reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);

I'd just mask the top byte so we don't have to update on the next flag we add.

Rob
