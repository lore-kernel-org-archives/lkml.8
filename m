Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ECF2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOuhdcya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgCFIpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:45:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgCFIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583484330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPUakhz1PfHoxZ0tbry8WaZvrV2+jq26d8FjwX0/vCU=;
        b=hOuhdcya0RP0iVK/XbtKQWGD+ASCrgXMyI9jgeZkVfZFesigLss3llYffiJ13Qnt31x1Vz
        TM5dMPuz4CLsJ6UnE4jZh74bOMc/HoSYG1DBweyLSseuBwXFKmvwBS4TEcAbiS8ArK9Is6
        iYa3OMScAQxhu2gpqcq703NwAY5PDjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-v0Un592VP8qi3rra8iHkVQ-1; Fri, 06 Mar 2020 03:45:28 -0500
X-MC-Unique: v0Un592VP8qi3rra8iHkVQ-1
Received: by mail-wm1-f71.google.com with SMTP id e26so358012wmk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NPUakhz1PfHoxZ0tbry8WaZvrV2+jq26d8FjwX0/vCU=;
        b=P/JvK17hWpMt7JCWSpngTKXIp601p6GxvSDtDl2AzdnvpjetC3LYbc/rZ80Pbed4mw
         J8I1d5jNLZVM10M57Gm5sLbl1C477OOFy7FqQl68v330WP8+O7NHrpXYuvppYw1s7+iR
         ioch4IKYZmZ9U2A+PKZTjQuFOX1XKKnSJnZmrxzWQURNLqX5aiTv9WueIuoJWxufzQRj
         a3cb+BEC5T1Z90EPUctF0SfX9qUWC1pF15IcJ3UKTiyPy54Ivofe1+IUgoisvVgCuj8e
         +zWDkdIF6lJCTe8jlskFOJSZ0kg7j6kuDiD8mnxoLtLflV60oKSMy5hPUyXnQglZFEYQ
         60iA==
X-Gm-Message-State: ANhLgQ0JP7EP6pL7bAPIL0fYrZ+ewJfYrjlrI8DT9Rzo6EmeZMC4xIDd
        +d7udy4mQLNUd9Kelz9SGpKmTrM5dDbbSsbd4799MmVEef5Tw6sI2wODThBRmCykzXN14D0CR1y
        ZMzQoeG3IPt84MaSh5c2vPvcL
X-Received: by 2002:adf:e38d:: with SMTP id e13mr2772218wrm.133.1583484327445;
        Fri, 06 Mar 2020 00:45:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuEMSmKXG0u6JbRxYLI8iuXjVLL2YaBM1kPo7etwUgNWuHn/SkYRbwru3mR9qW3MKYGvyvujA==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr2772202wrm.133.1583484327233;
        Fri, 06 Mar 2020 00:45:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e? ([2001:b07:6468:f312:b99a:4374:773d:f32e])
        by smtp.gmail.com with ESMTPSA id v7sm41493907wrm.49.2020.03.06.00.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 00:45:26 -0800 (PST)
Subject: Re: [PATCH v2 0/7] KVM: x86: CPUID emulation and tracing fixes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
 <6071310f-dd4b-6a6d-5578-7b6f72a9b1be@redhat.com>
 <20200305171204.GI11500@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d17c0c1-cdf0-f8cc-0cc4-4b9dda0b514d@redhat.com>
Date:   Fri, 6 Mar 2020 09:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305171204.GI11500@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 18:12, Sean Christopherson wrote:
>>> In theory, everything up to the refactoring is non-controversial, i.e. we
>>> can bikeshed the refactoring without delaying the bug fixes.
>> Even the refactoring itself is much less controversial.  I queued
>> everything, there's always time to unqueue.
> Looks like the build-time assertions don't play nice with older versions of
> gcc :-(

Yes, I was quite surprised that they worked.  I suppose you could write
a macro that checks against 'G', 'e', 'n', 'u', 'i', 'n', 'e', 'I', 'n',
't', 'e', 'l'...

Paolo

