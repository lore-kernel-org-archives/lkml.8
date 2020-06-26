Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1699920656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfSeHT4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgFZNtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFZNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:49:13 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D229C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:49:13 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w10so4622335oih.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swCARVHhCrCpWi0m0hXoSR+kJlH+uURNMzuGlvCBkOU=;
        b=dfSeHT4LBeVITNnTx7D2FIhzccfqT8ZY0kjISKTFmo8i0QMpy+0QINGm4fZzvNjRaG
         RAM5D+meCwswbwaqJHjxlP2XKWGRD/7tGF/riEou99QNj9wSm8tPlHldiKc3WcdcXVf/
         uZZNKm5GNjQ76zgF4tpPKcZNtzyp/LMotaZXy8WGZJUZV4VN79Xi8OHguT7b8QI6Sp+L
         AJaFpw7lfdSQ60w+YU5aSbw4nE8HuBoeLI5MiNp/kl8H04UQprjkN/tSwkdVSoaiSjMd
         Oob+rn/jrpmWeB1VkAbF/Z/UdF9ADMIxvC6QY6ja5VxouoM1p39HvVn/ja1AfzdJPdzA
         wAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swCARVHhCrCpWi0m0hXoSR+kJlH+uURNMzuGlvCBkOU=;
        b=Xmy25wSU1ePPyqZPKwg+4HdslSf9WSd9zoLkOl0EDGgvfdmCO8198PTL5txy/LbYDO
         0Ot1/H2cY/S65757hdr2CdFeASh7vgZeKy6875SoAJTc29AXs5ipOrpa5XWrYjVgBzfY
         PkODVNHxhBRPLBVHF/a3/KOsc3J7L8P7ZRSaLQDwAnZTu7PHbLY8Nel7Td/E0lnueTtW
         gnzWtFoXpjhdxspyHTBRAV2cRoi90vyryWP4VAxvpa1kCO3dC379BgJl5Owhddzdu9Km
         AEs05sYFQBhZbOOdizA+TCFaR2RSHygvfWd7SKYSlRdyB49Z3qXOPR27Xt9LMjBNH0sH
         DcoA==
X-Gm-Message-State: AOAM533LWRjpoUmA2f4p3kx55RJouosj9GM9vPhpQsuW3V6xTrqwlap4
        ESGW/11Rc795uPuYvy5QcTj5bDzn33IKELgsi8zSt62O
X-Google-Smtp-Source: ABdhPJzY/W56YJtQNo4xsfub7t1wxI596I4LQtUIoNNzG1P13Ufznlx82dqov2Xax65cVODriuNarLky01bLd0OI3Ys=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr2552687oia.102.1593179352641;
 Fri, 26 Jun 2020 06:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200624115539.GA8680@ogabbay-VM>
In-Reply-To: <20200624115539.GA8680@ogabbay-VM>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 26 Jun 2020 16:48:45 +0300
Message-ID: <CAFCwf12oLixsX_Nz0RsXh_orD5iW4uyXMwuWDxQjfkDJgLQ3yw@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Pinging you about this pull request to merge for -rc3
Thanks,
Oded

On Wed, Jun 24, 2020 at 1:49 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hello Greg,
>
> This pull request contains important bug fixes for the GAUDI code that was
> just merged. Details are in the tag message below.
>
> Thanks,
> Oded
>
> The following changes since commit 8c289ea064165237891a7b4be77b74d5cba8fa99:
>
>   mei: me: add tiger lake point device ids for H platforms. (2020-06-23 07:55:47 +0200)
>
> are available in the Git repository at:
>
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-06-24
>
> for you to fetch changes up to ce04326edd59d7902d7ef3a9d853864096e0cd1a:
>
>   habanalabs: increase h/w timer when checking idle (2020-06-24 12:35:23 +0300)
>
> ----------------------------------------------------------------
> This tag contains the following fixes for kernel 5.8-rc2:
>
> - close security hole in GAUDI command buffer parsing by blocking an
>   instruction that might allow user to run command buffer that wasn't
>   parsed on a secured engine.
>
> - Fix bug in GAUDI MMU cache invalidation code.
>
> - Rename a function to resolve conflict with a static inline function in
>   arch/m68k/include/asm/mcfmmu.h
>
> - Increase watchdog timeout of GAUDI QMAN arbitration H/W to prevent false
>   reports on timeouts
>
> - Fix bug of dereferencing NULL pointer when an error occurs during command
>   submission
>
> - Increase H/W timer for checking if PDMA engine is IDLE in GAUDI.
>
> ----------------------------------------------------------------
> Oded Gabbay (3):
>       habanalabs: block scalar load_and_exe on external queue
>       habanalabs: rename mmu_write() to mmu_asid_va_write()
>       habanalabs: increase GAUDI QMAN ARB WDT timeout
>
> Ofir Bitton (1):
>       habanalabs: Correct handling when failing to enqueue CB
>
> Omer Shpigelman (2):
>       habanalabs: use PI in MMU cache invalidation
>       habanalabs: increase h/w timer when checking idle
>
>  drivers/misc/habanalabs/command_submission.c       | 13 ++++++++
>  drivers/misc/habanalabs/debugfs.c                  |  4 +--
>  drivers/misc/habanalabs/gaudi/gaudi.c              | 37 ++++++++++++++++++++--
>  drivers/misc/habanalabs/gaudi/gaudiP.h             |  3 ++
>  .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  3 ++
>  5 files changed, 56 insertions(+), 4 deletions(-)
