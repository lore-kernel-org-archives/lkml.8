Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F8C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86040205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQNAbhTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgC3Kpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:45:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58052 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729352AbgC3Kpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585565136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynhonVYHrZ/r6D7ZTeqD8BdSmQrtIP7lxgjgux91PO8=;
        b=IQNAbhTiMihSg8k718KrEFxd8mxxgxYtZHR1XN2E8/3sgXoDCM7s/J1ld+PL5fgO/E6lGT
        Dow0aWmBYBGGcT/0okYJqbZW4KybHHuEzaOHH2OkoTOBbqW4HQV2Va8Lg2z9uScMmZ5/Dj
        LwUJRe/eex084SBIV1p2hUk4uOJ4gRQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-rDRJbabONyugDHMTLr0qtQ-1; Mon, 30 Mar 2020 06:45:35 -0400
X-MC-Unique: rDRJbabONyugDHMTLr0qtQ-1
Received: by mail-wm1-f69.google.com with SMTP id t22so6981854wmt.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 03:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ynhonVYHrZ/r6D7ZTeqD8BdSmQrtIP7lxgjgux91PO8=;
        b=ugJhMIYHzQl2ah1xk1LJnJ0/v5XlDYIk9+vXXHfZ5G/z6ZhOGcg5KRlRXeZxaq+bOf
         ozX2YtwEK53gAE7/5J6JXjkgNB5sUJyF3gCmTu7EUJWRj7Hh0wwQ0Jxi8Hh8HPKb/Dp0
         4sxKlR6CyW2Dp8srhlOZrISBctD1tsjvYWfxbmPFLnTNfIRmSHgTUHxfVLUdz/ca9r4k
         8SQJWEF/ZvDSzq/i2XMODtE/4lva5jYY4DUZwIlCzlbQagquq/rBOsDX1YSRLm6cHujQ
         qSfBPxD3asbFVJAkup8leQIwvdZG1Q8dyYUIVtsimsUembnbYOoyJgMy+IcVlKXpQfh0
         /kzg==
X-Gm-Message-State: ANhLgQ0KUc150rbHUmtn3qKKeX/yrWM8QiRRnDnFhNu7BnhwiWv91z46
        HMvXb2V5PaT53TCsC/GxAF72Pm31NhbBn8Q+otR9/qCQBX6/cU15WkBGWMP/ZsVSKlO2IyDX6Ze
        SQRtERXI0RB1IXuHF1QVR9i32
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr12922613wmb.112.1585565134032;
        Mon, 30 Mar 2020 03:45:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtRBvzmfOe/mqrcy4dakt/2hWa1Y+CxOuslpf0+gmoGJxhI0JnXw7g3K92OORRg/P22v2uGOg==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr12922595wmb.112.1585565133825;
        Mon, 30 Mar 2020 03:45:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id w204sm20754765wma.1.2020.03.30.03.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 03:45:33 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: x86: introduce kvm_mmu_invalidate_gva
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Junaid Shahid <junaids@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200326093516.24215-1-pbonzini@redhat.com>
 <20200326093516.24215-2-pbonzini@redhat.com>
 <20200328182631.GQ8104@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a1f9477-c289-592e-25ff-f22a37044457@redhat.com>
Date:   Mon, 30 Mar 2020 12:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200328182631.GQ8104@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/20 19:26, Sean Christopherson wrote:
>> +	if (mmu != &vcpu->arch.guest_mmu) {
> Doesn't need to be addressed here, but this is not the first time in this
> series (the large TLB flushing series) that I've struggled to parse
> "guest_mmu".  Would it make sense to rename it something like nested_tdp_mmu
> or l2_tdp_mmu?
> 
> A bit ugly, but it'd be nice to avoid the mental challenge of remembering
> that guest_mmu is in play if and only if nested TDP is enabled.

No, it's not ugly at all.  My vote would be for shadow_tdp_mmu.

Paolo

