Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F3C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F289020820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589120245;
	bh=NcHP7PMd0HXApatvGbvOymmYm7xrk960gseZ5NaDr94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QATPUkZ6jo//BucfxTHl/hu8cjUhT+gPqUfmpM0xBQOGWB8oPnp0qcs6e3dJxX7a5
	 AVHUWdYJ1+0/drWWAs43WDUZ9un20eBHlNlFXl+a3H9Ya/s6QghTG2UVuyBFmOHnsV
	 vr+l8UAH5g2ufCqWakpwDsA3bhEuokiDQQ4WHyQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgEJORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgEJORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:17:23 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C37820731;
        Sun, 10 May 2020 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589120243;
        bh=NcHP7PMd0HXApatvGbvOymmYm7xrk960gseZ5NaDr94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MU48330oSkeIyrauj9l8jfZAxRCyjJrF8QvJYOIOk7/c121S4+u1LpHxu6K4qDPPX
         FR+nYCTvtJbuW6lm2ZPG4k1Q5LzJgdj01htjDFE+s/wUxd9whcXKxByDzpyL3sp/wq
         lG0WFTilwNL9/MXLw3uKpXiU1RxFwsEAKLkAy0sg=
Date:   Sun, 10 May 2020 10:17:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, tony.luck@intel.com,
        ak@linux.intel.com, chang.seok.bae@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
Message-ID: <20200510141722.GM13035@sasha-vm>
References: <20200423232207.5797-1-sashal@kernel.org>
 <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
 <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
 <87h7wo3xkp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87h7wo3xkp.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:15:34PM +0200, Thomas Gleixner wrote:
>Vegard Nossum <vegard.nossum@oracle.com> writes:
>> On 5/10/20 10:09 AM, Vegard Nossum wrote:
>>
>> I spoke a few minutes too soon. Just hit this, if anybody wants to have
>> a look:
>>
>> [ 6402.786418] ------------[ cut here ]------------
>> [ 6402.787769] WARNING: CPU: 0 PID: 13802 at arch/x86/kernel/traps.c:811
>> do_debug+0x16c/0x210
>
>> [ 6402.820353] Call Trace:
>> [ 6402.821043]  <#DB>
>> [ 6402.821622]  debug+0x37/0x70
>> [ 6402.822449] RIP: 0010:arch_stack_walk_user+0x79/0x110
>
>That's a cute way to trigger that WARN_ON in the #DB handler.
>
>> [ 6402.816468] DR0: 0000000000000001 DR1: 0000000040006070 DR2: 00007ffff7ffd000
>> [ 6402.818406] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000003b3062a
>
>#DB recursion
>
>  [ 6402.832288] RDX: 0000000040006073
>
>27:	48 8b 1a      mov    (%rdx),%rbx
>
>Breakpoint on user space stack, #DB triggers and the low level ASM
>irqflags tracepoint has stacktrace enabled which unwinds into the user
>stack and triggers #DB again.
>
>Bah. I know why I want to ban all that tracing muck from low level entry code.
>
>> It might not be related to the patch set, mind.
>
>It's unrelated.

Thanks for testing Vegard!

-- 
Thanks,
Sasha
