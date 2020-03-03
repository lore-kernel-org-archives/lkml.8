Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C56DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0720866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDittj7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgCCPrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:47:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36872 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728291AbgCCPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583250471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG7spyj/jPjRcn2UnTtv+KAPrRp318NfiqYCxbBVCsY=;
        b=CDittj7vv1TCbo9NBcpvSma3YLBl8dK9DMv62XDckjh398t+mmuqjzjuLWsB4Giji48X4x
        WOF1dLAlzlELnLfXOleLu/w6L9s44a6ogFtOZvBCzjr8bdVvEOl9ozrE6HJnX/L0aoesrl
        10NRjNrYzQV33quh/fye9PhkxzJYxVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-sOt5g6mjNQOkQ2c-Lwk0Xg-1; Tue, 03 Mar 2020 10:47:50 -0500
X-MC-Unique: sOt5g6mjNQOkQ2c-Lwk0Xg-1
Received: by mail-wm1-f72.google.com with SMTP id m4so1260782wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bG7spyj/jPjRcn2UnTtv+KAPrRp318NfiqYCxbBVCsY=;
        b=Wx1zARfxitTy0uujqTVYBKfb6rtdaQPx+VBqCGjNNyQe7aZ59ZXfZHnE1D5XrFxgED
         Di6kDQyUF86ZF6N97H0ezJcALlKp3MHhRlIRtfSmYl4V1E2pgN3fFO4R1oHduclI52Nb
         QlzTvxWW7woefAPIPI7CHgVQBgGZ7WLtjRDjIzN5gY5bS6nwE4MUQPV8oQXQKIrcUsKe
         wETsniPXCus7kSnBgTX19/dCxmasQx8fgL88whHOIM6TO4H1hRH2rvCk4c6t5UG6CUV5
         2eOphqDXWbDd+0Bxumb2R/ErtUSDQoAfYk1ajGud5XVn5yCweGJmcj1sE6TB/ZS26ff7
         kixg==
X-Gm-Message-State: ANhLgQ1gFQO/+mcpFn/Af+S0SPsqO692xTHKe0lW+Y7CS+4IUPUDWBKt
        r4EKMYrRGlHeG/uB1KMGA5hNAtJyGFDBhHH4boMdaPNxdAZVXqa0TRnbRx2/ugFrdckCH7IieSB
        lVRG4rOo5fL3BTGPVYT9Rmt76
X-Received: by 2002:adf:f84a:: with SMTP id d10mr6193507wrq.208.1583250469314;
        Tue, 03 Mar 2020 07:47:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vurPs03BOzNDPspE899csrvDYsx6LhbVx0i31qdR5zsRxPUfjTQbsqbQsY3PprBfki9zN9/ww==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr6193486wrq.208.1583250469102;
        Tue, 03 Mar 2020 07:47:49 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id y139sm4796973wmd.24.2020.03.03.07.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:47:48 -0800 (PST)
Subject: Re: [PATCH v2 36/66] KVM: x86: Handle GBPAGE CPUID adjustment for EPT
 in VMX code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-37-sean.j.christopherson@intel.com>
 <90df7276-e586-9082-3d80-6b45e0fb4670@redhat.com>
 <20200303153550.GC1439@linux.intel.com>
 <c789abc9-9687-82ae-d133-bd3a6d838ca5@redhat.com>
 <20200303154453.GF1439@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21298366-2604-186d-1385-c2a04c74bad7@redhat.com>
Date:   Tue, 3 Mar 2020 16:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303154453.GF1439@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 16:44, Sean Christopherson wrote:
>>> Oof, that took me a long time to process.  You're saying that KVM can
>>> allow the guest to use GBPAGES when shadow paging is enabled because KVM
>>> can effectively emulate GBPAGES.  And IIUC, you're also saying that
>>> cpuid.GBPAGES should never be influenced by EPT restrictions.
>>>
>>> That all makes sense.
>> Yes, exactly.
> I'll tack that on to the front of the series.  Should it be tagged Fixes?
> Feels like a fix, but is also more than a bit scary.

If you don't mind, I prefer to do the changes myself and also fix the
conflicts, in order to get my feet wet in the new cpu_caps world.  I'll
push it to a temporary branch for you to take a look, possibly tomorrow.

Paolo

