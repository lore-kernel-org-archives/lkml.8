Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C617A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFdfEPcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG0IxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG0IxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:53:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06883C061794;
        Mon, 27 Jul 2020 01:53:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so2314293pje.1;
        Mon, 27 Jul 2020 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCfXf8WOmtA2IUxBJzSQxTBQrQqF9PVCIrC60H56Exo=;
        b=OFdfEPcJFl2T27EH2T+kq4cP2/lNJblPK9whqMS8JwUToaZ6c7g0P7tDaHEiCetLTi
         XLVWMLmwwVpxlfNlIWbW/SURNBk10dPdRs/BXcf1cBp/wqXq9ZB8zeP2Y3KvWO1argOe
         9FZc5gX4qPSJqKwxsxi4SABf+hTOgJV3H5JoqLdGUr2Yk+UZCstXwu5v+VknFWAYq5qi
         WqWCmljrN0zwRXKvUrEO6WO1Q023awVGbMfcfEQnkfWWSreHvQWYvznVskoT+6ZdBtBP
         VQbRRGsYFm1yPT5B1qwywSy7mLetjxkq2oqxhbeVwJwFR9JHrbJynDfdjBsdYjHwzf+D
         bjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCfXf8WOmtA2IUxBJzSQxTBQrQqF9PVCIrC60H56Exo=;
        b=J8Ah9ouCzJxHKFFiAanQUB36qIkZCrUhSXxDoY1RHXk6hkaoSlL/tutoi5vTwy0x4Y
         STvbDtffekZdQOFrQDPMx5h5vFNjL9GQu3jKVjGeXwiO4VsvCbrlLXACuxxFPS4mswDz
         PC128km0Y/VxewP6ihSPW+ZueGKfOjgUiesC3YA5mkfZPIPIQ81U5Pkxj6xKUqc53o1p
         mBKLyL1pyMDh2aexlX8SyDC4j158QGOJJdOEyqLjPZ0emyMcxKxi8cjayq4M2hqiV5xv
         URoJ/xV6HdYRM1Zx2xT6Xm6vn9ZIDCEdc5ZD8SPs0a2/ikozB9P8IOB5asjlxMBNBVJp
         3VPQ==
X-Gm-Message-State: AOAM5330EMQ3dkBmhuxzbvqLwwWVlsVi4mo+oVOUXDPST9rosar67Cmk
        BiisKcZvUMbpnx3JyoUh99k=
X-Google-Smtp-Source: ABdhPJyNaMdlpQ3AwoP7H3S3OxqRlhliSqoOA8hmKa9Cx8v/1LLppfqf9JPH9t52ILX2hBAJkzzJGg==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr17086238pjt.182.1595839990572;
        Mon, 27 Jul 2020 01:53:10 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id r204sm14346668pfc.134.2020.07.27.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:53:09 -0700 (PDT)
Date:   Mon, 27 Jul 2020 17:53:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [v3 PATCH RESEND] printk: Make linux/printk.h self-contained
Message-ID: <20200727085308.GE1386@jagdpanzerIV.localdomain>
References: <20200721062248.GA18383@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721062248.GA18383@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 16:22), Herbert Xu wrote:
> As it stands if you include printk.h by itself it will fail to
> compile because it requires definitions from ratelimit.h.  However,
> simply including ratelimit.h from printk.h does not work due to
> inclusion loops involving sched.h and kernel.h.
> 
> This patch solves this by moving bits from ratelimit.h into a new
> header file which can then be included by printk.h without any
> worries about header loops.
> 
> The build bot then revealed some intriguing failures arising out
> of this patch.  On s390 there is an inclusion loop with asm/bug.h
> and linux/kernel.h that triggers a compile failure, because kernel.h
> will cause asm-generic/bug.h to be included before s390's own
> asm/bug.h has finished processing.  This has been fixed by not
> including kernel.h in arch/s390/include/asm/bug.h.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to for-5.9, thanks.

	-ss
