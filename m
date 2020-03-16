Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8FC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5368206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G9SvvGTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgCPJ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:27:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40584 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgCPJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:27:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id j2so12012568qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6KKRggvbK0+NAqhE3WJvvvxBZ3bm45y+mPyerHldIY=;
        b=G9SvvGTaCE7lk6jTYD5LyqgoCgnp6sGRQuxZMcEmtVxq41kQTtxFkAj6fIqf0DjMzz
         op9lTItLw+6v5TQTPH399nhk2kBcFHmhvFRGgMmyRWJd4uj/MIs1bMl3mHC8tiFsHHsj
         jKAvKNXZ/E1AMhG5WaiLMb0ua6fpM/la/00zLl5p6DfWXS0Zw0vdqxGQTz6Wuj7LT3uW
         tZIUAPbqWjNC5ORiu4YZFKOeEXuiaYgavOZXqveBxoT39LhJamV+ZWqE977iffHP6lRp
         tKKzG7mu7O6sKqyxl5cftq5e3BsY5uBsQ4lh6kfZofNxGL1kWyfqhYxeJhFW1KqopRc9
         pRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6KKRggvbK0+NAqhE3WJvvvxBZ3bm45y+mPyerHldIY=;
        b=Bt0u1wuHq4yAnn9xhpsAS35Qf1x+VSJyctZkM23A4lsnk+LWSHIuWUOBDJXv6Qq2x5
         1HRA/fqygbzbC+fYLX1S0UuYylQzVH3Lxa749vDUf33CG+pO0/XyjV7MEViihsbUODHf
         qfQertXL1MOjrUr8eZPD8QruwdR6RD0zy8WrbkGBfPzMQDfYBp3s6bnXNiRJv8p9u2Ck
         82JDszglXDX1drL6e6ecBLNmrNrjrYlQRuRZsQqkpWdF8T6D1aq8v995aPNE2/oyTxJk
         K1JFdqBkav8gqh6n9Tqw79ICgkQzHYje6xyl2W4k2878SNrt8Yf6ug6sezKUynLbH7OX
         z5cg==
X-Gm-Message-State: ANhLgQ2apqUwDV/JQWvHQ+Sg9ZvlZcgcc+DM8F+rZN5Woqh7RVxQ+w2Q
        iKyiTBnEr/8D1Xkf3gaAwTW7JkrYljTfLnI3AheESuMj2gI=
X-Google-Smtp-Source: ADFU+vtA89e3VaeupVSYxqp/eyk/8w7sDvNnoJ+ZP6HESQ3pGFQfQz4PmtMTNCvvjdPZ3PC77VGAexLRBZQNRVaJkLs=
X-Received: by 2002:a37:4808:: with SMTP id v8mr22591137qka.263.1584350875543;
 Mon, 16 Mar 2020 02:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200315121338.251362-1-gch981213@gmail.com> <20200315121338.251362-3-gch981213@gmail.com>
In-Reply-To: <20200315121338.251362-3-gch981213@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 16 Mar 2020 10:27:44 +0100
Message-ID: <CAMpxmJXZpJ4D2oPYrkWOXeLzih5ti=YN-TBb6PGzP=4JVhXnOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mt7621: add BGPIOF_NO_SET_ON_INPUT flag
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 15 mar 2020 o 13:14 Chuanhong Guo <gch981213@gmail.com> napisa=C5=
=82(a):
>
> DSET/DCLR registers only works on output pins. Add corresponding
> BGPIOF_NO_SET_ON_INPUT flag to bgpio_init call to fix direction_out
> behavior.
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Patch applied with Rene's and Sergio's tags.

Bartosz
