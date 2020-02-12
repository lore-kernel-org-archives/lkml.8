Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A30C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829A8218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEAWMqhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgBLUuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:50:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38845 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBLUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:50:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so3958602ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lV7hvjNmswlLvWeK5lw61miY9L53LZTaOCTXifOja2E=;
        b=dEAWMqhkvKRQ2NLUxoF2wQS5EvmJBsSSQ5lj3v1zKZfcpaWEew8A03ii1GUv0Rzyb4
         li60+Iho5s/vJRVdYPiov613XgUf2+HHqZbQPUanhs0Y5tbFmi5BkYyjl+LOlO/l5l/G
         ybjpyGNVmWEJMZ/AyNUF22OGpDxnhRybIAzDNUEI1lhLZQxUBC4NCsRKKOiPET0b26jW
         2HijBLo7SKgtfJe1v07bFOii0CIjiuFknYNjZZOhfToitf3MBUv9wLdLQ3L5/FdbOKlU
         1vdoGXWmB2uaCpyadlAxNTfqqeChTjzPkIEOXDYWkNgVUDRBVL/NKL0eOKPzH8e8c4wv
         mfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lV7hvjNmswlLvWeK5lw61miY9L53LZTaOCTXifOja2E=;
        b=DVihTG9p084gYrBByWd1GjA3LBSL7coTu5nNDx/dXrikQ4GRP5YOgYo8oC7fZ1dYhF
         zFX0Dgf8CQ9i7Ei0Od3GTD9LXtop2MplqLdZoSI+kZqP4rkmfSqZwCalnjMhidD7Ja5a
         Nq1ZOPeDhTRdN2BQhGmx8jlAObj+WvVYBRnLdxyMdNL+8rja2ZPBhhL7IvdSMb+vMKh+
         MirtZH9kU5RMjPKFmNTXL6coUxnhQo+B6wLohug0QOKq7YSRlmvlCoAiwjViWRtTwlpU
         i1sMd/I329rMkex6FWR8/o5OkkzBbfP7vsBTBqNfpOc1Vi8FlLdAlGXzh1pyMSfUFAGz
         RRfg==
X-Gm-Message-State: APjAAAUTqMC41a4dNNyv8x+qQIq7OrtghjnyYKBbDEyDp2sAAAjdBukZ
        1WxHk5GCWrXTaCVW1XGO8mp/DFoBUU+cbikbBsyGkABM
X-Google-Smtp-Source: APXvYqymY/lQ1elEp2Ss9xlTL+56MB8I4hRX+1ShsPJ8o/QTu8wjBIKXeGwPdHIzZn/xSBuyGol0riXyg7okTiO32nQ=
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr9097388ljo.180.1581540598513;
 Wed, 12 Feb 2020 12:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20200212195231.GA2867@embeddedor>
In-Reply-To: <20200212195231.GA2867@embeddedor>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Feb 2020 21:49:47 +0100
Message-ID: <CANiq72nt19x2Z6ErT8a1_2c0sKfjkv_yUFMZS2mf3HWp3RvnDQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, Feb 12, 2020 at 8:49 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.

s:inadvertenly:inadvertently:

> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I saw the discussion regarding this -- thanks! Do you want me to
handle this or will you push everything centrally? If the latter, have
my

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
