Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE829C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9654820659
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEZfD6c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBMCCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:02:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34461 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgBMCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:02:37 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so4687602iof.1;
        Wed, 12 Feb 2020 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNctVHQXMHRMoLVHSnQu0meBGnR1Lkb/YWbGwQhQKXY=;
        b=oEZfD6c0cXQISVAJtbLhL96sNT9nGk93VWwf13BYufaRBk0UiEL9bkUxdnt2YCKGeu
         qF5JhTN9cxHQ/xZIHZlpyFNI4hOas/fiwX/H6fiIqLeh0n8twoIX6eqxyqX+OJ85q+By
         BpyXH0IKtwb8+G4ssC7sebZYEWTGDP3K3rT8+XJkFPmd4rQ8WimhZPKhaAgiVnxztya/
         ArwEioUkb12Dsb2zJgdMG0anxTeBsJXo70/9g/HblXtgVJZe1kgsaq8Q/uv6kOF68b82
         1ke9fGmOETf/0cCJJaCyIl3X7I0GUO9fIsDjyRpKl/MaZ1Sw/UATl8YpV/oQMSumuO5z
         L31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNctVHQXMHRMoLVHSnQu0meBGnR1Lkb/YWbGwQhQKXY=;
        b=osxjrZM19lTGxG7r44xGuDCEr7sTCKeRqCEfoJktAToUHAFqyrkDl+tpM3WM/ZwNvQ
         IsQdoZPVEzku1DzqTdWVLhqs+HUDBbWs76UiPbbD+EjeeUHEJW1FieuOjGPB7DaIwbyp
         UOKhMD9K7V04J0fpm7kU3+ZzYzpZgGa+Q5+NssQN17hOprCfK7uZeGH4v/BRJ+EwlDqP
         K0To+NpAmGwCajI0ytqJfwPyNlnBwAwFZr77gDRpLrklUH6umeNxbbZ6c3XvjKgESGzS
         sRK1OQv5/6OLuqpV2Q4+ZJOqMMxOKqWM5EiIgNKhrTEY8Us6kFE0RaBqLu2uHiR5h/Fu
         uyuw==
X-Gm-Message-State: APjAAAV/7bKiXDTOPNhVmr4GzaTlGLPTr4DUTOhrxqP013icSktMYS+/
        14aJL38urbAdFQuefZpbD8UTEvIviQXYlHpWM0M=
X-Google-Smtp-Source: APXvYqxRLFhg7y/Ul+Ohfd1JDI8e5yvBFMQhWXHpXwwW9UL1nvuKxDSaN0zFwBWZ/FoUQJkD5MKh126lxnk+I4pHGk4=
X-Received: by 2002:a02:c856:: with SMTP id r22mr20946779jao.67.1581559356960;
 Wed, 12 Feb 2020 18:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200113051852.15996-1-samuel@sholland.org> <20200113051852.15996-3-samuel@sholland.org>
In-Reply-To: <20200113051852.15996-3-samuel@sholland.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 12 Feb 2020 20:02:26 -0600
Message-ID: <CABb+yY2MJ-1i0K7XVkPT3+6ac1XR9-3zf-GDNeswOMp6Zn_Ufw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 11:18 PM Samuel Holland <samuel@sholland.org> wrote:
>
> +static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
> +       int n = channel_number(chan);
> +       uint32_t msg = *(uint32_t *)data;
> +
> +       /* Using a channel backwards gets the hardware into a bad state. */
> +       if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
> +               return 0;
> +
> +       /* We cannot post a new message if the FIFO is full. */
> +       if (readl(mbox->regs + FIFO_STAT_REG(n)) & FIFO_STAT_MASK) {
> +               mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
> +               return -EBUSY;
> +       }
> +
This check should go into sun6i_msgbox_last_tx_done().
send_data() assumes all is clear to send next packet.

.....
> +
> +       mbox->controller.dev           = dev;
> +       mbox->controller.ops           = &sun6i_msgbox_chan_ops;
> +       mbox->controller.chans         = chans;
> +       mbox->controller.num_chans     = NUM_CHANS;
> +       mbox->controller.txdone_irq    = false;
> +       mbox->controller.txdone_poll   = true;
> +       mbox->controller.txpoll_period = 5;
> +
nit:  just a single space should do too.

Sorry, for some reason I thought I had replied to this patch, but
apparently not. My mistake. Do you want to revise this submission or
send another patch on top?

thanks
