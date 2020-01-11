Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FDDC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481AD2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgAKNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 08:22:53 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52060 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729415AbgAKNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 08:22:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnPE3K6_1578748966;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnPE3K6_1578748966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jan 2020 21:22:47 +0800
Subject: Re: [PATCH] KVM: remove unused guest_enter/exit
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
 <c84ec6d3-4f5a-a24e-d907-8e5bc2729dbe@redhat.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <668e6bcb-89b9-7256-5492-274da5ea5836@linux.alibaba.com>
Date:   Sat, 11 Jan 2020 21:21:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c84ec6d3-4f5a-a24e-d907-8e5bc2729dbe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/1/11 下午7:32, Paolo Bonzini 写道:
> On 10/01/20 04:13, Alex Shi wrote:
>> After commit 6edaa5307f3f ("KVM: remove kvm_guest_enter/exit wrappers")
>> no one uses guest_enter/exit anymore.
>>
>> So better to remove them to simplify code and reduced a bit of object
>> size.
> 
> There is no reduction in object size, since these are inlines.  But PPC
> still uses them.
> 
> Paolo
> 

Thanks a lot Paolo. It's my fault to ommit the guest_exit checking.
Yes, guest_exit is still in using. but guest_enter isn't. no one use it. 

So how about this?

Thanks
Alex

---

From 5770c6b8b43adc1e26ecfe696488ccc01896ebfd Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sat, 11 Jan 2020 20:25:45 +0800
Subject: [PATCH] KVM: remove unused guest_enter

No one uses guest_enter anymore, so better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/context_tracking.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 64ec82851aa3..8150f5ac176c 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -154,15 +154,6 @@ static inline void guest_exit_irqoff(void)
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
-static inline void guest_enter(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_enter_irqoff();
-	local_irq_restore(flags);
-}
-
 static inline void guest_exit(void)
 {
 	unsigned long flags;
-- 
1.8.3.1

