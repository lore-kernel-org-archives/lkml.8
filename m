Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9DB20768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="j/PZKR7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgF2VF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgF2TMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48ACC08C5FD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:53:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so12663995wrp.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlkirLsIZMObxpVgMysLgRaq8YNVzTc6KirQpgVXrl4=;
        b=j/PZKR7k1xbX2L5QA4ostwRavWKWUK/N34oC2C8aMw8lMmmV4WnYf/amEnn5yWG6WP
         v5XfK2tf6vIerdnASizSZxc9nmxXFGUBQoEr8xbxqHz9ot4GDAC1Xhkk6IkuLKowEEV8
         jRQ7QmthO6fUya5tSXTmdvwiv/3InniocLRyjDawgX4ZtLcTjeean32ErbKDtyMpLfCt
         h41wudieF4BNsc3tKAMFx3t6ihPEw+EGzk38vspi+YI7g+cfql1SYETCLdsJRtdSN33C
         NCAHfXe896jFf+rcPPRYrLkX6EJW+Q9RPxehYZEuMaFqEJx2ildGX4cQH642SxNm4dB5
         cT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlkirLsIZMObxpVgMysLgRaq8YNVzTc6KirQpgVXrl4=;
        b=du79K/itkHhhi1n8+/dj/IJNArsyqsTD7e9m57yxVjbqp55SiWOkiUrcnaK4mYl3W2
         rRUeR4sFzlcm5kJ6GnbP371fle5sWS5NKP4uG6lJxmlK4JqHJyOCyjbX5vC28hAZOdFY
         2B5CKfGWTLjOAtddgxKJhtHUOtTSevIUUZMccCtsqQhNWY1Sgy5/DMk3jL/mHCXWwUh+
         4kJ4kqazTfrqiNEvHChGEYwmBR285ay97xozWMnZbKvykv+f4RiXhye4rXcfR2Ssevxe
         E648TCGqUuFDN8emDb1cbM/nnDbFHKnP0RV836+zWTbjIrIwZD7ILKCxKfT0gml5PHnH
         5+IA==
X-Gm-Message-State: AOAM531Kb4s4ZD9x1VVL2jYY5i/xKL8zl5OHZMOS/xPkWD4RNgQ3ERed
        wepkHenvADAoSByQO0Ea08KvxIwPQLzqIlgMJY3TWw==
X-Google-Smtp-Source: ABdhPJxa/xVZEo4rcONrdXK7z4EBCafJE7t3pkJxGBiHDISKtOWNiYaOD0c0v3gOgqNI5AKRBTrN8tHGHJujsgatwnI=
X-Received: by 2002:adf:de12:: with SMTP id b18mr16280822wrm.390.1593406386452;
 Sun, 28 Jun 2020 21:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com>
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 10:22:55 +0530
Message-ID: <CAAhSdy1uFt3rqf8cSHqS=W90AoeQjo10R_Ak4Cknb_QUvH1SPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
>
> This patch set adds raw event support on RISC-V. In addition, we
> introduce the DT mechanism to make our perf more generic and common.
>
> Currently, we set the hardware events by writing the mhpmeventN CSRs, it
> would raise an illegal instruction exception and trap into m-mode to
> emulate event selector CSRs access. It doesn't make sense because we
> shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
> selector through standard SBI call or the shadow CSRs of s-mode. We have
> prepared a proposal of a new SBI extension, called "PMU SBI extension",
> but we also discussing the feasibility of accessing these PMU CSRs on
> s-mode at the same time, such as delegation mechanism, so I was
> wondering if we could use SBI calls first and make the PMU SBI extension
> as legacy when s-mode access mechanism is accepted by Foundation? or
> keep the current situation to see what would happen in the future.
>
> This patch set also introduces the DT mechanism, we don't want to add too
> much platform-dependency code in perf like other architectures, so we
> put the mapping of generic hardware events to DT, then we can easy to
> transfer generic hardware events to vendor's own hardware events without
> any platfrom-dependency stuff in our perf.

Please re-write this series to have RISC-V PMU driver as a regular
platform driver as drivers/perf/riscv_pmu.c.

The PMU related sources will have to be removed from arch/riscv.

Based on implementation of final drivers/perf/riscv_pmu.c we will
come-up with drivers/perf/riscv_sbi_pmu.c driver for SBI perf counters.

Regards,
Anup

>
> Zong Li (6):
>   dt-bindings: riscv: Add YAML documentation for PMU
>   riscv: dts: sifive: Add DT support for PMU
>   riscv: add definition of hpmcounter CSRs
>   riscv: perf: Add raw event support
>   riscv: perf: introduce DT mechanism
>   riscv: remove PMU menu of Kconfig
>
>  .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
>  arch/riscv/Kconfig                            |  13 -
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
>  arch/riscv/include/asm/csr.h                  |  58 +++
>  arch/riscv/include/asm/perf_event.h           | 100 ++--
>  arch/riscv/kernel/Makefile                    |   2 +-
>  arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
>  7 files changed, 471 insertions(+), 245 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
>
> --
> 2.27.0
>
