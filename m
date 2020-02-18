Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F7C34044
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2AB2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZlGkVPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBRQZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:25:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgBRQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582043134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZaVBnl5LTDIz8p3MqR4G5st87wrZLl8IZBtXDiurEw=;
        b=ZZlGkVPJvcqDkdNLMQvpOKseAp5dr1cbAvs04pUD/Ho9KKirY1qVOdTl2UClGA8WwB4hSO
        2Twj/gyUpGN8HkiH3KREi/BonJlRc9XshiRuCcieIe7P5YVhG+uFZUw0D1Ugq4TFB6qfoq
        H7epsavkYXVZuctUSzN2YMsnmigl00g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255--kEA2dkuOd6oU1ZPiGfp2Q-1; Tue, 18 Feb 2020 11:25:26 -0500
X-MC-Unique: -kEA2dkuOd6oU1ZPiGfp2Q-1
Received: by mail-wr1-f71.google.com with SMTP id d7so688486wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZaVBnl5LTDIz8p3MqR4G5st87wrZLl8IZBtXDiurEw=;
        b=fQdd3GcdMbNDrK255aqQcnriTVwHcWMxioXLVNAaMpVEv89OKJ9ZO07qVdX+87gQmw
         BYReOKZtRJFNGXryY4Rvj9j6yQ8M4dHM+InZa9d3U1CpzzuwFy8zRBBSrHiDi7Rwwy/6
         +9cwko7Hi8+buZqcDY43LvAPEJbNy/ZCNpUMY6SWdx6stpgj2NuCpGBOOdz2QQyrbL82
         vQ5y4OiIUPvKxJROSAb/IURy3GiT35paz/yWman7nyQ1D1sljcj6J592hnLtdMfoxzAD
         d+oL0gJ/dEMA9way7vBsvXx4KiDIduRN6goPfl2QBQCufkAOCIE/vZpwWBXtBHC3GExt
         Uc1w==
X-Gm-Message-State: APjAAAXbNIjLMcMzpA8kb8trdgQ9QRVtGRSw9km8fVfk2U//k9MGwrSf
        ArJ0zkbXWdd+4HLSWhGFc/+t6b5JDOYf8urlwnAuuupdXPqeGBZai7FnpBLSI6IlJCqNdOVvO/2
        Ck4tOXp4ju6ORa5tlJqEvwoeI
X-Received: by 2002:adf:e68d:: with SMTP id r13mr29533055wrm.349.1582043125163;
        Tue, 18 Feb 2020 08:25:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNLjKGcihL8iLl16MvvwxIr4m9OPysTo+s7RHCHBY/nU4biCD6WeXWya+F/KA6iuYQonH+9Q==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr29533023wrm.349.1582043124928;
        Tue, 18 Feb 2020 08:25:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id x6sm4075105wmi.44.2020.02.18.08.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 08:25:24 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: replace "fall through" with "return true" to
 indicate different case
To:     Joe Perches <joe@perches.com>, linmiaohe <linmiaohe@huawei.com>,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581997168-20350-1-git-send-email-linmiaohe@huawei.com>
 <0e28c46fe2361f0bedf438818eb7bfd1197706e2.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <013d2bbc-6948-ab49-71ca-25da77915f63@redhat.com>
Date:   Tue, 18 Feb 2020 17:25:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0e28c46fe2361f0bedf438818eb7bfd1197706e2.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/20 04:42, Joe Perches wrote:
> On Tue, 2020-02-18 at 11:39 +0800, linmiaohe wrote:
>> The second "/* fall through */" in rmode_exception() makes code harder to
>> read. Replace it with "return true" to indicate they are different cases
>> and also this improves the readability.
> []
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> []
>> @@ -4495,7 +4495,7 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>>  		if (vcpu->guest_debug &
>>  			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
>>  			return false;
>> -		/* fall through */
>> +		return true;
> 
> perhaps
> 		return !(vcpu->guest_debug & (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP));

Nice, thanks Joe.

Paolo

