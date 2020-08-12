Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB679C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874E320774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="favdMBuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHLNEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:04:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46081 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbgHLNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597237488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Fsgrw+mRjbdWES2GWusstFr/mr6OnkInf7T7tR1iuA=;
        b=favdMBuQM9Qaxvle70A5xo/Fd9S0vPlNLvGEK9NCHXzp6ykG+AkaSdAg6qiStJqLpeDEdZ
        LwH6mwijs1cHTZVlpBSjzy0LqnduARdSreTJZnQYPCbClMsudze5ITlP0rW1Xhee7kfjAQ
        fZQrRkQ2C0rbJbUnFde6BRz8V/91IFE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-mztFXmPzN-OG0VvnKo25qg-1; Wed, 12 Aug 2020 09:04:47 -0400
X-MC-Unique: mztFXmPzN-OG0VvnKo25qg-1
Received: by mail-wm1-f70.google.com with SMTP id c124so696945wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Fsgrw+mRjbdWES2GWusstFr/mr6OnkInf7T7tR1iuA=;
        b=iT6BZ3EdoeU4pNyvE4MAJ8S7p53q4tme/+P39gKBdtctTrFnzNBLnfnk3cMP245DT2
         q3KSQ6f+1X/Ht/h9O2V1jz94PJwyc3V8VWii4awtkR+xPt0s9AstPYAAFWJWJRsk2X2F
         9g3csr4piBbaEi15GyyhPykDet/DlC8Kw6oG+Dv7+Cm9xA88Gulr6RXG5jyvbW10deiu
         Vu0igrXR856Ri7LKUlfKGB9RXvXnlpqMMZk8+q/WtjRz9QF9vg7SCa5V7mi0bRPNgCov
         P2orRAjD7uZY9QLCBTAEv1vAD2xJnHbjPpeYkhC58ekcLhm44MrDFnT5e7RnBX2OX4me
         8DLA==
X-Gm-Message-State: AOAM533OZMfI/BbPNs9cfOAGmJMn5qA6D4PK5RRR//g/iRQy2WCzUbCl
        QzZO7C1wlmngNCPidc6LrIkgqi62A2VdxqkMvVzzWvdPgAGil41psU2T/Hsi9YZFLKsKrIY9Ny3
        ODoh1Qf/CxBUGQvdo+cTeOE8g
X-Received: by 2002:adf:ab55:: with SMTP id r21mr32322655wrc.332.1597237485840;
        Wed, 12 Aug 2020 06:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJcm6bs/kye85/P+Jyuc7cEjwoDZlomX2S0Ug3Q7nIk7qrF3w/nV2klKWLtDnO1ChUHk9xzA==
X-Received: by 2002:adf:ab55:: with SMTP id r21mr32322639wrc.332.1597237485611;
        Wed, 12 Aug 2020 06:04:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fcdc:39e8:d361:7e30? ([2001:b07:6468:f312:fcdc:39e8:d361:7e30])
        by smtp.gmail.com with ESMTPSA id k204sm3938274wma.21.2020.08.12.06.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:04:45 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/pmu: Add '.exclude_hv = 1' for guest perf_event
To:     like.xu@intel.com, peterz@infradead.org
Cc:     Like Xu <like.xu@linux.intel.com>, Yao <yao.jin@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200812050722.25824-1-like.xu@linux.intel.com>
 <5c41978e-8341-a179-b724-9aa6e7e8a073@redhat.com>
 <20200812111115.GO2674@hirez.programming.kicks-ass.net>
 <65eddd3c-c901-1c5a-681f-f0cb07b5fbb1@redhat.com>
 <b55afd09-77c8-398b-309b-6bd9f9cfc876@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bdc60d5-c9ef-4e8f-6b73-b7bd012d9d30@redhat.com>
Date:   Wed, 12 Aug 2020 15:04:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b55afd09-77c8-398b-309b-6bd9f9cfc876@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/20 14:56, Xu, Like wrote:
> 
> My proposal is to define:
> the "hypervisor privilege levels" events in the KVM/x86 context as
> all the host kernel events plus /dev/kvm user space events.

What are "/dev/kvm user space events"?  In any case, this patch should
be included only in the series that adds exclude_hv support in arch/x86.

Paolo

> If we add ".exclude_hv = 1" in the pmc_reprogram_counter(),
> do you see any side effect to cover the above usages?
> 
> The fact that exclude_hv has never been used in x86 does help
> the generic perf code to handle permission checks in a more concise way.

