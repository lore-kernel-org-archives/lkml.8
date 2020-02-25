Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC8C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2618B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEmdaWoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgBYPCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:02:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32742 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727983AbgBYPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qmdty5ApanVXOoViqBDfD6UpwzRENkkg2TmUrzZnyAI=;
        b=eEmdaWoR1lgeMJaYN6Lxwokm2uCrGuxswseVJo/tdaCwqfUWDLbFIKIEatZH6Q2ZAm12D3
        kFoEnWhYJlAr2VyWpWCgZut3yT60l5w7CmGLIORJuEfxoIzDuQSLiiOF9wYTolScMDPZWC
        11E9O1XQAn3zGy+slNy4XiHm1bQ4OjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-X1lG7aU1MU2S9-mCXf-3Ww-1; Tue, 25 Feb 2020 10:02:50 -0500
X-MC-Unique: X1lG7aU1MU2S9-mCXf-3Ww-1
Received: by mail-wr1-f72.google.com with SMTP id 90so7433922wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qmdty5ApanVXOoViqBDfD6UpwzRENkkg2TmUrzZnyAI=;
        b=YvHP7UQM6g7UNciixxYW0m+GhDM03Q6qR9slRCRx8zj5S1Nvb/MiI4CFThE7MIg7UI
         hMn0HwijwArXsTxfyjmLPLN7f5xcEf2ijnr+TvS6NhTp0dMaLW80YoyVCLv9C113qHFo
         hfX4XOXmls1bAyhjGwrMC5XnV253ESx8P7QzJj346N862/XIyhcpCZWbjtPjk6Vmwfrq
         16KXj3dhYRmUPYZF+QpDWD7hUfSD2yVUAWlpBP8dXxZ9uACRU5l7jpI4sqvH2pF9Ihrw
         rI/S7gcjddXBcuRCjkHlKnq+ATZhMm9BWvRT+WI0qNburii9He+7qsWTjvYSxXUNagfE
         mROQ==
X-Gm-Message-State: APjAAAU36bh+cM4o3ynQtWXHnEGkFvuanZABC0xHCl2aFTr/yNfl/WWu
        aCWg38kfxn99jvD6IXRmsQ+nkl1i1cwhrzEF5537EcF52v4r5mH9DbA7EzNkigEkZ//mo43s8y5
        4h1whKtq7d8QPhkrxGa/L2Fi8
X-Received: by 2002:a5d:484f:: with SMTP id n15mr73445797wrs.365.1582642968951;
        Tue, 25 Feb 2020 07:02:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkYUCYshbyqHbkPfDvhCptK+3hJnYAP9y9sKsJfO/jrJLdoQQFtOEeiw50aW1MVd2Ye7HybQ==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr73445770wrs.365.1582642968670;
        Tue, 25 Feb 2020 07:02:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id x6sm24495600wrr.6.2020.02.25.07.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:02:48 -0800 (PST)
Subject: Re: [PATCH 29/61] KVM: x86: Add Kconfig-controlled auditing of
 reverse CPUID lookups
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-30-sean.j.christopherson@intel.com>
 <87a758oztt.fsf@vitty.brq.redhat.com>
 <20200224224613.GO29865@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f944dd3-aed3-be94-624b-35e7d35cb2db@redhat.com>
Date:   Tue, 25 Feb 2020 16:02:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224224613.GO29865@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/20 23:46, Sean Christopherson wrote:
>>>  static __always_inline u32 *__cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry,
>>>  						  const struct cpuid_reg *cpuid)
>>>  {
>>> +#ifdef CONFIG_KVM_CPUID_AUDIT
>>> +	WARN_ON_ONCE(entry->function != cpuid->function);
>>> +	WARN_ON_ONCE(entry->index != cpuid->index);
>>> +#endif
>>> +
>>>  	switch (cpuid->reg) {
>>>  	case CPUID_EAX:
>>>  		return &entry->eax;
>>
>> Honestly, I was thinking we should BUG_ON() and even in production builds
>> but not everyone around is so rebellious I guess, so
> 
> LOL.  It's a waste of cycles for something that will "never" be hit, i.e.
> we _really_ dropped the ball if a bug of this natures makes it into a
> kernel release.

There are quite a few WARN_ONs like that already.  I'd say each
non-constant-folded call to __cpuid_enty_get_reg is a waste of cycles,
if you're counting them. :)

Paolo

