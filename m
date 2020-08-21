Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF332072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHzB0lz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHULZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgHULU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598008850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVZPy7+N9bwrhLBiHBDmf2ilfdv7OW35jUfwMGWMLck=;
        b=SHzB0lz7EyE/uEYinPhsDvRB22EtHEnozzssZuJe5sfWxAlqG4ZhGTLpN21xlu4l55hqXb
        C6Tfkv0MX+Taj16O5/Yz/nFA5IuBng1qFpJfKeAjlLGmOGwczCoM4kAwNDapzrjFld38TN
        xqdVCp6mRRT9IqIPiK4mvE/PK/WuUsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-mLtxB508OFynLZExQXVzIg-1; Fri, 21 Aug 2020 07:20:46 -0400
X-MC-Unique: mLtxB508OFynLZExQXVzIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A16E1100CED1;
        Fri, 21 Aug 2020 11:20:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0DA705F705;
        Fri, 21 Aug 2020 11:20:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 21 Aug 2020 13:20:44 +0200 (CEST)
Date:   Fri, 21 Aug 2020 13:20:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Message-ID: <20200821112041.GH4546@redhat.com>
References: <20200820203902.11308-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820203902.11308-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20, Davidlohr Bueso wrote:
>
> @@ -1471,15 +1471,15 @@ static void kmemleak_scan(void)
>  	if (kmemleak_stack_scan) {
>  		struct task_struct *p, *g;
>  
> -		read_lock(&tasklist_lock);
> -		do_each_thread(g, p) {
> +		rcu_read_lock();
> +		for_each_process_thread(g, p) {
>  			void *stack = try_get_task_stack(p);
>  			if (stack) {
>  				scan_block(stack, stack + THREAD_SIZE, NULL);
>  				put_task_stack(p);
>  			}
> -		} while_each_thread(g, p);
> -		read_unlock(&tasklist_lock);
> +		}
> +		rcu_read_unlock();

Acked-by: Oleg Nesterov <oleg@redhat.com>

