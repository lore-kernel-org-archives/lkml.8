Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF1AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA5420780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjH6Xkpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgDQTGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:06:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32332 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgDQTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587150358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aexqVQ7wQQYqij2tXK706tjApKpXd1pq/NygCDJJnFw=;
        b=CjH6Xkpp8diOEF+g4dDjcgQWbypn+TixbqYbwxLjeUbSQcKPW51ElkA2UGuqUqkWfqocxp
        +ATSw7hlvPqhayt53nQdO0km7/01dJlrq1YR3KG+67EEk4dsokUBJ9+9OV8FZnh8VNUpZW
        ltovXvMUMonMnrLEvi1tHDfzaFKLff0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-BkyMJSxaPT-BauuTxllA0A-1; Fri, 17 Apr 2020 15:05:56 -0400
X-MC-Unique: BkyMJSxaPT-BauuTxllA0A-1
Received: by mail-qv1-f69.google.com with SMTP id et5so3149112qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aexqVQ7wQQYqij2tXK706tjApKpXd1pq/NygCDJJnFw=;
        b=IePEFIC8KDcThWH53lz9Svcn8MkrFTsi5iW+7TLgqhcmFq/CeG54wzRzeV4m+vWhaU
         2Wv5jz7KteuSlmw6JvEh/gYP6hp1zF9TRgVVnP/hzBGeDuMajDssX9TDiQNGE3Illx/d
         +iWb68mlNNotCjIdZ/sTcTfbwyBlQynyU9abI9AxF7TYMqKmK2jMqRp1FGxW3H+ZYcFN
         WQFpkjXjNjOXAdwrVsj5YulR5zxi4+s+wHDkAhpCx3tlDVlk3wLL4iSqT4iCHf+xh2/L
         RGJQypgUS/NDPNoJa1GZ2U1MLPLtcmemxZ3evZWKfaFfWUL3cziYYGzrTRtgM5h32qk3
         tPHw==
X-Gm-Message-State: AGi0PubGt918a7kG4Ri34Lx3/SoMAm4Ac8Wzzk1g/fPfywjcHZe6tzhJ
        Hzatj8mc72pUBJhXf/CbLfwAJ7xM63bqAldLubYjGI7dG8kWdXR5bsxtyucdq0uJgV933071pO5
        LtfKEdB4F/vHWOll8yCfggfLX
X-Received: by 2002:ac8:6642:: with SMTP id j2mr4466577qtp.311.1587150355608;
        Fri, 17 Apr 2020 12:05:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJK47cUAW8UhtqP+6vEGJNWgIFR2kpnvCsa+tpq1Wupmn2CfkAR46gEVGsdrfyTnQkPGXbbBw==
X-Received: by 2002:ac8:6642:: with SMTP id j2mr4466545qtp.311.1587150355360;
        Fri, 17 Apr 2020 12:05:55 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y21sm17199104qka.37.2020.04.17.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:05:54 -0700 (PDT)
Date:   Fri, 17 Apr 2020 15:05:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/3] KVM: x86: move nested-related kvm_x86_ops to a
 separate struct
Message-ID: <20200417190553.GI287932@xz-x1>
References: <20200417164413.71885-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417164413.71885-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:44:10PM -0400, Paolo Bonzini wrote:
> While this reintroduces some pointer chasing that was removed in
> afaf0b2f9b80 ("KVM: x86: Copy kvm_x86_ops by value to eliminate layer
> of indirection", 2020-03-31), the cost is small compared to retpolines
> and anyway most of the callbacks are not even remotely on a fastpath.
> In fact, only check_nested_events should be called during normal VM
> runtime.  When static calls are merged into Linux my plan is to use them
> instead of callbacks, and that will finally make things fast again by
> removing the retpolines.

Paolo,

Just out of curiousity: is there an explicit reason to not copy the
whole kvm_x86_nested_ops but use pointers (since after all we just
reworked kvm_x86_ops)?

Thanks,

-- 
Peter Xu

