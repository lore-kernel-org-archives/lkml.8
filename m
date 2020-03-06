Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD2CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CF3206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583518213;
	bh=UhXNAVre2EYkV7zoxOLBerLkdYc+pOutqOc+uFnYcec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dPjynAYv/U5dG/A9VOneJFzzomBg8vbysS0jpW+2vApcbqxaSWUmaM0qx/pGPWGki
	 Cw1265jEt5iaM72puzzuloQSPUHvxFs8/nNaUc/kpbip4Wn9OoGCeS4tGQH6is+sBn
	 zAAn5PygsaVbgGlRhg8PQR2aA5Yma5FaQobajIH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCFSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:10:12 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1F1206E2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583518212;
        bh=UhXNAVre2EYkV7zoxOLBerLkdYc+pOutqOc+uFnYcec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CtzbyL4NAuYPWgUAX3vsD5113YVohkpEKkM3GBJ7/Ljbn+aM6TuPN6NE36XRT2Ip3
         YytmTdNIkpzDj4VTxeYwu818w+8rjvFxmaG7i4gGNjCF92lWI9PgOY6YlwINZc760Y
         +HOBA2t6B57AClqmyM1q/YgD6iWRc0UQ5CbeLRyM=
Received: by mail-wr1-f44.google.com with SMTP id v11so3421763wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 10:10:11 -0800 (PST)
X-Gm-Message-State: ANhLgQ27l/wAyrvCeHReHlrJEVAG7drCj6G5c90fo9xMsx4V6tGw4ylx
        UlTvN9cl03SvtnIzfIST3nAi8eDIFXA1U1Xz1HnDbw==
X-Google-Smtp-Source: ADFU+vv1AOG5tHij0fLjC8000q+s+EtpHoNrB7M+8B5/f4EEjxeLFOS1UA6gWYXyIrJPXB9ljG/iAUbN9+zB2vN/6Tg=
X-Received: by 2002:adf:b641:: with SMTP id i1mr5258372wre.18.1583518210189;
 Fri, 06 Mar 2020 10:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20200305181719.GA5490@avx2>
In-Reply-To: <20200305181719.GA5490@avx2>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 6 Mar 2020 10:09:58 -0800
X-Gmail-Original-Message-ID: <CALCETrW2xH7FUKAXnREpak9tAcc-3yOFfvLnCYU_8e+D1jXApw@mail.gmail.com>
Message-ID: <CALCETrW2xH7FUKAXnREpak9tAcc-3yOFfvLnCYU_8e+D1jXApw@mail.gmail.com>
Subject: Re: [PATCH] x86_64: fixup TASK_SIZE_MAX comment
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 10:17 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Comment says "by preventing anything executable" which is not true.
> Even PROT_NONE mapping can't be installed at (1<<47 - 4096).
>
>         mmap(0x7ffffffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM

Reviewed-by: Andy Lutomirski <luto@kernel.org>

>
> I wonder if CPUs with wider address space carried the bugs...

I believe they do.  I won't swear to it.

FWIW, I specifically asked Intel to kindly fix this bug^Wfeature as
part of LA57, and I did not get a helpful response.
