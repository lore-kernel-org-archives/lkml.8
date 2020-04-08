Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2B1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB832074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDHNd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgDHNd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:33:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B99FAE59;
        Wed,  8 Apr 2020 13:33:53 +0000 (UTC)
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
To:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org,
        bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com,
        boris.ostrovsky@oracle.com, mihai.carabas@oracle.com,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408120856.GY20713@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <bcf8206d-5a41-4e6b-1832-75ba1d6367e4@suse.com>
Date:   Wed, 8 Apr 2020 15:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408120856.GY20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 14:08, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 10:02:57PM -0700, Ankur Arora wrote:
>> Mechanism: the patching itself is done using stop_machine(). That is
>> not ideal -- text_poke_stop_machine() was replaced with INT3+emulation
>> via text_poke_bp(), but I'm using this to address two issues:
>>   1) emulation in text_poke() can only easily handle a small set
>>   of instructions and this is problematic for inlined pv-ops (and see
>>   a possible alternatives use-case below.)
>>   2) paravirt patching might have inter-dependendent ops (ex.
>>   lock.queued_lock_slowpath, lock.queued_lock_unlock are paired and
>>   need to be updated atomically.)
> 
> And then you hope that the spinlock state transfers.. That is that both
> implementations agree what an unlocked spinlock looks like.
> 
> Suppose the native one was a ticket spinlock, where unlocked means 'head
> == tail' while the paravirt one is a test-and-set spinlock, where
> unlocked means 'val == 0'.
> 
> That just happens to not be the case now, but it was for a fair while.

Sure? This would mean that before spinlock-pvops are being set no lock
is allowed to be used in the kernel, because this would block the boot
time transition of the lock variant to use.

Another problem I'm seeing is that runtime pvops patching would rely on
the fact that stop_machine() isn't guarded by a spinlock.


Juergen
