Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A094B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZukNzRkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgFDQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:49:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729893AbgFDQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591289388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSloQZeBlmDu003tkw98+MiGlwjq8F4b7bZsC7a+EE8=;
        b=ZukNzRkE+/Id7oKoUo9EfaSGS80I5HbqFoA8tCIgbqE3Kq27Xa48zL2KivKexaeOJQzyiy
        6UXHEihlECkPnI4jY9yz9imACFBpO2N4YkMDn7KJRf+9MfQiaE/xoxQSPeXhorld580bRa
        ZuMhaM64EWV44j5Bh1CqKxl9hA74DQo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-fDRDo8yyNLaune0VjWkebg-1; Thu, 04 Jun 2020 12:49:46 -0400
X-MC-Unique: fDRDo8yyNLaune0VjWkebg-1
Received: by mail-wr1-f72.google.com with SMTP id f4so2650259wrp.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSloQZeBlmDu003tkw98+MiGlwjq8F4b7bZsC7a+EE8=;
        b=U4TA3B7r2mordnRBew+YLUTFNRg0jwdoVJr3Z8UJjwLJzMVwtZqol8muxZUzlMkzic
         tVKCzJ3kSHudyw4S9rhf4EUqZoLqCN+k9x+G1/Ehm+NPYqlbo556Zt6VHu/8rdKnMU1j
         kk3nk8LP6nfS2jo7cRRchld4GT1S8xkRDPHcOsMkuEs0T0SxxdMaEUrMdEPfQCAhBpah
         7wbLxpcolinfgQPfslNyZchoIrGW8559/4JTqQKI+5TRGcX2smXAQl+O8WE27newwtQo
         LMFL2vtznE3ZaSzFVxEI91P4VkkxwchgfTpeiPNxLjzC5Ld2jWZ18d5IQLG8OLENlIQJ
         TICA==
X-Gm-Message-State: AOAM5339CDlCecn/Her5r8RbNIRVG324o109ffnDFhgYmqvFOPQueG51
        Ae9lyrmEeWLZngwt12ZQ5j3mXi5wqhXLT0qDCn6uyve/g6FVeqkZ5K6ZYw63i41mMd6t/P6f8Mc
        8vtppKXwYhqu8+UYUnIbf/v+m
X-Received: by 2002:a1c:230a:: with SMTP id j10mr4793478wmj.124.1591289385464;
        Thu, 04 Jun 2020 09:49:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE7rQk5s9bJwM1Naq3r1F2RgivXWUzdGerP9kYwoNx+OOi8MvDJjnups/+JhoUTzbmaitu8A==
X-Received: by 2002:a1c:230a:: with SMTP id j10mr4793461wmj.124.1591289385262;
        Thu, 04 Jun 2020 09:49:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id t7sm8832001wrq.41.2020.06.04.09.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:49:44 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Always treat MSR_IA32_PERF_CAPABILITIES as a
 valid PMU MSR
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Xu, Like" <like.xu@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Like Xu <like.xu@linux.intel.com>
References: <20200603203303.28545-1-sean.j.christopherson@intel.com>
 <46f57aa8-e278-b4fd-7ac8-523836308051@intel.com>
 <20200604151638.GD30223@linux.intel.com>
 <f7a234a7-664b-9160-f467-48b807d47c8b@redhat.com>
 <CALMp9eQoKJg36AabLErekJ-U10-DkRHW=dn14q0bxQHh7XrGMQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <285863c6-ef4b-a6f0-d223-ebc7cc515f84@redhat.com>
Date:   Thu, 4 Jun 2020 18:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQoKJg36AabLErekJ-U10-DkRHW=dn14q0bxQHh7XrGMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 18:44, Jim Mattson wrote:
>>> I don't know if I would call it a "good assumption" so much as a "necessary
>>> assumption".  KVM_{GET,SET}_MSRS are allowed, and must function correctly,
>>> if they're called prior to KVM_SET_CPUID{2}.
>> Generally speaking this is not the case for the PMU; get_gp_pmc for
>> example depends on pmu->nr_arch_gp_counters which is initialized based
>> on CPUID leaf 0xA.
>>
>> The assumption that this patch fixes is that you can blindly take the
>> output of KVM_GET_MSR_INDEX_LIST and pass it to KVM_{GET,SET}_MSRS.
> 
> Is that an assumption or an invariant?

Both, I guess (a valid assumption for userspace, an invariant to be
respected for the kernel code).

The part where we don't fare to well, is that a bunch of MSRs that need
save/restore are _not_ included in KVM_GET_MSR_INDEX_LIST (and the PMU
is the biggest if not the only offender there).

Paolo

