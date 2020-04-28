Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B3C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28167206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="S9/mpZk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgD1O5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1O5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:57:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B787C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:57:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so17139784lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pYldvLV/gVCwLCXJG2H7I1itLEQ+WPd52A+pM1rS5s=;
        b=S9/mpZk6b0C8kH1z/+2Hb/MyGg1vdMdXEy2TANzfwGjfT2+7Q8xLLOkZFKhxYCDyW7
         eSiY44+1bweYxGxOKKvfYbSIKiubGLJl7aY1r3hYAQaN/yt0WqXp6Dy7JgMCUrt1iBhq
         XCP26NXykRimBGkPPqdb7VeNein9tJ6U0rwjQ69mjBkr4d/vBuSIKVhLC3rgGc23ThqR
         rYQ/qk3Cy/uS4fmm9bzAtm45h1YuDjcs54cwSK716jsdXDjviOgWWkyHCh3b7Rnvj9vo
         PL57x1DNaqvZQAi6lmANu4XuyT+/chIaFYQdIEQnF7h73929k097NwCLVpmRmUoeY+tW
         FHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pYldvLV/gVCwLCXJG2H7I1itLEQ+WPd52A+pM1rS5s=;
        b=pNd3OOZUkx2+0EMkd9Syr5B096mRL5L1KB/8GT7/48rTp9rOR6ppdPeccKT6lR4yEX
         THlzfgnk2y4aKA+cZCg6l8zkbCpHyVK2qIoFGxtN6bjLS7vZVwRyGhQVLTs5SVGlHmh3
         KoBrYeh+VwzDQP7a8PigxH/q9FaXAJcbWwlwOfN8bk/plR5P0HHjQso3X7UObLnUUKvU
         IpTcOg2+TUB5mIGh9NrIS6Hb0xeSrQk4QaPJAKkoVpa5MSB3nUVDj4Q9H/dLMfHJoylu
         inDnlzqEq7sXzH7kRAz007W2xzI3kPoDN5lYuS/Cjxyz8EV533E2rR/Ndq6MAFohCezt
         f+XQ==
X-Gm-Message-State: AGi0Pua6cwzYp6vU8DDId+HwR5buvyzy2Z750sO07DZ9I01CXPHSoKrI
        /lUYlee6oM2ajsT/lToaOOwIBkg26zy4yZ2zqWPeng==
X-Google-Smtp-Source: APiQypL5GJ29gOUynll/hdbbuwXoU4xD+j2nR/v1vFlTgeAng8OTy3G9J0eh3+8HNK5w1oKRGEkYRCBtwbX87dtudlc=
X-Received: by 2002:ac2:4546:: with SMTP id j6mr19867267lfm.203.1588085851962;
 Tue, 28 Apr 2020 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200427074222.65369-1-maco@android.com> <20200427170613.GA13686@lst.de>
 <CAB0TPYGZc_n-b5xtNsbJxEiqpLMqE=RcXGuy7C2vbY18mKZ6_A@mail.gmail.com> <20200428070200.GC18754@lst.de>
In-Reply-To: <20200428070200.GC18754@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 28 Apr 2020 16:57:21 +0200
Message-ID: <CAB0TPYF4yHwXTG2xb5yci9-KJiT5=VbwWz9yj+uyBwb2rSi8Rg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 9:02 AM Christoph Hellwig <hch@lst.de> wrote:
> I think reusing LO_FLAGS_DIRECT_IO makes sense to me - we have 32
> flags in the existing flags field (at least for loop_info64), so
> we might as well use the field and the flags.  Then we need flags
> validation in that we don't accept new flags through the old
> interface, and the new one validates that no unknown flags are passed.
>
> E.g. in the LOOP_SET_STATUS / LOOP_SET_STATUS64 handler do:
>
>         lo->lo_flags &= ~(LO_LEGACY_FLAGS);
>

mmm, I thought lo_flags was read-only in LOOP_SET_STATUS(64):

     __u32              lo_flags;                    /* ioctl r/o */

but it looks LO_FLAGS_AUTOCLEAR is writable:

 if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
               (info->lo_flags & LO_FLAGS_AUTOCLEAR))
                  lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;

and it allows requesting a partition scan. It makes sense to maintain
that behavior, but what about LO_FLAGS_DIRECT_IO? I think you're
proposing LOOP_SET_STATUS(64) should keep ignoring that like it used
to?

Thanks,
Martijn

> and then in the main function reject anything not known.
>
> And then maybe add something like 64 bytes of padding to the end of the
> new structure, so that we can use flags to expand to it.
