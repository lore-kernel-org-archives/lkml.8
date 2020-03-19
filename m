Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C8C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537EF2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j8G9K+B+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCSXjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:39:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37063 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCSXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:39:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id b23so4967395edx.4;
        Thu, 19 Mar 2020 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/mfJWmxNQuzD0dp6KizZYLJ7CLCpefixytllKpkTzc=;
        b=j8G9K+B+n/Ojbh81OEur+lMEXOYshUECgbkp9tY2M6biLvzxuXxFN6lSXsbzkFslae
         jc9HBRJfL/ELl9ivB2zl+RB7BwJBWe6Fe3cJUqDS3BvY8Ew3qTlSEHLOlAxL28+8zSzI
         K5mjzp5BIPEOKCjcxnOZcDUWvMDfzyFwri/UuDoqUNbN7Qbjb/4+tlqa9mer6w8iaXHu
         eWkmtlPpdTgLysTFsSzvDEb9VUTf7QQ61jEIzK6nEAYhOoZRP38YT3+XgmgwbWUc83Mm
         gE+Xe2D0Vbn9fvK4gxEZ/0IYCMKCgwcybXlA0udklqhacor6tDl6DYRYOk6EVgM544Zt
         dSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/mfJWmxNQuzD0dp6KizZYLJ7CLCpefixytllKpkTzc=;
        b=GncQZth+nlvs++c2VJZ0NAM/l5AFnCyjqtO7c8jn+Mnzbc0RDxuST/b8VbhMglk9Hm
         ynA4ns4GrepRKaloPNuCtMwwq9Cfhqs4lOnCZYcWPAHrjAZzvY2WQ8zFmxF+HkzhpGcT
         M1cuPDGV9CUJk/qNO1OM/DpwuZoWAxC+NWUfN+LdoB413aS6K60Ibiheb+bT5Zrso2I4
         XR5enLnfg91Cs2dcwlVmJgYzCGNeUaxM/EUmXpTuzw9oWdYSBPCj32GIsPIhtKam7d67
         xQP735ypVFpYGzbS+Yd5ZWhtAT2TDUVQpVVY++BQEt55TRYQ3odEz04Jc9iCf+WUV6Cz
         j53w==
X-Gm-Message-State: ANhLgQ3l9e/ap/emrSOEN7ctCRlr8ECFgOR5NaNa5Gvm4zsuNd+Jjfp/
        USS+zrG2U/JAUe/LEDvrSpVirm2Af3dE95+Q5vI=
X-Google-Smtp-Source: ADFU+vsBYF3lmb/S9MivVj1ar9fEgyHh9mNe7PH/to4h3/J9OWLSH5rf3wC8erfomQYZyINKFfGztDXrzBfrtovFz/I=
X-Received: by 2002:a17:906:6d0:: with SMTP id v16mr5698516ejb.90.1584661168372;
 Thu, 19 Mar 2020 16:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200302125310.742-1-linux.amoon@gmail.com> <20200302125310.742-3-linux.amoon@gmail.com>
 <7hlfoir8rj.fsf@baylibre.com>
In-Reply-To: <7hlfoir8rj.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 20 Mar 2020 00:39:17 +0100
Message-ID: <CAFBinCB2WXZNRg4wdFD0RJ5k4hHqcfAOCHemvHzZE42-Mo5vzA@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] clk: meson: g12a: set cpub_clk flags to CLK_IS_CRITICAL
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Mon, Mar 2, 2020 at 6:01 PM Kevin Hilman <khilman@baylibre.com> wrote:
[...]
> > updating flags to CLK_IS_CRITICAL which help enable all the parent for
> > cpub_clk.
>
> With current mainline, I've tested DVFS using CPUfreq on both clusters
> on odroid-n2, and both clusters are booting, so I don't understand the
> need for this patch.
I *think* there is a race condition at kernel boot between cpufreq and
disabling orphaned clocks
I'm not sure I fully understand it though and I don't have any G12B
board to verify it

my understanding is that u-boot runs Linux off CPU0 which is clocked by cpub_clk
this means we need to keep cpub_clk enabled as long as Linux wants the
CPU0 processor to be enabled (on 32-bit ARM platforms that would be
smp_operations.cpu_{kill,die})
cpufreq does not call clk_prepare_enable on the CPU clocks so this
means that the orphaned clock cleanup mechanism can disable it "at any
time", killing everything running on CPU0 and CPU1 (which are both
clocked by cpub_clk)

I have no explanation why this depends on booting from SD or eMMC.

for the 32-bit SoCs we have CLK_IS_CRITICAL on the CPU clock as well
since commit 0dad1ec65bc30a
on G12A we have CLK_IS_CRITICAL on the sys_pll clocks, however my
understanding is that cpub_clk could also be fed by one of the
fixed_pll derived clocks (which have a gate as well, which may or may
not be turned off by the orphaned clock cleanup - that is pure
speculation from my side though).


Martin
