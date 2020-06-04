Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69922067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUAua5qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgFDVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFDVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:12:36 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36130C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:12:36 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so4372581vsm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/2vvNqjDrDfa9zj4WkpMzbskQTo3mnO0g8KBrFA7s8=;
        b=CUAua5qV8xF2sA5jNCA2iEaVCwy8+VpWn+NmTfcE6rq0kqEpaokEJWOgU5rdPmU2g7
         1Vv5n3TRANrrPNT8DQXFfzcsyspUq7QIQNzjXHwb51Ovp3FYXom9Bk6Tt9wDXsmFiYI3
         sQsGqUR7iG/5s865l6vTA02WgDgK6RP0D8h7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/2vvNqjDrDfa9zj4WkpMzbskQTo3mnO0g8KBrFA7s8=;
        b=bz7PTPsrYFUi57dAvva8OO/MpgR1ti8YbfrpHGfYIXq/158tw+LZHATOWZ7VAX0R/g
         5GKg5TnqD9IRa5SfD1l3yNbPicVSKyY/MvXzRk+v2pROo9wAQVPVqdEi8FFTeFtgN1TP
         J87XYs0C0jTnkFU2mgD1LmN0srck8nbTxhOOZZtcJbUvwFYlFaCdD6c1Uk7+Urz5ZT7I
         ZzBDjAmFrcgQ37CytYgg4bvZWI72iL1UPXX6eitlVtG9cK8bCfp2n2Em3uAdnWeZQYm5
         OOhMh6JVZa0yNAU5KFnY9l6kJ5HksxymrKMF7poS+bNTBnweFnB6/SlBDi7WSRBXdDw5
         qvrQ==
X-Gm-Message-State: AOAM531nFLXkpgEOip/mAa4DWwpkO1k30fGn8vSd9zScN/oCgN5jR5vS
        tZYG60yNCAl8exK8HriGT1Uj1OcBiXg=
X-Google-Smtp-Source: ABdhPJxnS2HnhpSELozguuVLsLD2b1i80fzGZRhU0bm7CWM9L1CybFT8bMWNORxDKADhXJXCTsCDVQ==
X-Received: by 2002:a67:1dc5:: with SMTP id d188mr5131206vsd.103.1591305155043;
        Thu, 04 Jun 2020 14:12:35 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b21sm418256uap.15.2020.06.04.14.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 14:12:34 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id g44so2229219uae.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:12:34 -0700 (PDT)
X-Received: by 2002:a9f:2804:: with SMTP id c4mr5242531uac.8.1591305153580;
 Thu, 04 Jun 2020 14:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org> <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1591264879-25920-5-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Jun 2020 14:12:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URj6UiZgH_g3twcYgv=USGr7YUV5SkW3J-WYR1vs+MDw@mail.gmail.com>
Message-ID: <CAD=FV=URj6UiZgH_g3twcYgv=USGr7YUV5SkW3J-WYR1vs+MDw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 4, 2020 at 3:02 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> @@ -433,7 +432,8 @@ static int kgdboc_earlycon_get_char(void)
>  {
>         char c;
>
> -       if (!earlycon->read(earlycon, &c, 1))
> +       if (!kgdboc_earlycon_io_ops.cons->read(kgdboc_earlycon_io_ops.cons,
> +                                              &c, 1))
>                 return NO_POLL_CHAR;
>
>         return c;
> @@ -441,7 +441,8 @@ static int kgdboc_earlycon_get_char(void)
>
>  static void kgdboc_earlycon_put_char(u8 chr)
>  {
> -       earlycon->write(earlycon, &chr, 1);
> +       kgdboc_earlycon_io_ops.cons->write(kgdboc_earlycon_io_ops.cons, &chr,
> +                                          1);
>  }

The get_char / put_char functions are pretty unwieldy now.  If it were
me I would have done:

struct console *con =  kgdboc_earlycon_io_ops.cons;

...and then used it so the lines didn't wrap in such a terrible way.  ;-)

I'm not sure if I'd spin just for that, though.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
