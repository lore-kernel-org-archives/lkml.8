Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A13C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F16F206E7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZBOMk5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCNCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:04:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726414AbgCNCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584151476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6RAx+7LOoPDzXiiWu3DOXxzSvsuGCCdOqrRwdKhl/8=;
        b=QZBOMk5vh5Vmw4GGOvZfLKNCe6so71dsS5XypdudT+ZjVaTCNQ2lHfYdHRV2CUS0UVf96i
        XlhX54AdXq0TauHKH+Wum40MIOXzYarLZmcQ1G3GF3yWZ0MmP3VEk7CwFEuj+6RNZSpp7U
        pRndVgCn6OibKluOcFnCrDnhc4CfeFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-oTmEI7OUNIG_-4HoDnRjUg-1; Fri, 13 Mar 2020 22:04:34 -0400
X-MC-Unique: oTmEI7OUNIG_-4HoDnRjUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E6118C35A0;
        Sat, 14 Mar 2020 02:04:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28BAA8F34D;
        Sat, 14 Mar 2020 02:04:21 +0000 (UTC)
Date:   Sat, 14 Mar 2020 10:04:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
Message-ID: <20200314020416.GA13295@ming.t460p>
References: <20200312205830.81796-1-peterx@redhat.com>
 <878sk4ib93.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sk4ib93.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:24:08PM +0100, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > After we introduced the "managed_irq" sub-parameter for isolcpus, it's
> > possible to free a kernel managed irq vector now.
> >
> > It can be triggered easily by booting a VM with a few vcpus, with one
> > virtio-blk device and then mark some cores as HK_FLAG_MANAGED_IRQ (in
> > below case, there're 4 vcpus, with vcpu 3 isolated with managed_irq):
> >
> > [    2.889911] ------------[ cut here ]------------
> > [    2.889964] WARNING: CPU: 3 PID: 0 at arch/x86/kernel/apic/vector.c:853 free_moved_vector+0x126/0x160
> 
> <SNIP>
> 
> > [    2.890026] softirqs last disabled at (8757): [<ffffffffbb0ecccd>] irq_enter+0x4d/0x70
> > [    2.890027] ---[ end trace deb5d563d2acb13f ]---
> 
> What is this backtrace for? It's completly useless as it merily shows
> that the warning triggers. Also even if it'd be useful then it wants to
> be trimmed properly.
> 
> > I believe the same thing will happen to bare metals.
> 
> Believe is not really relevant in engineering.
> 
> The problem has nothing to do with virt or bare metal. It's a genuine
> issue.
> 
> > When allocating the IRQ for the device, activate_managed() will try to
> > allocate a vector based on what we've calculated for kernel managed
> > IRQs (which does not take HK_FLAG_MANAGED_IRQ into account).  However
> > when we bind the IRQ to the IRQ handler, we'll do irq_startup() and
> > irq_do_set_affinity(), in which we will start to consider the whole
> > HK_FLAG_MANAGED_IRQ logic.  This means the chosen core can be
> > different from when we do the allocation.  When that happens, we'll
> > need to be able to properly free the old vector on the old core.
> 
> There's lots of 'we' in that text. We do nothing really. Please describe
> things in neutral and factual language.
> 
> Also there is another way to trigger this: Offline all non-isolated CPUs
> in the mask and then bring one online again.
> 
> Ming, I really have to ask why these two situations were not tested
> before the final submission of that isolation patch. Both issues have
> been discussed during review of the different versions. So the warning
> should have triggered back then already....

Hi Thomas,

I run CPU hotplug & unplug stress test with isolcpus:managed_irq, however
the test just checks if the irq's effective vector is setup correctly and
IO can be run as expected.

Looks dmesg warning is missed to check, sorry for that.

Thanks,
Ming

