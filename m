Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A86C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D23D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEwbGGpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgGUOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:42:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:42:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so1772953pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AqB2Pes9HY0mfXIHZs55IOMGH+yvSYMllsLCvMYuJRQ=;
        b=LEwbGGpOtTy5VKyQ0OqJ4oiaDaGivfOY6l4hZoQB0GKawziemHBCIKMNmYLINzSH5k
         eUV7/weitMFK26xpGRwuKZ/wVpaSAkt0CndViCBBH/gX+IWna4mKclauXj0xardu/SsC
         TUGmAo+CYWXRh938OHurnq696W8M5GXb/DrwcyOYZqmalrF8fJbPbE5EnLm/KZouvvXx
         SpJUE8q5HIq7rL82JxObimEp58jY2CuxkDTxYZy/5DOrpFq+Wsnjnz4oFBk+qo5qEROV
         ziy5GHDkbvr7Y75VXeqUOO35f6On6C5v+dpeEldL1IXuHKuDVgihgJMWAO6X01d7MECG
         6CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqB2Pes9HY0mfXIHZs55IOMGH+yvSYMllsLCvMYuJRQ=;
        b=Tc0u3uOhrDCZwDHWgD+fspxCjF7SQB9a38WcXxT3107kIjVNaBqh79T+OxLVjh0OWy
         KjrusxqhvJvdT2yINDmcmqMr0phVG+fAdnjhOl2z2A/lJPSrh4AqT5TD2JAQQ+3nq9yq
         GGdg75z7f1crH5VfPGHR2mGcdTTeioEbRt8q4Al0UZpQQYCbL88IBzmZJJRO1PBdzAWz
         Kgpd+aVyC81wBuSfq4KLY5xtVrxn5cPxVHMevF4mF/5nZUsuyHBxOczqme4yl+fK/6h1
         ipeJCtXHORcBvUXEVt33qt8J3aoONk7nbjs9cKz/gncACpx1YHylU93OXMfnXRF9qcn6
         AMbg==
X-Gm-Message-State: AOAM532teAW8n0bFxIgVucPwNfW5BNtkcCgrAotafaV20YIa/QkHNsrS
        r6f5weG4y7beW3bx5tpkezE=
X-Google-Smtp-Source: ABdhPJx/CLcsZovzNbUNs7PWDKE7qDleMl6cyddLrZdb/pAWw102IzYOfTyFA+8hlhKEPCMG8EbmiA==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr5326502pjv.58.1595342543712;
        Tue, 21 Jul 2020 07:42:23 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id p11sm3504148pjb.3.2020.07.21.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:42:22 -0700 (PDT)
Date:   Tue, 21 Jul 2020 23:42:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200721144220.GE44523@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/20 11:30), Linus Torvalds wrote:
> > Do I get it right, what you are saying is - when we process a PR_CONT
> > message the cont buffer should already contain previous non-LOG_NEWLINE
> > and non-PR_CONT message, otherwise it's a bug?
> 
> No.
> 
> I'm saying that the code that does PR_CONT should have done *some*
> printing before, otherwise it's at the very least questionable.
> 
> IOW, you can't just randomly start printing with PR_CONT, without
> having established _some_ context for it.

OK, I see. I sort of suspect that we may actually have code that does
just pr_cont() (e.g. what Joe pointed out). It doesn't seem like that
"establish a context" was ever enforced, doing a bunch of pr_cont()
simply works.

[..]
> That said, we have traditionally used not just "current process", but
> also "last irq-level" as the context information, so I do think it
> would be good to continue to do that.

OK, so basically, extending printk_caller_id() so that for IRQ/NMI
we will have more info than just "0x80000000 + raw_smp_processor_id()".

	-ss
