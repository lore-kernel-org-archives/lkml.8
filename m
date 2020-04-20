Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFDC55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E720724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDTVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:53:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTVxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:53:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EE2CAE47;
        Mon, 20 Apr 2020 21:53:41 +0000 (UTC)
Date:   Mon, 20 Apr 2020 14:50:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        peterz@infradead.org, torvalds@linux-foundation.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, linux-mips@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>, joel@joelfernandes.org,
        will@kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
Message-ID: <20200420215014.sarodevmhphnkkn7@linux-p48b>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
 <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
 <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020, Paolo Bonzini wrote:

>On 20/04/20 22:56, Davidlohr Bueso wrote:
>> On Mon, 20 Apr 2020, Marc Zyngier wrote:
>>
>>> This looks like a change in the semantics of the tracepoint. Before this
>>> change, 'waited' would have been true if the vcpu waited at all. Here,
>>> you'd
>>> have false if it has been interrupted by a signal, even if the vcpu
>>> has waited
>>> for a period of time.
>>
>> Hmm but sleeps are now uninterruptible as we're using TASK_IDLE.
>
>Hold on, does that mean that you can't anymore send a signal in order to
>kick a thread out of KVM_RUN?  Or am I just misunderstanding?

Considering that the return value of the interruptible wait is not
checked, I would not think this breaks KVM_RUN.

Thanks,
Davidlohr
