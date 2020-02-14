Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F2C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678D62168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHgOYQHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBNXUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:20:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727620AbgBNXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581722408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z34VtLc1BYtNZqTBh3fQkOhafmRPIz9ekzq0qoyZ9B8=;
        b=aHgOYQHy9Xq27TaJ81F9uDDp9gAYaqsJ/AIcMKhLRDrQ6ECuOdUSnvT7TzijThILC7wHqU
        JjtVw7v7NZZEBUCPOdnjat5igB7TUZ703OYgEqCERwMch1aeaQIT7DGkd3/nSMAcxF+u9I
        wNvr/OgFlNal4cCQa9OTTYxNyHQs9iU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-o2pCaLhFOHaTGurnNWKV2g-1; Fri, 14 Feb 2020 18:20:00 -0500
X-MC-Unique: o2pCaLhFOHaTGurnNWKV2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B96578017CC;
        Fri, 14 Feb 2020 23:19:58 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1174A60BE1;
        Fri, 14 Feb 2020 23:19:56 +0000 (UTC)
Date:   Fri, 14 Feb 2020 18:19:54 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
Message-ID: <20200214231954.GA29849@redhat.com>
References: <20200214225849.108108-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214225849.108108-1-bgeffon@google.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this and other enhancements have already implemented by Peter (CC'ed)
and in the right way, by altering the retry logic in the page fault
code. This is a requirement for other kind of usages too, notably the
UFFD_WRITEPROTECT ioctl after which multiple consecutive faults can
happen and must be handled.

IIRC Kirill asked at last LSF-MM uffd-wp talk if there's any
particular reason the fault couldn't be retried currently. I had no
sure answer other than there's apparently no strong reason why
VM_FAULT_RETRY is only allowed 1 time currently, so there should be no
issue in lifting that artificial restriction.

I'm running with this patchset applied in my systems since Nov with no
regression at all. I got sidetracked by various other issues, so
unfortunately I didn' post a proper reviewed-by on the last submit yet
(pending), but I did at least test it and it was rock solid so far.

https://lore.kernel.org/lkml/20190926093904.5090-1-peterx@redhat.com/

Can you test and verify it too if it solves your use case?

Also note the complete uffd-WP support submit also from Peter:

https://lore.kernel.org/lkml/20190620022008.19172-1-peterx@redhat.com/

https://github.com/xzpeter/linux/tree/uffd-wp-merged

Thanks,
Andrea

