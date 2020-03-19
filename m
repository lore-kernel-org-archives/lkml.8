Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4FAC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1620722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR9k72Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCSHot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:44:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59961 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgCSHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584603888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqosX0I8MemyviAwLJfehcZri3xdX1d3AgPwhagy1LI=;
        b=FR9k72Z5Bn8NrKsgVbFgdvRI6hxNGVyQMiZLmESJji2AXB8iJlpFgSHqwsODvC7r2beILM
        xZaQsC1gM9oFUxTRMFbVX70FDvVbYCjg8bWvlFxRfpailMPDfbpmvKqhaklz53HCqtWYDz
        EzNrlbMcoqK5hmlcArw9zucUHePPk8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-cLj4inWeOQaIr1hq7jNBww-1; Thu, 19 Mar 2020 03:44:46 -0400
X-MC-Unique: cLj4inWeOQaIr1hq7jNBww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B58149C2;
        Thu, 19 Mar 2020 07:44:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A98162673;
        Thu, 19 Mar 2020 07:44:29 +0000 (UTC)
Date:   Thu, 19 Mar 2020 08:44:26 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200319074426.4gzvslbxvkngnkcc@kamzik.brq.redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318163720.93929-11-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:37:16PM -0400, Peter Xu wrote:
> Remove the clear_dirty_log test, instead merge it into the existing
> dirty_log_test.  It should be cleaner to use this single binary to do
> both tests, also it's a preparation for the upcoming dirty ring test.
> 
> The default behavior will run all the modes in sequence.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   2 -
>  .../selftests/kvm/clear_dirty_log_test.c      |   6 -
>  tools/testing/selftests/kvm/dirty_log_test.c  | 187 +++++++++++++++---
>  3 files changed, 156 insertions(+), 39 deletions(-)
>  delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

