Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DE9206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iImn9zZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgAXKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:21:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731492AbgAXKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579861274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5HPA+MpTJSeRz5I3KDYpYGg6n0niPqSTR8+sgUSVTs=;
        b=iImn9zZyMZbS7tm8KJfIr3tPKXOUZtswTJYh7gFnZPaPnFrMqsTBTbGVtz4LJ8eqZfgAF6
        KAxrCX/88HrSLEhz4tJSBfUJPxJ8k/SUPR8ULOoMAshon4Jx1Z341STmZBvibyiFNMlvxC
        PS0xJNeQSbo9KIcxswd00pUEeIxGhHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-norJzSFTNNqWRa7wlsSNqg-1; Fri, 24 Jan 2020 05:21:12 -0500
X-MC-Unique: norJzSFTNNqWRa7wlsSNqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A15778017CC;
        Fri, 24 Jan 2020 10:21:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DA9E5DA7D;
        Fri, 24 Jan 2020 10:21:06 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:21:03 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 08/10] KVM: selftests: Time guest demand paging
Message-ID: <20200124102103.uezov62hlpzwmtny@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-9-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180436.99487-9-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:04:34AM -0800, Ben Gardon wrote:
> In order to quantify demand paging performance, time guest execution
> during demand paging.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 2002032df32cc..0dc5d04718678 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -32,6 +32,12 @@
>  
>  #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
>  
> +#ifdef PRINT_PER_PAGE_UPDATES
> +#define PER_PAGE_DEBUG(...) DEBUG(__VA_ARGS__)
> +#else
> +#define PER_PAGE_DEBUG(...)
> +#endif
> +
>  #ifdef PRINT_PER_VCPU_UPDATES
>  #define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
>  #else
> @@ -64,6 +70,26 @@ static uint64_t guest_test_phys_mem;
>   */
>  static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
>  
> +int64_t to_ns(struct timespec ts)
> +{
> +	return (int64_t)ts.tv_nsec + 1000000000LL * (int64_t)ts.tv_sec;
> +}
> +
> +struct timespec diff(struct timespec start, struct  timespec end)
> +{
> +	struct   timespec temp;
> +
> +	if ((end.tv_nsec-start.tv_nsec) < 0) {

spaces around the '-' would be nice

> +		temp.tv_sec = end.tv_sec - start.tv_sec - 1;
> +		temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
> +	} else {
> +		temp.tv_sec = end.tv_sec - start.tv_sec;
> +		temp.tv_nsec = end.tv_nsec - start.tv_nsec;
> +	}
> +
> +	return temp;
> +}

Could probably add these new time utilities to the new test_util.c

Thanks,
drew

