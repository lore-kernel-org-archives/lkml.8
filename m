Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A0320748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQsukgFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgHQOHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:07:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728489AbgHQOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CISar0ED1yHEmy/zSC+DxJhwjT7dtxetwJg9y4KnwVg=;
        b=UQsukgFJZnMEjpdAbatgz0l5XdP8kWmcKxadQeij2DCLQHNOtcIIiDRAdgWbClZgpEqgNQ
        vRYuNCkS9/lIBIRFeYpOHi9Aj1WzYldssIfqOsOjkCdsbEwIdpGQKJ2tI9bMtEiEDbD97x
        4VS+h2O7KCzCjqOV/3pIdmQ5fsmYyMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-sRjTP-gnMsORM4V06tB3vA-1; Mon, 17 Aug 2020 10:07:50 -0400
X-MC-Unique: sRjTP-gnMsORM4V06tB3vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95EAF185E521;
        Mon, 17 Aug 2020 14:07:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D1767A1C0;
        Mon, 17 Aug 2020 14:07:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Aug 2020 16:07:48 +0200 (CEST)
Date:   Mon, 17 Aug 2020 16:07:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] uprobes: __replace_page() avoid BUG in munlock_vma_page()
Message-ID: <20200817140744.GC29865@redhat.com>
References: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Hugh Dickins wrote:
>
> --- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
> +++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
> @@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
>  		try_to_free_swap(old_page);
>  	page_vma_mapped_walk_done(&pvmw);
>  
> -	if (vma->vm_flags & VM_LOCKED)
> +	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
>  		munlock_vma_page(old_page);
>  	put_page(old_page);

Thanks!

Acked-by: Oleg Nesterov <oleg@redhat.com>

