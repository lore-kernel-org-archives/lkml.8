Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B1C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1420672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEemUvBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgDEOhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:18 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34878 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDEOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id i2so1721357ybk.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKQvHdwC+ist3T6F8i7xcPFrJp3xaHVCClbktGExROY=;
        b=aEemUvBbCWM/Pv9KFjjqy1aPFijL+dwSiZ/pFpkmnZ++FzJnyTEqoPZG05slBZslZ3
         1npbJcN33CUNn2vFXG5c81zx/j8x/3vEEOmgdve3p9EwtxzuD/Yr3oeiQ6wfNFC9KcdH
         9ik3prusQPUyMEOQMxm/NEj7Dge7shyfTVmiSU4P642LRqvjDJlBVwJldmj6v30Wm8oP
         yUMonnOGlCAMAt0g2C8WjR+BJyAYxV6GOYlWICIY+0yGx31sZkGUC56KbiizQwD0yyyI
         JAWoobJuYULQKamzGbHglpmv1svTsANMC6vduQ1Ipsv1ko4G7Xnq+H+bra8DNywTeZp8
         4BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKQvHdwC+ist3T6F8i7xcPFrJp3xaHVCClbktGExROY=;
        b=JHUQ8jSZTnr98DlrDMfQFUeRdl4j5IcAya9wB6r0IwRozAZh5ZQeh7WVEmRre9lYx0
         6vZMZpi+589DLC48qGfDaPfAqBDXWvyIz9/6Z5bUwb6AuIuzuDXdXU1Im9yOM/hZStYu
         mp2CXjEL26ocjLLPoF0HY4nOs3siJ2b8yxcQV9JWB/ssoF1WZKCRZqTVNqOFtCNvv27i
         +0tvlfOFjDKVHnPrXA8Fos3uIN7BYJgksDtfh2QEoLO/wH28ADcfB+jK8US3e+X7PYep
         dEF1GjK8PzmyxDmqE/jLv4bOONcytpwBLsObd3Fe/d+JFgl5R3KFwLQHx0tzWlRQ6tDL
         PBUQ==
X-Gm-Message-State: AGi0PuY6UHccrPcLrpNt99g8LxoJ9H5rECSTG4zomR+C1OyOmta6oZEn
        KlxGpqyFzBmZkSds5PuQ2Kx8nT4Uz1ervCot3ik=
X-Google-Smtp-Source: APiQypLIDyHR18s2gWsL39NR76H+2z45jTNzr28WXT++x/VulixJW1bLPAjQ+4WHe9BzUecXNEZzdh4k8VAoF/PdpCs=
X-Received: by 2002:a25:d646:: with SMTP id n67mr26357259ybg.65.1586097435424;
 Sun, 05 Apr 2020 07:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-5-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-5-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:03 +0800
Message-ID: <CAEUhbmUN4rkJA+KZQN1n=VFhC5=QX-DsfjEun6_HGR6WL3WgpQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/11] RISC-V: Introduce a new config for SBI v0.1
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:11 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> We now have SBI v0.2 which is more scalable and extendable to handle
> future needs for RISC-V supervisor interfaces.
>
> Introduce a new config and move all SBI v0.1 code under that config.
> This allows to implement the new replacement SBI extensions cleanly
> and remove v0.1 extensions easily in future. Currently, the config
> is enabled by default. Once all M-mode software, with v0.1, is no
> longer in use, this config option and all relevant code can be easily
> removed.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Kconfig           |   7 ++
>  arch/riscv/include/asm/sbi.h |   2 +
>  arch/riscv/kernel/sbi.c      | 132 +++++++++++++++++++++++++++++------
>  3 files changed, 118 insertions(+), 23 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
