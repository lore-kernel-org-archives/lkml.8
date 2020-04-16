Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4AB21927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJOvUilE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394362AbgDPOcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2442082AbgDPOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587046487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4LbIjifhs31GrdZsatWJ4in6sP3uCDUI2SE3ic9y2k=;
        b=FJOvUilEjsdH+VD4Ne1Jj/kdTLHGWZ6Z6g+CobCTsfgk3DfG6CUc5qVc8KulnxsqZFqrnQ
        bn3ka9T9LF0PUOs+2wZ+fFlN1kUssKYDdTsYBtohS9BcfA9grDz+DyxeO4CnO2NKrNIpTs
        APBJLH514s3Ar3nFS0VzZ6rcsU9PiQo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-ODxijk5-MeCjBj5HWOc7VQ-1; Thu, 16 Apr 2020 10:14:45 -0400
X-MC-Unique: ODxijk5-MeCjBj5HWOc7VQ-1
Received: by mail-wr1-f70.google.com with SMTP id m5so1762555wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4LbIjifhs31GrdZsatWJ4in6sP3uCDUI2SE3ic9y2k=;
        b=pFIJin0keLaOu60S8/eCi/E0URw8wSRM4f9eWLPnsK8ACatPa5Y+kAh9Gd1gjVCG+g
         sJ08XHzispJ2jscHwRjNCtvRdRyC1AXzxIvSW3CY8PbryyX6INAjXAf/TFo0KNQAiGDG
         EVTI/f7XCX+3yWCBuBpLyiZUpmhl2una8CmBZOqOZRrVqNqvEVVGSBnF97iZO8iz7FfJ
         l7zdLfoQnknhHtOXcwREq+IC8JyXiEQBYxxtS2lNqLVK0t53GgP8unbPAlpec/RnABvS
         rxpUijMJN+SW3g+Qu4+tqH0/CcPF093Tr4AA5ORcrnC6ZTZBxjhEeJ1MBxMUMxfQjnZf
         Lajw==
X-Gm-Message-State: AGi0PuYbwWz0xQiQTU+dT8+DNnrJJlLcxvBPEmlOwf3EUoNILTg25qbS
        S37LRigvgS00/17pa5hD8f/uDeP/a2HMIfMR+YxSt4EnoQ8Qkm/A/sxKZ2F0qRqCXgULMJXw9uO
        9UPUIu1pRqHFUpvebca3ZYEkF
X-Received: by 2002:adf:e848:: with SMTP id d8mr33883867wrn.209.1587046484436;
        Thu, 16 Apr 2020 07:14:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+5qHqtVwzCgx7S8VpTriOqQUHASdbkuuPRsw8bJP55L1T+tlRS2o36NHVkciWfVcEHwcnNg==
X-Received: by 2002:adf:e848:: with SMTP id d8mr33883843wrn.209.1587046484184;
        Thu, 16 Apr 2020 07:14:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id e5sm28732851wru.92.2020.04.16.07.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 07:14:43 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: fix compilation with modular PSP and
 non-modular KVM
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     ubizjak@gmail.com
References: <20200413075032.5546-1-pbonzini@redhat.com>
 <d8cab90f-8c9c-7f79-0913-ba0d8576206d@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2965bb4-42f3-7961-aaba-66f031197dff@redhat.com>
Date:   Thu, 16 Apr 2020 16:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d8cab90f-8c9c-7f79-0913-ba0d8576206d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 15:57, Tom Lendacky wrote:
> On 4/13/20 2:50 AM, Paolo Bonzini wrote:
>> Use svm_sev_enabled() in order to cull all calls to PSP code.  Otherwise,
>> compilation fails with undefined symbols if the PSP device driver is
>> compiled
>> as a module and KVM is not.
> 
> The Kconfig support will set CONFIG_KVM_AMD_SEV to "n" in this
> situation, so it might be worth seeing if sev.o could be removed from
> the build at that point. I'll try and look at that when I get a chance,
> but I'm currently buried with a ton of other work.

It could be made to work, but you would have to add stubs to sev.h.

Paolo

