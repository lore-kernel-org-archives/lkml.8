Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73507C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D78F22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGTOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:01:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38437 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:01:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id t18so12243220otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sm9hzY8Gx8u/oDin+jrj/nuec2pHnEQC63GiApJcb8=;
        b=EoYZxRVtZg3os9dPNLla3rdHhi/O9kZvUfBNecJD3iG8GxjJ2xRJ6uVOLP55r9qmWJ
         +8nYOXElnrsi0LWYEj2X8Fkzbz5Qs7muTD9btAsF4FRpp6Bf4jEJIhREpDK0aF7yShIq
         T0iyLCptmbZgUNNe2yNcZYdkXRgEBnUJzoMADCsdXr8bXPIeFsYGZ140PVatAxZJFcL3
         nV9FUOsBZ/pYq+1I0B/t1OJnDMqgf9Fwt7lwconlBn4evTO9uRHI/GBwwe8tVc7mvBYq
         d/fdNSPm50bCMYmlpijJ5UWvxTokzupNjvM5RQtId8Mty6uqHJXZbUMyu/yrgTpNoqTo
         /98g==
X-Gm-Message-State: AOAM532ADIItM5Fzi8itfSnuVD1zsPw4EjWpyJOD2/Ix3HOFBkwtpA7V
        IRQwX4djUvo364ZaSTEf2Xlk5flUUhp1VPsT8177R12zkZ8=
X-Google-Smtp-Source: ABdhPJyRR7/982OV9K2u33/RDBbMGpEKnnAWR4wgcjqqxpzZSB3DWV3jw54gd07WTR/pMSO2JPgjCxhao9mCGfbIky4=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr18877741otb.107.1595253717346;
 Mon, 20 Jul 2020 07:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200720130737.4428-1-geert@linux-m68k.org>
In-Reply-To: <20200720130737.4428-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jul 2020 16:01:46 +0200
Message-ID: <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 3:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8-rc6[1] to v5.8-rc5[3], the summaries are:
>   - build errors: +6/-3

  + error: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!:
 => N/A

um-x86_64/um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba47d845d715a010f7b51f6f89bae32845e6acb7/ (192 out of 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/11ba468877bb23f28956a35e896356252d63c983/ (192 out of 194 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
