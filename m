Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A552070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NATaD6DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgG0KyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0KyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:54:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C9C061794;
        Mon, 27 Jul 2020 03:54:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so7813956ple.0;
        Mon, 27 Jul 2020 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIEKzcok0AHytuejxAqDHox+Hv/4xCQLeQwpksAUjBk=;
        b=NATaD6DOFsQ65caJoNxzMR1zR5wWv1mukgUlz/BQxbkOyAc5URJ66Y+8cdha222tlD
         khfhBoARpbTJAfxfgmxzI25DrnSdQBWxkRBW4/FLvsE89WqdYen4yWtLcPPRWXfcPiQW
         Gik2kR8VvdLGEoWhb8f0jxxfsTaN1VITh/z6fnufWcLt+xSwyDnNjizNAmxx5ggA+Tl+
         ij30otw8WWxa0Me518bb4RvNp+5dOrGeuixKwriyJ/GTmZ0NBZVS3RelFEGMegirNXO3
         /3CobaheVraCdrqydqqbQPsNUyqVJl8E46cp9mILLaxCGk4jnpvgGsPmnunjnFgO7aeq
         LL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIEKzcok0AHytuejxAqDHox+Hv/4xCQLeQwpksAUjBk=;
        b=KFpEi9J7MISEH0iONR3nJaoIUpy0/uMKA/LAMhltjDKbfVXw7z1AQjnxp2o/SriHim
         uJuKTVon0Bjt9ronjDl0Y6XbOrIZi3T2Tc7ByWlVuf2o6mbtsk8DoZ/3gFp0koUgUiW3
         NFlj/XBVZIrYM6FGjjId2CqYKok9LdLF/4ssMm9cmh1Ejmdh1ur6bp96131NkZ48ZQAp
         z/+OGhVsS7//yWhetkUrg7BazCkHRquMbvGFehDG01Pgj9+0A1mvhxQ2wroEQSfTLFdF
         1Z3GWJ6VK2r2OVw/VBuQ0MD2KzIJvCyNCwSTu8KBkfQYwG2tEm8EARw6ZhdSroP2ZL+z
         Vbxw==
X-Gm-Message-State: AOAM531VNSC8Fqc3q/FwaSo1uzXPU6wyjmp5i/xcObqRBTlyez+7LFnm
        D0JGsdeshRQFLlGZMtlKZzOp/VE/eoTY0pj4u0scEdNa
X-Google-Smtp-Source: ABdhPJzKpuotHtZQWXCNXpW4Rd40X2ZHyq6xGCf7dma4uujyWwxfrgebmhgIZK8KpV8IbxrNGqpdB0U2NUlVH+QVpNQ=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr19017924pjh.129.1595847245382;
 Mon, 27 Jul 2020 03:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <0bad52e6e10ff2e8d8a19f95bab7642ec5e71838.1595838334.git.sramani@mellanox.com>
In-Reply-To: <0bad52e6e10ff2e8d8a19f95bab7642ec5e71838.1595838334.git.sramani@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 13:53:50 +0300
Message-ID: <CAHp75Vdsw61-uNi2TiR7F4j0s=F6XCnQC_j81hXfyJ9tfeq8QA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
 PMC driver
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:02 PM Shravan Kumar Ramani
<sramani@mellanox.com> wrote:
>
> The performance modules in BlueField are present in several hardware
> blocks and each block provides access to these stats either through
> counters that can be programmed to monitor supported events or
> through memory-mapped registers that hold the relevant information.
> The hardware blocks that include a performance module are:
>  * Tile (block containing 2 cores and a shared L2 cache)
>  * TRIO (PCIe root complex)
>  * MSS (Memory Sub-system containing the Memory Controller and L3 cache)
>  * GIC (Interrupt controller)
>  * SMMU (System Memory Management Unit)
> The mlx_pmc driver provides access to all of these performance modules
> through a hwmon sysfs interface.

Just brief comments:
- consider to revisit header block to see what is really necessary and
what can be dropped
- add comma to the arrays where last line is not a termination
- look at match_string() / sysfs_match_string() API, I think they can
be utilised here
- UUID manipulations (esp. with that GUID_INIT() against non-constant)
seems too much, consider refactoring and cleaning up these pieces
- use kstroto*() API instead of sscanf. It has a range check


-- 
With Best Regards,
Andy Shevchenko
