Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73CC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597022467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582736859;
	bh=hdBOrNvqms6LuHkKaNu6g1GZnlXtrzXpNgMmojjUAoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=My4RA9Zepq7XlGE7AZUTjNKwQ2RFRyyZ52tgkp8gMxiv9OwwzPmlRkX7xq7izkA5X
	 AfDKFZjJ/KCdDyUeC3nyAW1R6K25YVbF9dS7demScVgnELlWj6JOQ7Idegm3x0Pe14
	 TrkcvoYQZq5orEe94WjvkG5XQjBIHQQGrGWgBRuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBZRHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgBZRHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:07:37 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E962F24683
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582736857;
        bh=hdBOrNvqms6LuHkKaNu6g1GZnlXtrzXpNgMmojjUAoU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bzckcxKBmI/41g+OQgQVT4JyCXrpKENm0o4X2kIZxb8b7Tq0Ju0jpRG4fcAQOdYBr
         em9Jx5NQojxt+gALqKJPJBcTbxAlPk9pu5yyaWvRtcaoKWLlJHHS5PFwD4W+hCT61C
         mjM3Q6lS9TwA5hp0O5wXYjKHUcEu8XFZpG7fm7fE=
Received: by mail-wr1-f50.google.com with SMTP id j7so3959322wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:07:36 -0800 (PST)
X-Gm-Message-State: APjAAAUIBUgg6r9bIjW8ZLfeJS1HdcrCSL/cB03z81iE/8vVpC+X9K0T
        jol2RdBJTFvlLkjRTS3cgCLn7uF9G6ef4lkd9PXwyA==
X-Google-Smtp-Source: APXvYqx+iElQIGWBKUiundYdfvD86tWpE7osPnNNLRATKnU/zrwkEUsr7nY9Tn2lBt1Hkf0xS0YZvAhu9gwG/tuHw0c=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr6703799wrw.252.1582736855337;
 Wed, 26 Feb 2020 09:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20200223221324.156086-1-xypron.glpk@gmx.de>
In-Reply-To: <20200223221324.156086-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 18:07:24 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu84RKGFxFSGra__NbsYVLzu9TH7C+b02e1GxEbo5zyHFw@mail.gmail.com>
Message-ID: <CAKv+Gu84RKGFxFSGra__NbsYVLzu9TH7C+b02e1GxEbo5zyHFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: don't shadow i in efi_config_parse_tables()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 at 23:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Shadowing variables is generally frowned upon.
>
> Let's simply reuse the existing loop counter i instead of shadowing it.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued in efi/next, thanks.

> ---
>  drivers/firmware/efi/efi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69a585106d30..d0c7f4c1db31 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -553,7 +553,6 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>                 while (prsv) {
>                         struct linux_efi_memreserve *rsv;
>                         u8 *p;
> -                       int i;
>
>                         /*
>                          * Just map a full page: that is what we will get
> --
> 2.25.0
>
