Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71453C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B84F208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWWeYCZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391251AbgFYVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgFYVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:52:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:52:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so7648736iox.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeX1os+mAQlfCuEpBTaGRzCtZlffjqRfxdp4eoZGB7w=;
        b=XWWeYCZ9C2tAcsEI4s6KOl3ZWFkq7oFW8XatZlmOPkOmo9Z+6NG3pAJROiDcSsM5dU
         iGqYME6VUNe/ARlpC+0Ew7lM2mYjdOX6p6VT+uPDfGKdd1aL1TjIyU8wis0IH4IC9Ge7
         DfQ8c2/qTdcKH7OsyCrBnGAvrvNbBuhCm3L9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeX1os+mAQlfCuEpBTaGRzCtZlffjqRfxdp4eoZGB7w=;
        b=sn3YZBYJegPmRgpvOwG7siBd8xcwfLSQqKNY1307XckIA/IRNEY482cJnojKaq0umk
         ra87dyZJQJlDjGHlMvhoEvA1Imac2SJbx7o4+fRuupTiTPqX4Y7NSEh009OXOZgn87lA
         c7xpcurwNnJfwsbi6v1VF68SWi0D2KpjHWhwIwFaubLwoB84edoS6isedTMsJLPeuhsz
         uY7VxVYMwIJR+iJ1pejMyBVU+hg3oFeO2MpcQF48GGL9S6s/laH9p1Ywhz7FuA6tmQab
         TjRtBP41kiprEURvvYnQ075/Fv8cEt7gAVRiQIQNXZab48ozOPuEYkISYiDiD0v1R+1N
         qnWA==
X-Gm-Message-State: AOAM5315ImQUGEKFPZ9i6yXdu7aPilAMH4wX8VJhzPAJvQC66XYoC4D3
        AE1xfXOmKGGv2SsXX1ps5rWPW/wIhDoGAPlCNWqRiQ==
X-Google-Smtp-Source: ABdhPJzG53+5LnhscugdVHfSJpAdXXTNS1n0G6xdNdV37K1Da2WH9/9elhlJ1JlmhLjn3n3i+YhDpvPcScUQ9UQuY6Y=
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr212245iod.170.1593121961964;
 Thu, 25 Jun 2020 14:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200625170241.224780-1-enric.balletbo@collabora.com>
In-Reply-To: <20200625170241.224780-1-enric.balletbo@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 25 Jun 2020 14:52:31 -0700
Message-ID: <CAPUE2utWQzkK4y_J=Zn779oF0H0WGuF_NkYxSfr2L9B-yMqvHw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Document missing function parameters
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Thu, Jun 25, 2020 at 10:02 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Kerneldoc expects all kernel function members to be documented.
>
> Fixes the following W=1 level warnings:
>
>   cros_ec_spi.c:153: warning: Function parameter or member 'ec_dev' not described in 'receive_n_bytes'
>   cros_ec_spi.c:153: warning: Function parameter or member 'buf' not described in 'receive_n_bytes'
>   cros_ec_spi.c:153: warning: Function parameter or member 'n' not described in 'receive_n_bytes'
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/platform/chrome/cros_ec_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index f7cf7c6a04507..d17f5c74ae976 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -148,6 +148,10 @@ static int terminate_request(struct cros_ec_device *ec_dev)
>   * receive_n_bytes - receive n bytes from the EC.
>   *
>   * Assumes buf is a pointer into the ec_dev->din buffer
> + *
> + * @ec_dev: ChromeOS EC device.
> + * @buf: Pointer to the buffer receiving the data.
> + * @n: Number of bytes received.
>   */
>  static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
>  {
> --
> 2.27.0
>
