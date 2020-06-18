Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A86C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A54208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592501523;
	bh=MbP7mOWx2ZQ1ah+GMFiLoS/ALpIMALMfhPkMBfn1PDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lWQK/EUvchlY+Uza3kRt1A7B/W9nMrZoUiVCmV0QyvqrV8Z2UUouQ0tPwqaSZ8dfJ
	 QRYZgf3Czgrm9ODFSvLLagCdusowjcyYjl0cBau+FVt1UClW71Q/bft3BmGgQkUZM3
	 2i2SADN3xJOW0E1lKD7wcEgHndxhc6S92SlN0sj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgFRRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgFRRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:32:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C50C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:31:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so3942065lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+3l/Q75hqlpfPKwrMFPeUpG34nLQQoZ+DZeejxM3lw=;
        b=Q94LAWyM6UdCyep6rbdX5AX8SjBXawSqnaVirWZoydAHwNL/wFfTDJekv4KBa2OPH6
         zhZNqgptSqdtLsjL0MXsWeiy8eWCp+2xG00DTgMPAt1rmxw41d789sD7wvPS6v6y5K5W
         TKqQ8fxlm7n/aIr0IsoaJluEsN2RG3kdIl9zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+3l/Q75hqlpfPKwrMFPeUpG34nLQQoZ+DZeejxM3lw=;
        b=qfqysSQxViicDUFsvY1v3R2HCeD4LiKkv86UEQG0oF2tR5+aTzbRVEBKLkZYLvw5C5
         tJlxSLwMvEBhHKFAGF6joAXvCjLo3iwBQPRFURssU9uGwi5KbCYDGZ4AWCEwhON+gUpu
         YIrHct52rLBKQ+3PkxlcOJ07MzHWBb5jv2ltu0JP3MLJpdbZZlXIVlDpx2w0VQGLr0ag
         YAwarrZALv78PxBUGr3PBkaCrfSHLyE5I689nZ4JArEm6ZvaxazbGsQv9JKarrgT9ZtL
         OAMCcZSiE5FuNvgexE9yyzG1eKyeLYtvAQh9JyaTQzcFNtIWQkmhY7jC8j4DNP0TNuc9
         x/yg==
X-Gm-Message-State: AOAM5309ZNUesJrRCPtjrzGYTiePI/GJ9r2n/iDcXRYN7Xy1X0MrWTzz
        ZXr0C33DDO1s0/MHnsU9eSWIRoRj4t8=
X-Google-Smtp-Source: ABdhPJyY4cNAylV+WN84k7qeJlik3NWgNyJPhLCUDih6RfsOLYy1ntEloEDdIGy2S8dMV0fbLVfTig==
X-Received: by 2002:a19:4915:: with SMTP id w21mr2937416lfa.153.1592501517788;
        Thu, 18 Jun 2020 10:31:57 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q27sm738387ljm.60.2020.06.18.10.31.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:31:57 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id n23so8246441ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:31:56 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr2689369ljn.70.1592501516416;
 Thu, 18 Jun 2020 10:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200618005117.GB5279@shao2-debian> <0cc7fed8-faaf-459a-8b78-a9f66b556c1d@i-love.sakura.ne.jp>
In-Reply-To: <0cc7fed8-faaf-459a-8b78-a9f66b556c1d@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 10:31:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpdB+4nBqjxvyeJ2OdZ1tTMADC=BDJW3Q9RK_swhN_qA@mail.gmail.com>
Message-ID: <CAHk-=wgpdB+4nBqjxvyeJ2OdZ1tTMADC=BDJW3Q9RK_swhN_qA@mail.gmail.com>
Subject: Re: [pipe] 566d136289: stress-ng.tee.ops_per_sec -84.7% regression
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:18 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This would be because the test case shows higher performance if the pipe writer does busy wait.
> This commit fixed an unkillable busy wait bug when the pipe reader does not try to read.
>
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
>
> We can't fix the issue. ;-)

Well, it does highlight that there are potential loads that would
prefer spinning to wait for data rather than returning early.

Put another way: right now we are very eager to return -EAGAIN for
nonblocking pipe writers, and sleeping for blocking ones. I didn't
check which of those cases that stress-ng.tee.ops_per_sec thing is
testing.

But the improvement in the numbers implies that it might be worth it
to have optimistic logic for "spin for a bit waiting for a concurrent
reader". Kind of like the old logic we used to have to try to avoid
extra system calls on the reader side (where we'd give an existing
writer the chance to fill the buffer instead of returning early).

The old reader-side optimization was somewhat painful, and didn't
really help much on SMP anyway. But particularly for the "we just
dropped the locks, and we're going to wait" case, maybe it's worth
looking at whether dropping the locks now woke somebody else up on
another CPU, and we might spin for a short while synchronously...

IOW, conceptually all the same optimistic spinning stuff that we do
for semaphores..

It would likely be a somewhat involved thing, though. We'd have to
make wakeup_pipe_readers/writers() return a "did I wake up somebody
else on another CPU" return value for hinting whether it might be
worth it, and we'd have to then add the logic to see if it's worth
spinning for a while waiting for them to fill the input queue (or
empty the output one) and then continue the splice() op.

That 84% change sounds like it *might* be worth doing some extra work
for. splice() itself might not be so interesting, but the exact same
logic is presumably worth something for a pipe read/write pair...

Anybody interested in trying?

               Linus
