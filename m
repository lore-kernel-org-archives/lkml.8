Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81421C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5312D2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4uXw8Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTKez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:34:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38290 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:34:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so5708337wmi.3;
        Fri, 20 Mar 2020 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9LMr0UXcZSEqVnqNAwLyFiSr+kmUdRM1J1fT1cXn5U=;
        b=Z4uXw8PfRFLJlofHFGW41vrqoGwlAIqRACj+uRDYvGpB8tWq7q1Li9OwTmu9kmT7sS
         VJ3g8sAmUG2NSBqkCPDsohe7yIgPn3QYHTtZLkdZRYvvKEXiboau8buIhpjAzyNF7evV
         x8vRSxGYM0NmnHdGYBjFzdCkQW3RfOZeutJgCiimnqdA8Gdqu2ANQvtjli+HGCLBzz+Q
         v0Iyv/TwBHXbwA0m9jSHsI9Ks5ouiTq8po/U26UqHCZnOeITzTRNSvu2ha6JxopKmf12
         RFvRFeqsQMqfbXmM1nUgVOsBp1+1zkx3fMIeAvg8fRKJqvRrmtmPrKcw2aY5p9exuglM
         TKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9LMr0UXcZSEqVnqNAwLyFiSr+kmUdRM1J1fT1cXn5U=;
        b=DEqEfb6zAW0+TDZe3TilMZPW6snb29jO5GeFIPWRU1lsD9zx5eISvt1RWt7raR7wVh
         4KrIsUumEtGiZY2ROifrW83enC1QT2IrXkGQkPDPecCct8kSsie0s2Jxt7rAwlASqQaG
         zumWjoQi1KVh1OJZuFtHbZoTrLFt3mW5X+zcOJXps7MZJJuErl/vguONiHM7JcVJ7lMg
         SAcFOvzQTwkT6XJmYMcOH4HLYcTc6GqYk8daIPXvg6XS+hmogTJt3UXeJKd7a+UGHQ3h
         h0F1qXr7kIGzS0am8sNHCpnXBHvaylHdq626cSIC2ocDbE1wg+BbYvFcApxFCiYUozH5
         SBEw==
X-Gm-Message-State: ANhLgQ0QO8eVj8ICyHdT6Jhao+nhywn1tyRzzi5+pOwEITvgg8d35zbI
        3V4NK+IBnW22iDqMN7PZhRJytHpTX/1nKiFGMTZWJQ7M
X-Google-Smtp-Source: ADFU+vvRrvOiPU9AK3wSD6H8a7LzgOUg2SrSTLcnrfXfsiTSvivvRS4XrMnjiu3ESR+V0DJhpgTVgiItLeoY1EdIvVU=
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr9145899wml.26.1584700492517;
 Fri, 20 Mar 2020 03:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 20 Mar 2020 18:34:16 +0800
Message-ID: <CAAfSe-sWv1mrx1GPgO8ZRhSs9vbAy_PY_BA4BkHrE5FghsX7nA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Add clocks for Unisoc's SC9863A
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please take this patch-set to your tree if there are no
further comments.

Thanks,
Chunyan

On Wed, 4 Mar 2020 at 15:28, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add SC9863A specific clock driver and devicetree bindings for it,
> this patch add to support the new way of specifying parents
> without name strings of clocks.
>
> Also this patchset added support gate clock for pll which need to
> wait a certain time for stable after being switched on.
>
> Changes from v5:
> * Addressed comments from Rob:
> - Removed description from "clock-names" and "reg" properties;
> - Added maxItem to "reg" property.
> * Modified the descriptions for those clocks which are a child node of
>   a syscon.
>
> Changes from v4:
> * Fixed dt_binding_check warnings.
>
> Changes from v3:
> * Rebased onto v5.6-rc1.
>
> Changes from v2:
> * Addressed comments from Stephen:
> - Remove ununsed header file from sc9863a-clk.c;
> - Added comments for clocks which were marked with CLK_IGNORE_UNUSED,
>   and removed some unnecessary CLK_IGNORE_UNUSED;
> - Added error checking for sprd_clk_regmap_init().
>
> * Addressed comments from Rob:
> - Put some clocks under syscon nodes, since these clocks have the same
>   physical address base with the syscon;
> - Added clocks maxItems and listed out clock-names.
>
> * Added Rob's reviewed-by on patch 4.
>
> Changes from v1:
> * Addressed comments:
> - Removed redefine things;
> - Switched DT bindings to yaml schema;
> - Added macros for the new way of specifying clk parents;
> - Switched to use the new way of specifying clk parents;
> - Clean CLK_IGNORE_UNUSED flags for some SC9863A clocks;
> - Dropped the module alias;
> - Use device_get_match_data() instead of of_match_node();
>
> * Added Rob's Acked-by on patch 2.
>
> Chunyan Zhang (6):
>   dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC
>     specific
>   dt-bindings: clk: sprd: add bindings for sc9863a clock controller
>   clk: sprd: Add dt-bindings include file for SC9863A
>   clk: sprd: Add macros for referencing parents without strings
>   clk: sprd: support to get regmap from parent node
>   clk: sprd: add clocks support for SC9863A
>
> Xiaolong Zhang (1):
>   clk: sprd: add gate for pll clocks
>
>  .../clock/{sprd.txt => sprd,sc9860-clk.txt}   |    2 +-
>  .../bindings/clock/sprd,sc9863a-clk.yaml      |  105 +
>  drivers/clk/sprd/Kconfig                      |    8 +
>  drivers/clk/sprd/Makefile                     |    1 +
>  drivers/clk/sprd/common.c                     |   10 +-
>  drivers/clk/sprd/composite.h                  |   39 +-
>  drivers/clk/sprd/div.h                        |   20 +-
>  drivers/clk/sprd/gate.c                       |   17 +
>  drivers/clk/sprd/gate.h                       |  120 +-
>  drivers/clk/sprd/mux.h                        |   28 +-
>  drivers/clk/sprd/pll.h                        |   55 +-
>  drivers/clk/sprd/sc9863a-clk.c                | 1772 +++++++++++++++++
>  include/dt-bindings/clock/sprd,sc9863a-clk.h  |  334 ++++
>  13 files changed, 2457 insertions(+), 54 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
>  create mode 100644 drivers/clk/sprd/sc9863a-clk.c
>  create mode 100644 include/dt-bindings/clock/sprd,sc9863a-clk.h
>
> --
> 2.20.1
>
