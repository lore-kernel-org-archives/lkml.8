Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CCC207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zJXG3v/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHEDPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:15:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A4C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:15:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w19so11485947plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VtIghFUUQN5mDIDgH3ibaPqJHhjrfIMsBIz4Kx+N5Ow=;
        b=zJXG3v/hVCrB+1rVcOQ6m9Yd0dtr2TN4bTZWw8Zu1q5/MQWvJ4DwFqCrIcfwGunIEp
         ucW/z3YH4km9BvKmyUXePzMMjY7EgMsbXoWGeRueG7leIua6KOTit+hv0QLyEhY007Io
         VFcoElqsSZkts2Evqn94Us0FFofeU+X0vJyPc7J0K6u/ma9K7E8rE/8v+A/bT9fWF7C5
         CHjKNqngi+xZAVGpkMVDUHIU87S50gkaXEb+OqkdzNnc1y4y440Tu0/ccW5d6CfKfys5
         Ptma1t87IloKNk5AuPTCYukFVebK9gKUXA2Z7jT6z4luMlaFrOVkl2LR9GCbaEbpi9yi
         yAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VtIghFUUQN5mDIDgH3ibaPqJHhjrfIMsBIz4Kx+N5Ow=;
        b=uNFeq/H0Ne/YSiNLNXYU7ZcO52A/l6myCzmF/5dNUVuzDDv2eEnQWgqRzH7YKc443I
         HNJyYSc0iW8rPv15DgTZIMCf8gdLwKDaTWUnaIfsNCFGBjAiVlf66T6g7tzuOURfplS2
         eID+GCRWcLb97+ccBrZZyknVHoKoINDamffp1I6HKGtwgtbX1bCJSADo0Nqx7OVEvDJa
         OL2ki3BkSI7dSxHD6qFFwwjq3oden0Ysz01EqGpyF3CkWsqZoHbnw4BRHFeQEv4ZVNid
         45TTTfAFA6wxeaksc3cjRWxD74lsLOMPljjL6zZeQb+UHQvkaUp9MVRlO8r0q9I/mRp1
         OJwg==
X-Gm-Message-State: AOAM531aNPtXLFV15fINXGwDzqJIKONr98y5Wj5kAyqqT9tvtdYKGZ3I
        i9DyU6GyJ+G1gDUIGTjEH6xBtw==
X-Google-Smtp-Source: ABdhPJwACgfukRamo/zUHdUPi8KTwWhQHcSlNJgrqdqyEldAO2Q5ZM3XH0cxBgJ2eb195FpT47V41Q==
X-Received: by 2002:a17:90a:25a9:: with SMTP id k38mr1178872pje.103.1596597321290;
        Tue, 04 Aug 2020 20:15:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id il10sm816178pjb.54.2020.08.04.20.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:15:20 -0700 (PDT)
Date:   Tue, 04 Aug 2020 20:15:20 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 20:15:19 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: ptrace: Use the correct API for `fcsr' access
In-Reply-To: <20200805024807.GM1236603@ZenIV.linux.org.uk>
CC:     macro@wdc.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     viro@zeniv.linux.org.uk
Message-ID: <mhng-2d0483dd-411b-4e2b-aae1-b8bb52417d29@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Aug 2020 19:48:07 PDT (-0700), viro@zeniv.linux.org.uk wrote:
> On Tue, Aug 04, 2020 at 07:20:05PM -0700, Palmer Dabbelt wrote:
>> On Tue, 04 Aug 2020 19:07:45 PDT (-0700), viro@zeniv.linux.org.uk wrote:
>> > On Tue, Aug 04, 2020 at 07:01:01PM -0700, Palmer Dabbelt wrote:
>> >
>> > > > We currently have @start_pos fixed at 0 across all calls, which works as
>> > > > a result of the implementation, in particular because we have no padding
>> > > > between the FP general registers and the FP control and status register,
>> > > > but appears not to have been the intent of the API and is not what other
>> > > > ports do, requiring one to study the copy handlers to understand what is
>> > > > going on here.
>> >
>> > start_pos *is* fixed at 0 and it's going to go away, along with the
>> > sodding user_regset_copyout() very shortly.  ->get() is simply a bad API.
>> > See vfs.git#work.regset for replacement.  And ->put() is also going to be
>> > taken out and shot (next cycle, most likely).
>>
>> I'm not sure I understand what you're saying, but given that branch replaces
>> all of this I guess it's best to just do nothing on our end here?
>
> It doesn't replace ->put() (for now); it _does_ replace ->get() and AFAICS the
> replacement is much saner:
>
> static int riscv_fpr_get(struct task_struct *target,
>                          const struct user_regset *regset,
>                          struct membuf to)
> {
> 	struct __riscv_d_ext_state *fstate = &target->thread.fstate;
>
> 	membuf_write(&to, fstate, offsetof(struct __riscv_d_ext_state, fcsr));
> 	membuf_store(&to, fstate->fcsr);
> 	return membuf_zero(&to, 4);     // explicitly pad
> }
>
> user_regset_copyout() calling conventions are atrocious and so are those of
> regset ->get().  The best thing to do with both is to take them out of their
> misery and be done with that.  Do you see any problems with riscv gdbserver
> on current linux-next?  If not, I'd rather see that "API" simply go away...
> If there are problems, I would very much prefer fixes on top of what's done
> in that branch.

I guess my confusion was about "start_pos *is* fixed at 0": it certainly is
zero in the code right now, but when poking around while review the patch I
didn't see any reason that must be so.  Admittedly all I did was read the
prototype and function, so maybe I'm just missing something.  That said, if
it's all going away anyway then I don't really care either way.

As far as I can tell the patch set in question (the RISC-V one) doesn't change
any functionality.  I don't actually use GDB, but I haven't seen any issues
reported in a few years so if there is one I've missed it.

I did this ptrace stuff many years ago (IIRC it was actually my first RISC-V
Linux patch), and all I really remember is that it seemed way more complicated
than it needed to be.  I'm happy to just drop our patch set, as yours looks way
cleaner to me and if you're already planning on fixing put() then it doesn't
seem worth the churn.
