Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3A8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201B62073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftFr0phx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgE3FKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 01:10:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26240 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgE3FKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590815453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Kf6XO5g1mQ6NPxd92AMMUcl7wDe8Zvf48X720rxLRo=;
        b=ftFr0phxlcLpItXJlJpuKC5Rr08JopMjZNufKyxoYlZihfBqC6bmxEPtW92KPgg002ooUY
        MxmVUZSuuvW9pKwJ4lT2WqBb6SDntvKYw6QyT8S2b5rP6kLY7/ufFEkrH9+Sb/tNme18OQ
        n8uTGpyrfms2lcA4gY/3Ndh67GJQbwE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-XY_mnefCPemKW1x1I61Cew-1; Sat, 30 May 2020 01:10:49 -0400
X-MC-Unique: XY_mnefCPemKW1x1I61Cew-1
Received: by mail-wr1-f71.google.com with SMTP id p10so1798432wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Kf6XO5g1mQ6NPxd92AMMUcl7wDe8Zvf48X720rxLRo=;
        b=Edi5ZoyoQVWm/kbmDhr1L1Y9I2YMh7tclOTIvh8T1Fpqr4IWFJdAq/QR8L/Lj/v2uZ
         Wj14VKDr2vyYeblWcvelO1pi6sGMCe7LhxM+LInUX+nHdoWFg07vbhY1b5DIxvNy/Ovz
         hhayosm0AIVkpYb6oU3+W6zk1LtNfWCHOIqiOWvdG/xr0Xb9OvclMnj1yMk/zyN7lUOl
         Es94Fd7abKxH1NtXK0J4V5TG2t1/YZnOz24xxW/lZColJypjTsWPU5jd0Tto5VuWuk2b
         dyT7ooyc9yEEofw39e7RSKWcJ83pC83kCysbEWKeBiANnuefsgI5VD+6HeFt6gjab5Iz
         OFLw==
X-Gm-Message-State: AOAM53126h7hZuw2DoP6ETK/vtTXjAIlbuHeMSVU68IPqq0Kt5shWNDu
        +PdLzBMoXRXqnG27zdM9+pgXFw/j75XGxPqvmoHrXkb2fmMLlQ4gqqktfaJ61wnKQjtpNBbnQ+z
        gWwAt/rjK9v53XHRWurUXYYWS
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr11333446wmj.87.1590815447746;
        Fri, 29 May 2020 22:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRg40r5C7bTlx+kDl7KL+EfcxvhwaWd/5V7DTZRfgr2vb/jPzdmLxSIsGDaqjhAGNZhhfxtQ==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr11333434wmj.87.1590815447492;
        Fri, 29 May 2020 22:10:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id s2sm1949988wmh.11.2020.05.29.22.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 22:10:46 -0700 (PDT)
Subject: Re: [PATCH 17/30] KVM: nSVM: synchronize VMCB controls updated by the
 processor on every vmexit
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-18-pbonzini@redhat.com>
 <128fe186-219f-75d0-7ce2-9bb6317e1e7d@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b858b7ac-b815-6c23-0adc-354bd11d5205@redhat.com>
Date:   Sat, 30 May 2020 07:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <128fe186-219f-75d0-7ce2-9bb6317e1e7d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/20 04:06, Krish Sadhukhan wrote:
>>
>>   -    nested_vmcb->control.int_ctl           = vmcb->control.int_ctl;
>> -    nested_vmcb->control.int_vector        = vmcb->control.int_vector;
> 
> 
> While it's not related to this patch, I am wondering if we need the
> following line in enter_svm_guest_mode():
> 
>     svm->vmcb->control.int_vector = nested_vmcb->control.int_vector;
> 
> If int_vector is used only to trigger a #VMEXIT after we have decided to
> inject a virtual interrupt, we probably don't the vector value from the
> nested vmcb.

KVM does not use int_vector, but other hypervisor sometimes trigger
virtual interrupts using int_ctl+int_vector instead of eventinj.
(Unlike KVM they don't intercept EXIT_VINTR).  Hyper-V operates like that.

Paolo

