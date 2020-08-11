Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B81206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SLDbdUHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgHKGtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgHKGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:49:17 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:49:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c15so6072259lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kY/rAV0FJYGk7hx9T+47Qz9NsD26rE8fB4kuCHrX6E=;
        b=SLDbdUHcx8Lz3amorc2vV3mxnoUv4wH2iuha7x9WLywq6ZddK3UliJ7LIBWHIbZC+K
         RC9SspyrF/1/EMS1BmKW3LJBtvbtjre/pIQnVt5tvJv4G8KkhCSQl+SiQ5QWLFqP8dFz
         +GQMiCaxXytENslyPSE0MYthAbne8eLrBNZBEMepnEaVoVQCHIiiRshA3Xq8P+M4/keW
         vEH3ntVlCgaCpy0Tk9s5IJW/yplzt0O6V5YcrNhRVStYlgEEovMPgw7lhSLDQoigNt4Q
         31Xj5akw+VcjbZCnpYqD7iOypB1xqVtYidW/WxjudZ+mO2Zo4K3PohnMzHZ7MCenzYk9
         LVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kY/rAV0FJYGk7hx9T+47Qz9NsD26rE8fB4kuCHrX6E=;
        b=BLr6+KL/M/kMP7sOBW3v4ES6R5WiupVcGlW9CKtrbQHBsSIhd1Ep0rVsVPJZrdV6Ew
         CEFsiuyjiFRv3qS0ok8t3ga4QrnKOMsZwFyeYbMXqOdGy/4qOrJREWZesUFkVlVYOvOk
         MEzXXRd5horPUtMkMkvS1EUb8eQrbJtOGM0OMv1CjXCFGKMMv0YvRba6tdkKZs9rvYwG
         2tzpCicQ8IUYPNI1RU9ZF3+zzOmKpiWJ0kB2aH1Dj4Nlb1o5IHJNlLxr3EcNZ354EEQz
         alaX2n6fA8va6QUFVuHmcJHAJnCO/V6ZAvMQvpSKIm/yg2scDXYFhiIQLkvJFdKc8sdJ
         hd1g==
X-Gm-Message-State: AOAM5316f8e7g9LetUwP29Kd36ubjGkmLh96YG2qH/5PYjpi0Q2ZqahK
        9Tfw804Xe40wGbP+jJSyYeyFCoocOnqqepAFoOyEog==
X-Google-Smtp-Source: ABdhPJyLtARnZ3K9/59qQ4VYxXQRcLwc9q1XYmD2L2XRFFOYonKc0xemwpkqefBElS2O5CQKxOWALMkJ9U7/CjM/5is=
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr2460052lfr.17.1597128554916;
 Mon, 10 Aug 2020 23:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200810171632.GA226564@gardel-login>
In-Reply-To: <20200810171632.GA226564@gardel-login>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 11 Aug 2020 08:49:03 +0200
Message-ID: <CAB0TPYE-_ErKTqveFW-3Gpb8=ayoy3okyhkeScKi7r5rmLzp8A@mail.gmail.com>
Subject: Re: [PATCH v2] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 7:16 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> When LOOP_CONFIGURE is used with LO_FLAGS_PARTSCAN we need to propagate
> this into the GENHD_FL_NO_PART_SCAN. LOOP_SETSTATUS does this,
> LOOP_CONFIGURE doesn't so far. Effect is that setting up a loopback
> device with partition scanning doesn't actually work when LOOP_CONFIGURE
> is issued, though it works fine with LOOP_SETSTATUS.
>
> Let's correct that and propagate the flag in LOOP_CONFIGURE too.
>
> Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")
>
> Signed-off-by: Lennart Poettering <lennart@poettering.net>
> Acked-by: Martijn Coenen <maco@android.com>

Thanks, still looks good to me.

> ---
>  drivers/block/loop.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d18160146226..2f137d6ce169 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1171,6 +1171,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>         if (part_shift)
>                 lo->lo_flags |= LO_FLAGS_PARTSCAN;
>         partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> +       if (partscan)
> +               lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
>
>         /* Grab the block_device to prevent its destruction after we
>          * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
> --
> 2.26.2
