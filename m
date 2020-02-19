Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504BC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AC924655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uDmXFWXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBSDWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:22:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39179 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgBSDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:22:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so5122394wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 19:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfaJyOLTybqR0wcRksQXUpE/zn256XZxT7vhQ+bdkaU=;
        b=uDmXFWXnf56hOs5K5rJk7/rXsq1nJoqSFUWioTEehkzjUO+5MHupZ2k0O5+7cMogWZ
         tLujlPw8jm0JINEyEnU+rqNpbLUxvszcOHfeoMFhS8UZuHra8UT8y940bXfcvdfRt9lW
         1DxJHCxzNDUDgfGl1b3gnOTa5kH7+s6P29EJ8IbDw8jPQYge8Qhh1PjRSbvhQ4V+bhQO
         4gBq0Hg/FGdeEnU/kDLW6i6jNlkqtf+SpyYwD2iK9SNeNVBEd2n/ublFSG47Q8W1tGjS
         Y/q9qtzXizLVB40m6uyRw84LkXdyaZpX1cdohZmm+lcM7G4E4kxZsrDNJaQKfyTkfNJz
         V9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfaJyOLTybqR0wcRksQXUpE/zn256XZxT7vhQ+bdkaU=;
        b=QYr6FM4fLKe9LM58ZAUCfJe9zxlmG1H8Xv8F+5KAP9KaVD0Sc9yY5oEyMOJ2OZVETW
         d8UTJE/uQVxy6Y13Pp2dkabv43++oFtg5x6l5/eBqrIdgtE4eOhVq2TGHmI2ARAkXwXo
         rz7lh1zDmZHR8ue8dKLn+f6wbLUQ99s0Aq1cI54yUNlEnH4aHZKJwJ0CbrQzv5/l9fCH
         V+PoMniROU8iXuDzls1+p3s/Uspy/rnQXF9dXvJVuVHTIejpsnZFQvYMZJ2Sg00OowU5
         p6N14j1kqjkeszH/zbJfU/IdrgG7y6hlmaGoHJWKBPziqFTlTUEuB0dm/2/Jplyb96eu
         s3tA==
X-Gm-Message-State: APjAAAXvgKHSA5rKPQMJlFsVFY/TCkTNeVPJFxvFTFcay19Vqri2Fy8J
        SCwYE4tpaLdm7YKuKCFMBzsoz0OOJsI7prGtpEEZnDsu
X-Google-Smtp-Source: APXvYqwpdZAuR0yqwqResXLX6h5jE0qt/FwuFVScUvP5kgWEtYnlnp5loicPr1meqDdLp9fKWagkF34a05iDbQD8A0U=
X-Received: by 2002:a1c:6246:: with SMTP id w67mr6645202wmb.141.1582082569880;
 Tue, 18 Feb 2020 19:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20191203034909.37385-1-anup.patel@wdc.com>
In-Reply-To: <20191203034909.37385-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 19 Feb 2020 08:52:38 +0530
Message-ID: <CAAhSdy0=NHHVvJed733nK+FkprfQ5j7puw1RtsD3Xtg4s2vQjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] QEMU Virt Machine Kconfig option
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Dec 3, 2019 at 9:19 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patch series primarily adds QEMU Virt machine kconfig opiton and
> does related RV32/RV64 defconfig updates.
>
> This series can be found in riscv_soc_virt_v2 branch at:
> https//github.com/avpatel/linux.git

The corresponding QEMU patches are now part of QEMU upstream
master branch.

Can you consider this series for Linux-5.6 ??

Regards,
Anup

>
> Changes since v1:
>  - Fixed commit description in PATCH2
>  - Rebased series on latest Linus's master branch at
>    commit 76bb8b05960c3d1668e6bee7624ed886cbd135ba
>
> Anup Patel (4):
>   RISC-V: Add kconfig option for QEMU virt machine
>   RISC-V: Enable QEMU virt machine support in defconfigs
>   RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
>   RISC-V: Select Goldfish RTC driver for QEMU virt machine
>
>  arch/riscv/Kconfig.socs           | 24 ++++++++++++++++++++++++
>  arch/riscv/configs/defconfig      | 17 +++--------------
>  arch/riscv/configs/rv32_defconfig | 18 +++---------------
>  3 files changed, 30 insertions(+), 29 deletions(-)
>
> --
> 2.17.1
>
