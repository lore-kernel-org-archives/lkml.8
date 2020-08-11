Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E90206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnwEdiH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgHKNno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728550AbgHKNnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597153421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsEkVhBkdW2xurAwlkSpkIIJfJ5lTVvR2x5t+rRtl1c=;
        b=LnwEdiH/ozKlibaLAtnzoLbOKC73kGMD/ALyzyqvFD0UlctwbBI4XZDxbcJNBUVR593c90
        XFrSFe5bE4Wh++3u8dLAyX/sXYT8rK7vNLfGEsGE9jwzitFZLW4mWJG80iRRXw6Dd5zaAn
        0t2eDNkwUfb5s37yZtHfwssGommFH7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-XpoG-LUSMPKJjFXjDFnTNg-1; Tue, 11 Aug 2020 09:43:37 -0400
X-MC-Unique: XpoG-LUSMPKJjFXjDFnTNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2767D100A8F1;
        Tue, 11 Aug 2020 13:43:34 +0000 (UTC)
Received: from prarit.bos.redhat.com (dhcp16-222-232.7a2m.lab.eng.bos.redhat.com [10.16.222.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC1B170599;
        Tue, 11 Aug 2020 13:43:28 +0000 (UTC)
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and
 real
To:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jon DeVree <nuxi@vault24.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        John Ogness <john.ogness@linutronix.de>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley> <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <ea1def14-3f03-e0e7-6658-6bbcd9861b2e@redhat.com>
Date:   Tue, 11 Aug 2020 09:43:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200811130218.GI6215@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/20 9:02 AM, Petr Mladek wrote:
> On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
>> Petr Mladek <pmladek@suse.com> writes:
>>> At least "crash" tool would need an update anyway. AFAIK, it checks
>>> the size of struct printk_log and refuses to read it when it changes.
>>>
>>> It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
>>> needed because we would need to update the crashdump-related tools anyway.
>>>
>>> Well, the timing is good. We are about to switch the printk ring
>>> buffer into a lockless one. It requires updating the crashdump tools
>>> as well. We could do this at the same time. The lockless ring buffer
>>> already is in linux-next. It is aimed for 5.10 or 5.11.
>> ...
>>> It would be great to synchronize all these changes changes of the
>>> printk log buffer structures.
>>
>> I agree that having one update is a good thing, but pretty please can we
>> finally make progress with this and not create yet another dependency?
> 
> To make it clear. I definitely do not want to block lockless printk by
> this.

Thanks for clarifying that.  I had the same concern that tglx had.

> 
> BTW: I am not 100% convinced that storing all three timestamps is
> worth it. It increases the code complexity, metadata size. It needs
> an interface with the userspace that has to stay backward compatible.
> 
> Also it still will be racy because the timestamp is taken when the message
> is printed. It might be "long" before or after the event that
> it talks about.

That scenario plays out today with the current timestamp.  Printing debug with a
better timestamp doesn't resolve that problem nor is it intended to.

> 
> There is still the alternative to print all three timestamps regularly
> for those interested. It is less user convenient but much easier
> to maintain.

While I agree, in general, your alternative is useful for in-person debugging it
is not helpful in cases where a user only has an image of a panic where the
printk time-synch message has scrolled off the screen.

Consider this real debug case where I hacked the boottime stamp into printk:  We
had some systems with flaky HW that hit panics at 10 hours [1] of uptime.  Since
these systems came from different vendors with different HW the clocks were
out-of-sync.  I had a suspicion that it was some human-coded event causing the
HW to die but wasn't sure until I did a boottime-stamped printk to prove that
all the systems died after 10 hours.

I could have set a stopwatch or timer to somehow catch this kind of event.  I
could have set up video cameras to watch the consoles, etc.  There are a lot of
other ways I could have debugged this situation but ultimately the fastest thing
to do was code and provide kernels to the various HW companies and see if
everything lined up as I thought it would.

This problem happens far more often then I'd like to admit and we still see this
type of problem with new HW and FW.  I also recall that other kernel groups
(storage, networking, etc.) were interested in the timestamps as it would make
their debugging easier to have a true synchronized timestamp available.

One other thing -- IIRC I had to modify the dmesg code by providing a sysfs (or
proc?) interface for dmesg to identify the stamp.  It's something that should be
investigated with this code too.

P.

[1] It was 3+ years ago.  I can't remember if it was 10 or 100 but you get the
point.

> 
> Best Regards,
> Petr
> 

