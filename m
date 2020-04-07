Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D4C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA420747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHCJHBHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDGWHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:07:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34668 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgDGWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586297259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBcX0MuRfqdKJ/UDy2UrC0OesweN1b1Dk27ZzjJGB5Y=;
        b=CHCJHBHaAxKgPRafNTTnUllSlj3WVsliBgD+bmXxip8GnAUR8CML7KhzlmLXQpWEgNZwD3
        kJ8IyfsCpCgusgsgT4o1/KZ+Cq5u5qW78RWVL1XoAuW9QRFwVHlVHI33mUNx5FHFBETR1P
        /vjfEl1VhqGX49zYcqeyzh67DfYTJCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-EbvBUQhIPiuZ9z3P0CD47Q-1; Tue, 07 Apr 2020 18:07:26 -0400
X-MC-Unique: EbvBUQhIPiuZ9z3P0CD47Q-1
Received: by mail-wr1-f70.google.com with SMTP id g6so2911744wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sBcX0MuRfqdKJ/UDy2UrC0OesweN1b1Dk27ZzjJGB5Y=;
        b=NGfBL0aAmWPRGvk7+pz403NSE8j1pDccTenJfBTd66RTO4gy3wRbqfNqPgzsqKYHTd
         hWeo4m2eMFCQ5JgDZxpFngfhZqjmjGUK/0ZagVC8zmZKmH8fi3oUNV9JF0Ws9KG/DvKY
         PxqVAX3GENEGN9bB5ZT6mLsZjxcTVZD3o9lTaBRUl4Z4tHzzSu20GrE0DLlvTEpMXp11
         OV7j0z3FxExlNDd4J8EOzgDXUAEKb6adwUvXjdDGU0QRek83+cGDEWFd1Uoqo3qJeR5s
         3EE7Cf6Wj2YJToqxz+gnMcKWqMW0RDBssnTdQp43aoSIg6Q38o0Eo9kZQH0n0/QAFXud
         QHfw==
X-Gm-Message-State: AGi0PuYlADv3Y8rwl1faoiIKC6uNR7WwYYjOHa+Dt75XyIGB+gLe0WdD
        n85sCOB698dKajkpygVkwCYQytyqTr3nLArZfvhL6AWCpAgLkqkN+HujhFWda4RSvzlnGVvwINM
        +tyzwI1F1v06WBkkgmnrvw/Wb
X-Received: by 2002:adf:b64f:: with SMTP id i15mr5190285wre.351.1586297244869;
        Tue, 07 Apr 2020 15:07:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLm4s/z1WuBmAjFihAoIU+l3M3dmlXE9c2JCfBcrBn/lXHVlRvx1DDkIp0weC8LKHXvuX6Bwg==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr5190263wre.351.1586297244650;
        Tue, 07 Apr 2020 15:07:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id w66sm3973000wma.38.2020.04.07.15.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:07:24 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <B85606B0-71B5-4B7D-A892-293CB9C1B434@amacapital.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2776fced-54c2-40eb-7921-1c68236c7f70@redhat.com>
Date:   Wed, 8 Apr 2020 00:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <B85606B0-71B5-4B7D-A892-293CB9C1B434@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/20 23:41, Andy Lutomirski wrote:
> 2. Access to bad memory results in #MC.  Sure, #MC is a turd, but
> it’s an *architectural* turd. By all means, have a nice simple PV
> mechanism to tell the #MC code exactly what went wrong, but keep the
> overall flow the same as in the native case.
> 
> I think I like #2 much better. It has another nice effect: a good
> implementation will serve as a way to exercise the #MC code without
> needing to muck with EINJ or with whatever magic Tony uses. The
> average kernel developer does not have access to a box with testable
> memory failure reporting.

I prefer #VE, but I can see how #MC has some appeal.  However, #VE has a
mechanism to avoid reentrancy, unlike #MC.  How would that be better
than the current mess with an NMI happening in the first few
instructions of the #PF handler?

Paolo

