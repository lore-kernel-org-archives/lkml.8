Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641DD207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="tFCc/C8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgEUWGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgEUWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:06:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:06:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so4145745pfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0cVGbHslsk+cbZypfcJMBHiLvJoLsHioFzaKTSs+n+o=;
        b=tFCc/C8HJj4LpJX0P2usSwLyQNiX7DxHVcYzHTYDYaHTMaraLT4kkBngKG8FhueNc5
         d5ePFyP3TLxjNPRnxc5UtTRC7HJNUa+E76KxJEHtwKvmmvQMLjiZdXWSVtor8Ip4v24k
         hOKoKObMITbh5hdxZKVY8waTspi0Z/D+1Zsr1GFBFvPvAlbpYALUyf7b9kp/mhn6pioJ
         SHMavJbQGI6Yv0lQENuxdhbfdf3QqpNruy95w1Zf1tj/jKk1oDNldY719Vnq19P7p3st
         bs2aE0AeCy/sOcgifPOR0ulmqEKoWYboeiMUJTP2WRsWkztcMg0rJhj3QAHKyk5CJYE6
         FSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0cVGbHslsk+cbZypfcJMBHiLvJoLsHioFzaKTSs+n+o=;
        b=Br9eHPa1dw2gR6e79d39bHu51wuTLgod81+da0o/sJHJYq1UNqtObLgLIaHesJdV34
         TF1DxBBM0HFXRE22vNiA0Ojx33YwC0Kr9Na7qnQh8HRsfD2wXt10kvpr6rT+mRImZcaw
         pHOhxZ99VnOSq1omIaWFv5BJMPc0mbykOSvYR9OeismAW3k4BWZC0UTLBYR3HW2xP/AZ
         ROUBpsKmGU4ORiSJ//S1u2Rt8qc6zzEHouodyAAl25pHJG7cMlX55OTDkQa1E6tWOldw
         /eJaI/dgKrCKC0bJSV7vRkUur+3w3abhuZYBCgzovK320UpsrICCb5aDEm5Q5N7zmhqA
         rp4Q==
X-Gm-Message-State: AOAM532wYL7Bf7bM7m+o0ZK89ralSe23JGkgg2IJylwSwyRF3BW1XvqY
        vwKIgG2gjO9NxEcreuf7zJ6ENA==
X-Google-Smtp-Source: ABdhPJxvNiAP71og79LqCA+AUMUDFGKq0Neyp8AahXQM9Diqmra4GU8++wzYfqWAuuFkyfp8UIeyjw==
X-Received: by 2002:a63:6345:: with SMTP id x66mr10607701pgb.156.1590098782531;
        Thu, 21 May 2020 15:06:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t20sm5140916pjo.13.2020.05.21.15.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:06:21 -0700 (PDT)
Date:   Thu, 21 May 2020 15:06:21 -0700 (PDT)
X-Google-Original-Date: Thu, 21 May 2020 15:04:03 PDT (-0700)
Subject:     Re: [PATCH v2 0/3] More improvements for multiple PLICs
In-Reply-To: <20200518091441.94843-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-a2588163-0a87-494f-af68-59f0ca15965c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 02:14:38 PDT (-0700), Anup Patel wrote:
> This series does more improvements for supporting multiple PLIC
> instances.
>
> PATCH1 and PATCH2 are fixes whereas PATCH3 helps users distinguish
> multiple PLIC instances in boot prints.
>
> These patches are based up Linux-5.7-rc5 and can be found at
> plic_imp_v2 branch at: https://github.com/avpatel/linux.git
>
> To try this patches, we will need:
> 1. OpenSBI multi-PLIC and multi-CLINT support which can be found in
>    multi_plic_clint_v1 branch at:
>    https://github.com/avpatel/opensbi.git
> 2. QEMU RISC-V multi-socket support which can be found in
>    riscv_multi_socket_v1 branch at:
>    https://github.com/avpatel/qemu.git
>
> Changes since v1:
>  - Re-arranged PATCHs to have fixes first
>  - Added Fixes tag to PATCH1 and PATCH2
>  - Use %pOFP in boot print to distinguish PLIC instance
>
> Anup Patel (3):
>   irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
>   irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is
>     present
>   irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
>
>  drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Thanks!  Aside from that parallelism question this LGTM.  IIRC Marc picked up
the last round, so I'm assuming this would go in through his tree as well.
