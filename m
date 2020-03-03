Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C03C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4A62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ogqzViFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCCC7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:59:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37555 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgCCC7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:59:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so705146pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 18:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TKO0L3z/J7Uevo3j6Cjbfw67QzjwRhKOacKqgs2izaw=;
        b=ogqzViFeXGao56AivP/vc0QdZ44N/zp3LPAu9t7auJ6D5w4BYt32BdcsGMVwKMJMLX
         V17HhvkBFQuG/pXjAeSdKXMWBIETLu5a09qRe6As23S2FzKG8qNZn7G649/7kIe3bLZI
         rvSZ5EvCIjyaeqwp71KKRZAe+yN/wPQNTbgyxc+SvzIuGf1KyC5SJpWDuNtq+1EdkgR4
         ArbPJcGMikx2+KnUS5KbPa361UGsUE+oCIpKZ/c2JbYcp4vWUnfG/AJk1yT3ArzQFxZR
         k/5X/Uq/EHXpgB3JoiIVdklAEamobQMFUfx4YwjR7hf5rq+HPAXBqQ/K2ZcORZ6n+waK
         ZMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKO0L3z/J7Uevo3j6Cjbfw67QzjwRhKOacKqgs2izaw=;
        b=rR/76ErrKHdgh4lKJcFQtgsI2cdGHl1w8yYDeZ6lNEoiFov2LPbQpPCAFFkGgql1fG
         61xBYiPMNvzS9tNoCN3CM+Rtd2wj4mxhS0NdKmppZW/63jloHbM/EESM8f62yEqEQJa2
         AT8+tRb/3+vELWvzs9CkeeJdxPjZvDO68AFlOh1iTreOnlJZoiFur/ul6qAWBiHl2Ppr
         uUbAR6DmCmcqkXFuxsDpwkb8cupxylu/M+p1cxbX2PAvc70lfwKX/T8yAc8Vy55F949q
         E713XvbGKzmQGVwEAwoFFzUUALd4RffZYRKfOpSYMhKpDaePu2N+3eTqOaLaHVfMzDLp
         5xnw==
X-Gm-Message-State: ANhLgQ14pqs11AlpX5HrqbNYXmngjqeaXMKSAu2xOaILpG6tTdw4ikdk
        +uDe+VgWagNqmQRI5Vpba1f/CHz4qgI=
X-Google-Smtp-Source: ADFU+vvAe42HEiTPq5z1cVZS5f+hW7AQAx29DDs4d+zaE0yVL/aZyCp8qfPq7TSX5al2Gq0NZRN78A==
X-Received: by 2002:aa7:82ce:: with SMTP id f14mr2028100pfn.167.1583204349805;
        Mon, 02 Mar 2020 18:59:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w76sm3982670pfc.154.2020.03.02.18.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 18:59:09 -0800 (PST)
Subject: Re: linux-next: build warnings after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200303124133.13309249@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab8305a0-dda4-7b5d-2dec-00032410d6a3@kernel.dk>
Date:   Mon, 2 Mar 2020 19:59:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303124133.13309249@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 6:41 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
> 
> fs/io_uring.c: In function 'io_put_kbuf':
> fs/io_uring.c:1651:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  1651 |  struct io_buffer *kbuf = (struct io_buffer *) req->rw.addr;
>       |                           ^
> fs/io_uring.c: In function 'io_rw_buffer_select':
> fs/io_uring.c:2209:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  2209 |  struct io_buffer *kbuf = (struct io_buffer *) req->rw.addr;
>       |                           ^
> fs/io_uring.c:2216:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>  2216 |  req->rw.addr = (u64) kbuf;
>       |                 ^
> fs/io_uring.c: In function 'io_cleanup_req':
> fs/io_uring.c:4897:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  4897 |    kfree((void *)req->rw.addr);
>       |          ^
> 
> Introduced by commits
> 
>   7efcbb97deab ("io_uring: support buffer selection for OP_READ and OP_RECV")
>   8cab19f460b6 ("io_uring: add IOSQE_BUFFER_SELECT support for IORING_OP_READV")

Thanks Stephen, I added a fixup patch. I wish we had u64_to_ptr() and
ptr_to_u64(), but that's only for the __user pointers...

-- 
Jens Axboe

