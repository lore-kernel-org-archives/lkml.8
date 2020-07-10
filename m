Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A584CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832132076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ILDYVm0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGJRrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:47:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:47:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so3677796lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/CMHk4w6+cNFzgYJXIzp3UU76Y8y9UeHEGOkUVbXTU=;
        b=ILDYVm0LcXLZZrfmAxtURkQprTX9skjAShvhFipQKJAKbFGyoFEeZfJniL4uh1sJtQ
         6GQsddyIJ/M36EE7v0/XiEEynwtBixNj1dz7zWXkp46lP3Sbmpdp/lJneh5gVSnuRIoP
         uDZ95SWe4tPPb6v31ajhDIGF2FUlWNiVlWd+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/CMHk4w6+cNFzgYJXIzp3UU76Y8y9UeHEGOkUVbXTU=;
        b=rl3Cu49tVxkL9WOTXYkVAcObu5RjIRQKg/LNai6ojRrKujAo/PAuDQ1dYwCkg5sYjU
         SXor94IQt01WpFz657ieCExxJrD6S3IHXqnWYNwA3h2QnD//SPsF4HFt/uNcG8G8ynb1
         8vfEDAkUq/eiPv9QwvHLngae7oqvvHRb2MuVz9Tul5rfX8hS0ytu8A/Stg2Js15wYRri
         qf4g6uWz5Sdu9kdY3fFLXpI+irQXfGjLiMtR8FyK/3XoO1lTv3vwSLkUUZtaPfJ7BLGX
         baPLw1oErXQrwzqGIeRPRI29kMCXc9RjBPmIzT4fSCFBUZE3b3xAX2o1RoA39ocE+4N7
         OLbg==
X-Gm-Message-State: AOAM5306LkAIuXDY5vr8ZjKozxK072ui3n2X7HlQ0M8aWqZ2bIXOqPQW
        dNFSOQPUzgHb6QX/qK6uTpjq91t8UX8=
X-Google-Smtp-Source: ABdhPJzmcWNZP3D/rIuLnAIW9QBcxwfOqxYmdGBYY8+wrNchYFNnrHuHTdpHxrFzbLOmMM7XbAP/SA==
X-Received: by 2002:a19:83c7:: with SMTP id f190mr44731849lfd.14.1594403219184;
        Fri, 10 Jul 2020 10:46:59 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e10sm2101663ljb.118.2020.07.10.10.46.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:46:58 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h19so7364747ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:46:58 -0700 (PDT)
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr42517426lfm.99.1594402767378;
 Fri, 10 Jul 2020 10:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200033.1528052-1-dianders@chromium.org> <20200626125844.2.Iabd56347670b9e4e916422773aba5b27943d19ee@changeid>
In-Reply-To: <20200626125844.2.Iabd56347670b9e4e916422773aba5b27943d19ee@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Jul 2020 10:38:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft504BAm2sr0S32kSO2xoQWhjrXLXa9+uqgkcPO6wjNhrg@mail.gmail.com>
Message-ID: <CAE=gft504BAm2sr0S32kSO2xoQWhjrXLXa9+uqgkcPO6wjNhrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: qcom_geni_serial: Always use 4 bytes per TX
 FIFO word
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.thompson@linaro.org,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sumit.garg@linaro.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 1:01 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The geni serial driver had a rule that we'd only use 1 byte per FIFO
> word for the TX FIFO if we were being used for the serial console.
> This is ugly and a bit of a pain.  It's not too hard to fix, so fix
> it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 57 +++++++++++++++++----------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 4610e391e886..583d903321b5 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -103,12 +103,18 @@
>  #define DEFAULT_IO_MACRO_IO2_IO3_MASK          GENMASK(15, 4)
>  #define IO_MACRO_IO2_IO3_SWAP          0x4640
>
> +/* We always configure 4 bytes per FIFO word */
> +#define BYTES_PER_FIFO_WORD            4
> +
>  struct qcom_geni_private_data {
>         /* NOTE: earlycon port will have NULL here */
>         struct uart_driver *drv;
>
>         u32 poll_cached_bytes;
>         unsigned int poll_cached_bytes_cnt;
> +
> +       u32 write_cached_bytes;
> +       unsigned int write_cached_bytes_cnt;
>  };
>
>  struct qcom_geni_serial_port {
> @@ -121,8 +127,6 @@ struct qcom_geni_serial_port {
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>         unsigned int baud;
> -       unsigned int tx_bytes_pw;
> -       unsigned int rx_bytes_pw;
>         void *rx_fifo;
>         u32 loopback;
>         bool brk;
> @@ -390,13 +394,25 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
>  static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
>  {
> -       writel(ch, uport->membase + SE_GENI_TX_FIFOn);
> +       struct qcom_geni_private_data *private_data = uport->private_data;
> +
> +       private_data->write_cached_bytes =
> +               (private_data->write_cached_bytes >> 8) | (ch << 24);
> +       private_data->write_cached_bytes_cnt++;
> +
> +       if (private_data->write_cached_bytes_cnt == BYTES_PER_FIFO_WORD) {
> +               writel(private_data->write_cached_bytes,
> +                      uport->membase + SE_GENI_TX_FIFOn);
> +               private_data->write_cached_bytes_cnt = 0;
> +       }
>  }
>
>  static void
>  __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                                  unsigned int count)
>  {
> +       struct qcom_geni_private_data *private_data = uport->private_data;
> +
>         int i;
>         u32 bytes_to_send = count;
>
> @@ -431,6 +447,15 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 i += chars_to_write;
>         }
> +
> +       if (private_data->write_cached_bytes_cnt) {
> +               private_data->write_cached_bytes >>= BITS_PER_BYTE *
> +                       (BYTES_PER_FIFO_WORD - private_data->write_cached_bytes_cnt);
> +               writel(private_data->write_cached_bytes,
> +                      uport->membase + SE_GENI_TX_FIFOn);
> +               private_data->write_cached_bytes_cnt = 0;
> +       }

How does this not end up sending stray zeros? In other words, how does
the hardware know which bytes of this word are valid?
