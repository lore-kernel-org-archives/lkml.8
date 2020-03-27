Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEFC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B80E20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1rUgMWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgC0DGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:06:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46737 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgC0DGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:06:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so6640959lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSLNSOAWi6KCk4zSx0nfkc3noQNEt96T9ParppIuBog=;
        b=o1rUgMWmuu/u5WcBto31zRT1GEI3pHzIvSYQHY4OFpBJuPQuCTLtpAidukeGYXob/q
         SIEcxXncDs/FQuanUO8pkn4HtBJ1OB+kRA3jtwVJCIjWG+KOzVQA1G07r4LIFCqFXlVs
         Wj6nU1HOJspWfzWUHexCOy4ZkJ1Xe+DD/z5XO+pkgVlqX0WkNBTEdv0BbVXBvQdHZ4tq
         b9qacY4H2WaFb2QLy06nmR0ZOirm8dA2yht6LtRO0k9AZZ54cQCmiuIDgmA9R9bS2ORM
         8KoUGsDCDSRi0Ps+bPcNio5PUj2ZqugisoFuGtkY2y+pDekeqMmPS3IARBhXOTyPDn5m
         26pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSLNSOAWi6KCk4zSx0nfkc3noQNEt96T9ParppIuBog=;
        b=nd26i7+tXbDOcIx6aEWY6URjcH+HLeHakBG0IbmfxKaCDPHubuyQkFxHJCqqj4OwMB
         quLsDpWHD9wGhKohxO0zcJQSdUqIlXMnBDxc82kV/Il6EobEfPoU2YrZblLty4yagUfp
         Wqwrh49uH8AuOAytbdA+BKxdxDfjrh3I9wuS/BZgGrObwXHoaooo3sUQ84Xp6gY9ci2w
         auxxFTZOzbmGPVZ4AdLMyT69EcKee/gjAuPZKGQye5bftGpJPJauWI5BvR+d3XdrVB2P
         5CY7S3htgWJEVuADQLvr2HtmcdTFKqhwVGq71eivY1UBhiIZJFTBthbZlW1ondx1RZsp
         Lisg==
X-Gm-Message-State: ANhLgQ1YIfpd3nYWa/z0MajL+wJSOPiiz+zD9q+k6vmnhyXi7FerZksb
        6uMssbT20V2ie3ERvL/tLf5nmA+7XfrvGkdS00VHKQ==
X-Google-Smtp-Source: ADFU+vs+lTx9hER5McUabLfcl4hXpBx6bhOxOtGZRV+SpUcFTItUjI5/V8SW2oq31TxnXWiXJtTipm8bfOxpw2Twgp8=
X-Received: by 2002:a19:a401:: with SMTP id q1mr7550442lfc.157.1585278370632;
 Thu, 26 Mar 2020 20:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200326163245.119670-1-jannh@google.com> <20200327024500.GA211096@google.com>
In-Reply-To: <20200327024500.GA211096@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 27 Mar 2020 04:05:43 +0100
Message-ID: <CAG48ez32cmGxHfijeK1YJLU8WdYv=qooXDYE+PSD7-Wwjg4DuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make printk_deferred() work properly before percpu
 setup is done
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 3:45 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (20/03/26 17:32), Jann Horn wrote:
> > While I was doing some development work, I noticed that if you call
> > printk_deferred() before percpu setup has finished, stuff breaks, and
> > e.g. "dmesg -w" fails to print new messages.
> >
> > This happens because writing to percpu memory before percpu
> > initialization is done causes the modified percpu memory to be
> > propagated from the boot CPU to all the secondary CPUs; and both the
> > printk code as well as the irq_work implementation use percpu memory.
> >
> > I think that printk_deferred() ought to work even before percpu
> > initialization, since it is used by things like pr_warn_ratelimited()
> > and the unwinder infrastructure. I'm not entirely sure though whether
> > this is the best way to implement that, or whether it would be better to
> > let printk_deferred() do something different if it is called during
> > early boot.
>
> Hi Jann,
>
> I believe we have a patch for this issue
>
> https://lore.kernel.org/lkml/20200303113002.63089-1-sergey.senozhatsky@gmail.com/

Ah, thanks, I didn't think of searching the list archives for an
existing pending patch...
