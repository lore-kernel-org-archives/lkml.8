Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCB3C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF220650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqsRJy8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCLNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:42:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37800 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:42:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so6496798ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DOluD+F62+UVUFsNUjLxaC0lyKRRbWzeQTro9ET2IA=;
        b=NqsRJy8IfYtvVOx2m61P7EUj7eKkRQC1W1McHaxUOH/XTR5geJiuT5IJcQaQ3nXb8l
         M2LJAR79pVa8FQ+2/8ZcyBkREzLsxQmsdbbnBNAajt6/Ur8nAhUkN6nyGyUdPBeF+Yj9
         RhXI9+Db1pLJ5PtMWY5BohGHdNAG2Ng5Rzj0pir3fqfrWTc9vkEjUFRCeagCFSGP8NmW
         bTHID97c2LnvrSgLULrX+b0XRz6Ao3DLXkRhPWVncjiq3WLfRBMTsvoDvyJpmRX0AuSh
         vlLjYb7s73jyHx2EESmsqa8I/fTvd11T3BvX3H2aaKOFsXdqHfLK8Lr0bPskf+BhItYG
         jQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DOluD+F62+UVUFsNUjLxaC0lyKRRbWzeQTro9ET2IA=;
        b=XHgUgn9ecxM7qOkUyyxYos+jZm2o9P6X49ZORAJEs/dBGpM8iws3z21GyfuUo6umMh
         7cEz/Kuk4h2LQupxh5pID/3aw+dve1YaztSj6CFsiZD0s8UwTe/rQ420Jbq63JV1a7aR
         BzoRoLWuDky4l7AVyRHAEMmprr+xUJAXjchwbHbrJBNkfqb+xRh/WyNNsPuDVSVWo7rC
         Z6qkz4PYe/Cv+PpDawQW5yg4dgTTrRqGSXrFaClRyCJVQklgnxDGQ2186xdtsOWbGKyj
         x1mpjXphZxxWmVf1CCXmhYMqIijM3KT16MNUZQojxBXMxOP7YLOasfV6vFMe9WQB/Iyc
         RQsw==
X-Gm-Message-State: ANhLgQ3tibwZOnuTIirM5slXLnwEgjW6p4cGXuehZcDR4aCL3WowaCyg
        rMyRrMrlHvwG4blkdzqWQxOkFv4aW7aEUNLHqbMf5fG8HfE=
X-Google-Smtp-Source: ADFU+vthVOyM/lwX5Bu49UX4rxF6kLF6196E1PSZp8U0hCci6QQU3TSCkkgWEyqH9cjxUW9PFpIMdwSr5W2lUW0E3Dc=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr3002789ljl.223.1584020536783;
 Thu, 12 Mar 2020 06:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <1583941433-15876-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1583941433-15876-1-git-send-email-tharvey@gateworks.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:42:05 +0100
Message-ID: <CACRpkdb3VzOFmnZkXXopsbKAAiQ9nzsqm6fMpcsCfmuvmaeOmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: fix irq_request_resources
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Robert Richter <rrichter@marvell.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 4:43 PM Tim Harvey <tharvey@gateworks.com> wrote:

> If there are no parent resources do not call irq_chip_request_resources_parent
> at all as this will return an error.
>
> This resolves a regression where devices using a thunderx gpio as an interrupt
> would fail probing.
>
> Fixes: 0d04d0c ("gpio: thunderx: Use the default parent apis for {request,release}_resources")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This patch does not apply to the mainline kernel or v5.6-rc1.

Please verify:
1. If the problem is still in v5.6 (we refactored the driver to
   use GPIOLIB_IRQCHIP)

2. If not, only propose it for linux-stable v5.5 etc.

Yours,
Linus Walleij
