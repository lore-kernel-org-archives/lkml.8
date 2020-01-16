Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AACC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F4A24716
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHZcmqoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404868AbgAPReW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:34:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29969 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404857AbgAPReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579196058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVue51NKiEdCI1G3Wg0c7rke38eyF1pA9SE2ZsSZDQI=;
        b=fHZcmqoBNKJ/oTnjU0vuYOxeg8/j/PzykVnX2910NcHF03B349QRl82ZaZXLDfUUYEJjw9
        6E5mnVO7wr2s/YfAlKf0TH1ZOwZUVy5m9OljCBRiboopjssQ+50LKebR9DHmBR2kVsZlvz
        RFxesn+9wQxK4wO9PTdm84eTBHPeikY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-aaus8bAsOVm8obp_vZoOEQ-1; Thu, 16 Jan 2020 12:34:14 -0500
X-MC-Unique: aaus8bAsOVm8obp_vZoOEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F5519057D8;
        Thu, 16 Jan 2020 17:34:11 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 443E75C1D8;
        Thu, 16 Jan 2020 17:34:10 +0000 (UTC)
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
To:     Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rrichter@marvell.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200103151032.19590-1-longman@redhat.com>
 <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
 <87blr3wrqw.fsf@nanos.tec.linutronix.de>
 <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
 <87tv4vuyo6.fsf@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9ae2ee4d-7b67-50ff-e736-1d51753c5ccd@redhat.com>
Date:   Thu, 16 Jan 2020 12:34:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87tv4vuyo6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 11:57 AM, Thomas Gleixner wrote:
>> So your theory the MONOTONIC clock runs differently/wrongly could
>> explain that (assuming this drives the sched clock). Though, I am
> No. sched_clock() is separate. It uses a raw timestamp (in your case
> from the ARM arch timer) and converts it to something which is close to
> proper time. So my assumption was based on the printout Waiman had:
>
>  [ 1... ] CPU.... watchdog_fn now  170000000
>  [ 25.. ] CPU.... watchdog_fn now 4170000000
>
> I assumed that now comes from ktime_get() or something like
> that. Waiman?

I printed out the now parameter of the=A0 __hrtimer_run_queues() call. So
from the timer perspective, it is losing time. For watchdog, the soft
expiry time is 4s. The watchdog function won't be called until the
timer's time advances 4s or more. That corresponds to about 24s in
timestamp time for that particular class of systems.

Cheers,
Longman

