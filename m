Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB26C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56CD2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHNQSCBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWJyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:54:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgAWJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579773269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdY/01YnxgEcf8jBEhI8KPQzD/6+XrjHVp2ZZDmVmCk=;
        b=LHNQSCBYIuzDd4nMLaVBvJbdcJsK/v8i2iYh2URjlVKPWS2HRFiSuBIl4/i/PA3qDrGimP
        +uAH0gy4Ht3/rvD7Vse9wJaWQyqOwCHCXgyVDW+sOqTAKYpci5jUaBraKeEHr2rRgJJqNJ
        cG4V7HWCwvzpmN4yyEq3K0CirFourcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-bwpWl3lDOJi-X5PWeg9oRA-1; Thu, 23 Jan 2020 04:54:27 -0500
X-MC-Unique: bwpWl3lDOJi-X5PWeg9oRA-1
Received: by mail-wr1-f71.google.com with SMTP id 90so1478000wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdY/01YnxgEcf8jBEhI8KPQzD/6+XrjHVp2ZZDmVmCk=;
        b=fDfq8mjchYA1duFXX6d7b4cogw6fwux+ZpNgkD7AAqEEYOHpkTrIBcQX7j9AfToACT
         HWz57eXUvS0p5jwuNff5xbf774AHmRV2PaAQ8D5uu0CDOtSEj/Vv6XGS7tpkoKDg9ERx
         oP50widwzFToGOspbBXjWCMjxypdM3ZUG3yvMuEICFqeY71BJ3nEYR+L5zLl6nSDTeJk
         X4U8oDHVpOyLbfD+UqAYT5FHDs8dZRaWBk2KEd+iXhilqauPXClt4s2jpgxDdn7x1p4P
         2hxZLW51/HUSbTKcejm60ZYxmrLT7iYsM7FLwg44GQqYxlG2MBpbsC7OQSapi5JFb0fd
         Md9Q==
X-Gm-Message-State: APjAAAUKn0YqFb12wDITp/+Bsi8nOHyIivtKUEPszCTVi/M96VFruGdQ
        16CGpsGs/MmFWSLtcASD8216MAy0jDU4JOYlgNNORn3qoK1ofuW92KmHw+ppB4ccn83IGhnVQU1
        xPuBYa7gPy+/WcOw+l4oora8d
X-Received: by 2002:adf:d183:: with SMTP id v3mr17317244wrc.180.1579773266297;
        Thu, 23 Jan 2020 01:54:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAtrBi9gbReQo2xoYrZX95q69/GNjES5FxPk/zX0+P2S8Pau4UYtndwwrsnAMcOxolIcX0Xg==
X-Received: by 2002:adf:d183:: with SMTP id v3mr17317202wrc.180.1579773266023;
        Thu, 23 Jan 2020 01:54:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id c9sm2166949wme.41.2020.01.23.01.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 01:54:25 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in
 handle_invvpid() default case
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com>
 <8736c6sga7.fsf@vitty.brq.redhat.com>
 <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com>
 <87wo9iqzfa.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee7d815f-750f-3d0e-2def-1631be66a483@redhat.com>
Date:   Thu, 23 Jan 2020 10:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87wo9iqzfa.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 10:45, Vitaly Kuznetsov wrote:
>>> SDM says that "If an
>>> unsupported INVVPID type is specified, the instruction fails." and this
>>> is similar to INVEPT and I decided to check what handle_invept()
>>> does. Well, it does BUG_ON(). 
>>>
>>> Are we doing the right thing in any of these cases?
>>
>> Yes, both INVEPT and INVVPID catch this earlier.
>>
>> So I'm leaning towards not applying Miaohe's patch.
> 
> Well, we may at least want to converge on BUG_ON() for both
> handle_invvpid()/handle_invept(), there's no need for them to differ.

WARN_ON_ONCE + nested_vmx_failValid would probably be better, if we
really want to change this.

Paolo

