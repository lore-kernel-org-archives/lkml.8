Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECC720702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXqewzIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgFWAYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730987AbgFWAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NahUiJQzDT4T5YVMvJMh+ukesK3KvitTEMq94zE6mM8=;
        b=RXqewzIkpO9wLHq1oNOhj8kcqBFJVDy63fqHbkPH+jnIne+jkcADPMFklqfqCnGz23kD3h
        Qv3CzxdM278sAPHaxLLDFcDXw2ggsdn+hlHmEfIM4rFqG6kGTJ3KG1Y8o7gLKIMapdwdL8
        C3wqVM2w0yrva+9x6dA0zJMNL7Bli14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-MPKLF5hKMXu7ClMOwVwYfQ-1; Mon, 22 Jun 2020 20:23:56 -0400
X-MC-Unique: MPKLF5hKMXu7ClMOwVwYfQ-1
Received: by mail-wr1-f72.google.com with SMTP id j5so10175357wro.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NahUiJQzDT4T5YVMvJMh+ukesK3KvitTEMq94zE6mM8=;
        b=nppQpvCzJId3+J+X/ike7ZOjouMn1Gw1U4vez2OALC8kfgzWa24FB4ssrodlBb9QWX
         H9uHEEyjPsNDQ9B0Y515UfuaHfAbmwMTtt7ATeopC3yJxm106URKovV4awncSwKGiBBg
         tDm3Z1bXDo+aFGH+DUcD5U5LDmi3VY3myv242WpKnwxwH5NssKUe5HJwp/Jdxz+dxFVD
         33nRPaXyDUL35I0V70kSIG5fGi55LtOgBVwwGx/YzItHfZIxhLo9QSDeQNaBiaSLR5YZ
         3Hc6qquaQzRbSP+92j2L2c7ckPScsFXbZ0WfuZwiB7JjGzTr0CTP4azqSrAJU2pyLmMy
         5Odg==
X-Gm-Message-State: AOAM530RK7qxtHV1yhYINz/H3OaCD9ljujDgWxYg0SW240LKk6IleO7a
        brKc9vgrOP8MVJdNyY6MW3ItgwjwvuLKQAUCUb6ml0RWw8ctk/5YJJ7DBSvGulFIouA2oS/UBXC
        e7JUnBeqFbrecwyecjieO8mJC
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr9834357wme.160.1592871834868;
        Mon, 22 Jun 2020 17:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9X5tQCXeIJHnr5kL8QlKHGaaTuNECyqcOl4C6xBySPZ8QwnGYQom1PDI3LxchqhObFc9j0g==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr9834332wme.160.1592871834573;
        Mon, 22 Jun 2020 17:23:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id h14sm4124267wrt.36.2020.06.22.17.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 17:23:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Don't put invalid SPs back on the list of
 active pages
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200622191850.8529-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1916978-6efb-2839-d45a-c39ff2f6dc1f@redhat.com>
Date:   Tue, 23 Jun 2020 02:23:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622191850.8529-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 21:18, Sean Christopherson wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index fdd05c233308..fa5bd3f987dd 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2757,10 +2757,13 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
>  	if (!sp->root_count) {
>  		/* Count self */
>  		(*nr_zapped)++;
> -		list_move(&sp->link, invalid_list);
> +		if (sp->role.invalid)
> +			list_add(&sp->link, invalid_list);
> +		else
> +			list_move(&sp->link, invalid_list);

It's late here, but I think this part needs a comment anyway...

Paolo

