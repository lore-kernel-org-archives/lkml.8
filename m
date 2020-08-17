Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F15C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FBF20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlEOJF0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHQIAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:00:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC20C061388;
        Mon, 17 Aug 2020 01:00:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so11548766eds.2;
        Mon, 17 Aug 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z330LvAKCYsk0CrMhzqHRPa+XHQ9kqhfbHPXy6rxLoM=;
        b=YlEOJF0lqSY2ZKxZNl18VpwO36rWpHTf7HGkba8Q2IWbzK4zF1kSRdAuWm88k+AcJT
         06Txq1Pl6Dni4Oy5YuyKj6RCRRAW19JeS2e1a3/XqJhE5G2hW7yE2RyXQanvV+nZfBws
         ZtFkz+MEAzCohroWddiuzf8u15aYH10qCjaCEWaH3r3mMsrWaEKDaLpR/m3IGl6OMAe2
         gmizw9hJ3NvK23pBHiksMvyedCAq/+GLBpw8ntO7JNBv0tH9LIYYIfTkOGX6RwWtO8dz
         tB0ymiJJz1R7v8k1d9o1bwj5Nu+BJmVkJcFm47JDFflqRppGdL6ebn+9f8g2GWusdrWI
         mBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z330LvAKCYsk0CrMhzqHRPa+XHQ9kqhfbHPXy6rxLoM=;
        b=fQAtei4jxH5FSwwwJw5m8tPKsHRNv56jqHsz/ShUDPvuLegNdFTP6eKY4FlOP0vdhE
         PbtYHImVu4j8hcY3BrsDn4bQk3Dfz0kKVuHgdQaK5dwU+Uhva7OugtmcryJYJhOBuDxP
         XbG+PbPO0oQGOj3OnyEaQF9WPeTmNhp66wa9UnbYTUL04sJZtt3vm2B3LwXl6YWJxY6u
         ojhxiPlFFlqFz8fUbM5buXingMKaRYv4EDA42yLgdEuxFHLTazsx4VYo0yOp6IqE7NvR
         7i8nputUomL7jon/sNqdcIP2ojV6ip6Fi4hc5C3Am+sE1fXf6AbTKoXUZYJOjnK2kwQi
         xdyA==
X-Gm-Message-State: AOAM531OaUc7D2APVBqY67AU1H+Q7//pKBe5UsAMKZ2Q6GLyBfI26EcY
        GaOGf4v6qCYoFMmmWl/yxpybbYL3OZoYdlxIuD0=
X-Google-Smtp-Source: ABdhPJw9CFBLfYGunenFJugiGq2Y/L120kJhbL/OldccxscUVhsgLFhWsM9M8Y45/rJyHpwKSjyYtK3M+2kwvr0P0aM=
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr13925150edb.22.1597651248588;
 Mon, 17 Aug 2020 01:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-4-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-4-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 15:45:43 +0800
Message-ID: <CAA+hA=TD9peuM10gp3R6mwt4vtehjCDrVz+Rwt-894-uOuvQzw@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] dt-bindings: clock: imx8mp: Add ids for the
 audio shared gate
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> All these IDs are for one single HW gate (CCGR101) that is shared
> between these root clocks.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
