Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC748C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A5120855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Wh5GOcai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHGIxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHGIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:53:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 01:53:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so1349179ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FGWnMv3Ra19uyn9AeOMIZCjrthqxBwjXKI+/nqj324=;
        b=Wh5GOcaifky54Z0qvkUeHFxg4l6hxxPVxyMNzLfFd+JZdNm5kBkLJzYa0vKm3Myz3p
         p4vxnOG/3h2NE9YQ9plmXzFRsHXZ7qxhVZCPViXuh3oIWgzk3NDoMju0C1bePkzmV3E8
         9xeCfFbwFn+FiFOeltHwMD+7BeUiz7+76iCbsHcx6cbo62xiAvMi4tebmR4Gm32XqTG3
         ZzlLefC7wjerYHpaziffpGq6cSxwvFPMu8HoPWuaT9xRoyiFTOdw7glN8ocYZ054vDlh
         7yq0Cp6ypUXOvVXDDLq9HpGttUu5TGdyKIu/LVwh3hIAxXpryqzAKWguPGrMehIcZJv9
         Nh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FGWnMv3Ra19uyn9AeOMIZCjrthqxBwjXKI+/nqj324=;
        b=GDfkVacQO3OVvt9m0OabllOoBSkqOnzH/B2WWGE9kiOATYAOnJpJIqRd+SEkk22bNM
         leIfaP7m8zoHPDw2fR507PIz5LoeOkcJVgHKACsWOoKWH5n631de2dNVOr4q5yu8BPqy
         jEc+vLm7DJlSbMaf0nn4SZA6h+R+oZZamVMEv9yyp/9yUiOBP2ZZEHiz5BYpKYnCdEBr
         vYzGdPG9bwQ7Ak/A9m8+0v9A8fephYEd3AqOyDOf5TZGR0GGVgc5oGaLFolO2YzsF9Y3
         s1uMwGtXipJnnA/EMZjTOXfqMUt1qQC7O57iNXTXCfQDAGGhRpM6MDB4GxGd6PGeXAvi
         hh8A==
X-Gm-Message-State: AOAM532LV0KBMZHve82WwYOFFJFa83JxFKH/lWVfznaZL290IUybx1k9
        qbRsQV6e0xIWd+VfPX1xmE6cV7vyONj9ShNp+Amd5wuW
X-Google-Smtp-Source: ABdhPJwqNVj6y5QwfXGcMVHxInI7wVfNpkbo123V4cqKumR5s4fH+faLV4b2UpJjLlEafDEwwON+Da8q7rwcR8sHcw4=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr5415222lji.292.1596790392713;
 Fri, 07 Aug 2020 01:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200806073221.GA219724@gardel-login>
In-Reply-To: <20200806073221.GA219724@gardel-login>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 7 Aug 2020 10:53:01 +0200
Message-ID: <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
Subject: Re: [PATCH] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lennart,

Thanks again for the patch, I tested it and it looks good to me. I'll
also add a test case to LTP for this. Two minor nits on the patch:

On Thu, Aug 6, 2020 at 9:32 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> Let's correct that and propagate the flag in LOOP_SETSTATUS too.

Think you meant LOOP_CONFIGURE.

Also, could you add a "Fixes" tag, like:

Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")


>
> Signed-off-by: Lennart Poettering <lennart@poettering.net>
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
