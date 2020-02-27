Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FDC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD14E2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582782989;
	bh=R9VEd0NDGHG23l9/8f5bs/P9pgnOwscgs82TKBNxFEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HIOrKybRcRk4xABpciBLUwQcvJNNUULZY/D3u3ORasj2xx3bb1s5nWFOquydtuq7U
	 pwiEEV5I4AwcNZl3H19sUz8330MzA+oJg5SvLLTff7oaf3IqefDQk2qpce0hPewFD4
	 qMupyLNknRXIOPUBLxuIYWdLWG/wULsavszL4saw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgB0F43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB0F41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:56:27 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2612B24672;
        Thu, 27 Feb 2020 05:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582782987;
        bh=R9VEd0NDGHG23l9/8f5bs/P9pgnOwscgs82TKBNxFEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O0AdVHRQx3VDctsBvC4N0ZihEthjvsr47cIp4X2kbDDo0TpIBiIJYkWRRyTETJfm4
         WBnTiFWPOEu7ubiL5KG7koSy3y1RoaqAcmRXw/1c7Ww7wJeHptWKYWJxQt10pargoD
         w5Sr27uxuvChFnoxAAAnC/XoMCPptP/Cd4rnMq4o=
Received: by mail-lf1-f52.google.com with SMTP id c23so1119976lfi.7;
        Wed, 26 Feb 2020 21:56:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ3hGWWRy1Rn6jZMmpyWGwLOQeQYXJK06gofew1DP6d1MSGQpQVq
        1ru7R1sS3HIMqDA8fPTAq34jVxrn2URFg2A6lL0=
X-Google-Smtp-Source: ADFU+vtg0fGzcYoaye5t1/UsBTkwUsvyGZXKcDkqdmLZOhJ19DxxGVywxm78hjafHzS5LYzWchS/gfPFmj7IZ0Oq6Nc=
X-Received: by 2002:a19:4a0f:: with SMTP id x15mr1096322lfa.172.1582782985300;
 Wed, 26 Feb 2020 21:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20200227001744.GA3317@embeddedor>
In-Reply-To: <20200227001744.GA3317@embeddedor>
From:   Song Liu <song@kernel.org>
Date:   Wed, 26 Feb 2020 21:56:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6EWnMWL6QeJaXDwsT4_aFmCAc_aEFGrvKwJsTFg_B2Cg@mail.gmail.com>
Message-ID: <CAPhsuW6EWnMWL6QeJaXDwsT4_aFmCAc_aEFGrvKwJsTFg_B2Cg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Replace zero-length array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 4:16 PM Gustavo A. R. Silva
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
> inadvertently introduced[3] to the codebase from now on.
>
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

Acked-by: Song Liu <songliubraving@fb.com>
