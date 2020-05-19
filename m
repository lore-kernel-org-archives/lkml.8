Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D79C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA1720809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589904497;
	bh=73so92TDl4jD8/w55hUs42JqOa9I4X3/YwQ+ktGp+rQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ddHsYDrG4WG9tXEdSMKZ24Vv5yDvCX68kEiBt0HHXjuZlUdeOcjYRM3yQGotl3e4b
	 hSvsi7Vc9Ty79/jSrPP06yDJhRRZi54F/nIQnEnEKuhF+m5az4ohc+sclxhEDGzZ9i
	 vMYdBJ4+1dNuqME7BlUPBMN9aJI8TZGmK9GULbd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgESQIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgESQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:08:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE80C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:08:15 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so11716055lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yx5q8kTLmBrxy32bs18zizlzOjtx0vFts57BKijzI48=;
        b=HCXGSXVripfdjF3MiGwI8HqE63+BVnW9g3cwRZiRc5Emx+jBu6A4Nsobp13SbpFd6U
         Lyt8wvpLjFnfI845wbjgkTVZflwu9OTBrRm/9vher3ASfX9/MH65gZZ8ahxQbI/5jnLa
         wMfTgbalXvP1B/G3Ib0nnbu0+sXLvWt0bQgfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yx5q8kTLmBrxy32bs18zizlzOjtx0vFts57BKijzI48=;
        b=RXFQO/3lY+XYer/k6xmWt2GID9Zze9GtCwBbginow+WcwXLZTzN/RQjz6bIQHJjGSK
         9P8mFx2UA3u2M2ZI4IJX8sK7oYOh7wDucO2sY4ldNGkBTbcdv8n+gyg/v7+mflOMRHCx
         CQ/iCgC3ZjlaF/wz1lzS/0aLBYS1nY7pEaBaZPt74kXgFZ2az/Vj0EYuVI1/XdE0yUaz
         DazgxRBGYgPi+MBf7K1IZWg8/TorOHXD/sFuIfI27kxk0wWdHuSSiflaTOD+Y83ZwlRj
         kSFxzpWjjc+7HTmSJGj3wBg37An+ouuBRCWsBXdChQyuKZYYJ68Y8jKeUyUl437fXJzW
         tvBw==
X-Gm-Message-State: AOAM533MeV7qi8VhARRDop6WlOmuvPhMteEHjCIX6gCI1lODTCO5fRR/
        QjMsrCYWqW33TOsaG5FHDgK71iKydn4=
X-Google-Smtp-Source: ABdhPJzFthOT4qIP/gWHIB44fwGuBLwCGu3csq5CFWFS+m+SdbyAiruK36JscgLWZwmq3RGBYMIZuQ==
X-Received: by 2002:a05:6512:3b6:: with SMTP id v22mr3971848lfp.97.1589904493428;
        Tue, 19 May 2020 09:08:13 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q13sm9343797lfh.73.2020.05.19.09.08.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:08:12 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 82so11749lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:08:11 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr1343727lfn.142.1589904491650;
 Tue, 19 May 2020 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-12-hch@lst.de>
In-Reply-To: <20200519134449.1466624-12-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:07:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
Message-ID: <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] bpf: factor out a bpf_trace_copy_string helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +       switch (fmt_ptype) {
> +       case 's':
> +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> +               strncpy_from_unsafe(buf, unsafe_ptr, bufsz);
> +               break;
> +#endif
> +       case 'k':
> +               strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
> +               break;

That 's' case needs a "fallthrough;" for the overlapping case,
methinks. Otherwise you'll get warnings.

                  Linus
