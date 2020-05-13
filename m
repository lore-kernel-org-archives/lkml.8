Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A911CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C0A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSEbV3Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbgEMMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:45:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgEMMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589373949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjjfCoKK48jzgXm67hbDCH1DJsihwHwCzqUHDeAkssg=;
        b=hSEbV3Gc012nJgv3eMzXzt7m4smiiH9vOC581qbKLt/GNagQx0rYme8ch5MMkXwSWymCW/
        xB4/z8q5yhqoQi/dGXjFeTyXo1hoxDni+gMB2M2UKJ3rf3tqf2Yf2KNup5l6K3Q9gKuh6W
        MAf1aZuzsHAyh/v6Xca/fEmPLLBk2QQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-AZdOkNvpPAix6SYjViarcA-1; Wed, 13 May 2020 08:45:47 -0400
X-MC-Unique: AZdOkNvpPAix6SYjViarcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F86107ACCD;
        Wed, 13 May 2020 12:45:46 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-165.phx2.redhat.com [10.3.113.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6DB62B1E;
        Wed, 13 May 2020 12:45:42 +0000 (UTC)
Date:   Wed, 13 May 2020 08:45:40 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        ouwen210@hotmail.com, pkondeti@codeaurora.org
Subject: Re: [PATCH v2] sched/fair: enqueue_task_fair optimization
Message-ID: <20200513124540.GB12425@lorien.usersys.redhat.com>
References: <20200513123335.28122-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513123335.28122-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, May 13, 2020 at 02:33:35PM +0200 Vincent Guittot wrote:
> enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
> throttled which means that se can't be NULL and we can skip the test.
>

s/be NULL/be non-NULL/

I think.

It's more like if it doesn't jump to the label then se must be NULL for
the loop to terminate.  The final loop is a NOP if se is NULL. The check
wasn't protecting that.

Otherwise still

> Reviewed-by: Phil Auld <pauld@redhat.com>

Cheers,
Phil


> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> v2 changes:
> - Remove useless if statement
> 
>  kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0c690d57430..b51b12d63c39 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5513,28 +5513,29 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                         list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  
> -enqueue_throttle:
> -	if (!se) {
> -		add_nr_running(rq, 1);
> -		/*
> -		 * Since new tasks are assigned an initial util_avg equal to
> -		 * half of the spare capacity of their CPU, tiny tasks have the
> -		 * ability to cross the overutilized threshold, which will
> -		 * result in the load balancer ruining all the task placement
> -		 * done by EAS. As a way to mitigate that effect, do not account
> -		 * for the first enqueue operation of new tasks during the
> -		 * overutilized flag detection.
> -		 *
> -		 * A better way of solving this problem would be to wait for
> -		 * the PELT signals of tasks to converge before taking them
> -		 * into account, but that is not straightforward to implement,
> -		 * and the following generally works well enough in practice.
> -		 */
> -		if (flags & ENQUEUE_WAKEUP)
> -			update_overutilized_status(rq);
> +	/* At this point se is NULL and we are at root level*/
> +	add_nr_running(rq, 1);
> +
> +	/*
> +	 * Since new tasks are assigned an initial util_avg equal to
> +	 * half of the spare capacity of their CPU, tiny tasks have the
> +	 * ability to cross the overutilized threshold, which will
> +	 * result in the load balancer ruining all the task placement
> +	 * done by EAS. As a way to mitigate that effect, do not account
> +	 * for the first enqueue operation of new tasks during the
> +	 * overutilized flag detection.
> +	 *
> +	 * A better way of solving this problem would be to wait for
> +	 * the PELT signals of tasks to converge before taking them
> +	 * into account, but that is not straightforward to implement,
> +	 * and the following generally works well enough in practice.
> +	 */
> +	if (flags & ENQUEUE_WAKEUP)
> +		update_overutilized_status(rq);
>  
>  	}
>  
> +enqueue_throttle:
>  	if (cfs_bandwidth_used()) {
>  		/*
>  		 * When bandwidth control is enabled; the cfs_rq_throttled()
> -- 
> 2.17.1
> 

-- 

