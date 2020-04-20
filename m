Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B82C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3F92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4LPcsbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDTGqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:46:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbgDTGqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587365200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqAUHVEd5BL+T3/HZ4FhSqFdvpe7bgdtT6IdzYjkTFs=;
        b=h4LPcsbS9VfsiItWm0wh4t6fJl8jkBVzjQ1ox0Di3SUk4LIEvvdkIjbhyv/rxb10hJdp+z
        i234R8NygQbBMRSz8QYw4mPb9dVok7G724DjtDJ4994qq/J5bgZLGQ1ANG+3EVkzQGDROT
        rLpJhUPTQ65+33Y+h7wJdP9LJ+v0LB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-kt8YJlrTME67F-8XzRn3OA-1; Mon, 20 Apr 2020 02:46:34 -0400
X-MC-Unique: kt8YJlrTME67F-8XzRn3OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69A21149C3;
        Mon, 20 Apr 2020 06:46:32 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 846F1129F84;
        Mon, 20 Apr 2020 06:46:27 +0000 (UTC)
Date:   Mon, 20 Apr 2020 08:46:24 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>,
        <david@redhat.com>, <heiko.carstens@de.ibm.com>,
        <gor@linux.ibm.com>, <Ulrich.Weigand@de.ibm.com>,
        <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] KVM: s390: remove unneeded semicolon in
 gisa_vcpu_kicker()
Message-ID: <20200420084624.1d8a1c13.cohuck@redhat.com>
In-Reply-To: <20200418081926.41666-1-yanaijie@huawei.com>
References: <20200418081926.41666-1-yanaijie@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 16:19:26 +0800
Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
> 
> arch/s390/kvm/interrupt.c:3085:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Fixes: 9f30f6216378 ("KVM: s390: add gib_alert_irq_handler()")

> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8191106bf7b9..559177123d0f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3082,7 +3082,7 @@ static enum hrtimer_restart gisa_vcpu_kicker(struct hrtimer *timer)
>  		__airqs_kick_single_vcpu(kvm, pending_mask);
>  		hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
>  		return HRTIMER_RESTART;
> -	};
> +	}
>  
>  	return HRTIMER_NORESTART;
>  }

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

