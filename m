Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D7C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7341A24656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZGlAvXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgBYOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:01:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730335AbgBYOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582639316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cy4Mge9KuRHZ+vguZEp3MFbF3jZxqc31nOjzMlddL7c=;
        b=QZGlAvXvakbPs8PlUpsfD0qiL1FzvFc3WLfy/6NvELUEYO056IzfFtetfUD5oT+ocCQQ9o
        CEDdyMOSrGt8yQJcCWIPKpGOyjMKpIardnooa9pn30HzIP5fmITiXhFDfZbL2t1BqpXat9
        DRXzWvxWJCHi65DCyZ32P+Gif3gGwGc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-08VYskdEM_m2fGQdewWolQ-1; Tue, 25 Feb 2020 09:01:55 -0500
X-MC-Unique: 08VYskdEM_m2fGQdewWolQ-1
Received: by mail-wr1-f69.google.com with SMTP id r1so7332576wrc.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cy4Mge9KuRHZ+vguZEp3MFbF3jZxqc31nOjzMlddL7c=;
        b=BDWA4JG0jGmGpX2p4vkq9FRJ6A11YnllFpm4FC8YMRsGSQxX+7UAcs/nVJu4zpIvxt
         IvdNbk4sd3LIwfRP4qxn8lFSpnMYdDwDm6curV1ePRF+DlNuIjdWFW9yWcf5wMdePwFm
         DQFR1/ogEEkIDBf3CXJSkn9MqcJ7uJ3kH8DY4N1fuKWsVz62SPg1GyDjjT0E2c1Z7tzM
         1W9foJS2WyCGE2Zy6HbG6mKGY2zi2K+wqvzs2OKTfSE/9swDEefFnMPAUZPD2nSvaBGi
         EEd6ifaHmiSlAbxOQQyKkrJdn0+FACte4z52s0+/dbfy59tqK1S8Pz1AJUxYx51cILQs
         bJZw==
X-Gm-Message-State: APjAAAXZtknOVtzL6IXmbQEFiivUaJLDS6oQGWE89awsAo1We5Oz1M0b
        cIDEfD+0v4ZO0qZLMlT2xD1DWkuFfCbuVX7mS6rXtiEU3Sk4o840KtjvEXC1OkLx/276S/OInob
        oBChk16kZXrEg1zAeg6gpDgLa
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr5676613wmb.118.1582639313900;
        Tue, 25 Feb 2020 06:01:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcqZv16UHutDm/y3gCnBP3VcZYojhMIJsMMUPRJNFOL5jWS8OmVMbBl1uO6UKRP4W4maomyw==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr5676587wmb.118.1582639313626;
        Tue, 25 Feb 2020 06:01:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id c9sm4324260wmc.47.2020.02.25.06.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:01:52 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: allocate AVIC data structures based on kvm_amd
 moduleparameter
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     rmuncrief@humanavance.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1582617278-50338-1-git-send-email-pbonzini@redhat.com>
 <874kven5kv.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2c3471d-3234-5e0a-0c76-872040a65bb6@redhat.com>
Date:   Tue, 25 Feb 2020 15:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <874kven5kv.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 14:45, Vitaly Kuznetsov wrote:
>>  	int ret;
>> +	struct kvm_vcpu *vcpu = &svm->vcpu;
>>  
>> -	if (!kvm_vcpu_apicv_active(&svm->vcpu))
>> +	if (!avic || !irqchip_in_kernel(vcpu->kvm))
>>  		return 0;
>>  
>>  	ret = avic_init_backing_page(&svm->vcpu);
> Out of pure curiosity,
> 
> when irqchip_in_kernel() is false, can we still get to .update_pi_irte()
> (svm_update_pi_irte()) -> get_pi_vcpu_info() -> "vcpu_info->pi_desc_addr
> = __sme_set(page_to_phys((*svm)->avic_backing_page));" -> crash! or is
> there anything which make this impossible?

No, because kvm_arch_irqfd_allowed returns false so you cannot create
any irqfd (svm_update_pi_irte is called when virt/lib/irqbypass.c finds
a match between two eventfds in KVM and VFIO).

Paolo

