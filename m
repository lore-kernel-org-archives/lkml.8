Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCCD2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="140/DSYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgIHRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:43:01 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:36701 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbgIHRm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:42:28 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 832e0821
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=O1y/MP6BAJBcGK9O2C6twcvboJc=; b=140/DS
        YGC+zc+6THM1gigQAIcITIcZPrYWw0mr27ZP56zdy8kKFccpokpzcb9/syJquCfo
        uH0hYSXNTeNk5WKbZe18I0qvdXFOOIWxnx24bgXvfroORab3d+93a8ijLYpjoUTd
        jz+Lg7evjS7RzZuQhVMy0biNFXUM1U6MYWR6KfMT+hIUjqqeiCBR1v6w7i5vUHdQ
        xBTWCkvHnrmmHM7tFs3b9BCvoY70F8Ltqc4A7LL/z6i9I04pMUYzyheA0K7XSVwt
        3IL4DpC9E1+CpwBv6IRsoQpubc/DMRmHJ6gIrqhtIdrFErpqVco6FI/e0zplk+Rl
        TbmeK5VQYXGstP0A==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 438e7a61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 17:13:30 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id m17so262366ioo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:42:24 -0700 (PDT)
X-Gm-Message-State: AOAM530F/p4r/Z3YB0ZlIp8gFtMZFLS698daJ2zdkDbWKGKc8clXl6WJ
        8aLnvc8fy6A4M1n/Nq6rA7J07tM3oy/5yWuT5dI=
X-Google-Smtp-Source: ABdhPJxEl8mIf/ma7/WnS3cspoEK7tA9iqYNZ+XKMw4mnqGQQyjh8teBzMH9CzZJhd9V+lItr/7qYT5QEJhDQFAnCo8=
X-Received: by 2002:a6b:7112:: with SMTP id q18mr21480718iog.79.1599586943669;
 Tue, 08 Sep 2020 10:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic> <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic>
In-Reply-To: <20200908173656.GI25236@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Sep 2020 19:42:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
Message-ID: <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 7:36 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 08, 2020 at 07:29:11PM +0200, Jason A. Donenfeld wrote:
> > Well that's not cool.
>
> So you're saying that if someone wants to kill its box by poking at that
> MSR, we should just let her/him?
>
> If anything, I think that a BIG FAT WARNING at least would make sense.

Are you prepared to track down all the MSRs that might maybe do
something naughty?

After determining optimal voltages, people have systemd running
intel-undervolt for them. It becomes part of the normal system
configuration, is applied all the time, and after figuring it out
once, users forget they ever had enabled it, except when observing
that their laptop works better than it originally did.

Does `dd` warn when you run `dd if=/dev/zero of=/dev/sda`?

> Now, if there were a proper interface which would allow only valid
> commands, now that would be optimal...

Probably not possible. Optimal values are related to the "silicon
lottery" that occurs when you buy a new CPU. Different optimal values
for different individual chips.
