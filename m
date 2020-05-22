Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF64C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A2920757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgEVVYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:24:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36134 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:24:10 -0400
Received: by mail-il1-f194.google.com with SMTP id 17so12146939ilj.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YCi9Dp13bDOmLIrC4hBxAOPuLUqxhaS10/WtAvU6TE=;
        b=E4nTa21FkNc29U9w1G6tTEgM3nsFGkCLh/utCgkLyTA5nGex152AARjgWdYVDfoBNk
         tP/MIsV9TaP9k8qrX5wmlTXPhzrQBO71r1pJc7ouZ0w2lz+IAQ9YeXv+vJ2fibHuXVcQ
         YCB3xhgY0XKRdhyZBTiadYSzH5xfE2qUMmyEhjN+XjYOTaBpBCq64FUNqQYbFu0q5DPH
         OqagQfJvo8iYxQmGvhGAq7GmGd4jUm4ZUJZxh8O8ACu/WqB3qPpYogQKFbwGNQAD0z7Q
         NOzPZnoWApCVYzOccn1IpeSfXcDUJIfnPN0T/IaS75E06jIwypi0QGd6KWnYt2ow1G6h
         N2wQ==
X-Gm-Message-State: AOAM531H5pnFpr/bYSkI3lByme7xpAno+caQ9U0Aljufm37lo0Aif5j1
        S+KGKpnJ3cC5pIRW32eBWyxyVHlY/ww=
X-Google-Smtp-Source: ABdhPJwfEaSZ5KMJB0ZENJ2xk517skPwFYrCr5kVjxMF3VMOCI1T5JYEGYO9kba+JimUR/Vw1MftaQ==
X-Received: by 2002:a92:9e51:: with SMTP id q78mr15556920ili.268.1590182650059;
        Fri, 22 May 2020 14:24:10 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id w88sm5371900ilk.83.2020.05.22.14.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:24:09 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id l20so12088636ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:24:09 -0700 (PDT)
X-Received: by 2002:a92:c401:: with SMTP id e1mr15870971ilp.134.1590182649355;
 Fri, 22 May 2020 14:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200518221904.GA22274@embeddedor>
In-Reply-To: <20200518221904.GA22274@embeddedor>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:23:46 -0500
X-Gmail-Original-Message-ID: <CADRPPNST6qhAHAEKXAnnJhQhoyb=r5O5YVs2KJW5qNgOjanu-Q@mail.gmail.com>
Message-ID: <CADRPPNST6qhAHAEKXAnnJhQhoyb=r5O5YVs2KJW5qNgOjanu-Q@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 5:16 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
>
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct qe_firmware.
>
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/soc/fsl/qe/qe.c | 4 ++--
>  include/soc/fsl/qe/qe.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied for next.  Thanks.

Regards,
Leo
