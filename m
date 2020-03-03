Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223820838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgCCOMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:12:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:12:13 -0500
Received: from [5.158.153.55] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j98HG-0007lB-6g; Tue, 03 Mar 2020 15:12:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D8A59104098; Tue,  3 Mar 2020 15:12:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] threads: Update PID limit comment according to futex UAPI change
In-Reply-To: <20200303102540.GC2579@hirez.programming.kicks-ass.net>
References: <20200302112939.8068-1-jannh@google.com> <20200303102540.GC2579@hirez.programming.kicks-ass.net>
Date:   Tue, 03 Mar 2020 15:12:00 +0100
Message-ID: <8736apede7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Mon, Mar 02, 2020 at 12:29:39PM +0100, Jann Horn wrote:
>> The futex UAPI changed back in commit 76b81e2b0e22 ("[PATCH] lightweight
>> robust futexes updates 2"), which landed in v2.6.17: FUTEX_TID_MASK is now
>> 0x3fffffff instead of 0x1fffffff. Update the corresponding comment in
>> include/linux/threads.h.
>> 
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>>  include/linux/threads.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/threads.h b/include/linux/threads.h
>> index 3086dba525e20..18d5a74bcc3dd 100644
>> --- a/include/linux/threads.h
>> +++ b/include/linux/threads.h
>> @@ -29,7 +29,7 @@
>>  
>>  /*
>>   * A maximum of 4 million PIDs should be enough for a while.
>> - * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
>> + * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
>>   */
>>  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>>  	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
>
> I just noticed another mention of this in Documentation/robust-futex-ABI.txt
> There it states that bit-29 is reserved for future use.
>
> Thomas, do we want to release that bit and update all this?

In fact we've released it long ago:

include/uapi/linux/futex.h:

#define FUTEX_TID_MASK          0x3fffffff

Thanks,

        tglx
