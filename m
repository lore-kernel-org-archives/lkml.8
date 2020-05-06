Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B30B20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdbv4MJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgEFQ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:29:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729477AbgEFQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588782594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abwCUwFlrBH0/LiV4fKJ+ekZyJJub1hZZHM26AMRfgg=;
        b=Mdbv4MJuGkogt8l9p0XYKWYeFvLBPMzSr84QJGsI2gD2nkxi8dLQxsLrplUaPFGPmVB0UO
        RVPyVRqfHiCQbXPw2jaOtgrp30Wh+JfaASNXXKzmGT51f5wrnKrWabM06hJDOa+qQd1t5s
        Pp2s4BhL8gxv/qzuJWz7jd2wEn0YXFI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-OgpJNkx8NeG1KqBJovUoQg-1; Wed, 06 May 2020 12:29:52 -0400
X-MC-Unique: OgpJNkx8NeG1KqBJovUoQg-1
Received: by mail-wr1-f69.google.com with SMTP id x8so1590760wrl.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abwCUwFlrBH0/LiV4fKJ+ekZyJJub1hZZHM26AMRfgg=;
        b=OdkuMHc1m3hsGTcwgOThPdcyfpHGVilQ3Gsf1rCxFdG0fVaXUaiqXdkGhjFRRvBMPb
         71rIgT96SO+uGn1eh1bmWIk/O6/KL2O7sSC/WeoqM2od5+O1If7GZiQWdtRlV1hiqqCr
         Jgnj8czrioQRleUwnFIT5FCTCmipkhueI1Bw2zeob/WpToBTIZT60vC+vAHGwEcLYfVd
         JzyseaRfOJ8laBjRk/j0x2KW6vWPw5MZzrIqHX73BOYjQ7d2h0sgfsM36Sh7fFWfE9jE
         yUbOmgdhGXuVYkVpPAw8xRI43lkyOuxo5KD80YzoKSXlcfrbdCmZQVzczknM5MujXH6c
         rV8Q==
X-Gm-Message-State: AGi0PuZEYZP0QwlS8Fgu6YC8pitiuKiwqz1vTIzXRvXh7NPKDzG6jRAU
        lZi+NEPAtQlYTaD8MM2feAbhU0kS9Qyogaea4Rg+HHNyuCHyWmF440KJzix0f0iOBEz6Bjl6bXq
        pnXNG70ne1Vv7ty6dLFdNgj6O
X-Received: by 2002:a7b:c772:: with SMTP id x18mr5716546wmk.39.1588782591378;
        Wed, 06 May 2020 09:29:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIOizF0VWlYYPBGj4lNHbkD5Wb9Jr67pX998Z7+LwMKTtIBUNp+iXihf2wcB7cDgd24ImonDg==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr5716526wmk.39.1588782591146;
        Wed, 06 May 2020 09:29:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id 5sm3304030wmg.34.2020.05.06.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 09:29:50 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: SVM: Fixes setting V_IRQ while AVIC is still
 enabled
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     joro@8bytes.org, jon.grimm@amd.com, mlevitsk@redhat.com
References: <1588771076-73790-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1588771076-73790-3-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a963a336-4096-b53a-276b-6509f5cb9402@redhat.com>
Date:   Wed, 6 May 2020 18:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588771076-73790-3-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 15:17, Suravee Suthikulpanit wrote:
>   */
> -void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
> +void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit,
> +			      struct kvm_vcpu *except)
>  {
>  	unsigned long old, new, expected;
>  
> @@ -8110,7 +8111,16 @@ void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  	trace_kvm_apicv_update_request(activate, bit);
>  	if (kvm_x86_ops.pre_update_apicv_exec_ctrl)
>  		kvm_x86_ops.pre_update_apicv_exec_ctrl(kvm, activate);
> -	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_UPDATE);
> +
> +	/*
> +	 * Sending request to update APICV for all other vcpus,
> +	 * while update the calling vcpu immediately instead of
> +	 * waiting for another #VMEXIT to handle the request.
> +	 */
> +	kvm_make_all_cpus_request_except(kvm, KVM_REQ_APICV_UPDATE,
> +					 except);
> +	if (except)
> +		kvm_vcpu_update_apicv(except);

Can you use kvm_get_running_vcpu() instead of touching all callers?
Also a slightly better subject would be "KVM: SVM: Disable AVIC before
setting V_IRQ".

Paolo

