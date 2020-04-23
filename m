Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256BEC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F050520784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0/OP9DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDWVXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgDWVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:23:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45727C09B042;
        Thu, 23 Apr 2020 14:23:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so3631514pfg.2;
        Thu, 23 Apr 2020 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUMoGhY5L7Ce12qPN/+ZvR9RdaPKROuCE+nbwYYQZjo=;
        b=s0/OP9DDA3gkPf7NIb24mAh7l/E0qodqA1SOp9ziVmNnIO9fT1oyN0LqMv9o8L6cen
         aeolu96fv+P5eTrlCkNWKxCnSM5ynJO+jOCCnD876QvT1ehFUguZKa+fBN6STq19O97O
         CiSJHOHTJcGiurWOmlLB1qHssbx4D74cfm9x0/fQS+rfmkru01P064qg/bnR3v4epEQh
         TCORYK94sO0/9w08wp1/9p2v3kB56BoaHNZ3XLFvV8JaQAZuRa/mzaLQxwyDc972iOBO
         WbiNhpWsdPTip3BN3vU8Tdlk8uVXTq3w4rfWnC8/sBaX1OCT5xwnSys8Ir+UFqeGjNhP
         UBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUMoGhY5L7Ce12qPN/+ZvR9RdaPKROuCE+nbwYYQZjo=;
        b=TQwToyJeYmiT2ZtTVZidyFTZsAlLFe/NWujXuoZvyUQ7Qe7ia97FXH8FXgknk+HLpq
         EjY7UUBfNVZDqdDqCR8r7KzOfxuscBQEsOYPrBYcOC9eJ4cLgNaUYeuhEEs4R7mywiZN
         3LNjO1R/OWekN+EI19ySu60eIFQynWooMip/53zRH4rjGD5yVXrCllCY4kVNA+g1NznW
         GEWCWGKP8qsd3OsFGChB9NM9lg+sfrjTFJ/k0xgzpY6hS/rQ3rdpGVQR7C7rtgSPEUHN
         l1zHkEPhQliIV/W5Hc6DU5M/AgtuRgG/qVUwb3baeN1rNrWn2KAbKKB7+6ltk6sFW48K
         B9vg==
X-Gm-Message-State: AGi0PuZQKh3xgRI5fghPG68I3P+E8sRwyHRe9JBHkzXqYYq/+aQq6OsI
        jVuwTgLbk33+64iqTj92ZO9JYoUruXIghP++dSI=
X-Google-Smtp-Source: APiQypLtTkISyuDrfh11O88zSEDSw5J46od7eHcJ6QRa2ED7NGyRC8Qv79IS5r4EZ/IHXaEND1Yvqmh+MsIkorv+RlA=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr6033217pgb.203.1587677023745;
 Thu, 23 Apr 2020 14:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200423164251.3349-1-zhengdejin5@gmail.com>
In-Reply-To: <20200423164251.3349-1-zhengdejin5@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Apr 2020 00:23:31 +0300
Message-ID: <CAHp75VdSv4AooA-hrgoQH-qs_8woFbzHJH99AKrYUrwae7xoZQ@mail.gmail.com>
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak related
 system resources
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, akpm@osdl.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:42 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> A call of the function do_take_over_console() can fail here.
> The corresponding system resources were not released then.
> Thus add a call of iounmap() and release_mem_region()
> together with the check of a failure predicate. and also
> add release_mem_region() on device removal.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: e86bb8acc0fdc ("[PATCH] VT binding: Make newport_con support binding")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v2 -> v3:
>         - modify commit tag CC to Cc by Andy's suggestion.
>         - modify Subject 'console: console:' to 'console: newport_con:'
>           by Bartlomiej's suggestion.
>         - add missing release_mem_region() on error and on device removal
>           by Bartlomiej's suggestion.
>         - add correct fixes commit, before this patch, add a wrong 'Fixes:
>           e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")'
>           thanks Bartlomiej again!
>
> v1 -> v2:
>         - modify the commit comments. The commit comments have some more
>           appropriate instructions by Markus'suggestion. here is my first
>           version commit comments:
>
>           if do_take_over_console() return an error in the newport_probe(),
>           due to the io virtual address is not released, it will cause a
>           leak.
>
>  drivers/video/console/newport_con.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 00dddf6e08b0..2d2ee17052e8 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -32,6 +32,8 @@
>  #include <linux/linux_logo.h>
>  #include <linux/font.h>
>
> +#define NEWPORT_LEN    0x10000
> +
>  #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>
>  /* borrowed from fbcon.c */
> @@ -43,6 +45,7 @@
>  static unsigned char *font_data[MAX_NR_CONSOLES];
>
>  static struct newport_regs *npregs;
> +static unsigned long newport_addr;
>
>  static int logo_active;
>  static int topscan;
> @@ -702,7 +705,6 @@ const struct consw newport_con = {
>  static int newport_probe(struct gio_device *dev,
>                          const struct gio_device_id *id)
>  {
> -       unsigned long newport_addr;
>         int err;
>
>         if (!dev->resource.start)
> @@ -712,7 +714,7 @@ static int newport_probe(struct gio_device *dev,
>                 return -EBUSY; /* we only support one Newport as console */
>
>         newport_addr = dev->resource.start + 0xF0000;
> -       if (!request_mem_region(newport_addr, 0x10000, "Newport"))
> +       if (!request_mem_region(newport_addr, NEWPORT_LEN, "Newport"))
>                 return -ENODEV;
>
>         npregs = (struct newport_regs *)/* ioremap cannot fail */
> @@ -720,6 +722,11 @@ static int newport_probe(struct gio_device *dev,
>         console_lock();
>         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>         console_unlock();
> +
> +       if (err) {
> +               iounmap((void *)npregs);
> +               release_mem_region(newport_addr, NEWPORT_LEN);
> +       }
>         return err;
>  }
>
> @@ -727,6 +734,7 @@ static void newport_remove(struct gio_device *dev)
>  {
>         give_up_console(&newport_con);
>         iounmap((void *)npregs);
> +       release_mem_region(newport_addr, NEWPORT_LEN);
>  }
>
>  static struct gio_device_id newport_ids[] = {
> --
> 2.25.0
>


-- 
With Best Regards,
Andy Shevchenko
