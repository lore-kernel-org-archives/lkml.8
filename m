Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E71206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYUGuQFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgDUPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:09:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587481767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z0+4zQmptA1LzH0MyzzFbxw+OgbhZZrQrJFNKgXpR/M=;
        b=LYUGuQFKcNjaGNPIm7LL6gqz02ngjtUIwVVX+Gn09i3oM63nqjQ3dP6zIV6wSxcQBoNbYx
        L2R8wxOvVjwqMgbtNP/3+7XuXWkz7Q0JsY2kLLztBpfcEuP6ld5PNsXWz8trSPnMMHsH35
        1cvwBrGKkGpvSe6Rn2NdRmxdroHD9A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-J6Zg_KR1MfqmJV2tO6LIFw-1; Tue, 21 Apr 2020 11:09:22 -0400
X-MC-Unique: J6Zg_KR1MfqmJV2tO6LIFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463328017FE;
        Tue, 21 Apr 2020 15:09:19 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F482898A;
        Tue, 21 Apr 2020 15:09:15 +0000 (UTC)
Date:   Tue, 21 Apr 2020 11:09:13 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org, pauld@redhead.com
Subject: Re: [PATCH 2/2] sched/fair: Refill bandwidth before scaling
Message-ID: <20200421150913.GB26514@lorien.usersys.redhat.com>
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
 <20200420024421.22442-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420024421.22442-3-changhuaixin@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 20, 2020 at 10:44:21AM +0800 Huaixin Chang wrote:
> In order to prevent possible hardlockup of sched_cfs_period_timer()
> loop, loop count is introduced to denote whether to scale quota and
> period or not. However, scale is done between forwarding period timer
> and refilling cfs bandwidth runtime, which means that period timer is
> forwarded with old "period" while runtime is refilled with scaled
> "quota".
> 
> Move do_sched_cfs_period_timer() before scaling to solve this.
> 
> Fixes: 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup")
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..9ace1c5c73a5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5152,6 +5152,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  		if (!overrun)
>  			break;
>  
> +		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
> +
>  		if (++count > 3) {
>  			u64 new, old = ktime_to_ns(cfs_b->period);
>  
> @@ -5181,8 +5183,6 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  			/* reset count so we don't come right back in here */
>  			count = 0;
>  		}
> -
> -		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
>  	}
>  	if (idle)
>  		cfs_b->period_active = 0;
> -- 
> 2.14.4.44.g2045bb6
> 

This one is independent of the first so could be taken as is.

Reviewed-by: Phil Auld <pauld@redhat.com>
-- 

