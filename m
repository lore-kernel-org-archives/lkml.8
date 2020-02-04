Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E80C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D131C20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB7A3PNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDO12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:27:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727230AbgBDO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580826446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAB5nDRTqzlehnr3GB6Da+YlYF/dWDfqvHLd5KY06rI=;
        b=NB7A3PNmlcl2OPy9kPwgs1PIHPqi7VcCPONgHTI19nwz7LVo17njzpjWytkGm9ce05nQFJ
        0TKfVJ8+Tim01cn/fVxoGxhtztnoDzUc4v2OhZkZeKvnNDHIldXs96D+2h4GK8n3sdaaAc
        rEHdRWl6upE3y7i14BE+q+WOQYeyhBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-b8on8YDkNLuhmXGp1Ciaig-1; Tue, 04 Feb 2020 09:27:23 -0500
X-MC-Unique: b8on8YDkNLuhmXGp1Ciaig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD51A100FB7F;
        Tue,  4 Feb 2020 14:27:21 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAD37792B;
        Tue,  4 Feb 2020 14:27:20 +0000 (UTC)
Date:   Tue, 4 Feb 2020 09:27:19 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: sched_tick_remote: Remove duplicate
 assignment
Message-ID: <20200204142718.GA23972@pauld.bos.csb>
References: <1580776558-12882-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580776558-12882-1-git-send-email-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Mon, Feb 03, 2020 at 07:35:58PM -0500 Scott Wood wrote:
> A redundant "curr = rq->curr" was added; remove it.
> 
> Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 45f79bcc3146..377ec26e9159 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3683,7 +3683,6 @@ static void sched_tick_remote(struct work_struct *work)
>  	if (cpu_is_offline(cpu))
>  		goto out_unlock;
>  
> -	curr = rq->curr;
>  	update_rq_clock(rq);
>  
>  	if (!is_idle_task(curr)) {
> -- 
> 1.8.3.1
> 

Reviewed-by: Phil Auld <pauld@redhat.com>

Out of curiosity, why remove this one and not the one right before the 
cpu_is_offline check?


Cheers,
Phil

-- 

