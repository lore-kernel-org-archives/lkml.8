Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75268C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2B20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyYeaN+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgE3UZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgE3UZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:25:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84DDC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:25:15 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p5so4707284ile.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVDEQbxJRqHCD6C3XLRhpTACNyer8e0/jr8G0oUIeZk=;
        b=fyYeaN+eWlQGPYfpfbnHxFirFwfQD0kFI453m18Vcfetpoxgx5C/h5ljTsnWjc/06I
         BlAhjxArEV8sGNCtU0d0WGhDW/Rs6lVqvHDXDqXX/A2Qs8hDXd/VuG4ZfrE+aUsVA/Uo
         mnTIDpKkKy6ickZT/wPfdlhB2wSQ3+QzluzE/JTc6RrtilgrWVZIrKfuFjG+bS+vII+F
         SfRa2rxZOB7LZtcjVXeTbY7+t/YFbhTV13vbOcsE9PkphFHkOj/O/Q4tsF8bApun9sEI
         7X9Cw62iOTxhph1HII3upgsgEWvXg1duRfGtjfiRSgJLBFaVP+mTv+leD3dr0rrfISSt
         zo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVDEQbxJRqHCD6C3XLRhpTACNyer8e0/jr8G0oUIeZk=;
        b=Dkp/tXtyj9rdUpoWouHWNdcNPkQeZSRQLCLl+9y86tWr749qunhx6Uyep7k5CqFvsX
         NnFCoei3wLk+7OD1SOGfyaqtyTa9oY2fAi0/1ChrIH6lvB+2WYJWkYGq86UPRleFci/J
         IB85u8di0aywYOqfG0cEU/9bqJ3eWhb15R088Akiia6bsHyUHjJuJw7zMb9E2U7puX5f
         OGWGB/1Hw8Pu96KGNhcc/ZNrKfFH0+hfa1lQB9AEuYyQbFTPoMQyZRyLs3gZLVjoOiLc
         UnSGMR7ickuqvSZzwMcZcTOft5On1fsndoXMeM7hmr3p6gL2xSxgXYuMbwCUisM3+2o0
         GMtw==
X-Gm-Message-State: AOAM533JiTrYIDH3BAflp5A2FcDt3SSgJtG57Zr8svuRBpTmgReHNa5d
        OrFkiAK0PPVomUhJMDtVpPYll41wkzazcaQa9WM=
X-Google-Smtp-Source: ABdhPJyY8pMeUvqgIC8mnhNT24EEBTNyTwienH/RJv1LLYfHieGe425z4ZytcB2rVSM9UazEm7Rc7V2As5AboOc/oco=
X-Received: by 2002:a05:6e02:1242:: with SMTP id j2mr13486290ilq.303.1590870314863;
 Sat, 30 May 2020 13:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200511055052.23868-1-joe_zhuchg@126.com>
In-Reply-To: <20200511055052.23868-1-joe_zhuchg@126.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 30 May 2020 15:25:03 -0500
Message-ID: <CABb+yY0qBk_BgexswYOaBf4qac605KBwYxah2yD4nYeADi8Phg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: no error log in mbox_client_txdone() for tx done
 by irq
To:     joe_zhuchg@126.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Zhu <Chunguang.Zhu@verisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:52 AM <joe_zhuchg@126.com> wrote:
>
> From: Joe Zhu <Chunguang.Zhu@verisilicon.com>
>
> client does not know and not care about how controller implement tx done.
> mbox_client_txdone() may be called when controller uses irq method.
>
> Signed-off-by: Joe Zhu <Chunguang.Zhu@verisilicon.com>
> ---
>  drivers/mailbox/mailbox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 0b821a5b2db8..116124adf188 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -189,7 +189,9 @@ EXPORT_SYMBOL_GPL(mbox_chan_txdone);
>  void mbox_client_txdone(struct mbox_chan *chan, int r)
>  {
>         if (unlikely(!(chan->txdone_method & TXDONE_BY_ACK))) {
> -               dev_err(chan->mbox->dev, "Client can't run the TX ticker\n");
> +               if (unlikely(!(chan->txdone_method & TXDONE_BY_IRQ)))
> +                       dev_err(chan->mbox->dev,
> +                              "Client can't run the TX ticker\n");
>                 return;
>         }
If it is not by ACK, client should not call txdone() so we shout
immediately. Otherwise something is wrong.

thanks.
