Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5420748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od2oMIms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHQOJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:09:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47789 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgHQOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ND/esKGMRL5ZPUChC4jbz00fcc6iemDjh98b20FEHI=;
        b=Od2oMIms49/LjyBuqRTyKbtNs0Y4yRExZt/G7XxVrjmj0BiL/LeZjSti41t8FlfjlzGKJH
        cnDytshgrNJ9yJ2Y2GWhvDdhoH6kHfOYHeC1JGT2XpR5gGBBkjWejHmniwaCBSGs9kFAmz
        VYEZAdMcQFE4MmIAF0HvpmDumMhKvG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-FA3l1lKOOGCg_in2VFoMHQ-1; Mon, 17 Aug 2020 10:09:46 -0400
X-MC-Unique: FA3l1lKOOGCg_in2VFoMHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A069E10082E6;
        Mon, 17 Aug 2020 14:09:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C3175C3E0;
        Mon, 17 Aug 2020 14:09:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Aug 2020 16:09:45 +0200 (CEST)
Date:   Mon, 17 Aug 2020 16:09:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] block: fix ioprio_get/set(IOPRIO_WHO_PGRP) vs
 setuid(2)
Message-ID: <20200817140942.GD29865@redhat.com>
References: <20200817003148.23691-1-dave@stgolabs.net>
 <20200817003148.23691-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817003148.23691-3-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Davidlohr Bueso wrote:
>
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -119,11 +119,13 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>  				pgrp = task_pgrp(current);
>  			else
>  				pgrp = find_vpid(who);
> +			read_lock(&tasklist_lock);
>  			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
>  				ret = set_task_ioprio(p, ioprio);
>  				if (ret)
>  					break;
>  			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
> +			read_unlock(&tasklist_lock);
>  			break;
>  		case IOPRIO_WHO_USER:
>  			uid = make_kuid(current_user_ns(), who);
> @@ -207,6 +209,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
>  				pgrp = task_pgrp(current);
>  			else
>  				pgrp = find_vpid(who);
> +			read_lock(&tasklist_lock);
>  			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
>  				tmpio = get_task_ioprio(p);
>  				if (tmpio < 0)
> @@ -216,6 +219,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
>  				else
>  					ret = ioprio_best(ret, tmpio);
>  			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
> +			read_unlock(&tasklist_lock);

Acked-by: Oleg Nesterov <oleg@redhat.com>

