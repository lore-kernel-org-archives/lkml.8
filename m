Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521CDC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6020722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L24qyoiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCSHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:55:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51803 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgCSHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584604513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WrcEkZJ92O5FyyfklQyM4XRQPnUfp7MvJerL4+K+rPc=;
        b=L24qyoiUU+QZ1uh66pYTvGXGP5op0fwxLzsUCBMwBUDZfpY03ToJ5Tm2hIABkATbunPemX
        3wcyuysZS3nJh2mcP1J3yj6RI5Me5OF1mhcHAF5wUDBgNSIyQQGJ2/SEvqSBivbSZiMw+c
        PhZzzcoZ3P+lF55/+d+Bfy1aAMWKnzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492--rNErUqmN2iRoD2kcJJvaw-1; Thu, 19 Mar 2020 03:55:11 -0400
X-MC-Unique: -rNErUqmN2iRoD2kcJJvaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31071801E70;
        Thu, 19 Mar 2020 07:55:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2238C60BF1;
        Thu, 19 Mar 2020 07:54:55 +0000 (UTC)
Date:   Thu, 19 Mar 2020 08:54:52 +0100
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
Subject: Re: [PATCH v7 14/14] KVM: selftests: Add "-c" parameter to dirty log
 test
Message-ID: <20200319075452.eyykmtqt6e2etlc6@kamzik.brq.redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318163720.93929-15-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:37:20PM -0400, Peter Xu wrote:
> It's only used to override the existing dirty ring size/count.  If
> with a bigger ring count, we test async of dirty ring.  If with a
> smaller ring count, we test ring full code path.  Async is default.
> 
> It has no use for non-dirty-ring tests.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

