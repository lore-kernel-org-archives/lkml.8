Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896762469C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEHM9w8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFTUs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:48:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35039 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgFTUs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:48:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id t74so7502875lff.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjItgRxlCwG7kM4tiHMGmFaM+sKcdbDC0+Nnh8enW9M=;
        b=TEHM9w8J5DL8WMBxSWXMSM7g3AT8WZqQ4MmUuryQGW2mHrRezqSiaa+ubCi+VIz8vW
         vGzQ/6aRajbJCPJJk/zYEwvOZ0K9UkWyBcLLNgn94SMpzNHl5YwAoHTw96JAy8/UYwJH
         /SlGZU4qpC3HoFZczOdETesk2RJN2bPxqtZ7ptyf7srcAIwRSlQFhF1Zy0AYM7Qe0WzG
         KoyChVvpkjkTFsaS/k0q7vntqsGXYyYNxLjBoQjdT8/sgEb8tR4EWipi2mitTnDXTPd1
         jQNXQehKHBIdSrYpwdd7+J881kyAdAwXyX/KAd6UufTwjyZIO3flFkPiAKLKIDB2moK3
         cFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjItgRxlCwG7kM4tiHMGmFaM+sKcdbDC0+Nnh8enW9M=;
        b=uWfQ/Ji/jgCuqUg3e8bXOc3q0roFYDBhwgQ3RheX6k144K/Nv3nXSLUAb5OrVcaW/l
         WTBgPEWfqH0W7s0TZBsK9urDJ6Mb3fsDutosRD2sARpTEZnNXAWZcxElmZV+JTs5Prmf
         UKUZzij+Ph9/tbGzp9LI5m3HiJIped+LkGfFqTdZT6rrKbO3pjopSn/dfcWSXTtHM/gv
         LVVS3YAA2fCNKuNxk9CVpXnNxp2L+W5kMIOGBpIS/DmuTjhJZjC4erQ8uy18cmxjp0D0
         2L1FLGNH1XBp49K4hxQzyVAnfDUNdCp1UYYMy14WP5OlvYnTczgnx+z7RT3aoDh2Rs1X
         Hccg==
X-Gm-Message-State: AOAM531gWwWs61bXGhq6QTszmTMfxXSMcjACPjcL+76vzKEd2VGwf2za
        SMACLiA6MHmFaFoPkYnnGys0v7i4wnmiIJri2lym1Q==
X-Google-Smtp-Source: ABdhPJylVUTQr8IvfKLH+J/M5vlpR1eJjw41oHLgdp91Fm0bMUP/KIJnEc359B0WLIAjdK0jFVDfSoek4c+gTfVpwzE=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr5435603lfn.21.1592686045343;
 Sat, 20 Jun 2020 13:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu>
In-Reply-To: <694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:47:14 +0200
Message-ID: <CACRpkdYbOAnZb2H1jmD_QCgT7bkFYtpJ8cEGDFDDkJDG6aMhbQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: cpm_uart: Fix behaviour for non existing GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 8:26 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> devm_gpiod_get_index() doesn't return NULL but -ENOENT when the
> requested GPIO doesn't exist,  leading to the following messages:
>
> [    2.742468] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.748147] can't set direction for gpio #2: -2
> [    2.753081] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.758724] can't set direction for gpio #3: -2
> [    2.763666] gpiod_direction_output: invalid GPIO (errorpointer)
> [    2.769394] can't set direction for gpio #4: -2
> [    2.774341] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.779981] can't set direction for gpio #5: -2
> [    2.784545] ff000a20.serial: ttyCPM1 at MMIO 0xfff00a20 (irq = 39, base_baud = 8250000) is a CPM UART
>
> Use devm_gpiod_get_index_optional() instead.
>
> At the same time, handle the error case and properly exit
> with an error.
>
> Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
> Cc: stable@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Using devm_gpiod_get_index_optional() and exiting if error

Excellent!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
