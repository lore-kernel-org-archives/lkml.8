Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381C4C5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D86520738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:25:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:25:41 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEHqK-00070c-F7; Tue, 17 Mar 2020 20:25:36 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 604D6101161; Tue, 17 Mar 2020 20:25:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ben Hutchings <ben@decadent.org.uk>,
        Edward Cree <ecree@solarflare.com>
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: Re: [PATCH] genirq: fix reference leaks on irq affinity notifiers
In-Reply-To: <18622dc08c49e7d4304f221e378137ecde09ba61.camel@decadent.org.uk>
References: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com> <17c4273e4f72ebdf1ca838d75fc6ed93fcdc7287.camel@decadent.org.uk> <a527a4bb-fdc4-815d-8852-674767b9dd1d@solarflare.com> <18622dc08c49e7d4304f221e378137ecde09ba61.camel@decadent.org.uk>
Date:   Tue, 17 Mar 2020 20:25:35 +0100
Message-ID: <87r1xqbx74.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hutchings <ben@decadent.org.uk> writes:
> On Tue, 2020-03-17 at 10:58 +0000, Edward Cree wrote:
>> On 15/03/2020 20:29, Ben Hutchings wrote:
>> > ...since the pending work item holds a reference to the notification
>> > state, it's still not clear to me why or whether "genirq: Prevent use-
>> > after-free and work list corruption" was needed.
>> Yeah, I think that commit was bogus.  The email thread[1] doesn't
>>  exactly inspire confidence either.  I think the submitter just didn't
>>  realise that there was a ref corresponding to the work; AFAICT there's
>>  no way the alleged "work list corruption" could happen.
>> 
>> > If it's reasonable to cancel_work_sync() when removing a notifier, I
>> > think we can remove the kref and call the release function directly.
>> I'd prefer to stick to the smaller fix for -rc and stable.  But if you
>>  want to remove the kref for -next, I'd be happy to Ack that patch.
>
> OK, then you can add:
>
> Acked-by: Ben Hutchings <ben@decadent.org.uk>
>
> to this one.
>
>> Btw, we (sfc linux team) think there's still a use-after-free issue in
>>  the cpu_rmap lib, as follows:
>> 1) irq_cpu_rmap_add creates a glue and notifier, adds glue to rmap->obj
>> 2) someone else does irq_set_affinity_notifier.
>>    This causes cpu_rmap's notifier (old_notify) to get released, and so
>>    irq_cpu_rmap_release kfrees glue.  But it's still in rmap->obj
>> 3) free_irq_cpu_rmap loops over obj, finds the glue, tries to clear its
>>    notifier.
>> Now one could say that this UAF is academic, since having two bits of
>>  code trying to register notifiers for the same IRQ is broken anyway
>>  (in this case, the rmap would stop getting updated, because the
>>  "someone else" stole the notifier).
>
> So far as I can remember, my thinking was that only non-shared IRQs
> will have notifiers and only the current user of the IRQ will set the
> notifier.  The doc comment for irq_set_affinity_notifier() implies the
> latter restriction, but it might be worth spelling this out explicitly.

Bah. I so wish these notifiers would have never been introduced at all.
