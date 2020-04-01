Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D6C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6172073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7BamOUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgDAHE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:04:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731914AbgDAHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585724664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XtftBuo0wy/Bbn7sgTXmnd0B0OWhvzcLYpA4CPew0og=;
        b=K7BamOUhwodWpXaJme7No4CjWgazfJdIZbDffIt8l7OHA+l5AXAXB6FxfLj0t/TRwucmlJ
        AoCczmSg9n8+r55IgPUS89mtz5D8VSOkj2G8tzGv/CF9HUTE5DZYsXynLz6n2NzquKee6J
        0p9HWrhNzJIuijuB4Ww3CNZIZm0B60I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-e7g_rBI6PAiForSNyidxgg-1; Wed, 01 Apr 2020 03:04:20 -0400
X-MC-Unique: e7g_rBI6PAiForSNyidxgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF25813F8;
        Wed,  1 Apr 2020 07:04:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8CA96F85;
        Wed,  1 Apr 2020 07:04:03 +0000 (UTC)
Date:   Wed, 1 Apr 2020 09:04:01 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v8 08/14] KVM: selftests: Always clear dirty bitmap after
 iteration
Message-ID: <20200401070401.hyca2hffledu2il7@kamzik.brq.redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
 <20200331190000.659614-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331190000.659614-9-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 02:59:54PM -0400, Peter Xu wrote:
> We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
> clear it for us before copying the dirty log onto it.  However we'd
> still better to clear it explicitly instead of assuming the kernel
> will always do it for us.
> 
> More importantly, in the upcoming dirty ring tests we'll start to
> fetch dirty pages from a ring buffer, so no one is going to clear the
> dirty bitmap for us.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 752ec158ac59..6a8275a22861 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -195,7 +195,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
>  				    page);
>  		}
>  
> -		if (test_bit_le(page, bmap)) {
> +		if (test_and_clear_bit_le(page, bmap)) {
>  			host_dirty_count++;
>  			/*
>  			 * If the bit is set, the value written onto
> -- 
> 2.24.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

