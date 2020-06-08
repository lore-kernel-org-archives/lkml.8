Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80214C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541FD206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOzkmLm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFHOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:43:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729989AbgFHOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591627417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCu4klvK8WqDG/7fqy7QMZOQkd/Lpx79HGToUSh8N5c=;
        b=hOzkmLm8WlVb65nrxXrdUiVV2RkZahwJJhFtBSUKrVXOIjfNCgOc9gPHl0YasMezB7THjs
        aYh6/HCEc7AH9eHK2LwelWdoddYn2nrmVYvvx9YZRqyCOX5hpteVbqOaU//PyePeY7DmHE
        pRN8nxJxaoX6sN/CmP012DmK9sxJ7Ow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-7osZUcnGPlSqORgmZGpjag-1; Mon, 08 Jun 2020 10:43:35 -0400
X-MC-Unique: 7osZUcnGPlSqORgmZGpjag-1
Received: by mail-wr1-f71.google.com with SMTP id p9so7269144wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 07:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dCu4klvK8WqDG/7fqy7QMZOQkd/Lpx79HGToUSh8N5c=;
        b=JF6LkYMxQzzLBivetcIdooDMOZeRSNjHkZXf7qkJ09SGhoIt8+Lqe6cAGkGqzN7zGQ
         Jz/1qQzEtIjrhy6evlwsvh7H5K4wKg4dKNtF8t761vPUVihNSVQXXXETnAcWaMdZwU7W
         qs117XGsh7jk40SXz8wRZIO9BW2NsszQVX2GqwmzT4AuSsjc8T5/Dmkiqd2PTLL21n4T
         CtbPVcD9pykXfYEywsqJwppGSmjZN++9Q/kODWulyfUHyVhAWLB4ikwbFeFJxmIBKCHn
         0Meq6VSet1aIwN9Acuf1+azjOWt3L3SWgvQo4U61ic54FWD6SvpvsNyce1dVDCGGOz/S
         3MAQ==
X-Gm-Message-State: AOAM530KTw72NPyQGpzJoJlFkOCAZAvQyZMfZKCfCI1xpVGssN7rlx9l
        ZHnqJMiZRljI+/XpR2RAwfyoCChoOP/njPSxTK72nfLYfaOA0zueEqq79yPnSBymd53Mj0u8ysu
        SFkVvBjmuVZ3yMhrlEIILTfM/
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr17379008wme.41.1591627414624;
        Mon, 08 Jun 2020 07:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdXdnqTWlVa3j79SWNzN7JbE0jP7z5+vx+TBdN9i5XhxydAeK9f7Bns2HfpNfKKDsLlJwjEw==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr17378990wme.41.1591627414384;
        Mon, 08 Jun 2020 07:43:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
        by smtp.gmail.com with ESMTPSA id k21sm24574254wrd.24.2020.06.08.07.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:43:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: fix vmx_preemption_timer_test build
 with GCC10
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
References: <20200608112346.593513-1-vkuznets@redhat.com>
 <20200608112346.593513-2-vkuznets@redhat.com>
 <39c73030-49ff-f25c-74de-9a52579eefbe@redhat.com>
 <20200608143859.GA8223@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b2a36b7-69ad-7cce-fec4-2df70f867fe2@redhat.com>
Date:   Mon, 8 Jun 2020 16:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608143859.GA8223@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 16:38, Sean Christopherson wrote:
>> Queued both, thanks.
> 
> Hmm, someone go awry with your queue a while back?
> 
> https://lkml.kernel.org/r/ce6a5284-e09b-2f51-8cb6-baa29b3ac5c3@redhat.com

Both that one and "x86/kvm: Remove defunct KVM_DEBUG_FS Kconfig" were
queued for 5.7, but Linus released one week earlier so they got lost.

Paolo

