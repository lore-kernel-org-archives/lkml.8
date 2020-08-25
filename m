Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBCFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0238A206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="c4ZZgQ2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHYAdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgHYA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56906C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:29:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so5935538pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rK9hGhgXVC8NPfqVY3Kpb9dQwJZSivpy8q2Mup6dtSM=;
        b=c4ZZgQ2YaOyAq7e5T+tyFU0xqMufACY+Y4SnbIlMwiY/5sKjRW9L+obI/uA+5stwVq
         JHkc5gnYKmKcZpu+NiFL8tXyLRyHW51aSKG5zmYRQHrPXaVIuq5NgouoW4qDOmWehjqd
         zj16E4/59kSSYwyPHHVeVxpg9v3KtL3+FOfjWUB1RdcCArxJqS3i1lVzSKgQ3yw2YL9M
         Z6pcqkvhHkvgQgG7oLp3n1p0Syg9AhEy+QWNtmtUU3R1boenHXU67c55myRV+Wm8XHos
         McZfUvW3KGoL+k2BVCKHx3Y3+49MLogFiC5xStqzaBZh/NGJ2gpPhZWsGXD2nq0l5LFg
         wLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rK9hGhgXVC8NPfqVY3Kpb9dQwJZSivpy8q2Mup6dtSM=;
        b=djxRcZv58Ij8kz7xCrElXzZFputcQIGU8vwybsy09G6udjMQdIByX3WNGwMuAtTrnn
         5+V/rYRVliV0q3TeSgcbPegSPwIJwbMLcgG2mHz4d3p/h0RDPLV2DWs0gijGBzKCNxTr
         T0Sfd6dTqemawIorB8xZ1/Itrd03HVuGYG9aPcpgaJmUCduh4i0JHdR1KsG0LcRt9BbO
         qAck14JrlC+s7wSFF0UrNcbUkeXQwM/aLJwQ4VHxrcx5Z/U0GB5qIN6jLN+GFtuEOOdf
         KDcdGUMZRtG5z4X7lEfSgrQGrnYnxBBNsbcvVSYGyq86ZOKDZ30UQnk8yymcOyI8M/I8
         XVDw==
X-Gm-Message-State: AOAM530JIaTWOoP1oW4R94qd0EO9lmysAFIrlYACWcSzqOoAYGBpsTEq
        y8j5PeDUZaPp3mfQiYy5CALjqA==
X-Google-Smtp-Source: ABdhPJw/jqpwfLOw3R6pkLUIZZ4Ecso+LA6G75jVVfmfWTR2dmWId+wwLT6HnFSbtT7bjTfvJeyROw==
X-Received: by 2002:aa7:9aa2:: with SMTP id x2mr6097798pfi.318.1598315373559;
        Mon, 24 Aug 2020 17:29:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w130sm12707231pfd.104.2020.08.24.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 17:29:32 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:29:32 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Aug 2020 17:29:28 PDT (-0700)
Subject:     Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
In-Reply-To: <20200813113743.001b6c31@oasis.local.home>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-5de4c6ca-7e77-4b55-9097-59296872e6de@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 08:37:43 PDT (-0700), rostedt@goodmis.org wrote:
> On Wed, 12 Aug 2020 22:13:19 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> Sorry, I'm not really sure what's going on here.  I'm not really seeing code
>> that matches this in our port right now, so maybe this is aginst some other
>> tree?  If it's the RISC-V kprobes patch set then I was hoping to take a look at
>> that tomorrow (or I guess a bit earlier this week, but I had some surprise work
>> stuff to do).  IIRC there were a handful of races in the last patch set I saw,
>> but it's been a while so I don't remember for sure.
>>
>> That said, I certainly wouldn't be surprised if there's a locking bug in our
>> ftrace stuff.  It'd be way easier for me to figure out what's going on if you
>> have a concrete suggestion as to how to fix the issues -- even if it's just a
>> workaround.
>
> The issue is actually quite basic.
>
> ftrace_init_nop() is called quite early in boot up and never called
> again. It's called before SMP is set up, so it's on a single CPU, and
> no worries about synchronization with other CPUs is needed.
>
> On x86, it is called before text_poke() is initialized (which is used
> to synchronize code updates across CPUs), and thus can't be called.
> There's a "text_poke_early()" that is used instead, which is basically
> just a memcpy().
>
> Now, if ftrace_init_nop() is not defined by the architecture, it is a
> simple call to ftrace_make_nop(), which is also used to disable ftrace
> callbacks.
>
> The issue is that we have the following path on riscv:
>
>  ftrace_init_nop()
>    ftrace_make_nop()
>      __ftrace_modify_call()
>        patch_text_nosync()
>          patch_insn_write()
>            lockdep_assert_held(&text_mutex);
>
> Boom! text_mutex is not held, and lockdep complains.
>
>
> The difference between ftrace_make_nop() being called by
> ftrace_init_nop() and being called later to disable function tracing is
> that the latter will have:
>
>
> 	ftrace_arch_code_modify_prepare();
> 	[..]
> 	ftrace_make_nop();
> 	[..]
> 	ftrace_arch_code_modify_post_process();
>
> and the former will not have those called.
>
> On x86, we handle the two different cases with:
>
>
> static int ftrace_poke_late = 0;
>
> int ftrace_arch_code_modify_prepare(void)
> {
> 	mutex_lock(&text_mutex);
> 	ftrace_poke_late = 1;
> 	return 0;
> }
>
> int ftrace_arch_code_modify_post_process(void)
> {
> 	text_poke_finish();
> 	ftrace_poke_late = 0;
> 	mutex_unlock(&text_mutex);
> }
>
> Although, the post_process() probably doesn't even need to set
> ftrace_poke_late back to zero.
>
> Then in ftrace_make_nop(), we have:
>
>   ftrace_make_nop()
>     ftrace_modify_code_direct()
>       if (ftrace_poke_late)
>         text_poke_queue(...); // this checks if text_mutex is held
>       else
>         text_poke_early(...); // is basically just memcpy, no test on text_mutex.
>
> The two solutions for riscv, is either to implement the same thing as
> above, or you can create your own ftrace_init_nop() to take the
> text_mutex before calling ftrace_make_nop(), and that should work too.

Ya, thanks, that's a pretty straight-forward issue.  I've To'd you on a patch,
but it's essentially just exactly what you suggested so I doubt it's that
interesting.

I pointed out in the patch notes that it seems reasonable to have the generic
code handle this case, would you be opposed to doing it that way?
