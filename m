Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572A1CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1820B206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9e7eTKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgELP5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:57:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbgELP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TfDyrqYtNxdncU0wHn8hrX/BpS827dCs9/4XX4Yc/pE=;
        b=H9e7eTKhhLb9XZFV2/+kAKgp9lilGs5iHRsbzrpNVOqnLqJt66N4mSzbbmhp5Ewui5xp18
        +pweWK0M6j8yybpU8QIyVfcYA8+1CZ+PQUwsmo7oHmTrlr16OUkZV4LhVQS5n0oP8h3Umx
        UgszTAmP2DPP4W6gU2qGtODzCIPjJSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-8wLcPjIANCCtvNRBxty-WA-1; Tue, 12 May 2020 11:57:43 -0400
X-MC-Unique: 8wLcPjIANCCtvNRBxty-WA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE770107ACF2;
        Tue, 12 May 2020 15:57:41 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00AE71CA;
        Tue, 12 May 2020 15:57:37 +0000 (UTC)
Date:   Tue, 12 May 2020 11:57:36 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH] sched/fair: enqueue_task_fair optimization
Message-ID: <20200512155736.GB4256@lorien.usersys.redhat.com>
References: <20200511192301.1009-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511192301.1009-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:23:01PM +0200 Vincent Guittot wrote:
> enqueue_task_fair() jumps to enqueue_throttle when cfs_rq_of(se) is
> throttled, which means that se can't be NULL and we can skip the test.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4b73518aa25c..910bbbe50365 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5512,7 +5512,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                         list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  
> -enqueue_throttle:
>  	if (!se) {
>  		add_nr_running(rq, 1);
>  		/*
> @@ -5534,6 +5533,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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


Reviewed-by: Phil Auld <pauld@redhat.com>

-- 

