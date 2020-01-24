Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E5CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4AF21556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2xK4ez3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgAXJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:49:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387821AbgAXJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579859373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9hxHYlrOWreTcT9F0JXhv/b/MPgxcQiCtt+IvAmvNhM=;
        b=O2xK4ez3rlgi/WD9kF7JdZgX1WdI42HWRlH6RwaE6YgE3NfOF0RxzxHw2RmPSpH3eG8vkA
        igAYsti0Gm+noXsiDJgJrPbFgOKBO6Qa8OOdU7rV0e/hoWsAMTe7w5TSZMWXqWDoVXb5MJ
        UbiQ2umuvC7VRekGWdUhK8XWap1R574=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-eUteBcnwOQy0V5A0BOZbOw-1; Fri, 24 Jan 2020 04:49:31 -0500
X-MC-Unique: eUteBcnwOQy0V5A0BOZbOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85D4D1137840;
        Fri, 24 Jan 2020 09:49:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49EA087EDC;
        Fri, 24 Jan 2020 09:49:26 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:49:23 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 01/10] KVM: selftests: Create a demand paging test
Message-ID: <20200124094923.phubywl4hwdydnbu@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180436.99487-2-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:04:27AM -0800, Ben Gardon wrote:
...
> +#ifdef __x86_64__
> +	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
> +#endif
> +#ifdef __aarch64__
> +	ucall_init(vm, NULL);
> +#endif

We don't need the #ifdef around ucall_init anymore, now that architectures
that don't need it got stubs. I guess dirty_log_test.c could be cleaned up
too. I'll send a patch.

Thanks,
drew

