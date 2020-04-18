Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDDCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B4221F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6gZCfXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgDRJ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:57:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbgDRJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587203820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTcRkdSTcnogmYKb1vyPZlIFr7BRZzMxTKvCBHcehjE=;
        b=W6gZCfXK7bdhvLH+4X2OkPJ8/q6/eXa/j6DCg2ZnMeT6dY1w6Od0juYBC+Pp2rFy8Wevaz
        tMpYK0ZJ0BEji1rc32Np0+MOor+bjaIl0k4UgoSFE3Yi2pT+UdN+xxQ/NC4kD60/Zqeqc0
        qbHhnshesBQlpACtpR8E9YMOBBDaJoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-kK7CS1NWPkS_OWysJgzybA-1; Sat, 18 Apr 2020 05:56:58 -0400
X-MC-Unique: kK7CS1NWPkS_OWysJgzybA-1
Received: by mail-wr1-f71.google.com with SMTP id i10so2421177wrq.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wTcRkdSTcnogmYKb1vyPZlIFr7BRZzMxTKvCBHcehjE=;
        b=LqKLJc5lkzWQMKz9JzAFPqDx/YCpGoMvPeAC9eWRfn4KyeTzBh8WXbVfYC6HFAy3eN
         ZU/VT5S5U3RaSMKUq+NgL43Pt2w/fjd/8WIn3hDyRIZajwICUcQtw5yzvNKd6fxoOTI6
         xGX9hAjOwe1fRIv0Dc8uecvDWMyJasIOGEggXeqVLplaNq3g0H1JrrX/kRf8lAnR7B7b
         MGmuPt8pxE7o4tboifnpeHW87zALqs6vtThY0NapMSYM7sMnC/7XgZ4wLyfpnEuPgoSI
         t/kvHN2VMS7rAjih0hE/GyUwBdhgWIA2eH8w1oB40xSZ6sBp+56E8tUF/uvX5YYyc8la
         ggJg==
X-Gm-Message-State: AGi0PuZSQ0QtWPMyADPXmbcN2Jl+q5dVeAKTjSQRHd4HYkZwQkf55gZx
        6MDyfHtUUs9h2QKpQPwRmOsWHHk+8baV2AdjAy2rdKwIFkceMxtDzV36pJN3P0/vahnH/+t4pDG
        rQOkEERcfCH7RxRJWVVOZeHXV
X-Received: by 2002:a5d:5651:: with SMTP id j17mr8094497wrw.406.1587203757741;
        Sat, 18 Apr 2020 02:55:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKaFYVKYrHh6jgP/k8hU9lt1vzMRnvu1GNp+mZ/1QD5M7AdEyKXjR5tLK6F6ffWE/fvI94HJg==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr8094485wrw.406.1587203757516;
        Sat, 18 Apr 2020 02:55:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e04c:97cb:a127:17b6? ([2001:b07:6468:f312:e04c:97cb:a127:17b6])
        by smtp.gmail.com with ESMTPSA id g15sm12971965wrp.96.2020.04.18.02.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 02:55:57 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: move nested-related kvm_x86_ops to a
 separate struct
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200417164413.71885-1-pbonzini@redhat.com>
 <20200417190553.GI287932@xz-x1> <20200417191159.GA14609@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c69d11e-40ab-fdb8-6f32-fdf7298d1277@redhat.com>
Date:   Sat, 18 Apr 2020 11:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417191159.GA14609@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/20 21:11, Sean Christopherson wrote:
> Ya, my vote would be to copy by value as well.

I'd rather avoid useless churn, because

	vmx_x86_ops.nested = vmx_nested_ops;

is much uglier than

	.nested = &vmx_nested_ops,

and with static calls the latter would not have any performance downside.

> I'd also be in favor of
> dropping the _ops part, e.g.
> 
>   struct kvm_x86_ops {
>         struct kvm_x86_nested_ops nested;
> 
>         ...
>   };
> 
> and drop the "nested" parts from the ops, e.g.
> 
>   check_nested_events() -> check_events()

Agreed on both, I'll send v2 with these changes.

Paolo

