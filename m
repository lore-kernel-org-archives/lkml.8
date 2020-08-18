Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B340320639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB7njDfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRJaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:30:07 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A7C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:30:07 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id y134so11040692yby.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=481phWAt8mWnm/w37igX0FBuMwcl7pH6Y12b99av8uM=;
        b=iB7njDfkGMWSB25RqCTukPDN6G8BUqT8FDIKPbEpQC0PPxPKPgNd8/0ZoLApCGD6ue
         XnS3FZJTv1c66qJCmonlcde0qkn6fnGDolHBy4V4Iy7tRB5/nvEa3ADjeE6r1OeL48iU
         bZm6hPBgkSg4uRDECLSbVnYWMtpvFFDbrSDHHGibZZOWZTeiklukC2lU14Zyk2rNFlHz
         dnAUmQDjkrhjT1TdxXFGbYRAJLch4zTWjKgr88wZaXB03+Co74Q8FMdnvvjXDAizqCSs
         Hw/G7Zg3SD6lJtnXyxAH74PdHYt4wZhmUPhRSGUqVf5nsS1UkbhyCIYnmbhEFumURfnd
         etoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=481phWAt8mWnm/w37igX0FBuMwcl7pH6Y12b99av8uM=;
        b=q/vmiY+Mh4wFpxhhkyMOYwAX4CKQiYebl0JhOM6dXu922K/3pIsQ8VT/8MeoMz9UKM
         D76nNC/IPutU7ou6dJNht7kxUfZbkpEpTU+0MkZQHkJDGPkejAEFYDF9rK/S4PnvAozB
         dyWYivi7F/z0eV7X7Kq3lqOBY2xMPh8uTYBw8rqWLnBgvnOVZNpDmbZLIMxPc2FtYmF+
         6Z3xQAakWyfLiqlZiJbROX7Xd2xaM86g5o892168f8bf7/YlhtqnuwKoitPa5HLFp6he
         SVRk0vq2nHtzEnVHyuXP9OWMD1LtyMsNXupZ73C8qZBNpZjapmXvztbCqHIBVvsXExeT
         qaMA==
X-Gm-Message-State: AOAM532Y8uendKYM2fPck7Ivj5s5+gSP+qnF3dhCdEwEccPZtgKPdzFB
        WCP+zg46JfDGF0sfMO1JiSkXOvqHWUT6vMK+5qo=
X-Google-Smtp-Source: ABdhPJxM39/++p6F5f8iE4zXgPZAJlZZwZ9z86P+Ell1ALaX6vv0I5U7iT8v0iQCnIO3MMPqEkRjotqjVYYM6yDylkc=
X-Received: by 2002:a25:3b0d:: with SMTP id i13mr25465799yba.314.1597743004557;
 Tue, 18 Aug 2020 02:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com> <edca7c9e9a8934fc66d09c7056e92a6aa7f0d645.camel@wdc.com>
In-Reply-To: <edca7c9e9a8934fc66d09c7056e92a6aa7f0d645.camel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 18 Aug 2020 17:29:53 +0800
Message-ID: <CAEUhbmW6S2TG14w0smXQ6foZvmSfVvcdYf4kgkLwT9ivXV+m0Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bin.meng@windriver.com" <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:39 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Wed, 2020-07-15 at 21:39 -0700, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > This adds SiFive drivers to rv32_defconfig, to keep in sync with the
> > 64-bit config. This is useful when testing 32-bit kernel with QEMU
> > 'sifive_u' 32-bit machine.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>

Ping?

Is this patch applied anywhere? Thanks!

Regards,
Bin
