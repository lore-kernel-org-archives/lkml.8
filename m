Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6367C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989C6207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD54b2vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMOwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:52:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35268 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:52:04 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so8390530ild.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YX2j6/aVYY0oyXSlbbCOKmU+Ff+R7PXUUFucGLtqEZc=;
        b=pD54b2vF0OL3APyGS2FYWquHYvbSHt2+mDz0qqZYJVJKS4xrJEU3kGi9UQAQui03aP
         oPxoThY+/eB3UiBL63ipXM0eyzZW8Yg0WvXiVe14BeqC2dBJOMA1D13T+viEgaShwfCC
         3+jdDcJxFZ9PUdbfKr5VlpJoAwdcMnZ8RbUGYKR8e8sAW6tmzASNLJWHVEsPQXp7FuSM
         gr4Emm85qKxkNitHkdeoE4GZSIEw92HAjxpXIDhle9/Mu6BEsx/pllKJnyvmPECsU9/K
         v654FIVxSz5HuaQOfKF55qNMUIQyTqQ6Sm0Sg4m+MEW4COFiwkyeZoTAYhDgwE7NjKT2
         LXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX2j6/aVYY0oyXSlbbCOKmU+Ff+R7PXUUFucGLtqEZc=;
        b=Vq7jVDWjFZZMOBnjv+4VyEETmNqkkJk2/E3blcmbOEl81CD2XxUWhpTo1veIHH5nGd
         KO9qHmvnvaVIMVCsnISfBjVtoZLuJ0j7WXPB4TZWPkv98tLkHrwcN63BOKBp6DAvcX8z
         5PWfMYnzrcyGd0VON7f8u4sR0jOjoy6DZ6cD7/tTsnBoaxnpJUTQOAOU9wfUmcXz0KK3
         t8r4nJ2uTd13qiDl7T+fp35iINOCul2NU1+vWM+lu/0PxHwmig66CvGa4d1cA88oZ9HM
         xeZJy7Ux3gVAcQypjX0+S7+R3bmJ10GSfb7sSKTJBn44ZH8hk4Hk1Z0Z++FZKscZJs5N
         aZtw==
X-Gm-Message-State: APjAAAV+NiWZc7avxvHJb1fp19XiUfQs21Hw9jYnsezJb1MtmB8Hcyhh
        oVYcM7FOB+iFsJztueN+nNp8LL6CJIIp2A8Mtw1uinFw
X-Google-Smtp-Source: APXvYqyt+vEO+HWXZFJbDJmsViNsAKH88qGkQ/e/5oAuQgR33TSr56D6tCedpeUHpa+P2JqBu9+hmpBQr0J05fwog3s=
X-Received: by 2002:a92:390c:: with SMTP id g12mr14496630ila.246.1578927123873;
 Mon, 13 Jan 2020 06:52:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578789410.git.robin.murphy@arm.com>
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 13 Jan 2020 20:21:53 +0530
Message-ID: <CANAwSgTTx3TvtxWgp1E3LW15ejc06v7jiKg7xg_95GwuuVtb+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-rockchip@lists.infradead.org, Soeren Moch <smoch@web.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Sun, 12 Jan 2020 at 07:25, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi all,
>
> Here's a second crack at my RK805-inspired cleanup. There was a bit
> of debate around v1[1], but it seems like we're now all happy that this
> is a reasonable way to go. For clarity I decided to include Soeren's
> patch as #1/5, but since I've rewritten most of my patches I've not
> included the tested-by tags.
>
> Robin.
>
> [1] https://lore.kernel.org/lkml/cover.1575932654.git.robin.murphy@arm.com/
>

Despite the i2c warning message  it performs clean shutdown. So Please add my

Tested-by: Anand Moon <linux.amoon@gmail.com>

-Anand

> Robin Murphy (4):
>   mfd: rk808: Ensure suspend/resume hooks always work
>   mfd: rk808: Stop using syscore ops
>   mfd: rk808: Reduce shutdown duplication
>   mfd: rk808: Convert RK805 to shutdown/suspend hooks
>
> Soeren Moch (1):
>   mfd: rk808: Always use poweroff when requested
>
>  drivers/mfd/rk808.c       | 139 +++++++++++++-------------------------
>  include/linux/mfd/rk808.h |   2 -
>  2 files changed, 48 insertions(+), 93 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
