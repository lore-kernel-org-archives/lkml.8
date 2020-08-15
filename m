Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC11C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4432053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQE9ecdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHOVvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgHOVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D259C061233
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 22:41:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e4so5367725pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srq9xR0jTgO+mDmp3efyhBKbSnbNofpfpXcr4LilIjQ=;
        b=nQE9ecdjegmgyaV/9aIBzopGQ2bnLLI9akMcx4qO/xGiJshCq+dHj++WehnY4Pe9fS
         ME8Ogdd2M00zA6WGyvTCT1Y9KRwRtJsflWfM8+gNtcGzqPX0TyibVZ/TdpkVhMn1gUyo
         6Q0frCzlGBU4Xz/D4R4KhEVHAZv809XSwaZvo06Fxk3Ln+VXEXNkCi/PINwVy9XeZ/j+
         UzdHaGrXxegyEqXhEjMBtixhwIO1OrRK5c1HUFMLhw7qcP/k9vVdhaQe9BjzHpm35ySO
         Y4B0GdSaWkiPrDV5yG7wRLcm/8LvExOu6h3ibIVbtpDHwSvM3KIyv3duRrFmst/b1AIU
         yoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srq9xR0jTgO+mDmp3efyhBKbSnbNofpfpXcr4LilIjQ=;
        b=D/5oKQC6BFzUinl0Hj18I6XmLkHpDl4/Wlavv91KpLFRfeco7DQAqMx1Kok09RbT+m
         c7RlxF8uCXNpg9dGbFwgU+G1kuethX7SwmBFUmLNfCJTBLWyA7Fs1+1GXqF+KkNDqKai
         W6VJ7/nCaJZm93VJgMbhKMVRONuqgSi+jfeezS3mHgyzqoKr8AjVL0QKx+wnDGrmTCla
         G4k/n1b0NcHTQS2SVn0TjpEQDVWZuH7rc5HVPJzk9+0cR2qYMZdetk3FdVDWHwyZLx6Q
         YkJ8Yy8wEVZ5mGuVbOduFdWULfplHCHx/OfylYYbz/x818evjIpdYfN9OZqSI93PQlkJ
         auHg==
X-Gm-Message-State: AOAM5317muzUV65M13gw8Y9VVUCVR0pPF1P5cq+C1sJCSxb51YQHlUrG
        ntvJfXqpVGtWVSEOu2QY2s8=
X-Google-Smtp-Source: ABdhPJypo3nUqYu/XuaQmwg+dbDRJot7/hBtlak1SaimaM6styJw3N6daVyaBOPJOPne5SxMuas0NA==
X-Received: by 2002:a17:90a:70c9:: with SMTP id a9mr4519032pjm.167.1597470106338;
        Fri, 14 Aug 2020 22:41:46 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q7sm8704580pfu.133.2020.08.14.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:41:45 -0700 (PDT)
Date:   Sat, 15 Aug 2020 14:41:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200815054143.GD582@jagdpanzerIV.localdomain>
References: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/14 15:46), Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > I think what Linus said a long time ago was that the initial purpose of
> > pr_cont was
> >
> >         pr_info("Initialize feature foo...");
> >         if (init_feature_foo() == 0)
> >                 pr_cont("ok\n");
> >         else
> >                 pr_cont("not ok\n");
> >
> >         And if init_feature_foo() crashes the kernel then the first printk()
> >         form panic() will flush the cont buffer.
> 
> Right.
> 
> This is why I think any discussion that says "people should buffer
> their lines themselves and we should get rid if pr_cont()" is
> fundamentally broken.

I think what we've been talking about so far was "how do we buffer
cont lines now", what are the problems of current buffering and what
can we do to make that buffering SMP safe (preserving the context of
broken cont buffer, etc. etc.). I don't think that anyone concluded
to just "s/pr_cont/printk/g", I don't see this.

	-ss
