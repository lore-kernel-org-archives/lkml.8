Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4420734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXFp+CtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFBKQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:16:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgFBKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591092965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1kuok90cqFe8k5lrqY4B28NHCTcMIuHRs+lnAefnkA=;
        b=OXFp+CtQ3wTUwQcGWw+mT8Eq0UmUOlKz3mlP4+byeZq1uNJbUxxut21qd13F1BitfJh+re
        ndUPaeAnops4quEH+HCAAMakYnddwTAVng7GJZX1aVWiDRBxuG/9pBkMch/utYrW1Fv1/m
        D9VFlW8YYBhFxS0CQfEkDAGaZ8QdjCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-8lNvRmN0PPmIXv85p_HYSw-1; Tue, 02 Jun 2020 06:16:03 -0400
X-MC-Unique: 8lNvRmN0PPmIXv85p_HYSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5ABCA0C03;
        Tue,  2 Jun 2020 10:16:02 +0000 (UTC)
Received: from [10.72.12.83] (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11B6F7E7EA;
        Tue,  2 Jun 2020 10:15:58 +0000 (UTC)
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org
References: <20200602084257.134555-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
Date:   Tue, 2 Jun 2020 18:15:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602084257.134555-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/2 下午4:45, Michael S. Tsirkin wrote:
> So vhost needs to poke at userspace *a lot* in a quick succession.  It
> is thus benefitial to enable userspace access, do our thing, then
> disable. Except access_ok has already been pre-validated with all the
> relevant nospec checks, so we don't need that.  Add an API to allow
> userspace access after access_ok and barrier_nospec are done.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Jason, so I've been thinking using something along these lines,
> then switching vhost to use unsafe_copy_to_user and friends would
> solve lots of problems you observed with SMAP.
>
> What do you think?


I'm fine with this approach.


>   Do we need any other APIs to make it practical?


It's not clear whether we need a new API, I think __uaccess_being() has 
the assumption that the address has been validated by access_ok().

Thanks


>
>   arch/x86/include/asm/uaccess.h | 1 +
>   include/linux/uaccess.h        | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index d8f283b9a569..fa5afb3a54fe 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -483,6 +483,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
>   	return 1;
>   }
>   #define user_access_begin(a,b)	user_access_begin(a,b)
> +#define user_access_begin_after_access_ok()	__uaccess_begin()
>   #define user_access_end()	__uaccess_end()
>   
>   #define user_access_save()	smap_save()
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..4c0a959ad639 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -370,6 +370,7 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
>   
>   #ifndef user_access_begin
>   #define user_access_begin(ptr,len) access_ok(ptr, len)
> +#define user_access_begin_after_access_ok() do { } while (0)
>   #define user_access_end() do { } while (0)
>   #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
>   #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)

