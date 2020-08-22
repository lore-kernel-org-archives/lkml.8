Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC77C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5132078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="E04jO1Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgHVEs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgHVEs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:48:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3762C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:48:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b66so1349552wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EpfXuOfl5Lc4X03a/2NthXamDtm3ZTxJlpaERf1P2M=;
        b=E04jO1XaLwTEoC5F7ckK/3aQt1ozC0Fcmt/b8GJiWlnGHUdQBoV46zHaqX8lhyuA6t
         61+o8lWe+YunryUin42fuZz646fxNWnJy0TAxA/h6js4kvJ1SF9qesCf7SuIuuoB8HGl
         AVSzLN/Orw0rBpLQpmsY/cxB9ued9UHWTnUR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EpfXuOfl5Lc4X03a/2NthXamDtm3ZTxJlpaERf1P2M=;
        b=to+NpobgG81gjda5CGzDzbUAnz/4IK3dO7UzaZx0gCGYCRQeigxv4i2rQydboyhtB7
         Rbh3hjyDsjiShHkNVTdUepVIA/b5OVQcV/ifvx4LhS49DXIFyda7iNeFeO/Ix34MDxsa
         MglVkpBeN2nVoVxRRCOd7Ea8PnAj8wzDy9jva06z0Tlf30/H+BkvFgcod2FOosYrDjZl
         W8QU/w13wgvpuloWuW2P2rBtbGOxtkPpGrZ98Sw6bkYlSiHYog+yL12wGLpcbcdZPxNs
         2hDn/EGXpRXQeK4oaO4QGQ8Z2Z4ciVuJfcC0t49iy6k4gGRPaJtsZQcbZ1oRnGS8sLCy
         RiUw==
X-Gm-Message-State: AOAM531zTCaZfYcRuCaDMeESjSxgckwC+Go2pr4ZGJATPxzaqeedKqYB
        yKN4cysmV+PCN2IPGS7pgFVB3gXZ4q2RRS33gfGPmQ==
X-Google-Smtp-Source: ABdhPJw7xCkJoXDkG4cyA0Eab/W2Nf7VdU8EymJP8iNVywtv1/Z8GU515lX7IbfzvyLf86zSlVJwlLuih6meBwQ3rx0=
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr6535376wmi.2.1598071704261;
 Fri, 21 Aug 2020 21:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com> <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 22 Aug 2020 13:48:13 +0900
Message-ID: <CAFr9PXni=BmDY6_iuJPnYb3d6XB1VrxE6WP3YtSBxT6NciZMMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip: irq-mst: Add MStar interrupt controller support
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, alix.wu@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

On Thu, 20 Aug 2020 at 00:38, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> Add MStar interrupt controller support using hierarchy irq
> domain.
>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

I've integrated this version into my MStar/SigmaStar tree and tested
on an MStar MSC313E
based board (BreadBee) and I'm happy to say it seems to be working:

$ cat /proc/interrupts
          CPU0
17:       1219     GIC-0  29 Level     arch_timer
18:          0     GIC-0  30 Level     arch_timer
21:          0     GIC-0  42 Level     arm-pmu
24:          0  mst-intc  44 Level     1f002400.rtc
30:          0  mst-intc   2 Level     1f006000.wdt
31:          0  mst-intc   0 Level     1f006040.timer
32:          0  mst-intc   1 Level     1f006080.timer
33:          0  mst-intc  12 Level     1f0060c0.timer
34:          0  mst-intc  40 Level     1f200400.bdma
35:       3977  mst-intc  41 Level     1f200400.bdma
37:        196  mst-intc  34 Level     ttyS0
40:          0  mst-intc  30 Level     soc:usbphy@0
<snip>

So here's my tested by:

Tested-by: Daniel Palmer <daniel@thingy.jp>

I don't think your series contained an update to MAINTAINERS.
If/when you add this could you add my address above as a reviewer so
I'm in the loop if anyone makes changes to this going forward?

Thanks,

Daniel
