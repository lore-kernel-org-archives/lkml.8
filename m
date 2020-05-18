Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C444C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFFA207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgERQmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CFEAAC6C;
        Mon, 18 May 2020 16:42:32 +0000 (UTC)
Date:   Mon, 18 May 2020 09:37:00 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        torvalds@linux-foundation.org, will@kernel.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/5] rcuwait: Introduce rcuwait_active()
Message-ID: <20200518163700.4nn4csjlbpcixmsv@linux-p48b>
References: <20200424054837.5138-1-dave@stgolabs.net>
 <20200424054837.5138-5-dave@stgolabs.net>
 <57309494-58bf-a11e-e4ac-e669e6af22f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <57309494-58bf-a11e-e4ac-e669e6af22f2@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020, Paolo Bonzini wrote:

>On 24/04/20 07:48, Davidlohr Bueso wrote:
>> +/*
>> + * Note: this provides no serialization and, just as with waitqueues,
>> + * requires care to estimate as to whether or not the wait is active.
>> + */
>> +static inline int rcuwait_active(struct rcuwait *w)
>> +{
>> +	return !!rcu_dereference(w->task);
>> +}
>
>This needs to be changed to rcu_access_pointer:
>
>
>--------------- 8< -----------------
>From: Paolo Bonzini <pbonzini@redhat.com>
>Subject: [PATCH] rcuwait: avoid lockdep splats from rcuwait_active()
>
>rcuwait_active only returns whether w->task is not NULL.  This is
>exactly one of the usecases that are mentioned in the documentation
>for rcu_access_pointer() where it is correct to bypass lockdep checks.
>
>This avoids a splat from kvm_vcpu_on_spin().
>
>Reported-by: Wanpeng Li <kernellwp@gmail.com>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
