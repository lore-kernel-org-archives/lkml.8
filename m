Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49CB2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De0P/iPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgDHTYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:24:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727717AbgDHTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586373853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM2AllpyXY7ShvICsraKiOxw2/YebeJ26YLqQzcyXQw=;
        b=De0P/iPrsHnLvd+4jcbl4wDgznEbC6YIaxddHhckeIuaVNDNq3P4rLT+TAB2wmbDMmUeQl
        qUu/6W01ZvTRUPfHVYPWwz3VMkkUI85DE8G/szXaA5uLlTK2WN3KjAK7GVMDACD9miJsRU
        ScfQV1tzD69zqjTyBywSeRARo4tuZz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-DpnnIHi5PC6yVCxjqkl9Rw-1; Wed, 08 Apr 2020 15:24:11 -0400
X-MC-Unique: DpnnIHi5PC6yVCxjqkl9Rw-1
Received: by mail-wm1-f69.google.com with SMTP id f81so741361wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 12:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rM2AllpyXY7ShvICsraKiOxw2/YebeJ26YLqQzcyXQw=;
        b=jpOnZZtKga4eOqFz/0vKmN9L0HtG7Ulc+Nz70r4VNHt7fhei1se1g9LGuVQZbK5s0/
         1wfaRRdBeWxJPK1r8o2YH78XOK9fWLnBc3lMg5InZ6zNEPUt+KPyOk+a5dnNL2HlB3X7
         5G4dk9LqMedOvP1SfJfzc5QB9n6msLZh0msfMEkuPkkDFGUj1JWOGfkCS/cqic+A66ZW
         yxfXyevkGVOU1Pvdw9emDKm+qSa2Di9LMWTOoAVl+dU/4/JJlWSxos9lclvVMON/c9C+
         GtLq058vwfqPQkvVEko3wq5/6qXMIQ/kDNEvAznLrRbUHYN/mkJfz7kmkglVf7oOAUik
         EqWg==
X-Gm-Message-State: AGi0PuY7dtRhU3Yuw+MU7Cu7Sjw0dOyIRLfVg4m7/8cEEYCnGV01WDAQ
        Oom5/63OR7/C9nFkSgPCdvB03EGoLdPNNOHM+CJSBAYoWRwfyifueQIGmpyR7dgHGJqGQcf1mVB
        wEE6g9xcPxmWNshXATvNLbh3y
X-Received: by 2002:adf:8364:: with SMTP id 91mr171159wrd.36.1586373850398;
        Wed, 08 Apr 2020 12:24:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfyGuZhDcTX+fHc7e6x22wsZaM/1C+4qfhQ39ZVNXxi1OJc96DRxiwyLQO/tjF1Q/pTjfrrQ==
X-Received: by 2002:adf:8364:: with SMTP id 91mr171130wrd.36.1586373850160;
        Wed, 08 Apr 2020 12:24:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f4sm19680766wrp.80.2020.04.08.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 12:24:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu\@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
In-Reply-To: <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1586296907-53744-1-git-send-email-decui@microsoft.com> <877dyq2d4p.fsf@vitty.brq.redhat.com> <HK0P153MB02732CCBDFA879FCE5CA48C7BFC00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Date:   Wed, 08 Apr 2020 21:24:08 +0200
Message-ID: <87v9m9233b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Wednesday, April 8, 2020 8:47 AM
>> > IMO 'freeze' in a Linux VM on Hyper-V is not really useful in practice,
>> > so let's disallow the operation for both Gen-1 and Gen-2 VMs, even if
>> > it's not an issue for Gen-1 VMs.
>> 
>> Suspend-to-idle may not be very useful indeed, however, it worked before
>> and I think we can just fix it.
>
> How can we fix Suspend-to-idle for a Gen-2 VM, in which no device can work
> as wakeup devices? Note: in the case of Suspend-to-idle, now all the vmbus
> devices including the synthetic keyboard/mouse are suspended completely.
>
> Are you suggesting hv_vmbus should distinguish Suspend-to-idle from
> hibernation, and for the former hv_vmbus should not suspend the synthetic
> keyboard/mouse?

Yes, basically.

>  This should be doable but IMO this is not a very trivial
> effort, and I'm trying to avoid it since IMO Suspend-to-idle is not really 
> useful in practice for a Linux VM on Hyper-V. :-)

Well, to me it's equally (not) useful in all other cases :-) I think we
should Cc: linux-pm@vger.kernel.org and someone will describe a real
world usecase to educate us, we'll then see if there is any Hyper-V
specifics.

>
>> In particular, why do we need to do
>> anything when we are not hibernating?
>
> Are you suggesting hv_vmbus should not suspend the vmbus devices at all
> in the case of Suspend-to-idle?

That what we were doing prior to the hibernation series, right? AFAIU
suspend-to-idle is basically 'no processes are scheduled' mode but we
don't really need to do anything with devices.

>
>> > +/*
>> > + * Note: "freeze/suspend" here means "systemctl suspend".
>> > + * "systemctl hibernate" is still supported.
>> 
>> Let's not use systemd terminology in kernel, let's use the ones from
>> admin-guide/pm/sleep-states.rst (Suspend-to-Idle/Standby/Suspend-to-RAM/
>> Hibernation).
>> --
>> Vitaly
>
> Thanks! I'll use the accurate terms.
>
> Thanks,
> -- Dexuan
>

-- 
Vitaly

