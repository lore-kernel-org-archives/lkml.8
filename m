Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AAB24677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUz4x4hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCJI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:27:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24173 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgCJI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583828843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YW+eZQjJwxnNRN/lBhzZQTsNi4Px1s1mqH484/MZI5E=;
        b=TUz4x4hfDk/KJ6PeMNPODi56ojQ1jrxQylGWBKeoNhQJx9rjhVWsetHwtgDD8afk39wOQh
        c7tAIKfVeSh1GBM3WbLlWmvdwPLcL9H9iSrCj6Qqqd3ihjyIkOYjFTUIVdrrWyn4Xu3RR0
        A5um9FZR9bSiFVjog8fXrgOC5IqGDzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-fST45f-OOnuhELajc-eTHQ-1; Tue, 10 Mar 2020 04:27:21 -0400
X-MC-Unique: fST45f-OOnuhELajc-eTHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9358C100DFC5;
        Tue, 10 Mar 2020 08:27:20 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B5B8681F;
        Tue, 10 Mar 2020 08:27:06 +0000 (UTC)
Date:   Tue, 10 Mar 2020 09:27:04 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 13/14] KVM: selftests: Let dirty_log_test async for
 dirty ring test
Message-ID: <20200310082704.cvmy6h4u7t2spncd@kamzik.brq.redhat.com>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309222534.345748-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309222534.345748-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 06:25:34PM -0400, Peter Xu wrote:
> Previously the dirty ring test was working in synchronous way, because
> only with a vmexit (with that it was the ring full event) we'll know
> the hardware dirty bits will be flushed to the dirty ring.
> 
> With this patch we first introduced the vcpu kick mechanism by using
> SIGUSR1, meanwhile we can have a guarantee of vmexit and also the
> flushing of hardware dirty bits.  With all these, we can keep the vcpu
> dirty work asynchronous of the whole collection procedure now.  Still,
> we need to be very careful that we can only do it async if the vcpu is
> not reaching soft limit (no KVM_EXIT_DIRTY_RING_FULL).  Otherwise we
> must collect the dirty bits before continuing the vcpu.
> 
> Further increase the dirty ring size to current maximum to make sure
> we torture more on the no-ring-full case, which should be the major
> scenario when the hypervisors like QEMU would like to use this feature.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c  | 126 +++++++++++++-----
>  .../testing/selftests/kvm/include/kvm_util.h  |   1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   9 ++
>  3 files changed, 106 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 134637267af4..b07e52858e87 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -13,6 +13,9 @@
>  #include <time.h>
>  #include <pthread.h>
>  #include <semaphore.h>
> +#include <sys/types.h>
> +#include <signal.h>
> +#include <errno.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <asm/barrier.h>
> @@ -59,7 +62,9 @@
>  # define test_and_clear_bit_le	test_and_clear_bit
>  #endif
>  
> -#define TEST_DIRTY_RING_COUNT		1024
> +#define TEST_DIRTY_RING_COUNT		65536
> +
> +#define SIG_IPI SIGUSR1
>  
>  /*
>   * Guest/Host shared variables. Ensure addr_gva2hva() and/or
> @@ -135,6 +140,12 @@ static uint64_t host_track_next_count;
>  /* Whether dirty ring reset is requested, or finished */
>  static sem_t dirty_ring_vcpu_stop;
>  static sem_t dirty_ring_vcpu_cont;
> +/*
> + * This is updated by the vcpu thread to tell the host whether it's a
> + * ring-full event.  It should only be read until a sem_wait() of
> + * dirty_ring_vcpu_stop and before vcpu continues to run.
> + */
> +static bool dirty_ring_vcpu_ring_full;
>  
>  enum log_mode_t {
>  	/* Only use KVM_GET_DIRTY_LOG for logging */
> @@ -156,6 +167,33 @@ enum log_mode_t {
>  static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
>  /* Logging mode for current run */
>  static enum log_mode_t host_log_mode;
> +pthread_t vcpu_thread;
> +
> +/* Only way to pass this to the signal handler */
> +struct kvm_vm *current_vm;

nit: above two new globals could be static

