Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CAD20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf2kJMOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgGHNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:30:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729597AbgGHNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594215017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a08tCz9a1g45saZxljOnL0qxpDHyPSBjoSq9y4YxEWM=;
        b=Uf2kJMOYavwgANMqpsbsqZ4Mh1PqU0A1vL1pFrtFlgXSLcaUHbxrSkYB8RjuSVTUUb4T1M
        Ev40Qvd3xj1aFfF/vtCAd90V/p6aa/Y9gQbm0BlizBXhnAbRjPnG9LcnYM+mmBTlkV/hni
        5snHGyr6wBQCGfqI25BMGdg95E8GJ38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-WNKIay76OkG4knIsfkh0RQ-1; Wed, 08 Jul 2020 09:30:16 -0400
X-MC-Unique: WNKIay76OkG4knIsfkh0RQ-1
Received: by mail-wr1-f72.google.com with SMTP id i12so51857002wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a08tCz9a1g45saZxljOnL0qxpDHyPSBjoSq9y4YxEWM=;
        b=IoWgVlskaU/dov5FcVb1umdSK7UGAO7qLjVHeWmgr7wQy98e78/u/TvQQSIki+RcjG
         Zmv482fAgPXEMQiSP4L3gzXV4to9i3OrHyldm9p7v5M45s0o7+h2qJPYnMsKpdDDxKXc
         uPQlzz8eMw8pjEVEf4YKZWWODm8hFGKIrGb7vFgNUudv1sVNaKVSqokuP4jk78HNd5Vk
         FgqpL1NpxAZqHcL8h1mKrB+yQuqrlPHdNi0jH9ct1ClropllxeIe0L0YCGw6WnGAhw1L
         6c6zhM9djcXv2CAY0o7cpeabohOBbF8vsDdCBO3D1n+Rbe9YyxDfMv04L1avH7EuTaMP
         NuQQ==
X-Gm-Message-State: AOAM532Lwze6s74Zcs7YG2yJZr30S3GnN2ARcIlyDHbcJT4ceuBZZKjo
        jUMFaNRtsb2nBdwke+y/uKLy2lRRoa4Br26nK9XwRgUgWvputHyKY8C8vK35+zpX4m8+u78R5NJ
        za7tQRrR81C7ucY5fmseDlBDt
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr56984366wrr.11.1594215014789;
        Wed, 08 Jul 2020 06:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2jwWB+l1X8VbjFRDf1YAE71QxQJDyFYFq4dReBrjCyTz5nBbkC7IeqeRu5cmIiqtwLk5JWA==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr56984349wrr.11.1594215014525;
        Wed, 08 Jul 2020 06:30:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id e23sm5715619wme.35.2020.07.08.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:30:13 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] KVM: X86: Split kvm_update_cpuid()
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200708065054.19713-1-xiaoyao.li@intel.com>
 <20200708065054.19713-5-xiaoyao.li@intel.com>
 <ad349b28-bc62-e478-c610-e829974a8342@redhat.com>
 <92184f05-ca27-268c-ea72-f939fb1a0ab2@intel.com>
 <4123eb60-d89a-9112-dd7e-1a7627a0fc70@redhat.com>
 <0c0084cb-92c0-23fe-dc5a-441e4b04742c@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50a4b50e-0143-06dd-c75d-b76f1bbbe5ba@redhat.com>
Date:   Wed, 8 Jul 2020 15:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0c0084cb-92c0-23fe-dc5a-441e4b04742c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 15:27, Xiaoyao Li wrote:
>>
> 
> I'm ok with kvm_vcpu_after_set_cpuid().
> 
> BTW there is an unknown for me regarding enter_smm(). Currently, it
> calls kvm_update_cpuid(). I'm not sure which part it really needs,
> update CPUID or update vcpu state based on CPUID?

It needs to update CPUID because it affects CR4.OSXSAVE among others.

Paolo

