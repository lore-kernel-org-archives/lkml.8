Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E204C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266412073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4NAUMkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgFSAk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFSAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:40:27 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF5C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:40:27 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id r9so2624056ual.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DwgawLhU6PL5FSPvnraXncMLYJIMmvd/uQTqyvjBRY=;
        b=b4NAUMkrGQmHpV5jdeG0KSuh1KHDPIAQYqNtn7SUC2aPU2dvL1ju4YI+HbdSZqCFJ8
         QfFsFtthCw2LnuS9rA3pFMieIjVHb/ZkXE051MmSaYlZym10Ic33NkHUqJYM3EX3pw+1
         xEo2mYq+I7glhqD0CZf6QECXDtBVwBXO031ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DwgawLhU6PL5FSPvnraXncMLYJIMmvd/uQTqyvjBRY=;
        b=CMPHKBnHSiMH4I67zmLEvOazmn1jXqUBAIaWLokskT7fckAp1Ama0SqfO+JpGxS//j
         KjXskmVtMMHNdQjj9Y+/dEuRLvLQYwolDnHdXwJD1vQwy1KRG+L5Mom8ZAwE1zzwiapd
         opLh5O9fdpBxpItFiKLUF3zoPwvFQox5ud4Yei2pzeD+w3/laGY4/791wsEiIsfm0on+
         LcMtEgygREEpsJFroy/rjqZWLMmKBY0NVsN34vM+e7PXIr3KpQYH/Nx2LyCiM1l+TWCC
         dqvpwk4jAvyqFgiXqiMu7VQ4iVCg2ElQkNjuKtPm+6e02JRVi3FMbPLk2TJMolKMn/bU
         RH7A==
X-Gm-Message-State: AOAM532ALFeS9lQORylrrNZItDl2oAd7wLQD9dEQ8Atb8GzIHsyBpwTB
        AjJJJr1vqiOBaG0+wXQ5M6vYm1ZvxhA=
X-Google-Smtp-Source: ABdhPJxZClKFLF/fJAFBXQSgxdlUrK72F0jWjIeuEQEZ+PuZt7rRomDsgwJQAi/E16SnNke/tRVK8Q==
X-Received: by 2002:ab0:5fce:: with SMTP id g14mr843761uaj.38.1592527226173;
        Thu, 18 Jun 2020 17:40:26 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x20sm522273vsf.11.2020.06.18.17.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:40:25 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id j13so4667379vsn.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:40:25 -0700 (PDT)
X-Received: by 2002:a67:8881:: with SMTP id k123mr5789198vsd.198.1592527224605;
 Thu, 18 Jun 2020 17:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org> <20200618233959.160032-2-swboyd@chromium.org>
In-Reply-To: <20200618233959.160032-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 17:40:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W968K6RO0KE5Nq+MNxjN5iw7Ai0Qk0QomMSsKurx9bHA@mail.gmail.com>
Message-ID: <CAD=FV=W968K6RO0KE5Nq+MNxjN5iw7Ai0Qk0QomMSsKurx9bHA@mail.gmail.com>
Subject: Re: [PATCH 7/5] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 4:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We only need to test for these counters being non-zero when we see the
> end of a transfer. If we're doing a CS change then they will already be
> zero.  This implies that we don't need to set these to 0 if we're
> cancelling an in flight transfer too, because we only care to test these
> counters when the 'DONE' bit is set in the hardware and we've set them
> to non-zero for a transfer.
>
> This is a non-functional change, just cleanup to consolidate code.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 42 ++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 670f83793aa4..828cfc988a3f 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -126,7 +126,6 @@ static void handle_fifo_timeout(struct spi_master *spi,
>          * came in while cancelling.
>          */
>         mas->cur_xfer = NULL;
> -       mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
>         geni_se_cancel_m_cmd(se);
>         spin_unlock_irq(&mas->lock);
>
> @@ -517,29 +516,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>                 if (mas->cur_xfer) {
>                         spi_finalize_current_transfer(spi);
>                         mas->cur_xfer = NULL;
> +                       /*
> +                        * If this happens, then a CMD_DONE came before all the
> +                        * Tx buffer bytes were sent out. This is unusual, log
> +                        * this condition and disable the WM interrupt to
> +                        * prevent the system from stalling due an interrupt
> +                        * storm.
> +                        *
> +                        * If this happens when all Rx bytes haven't been
> +                        * received, log the condition. The only known time
> +                        * this can happen is if bits_per_word != 8 and some
> +                        * registers that expect xfer lengths in num spi_words
> +                        * weren't written correctly.
> +                        */
> +                       if (mas->tx_rem_bytes) {
> +                               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +                               dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
> +                                       mas->tx_rem_bytes, mas->cur_bits_per_word);
> +                       }
> +                       if (mas->rx_rem_bytes)
> +                               dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
> +                                       mas->rx_rem_bytes, mas->cur_bits_per_word);

...or we just remove these extra error-checks totally.  ...but if we
want to keep them:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
