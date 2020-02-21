Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA372C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD79222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbuVidS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBUR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:26:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52550 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgBUR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aa4zbJiGMg7M3QmslZBzxRFUBeWyQYNCsrPB0JpL0lk=;
        b=hbuVidS3w7hRzltx2PkWfU+hahbVtWzivyW0GnyT59LaWakUBenTj1sg9udXHNJrfgjzUy
        cYTU/e8SsZ9uZ6c97CpgH4MUaoVQRdTkxKeQTJXBolNX8lXqFS+1uTtqi9eusLEi5GG7px
        lGUjjHTGKtpNxyWHHVtnwaSEhWEwZtE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Jvo9SbKJMbay7ehJ8Wco6w-1; Fri, 21 Feb 2020 12:26:04 -0500
X-MC-Unique: Jvo9SbKJMbay7ehJ8Wco6w-1
Received: by mail-wm1-f71.google.com with SMTP id f66so847561wmf.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aa4zbJiGMg7M3QmslZBzxRFUBeWyQYNCsrPB0JpL0lk=;
        b=TdmGpxZo/sWkkMwWRDaydVovblofeBQ3SMAk6IztPgINi/FgifXR/NNmTP7wsfoTQ/
         +OhCQp7smvPPX/iWxepyGZ7oi19z2HaJX4HyNAAN+pbELQF89PCJ7zrMcUUu0f1AkN//
         EfPnShUyNLU36n0my0Fg7hrt5c5EKigtMPtPcJ0nXoYKKN9eF9cPtnMtjpn5CjhKtGD1
         BOuHPpeEbvact3etdhCPfxybP/709tGxsB8iGYoBRaig2FHfQTrT5/Hm9DIOmgOjFH5F
         P4CIZPqF5GMiV+NcrJXTL8bwei6je48i9EOXvvaShSUpLM+SHLTEIFFw4ZXkM11BvdeK
         WVaQ==
X-Gm-Message-State: APjAAAVyLq9pErIp/L9SgQrHlYk7/lk6XpP89U4oVjdHxlBfncjEGkOp
        fzmXl5WYCafe9ZYVaylzMXpq/hqwJTdIgsExFEDnbkOhD2sONfvkzxql0qhmYOpXKizsMjJbz+C
        yvAHajoYfjJgFPxscJ6iiMuLU
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr49551484wrq.331.1582305963517;
        Fri, 21 Feb 2020 09:26:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfBUjuDSSdiZSSO9suK49MMgtyvOMcRngBUhZB6jOyM+FsBg+E+dvkna0uZ8vrz9sbtbKk5g==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr49551468wrq.331.1582305963261;
        Fri, 21 Feb 2020 09:26:03 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id q124sm10395988wme.2.2020.02.21.09.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:26:02 -0800 (PST)
Subject: Re: [PATCH 01/10] KVM: VMX: Use vpid_sync_context() directly when
 possible
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200220204356.8837-1-sean.j.christopherson@intel.com>
 <20200220204356.8837-2-sean.j.christopherson@intel.com>
 <878skwt6yt.fsf@vitty.brq.redhat.com>
 <20200221153619.GE12665@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24835177-ecab-8b84-d31b-e6f93df544ef@redhat.com>
Date:   Fri, 21 Feb 2020 18:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221153619.GE12665@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/20 16:36, Sean Christopherson wrote:
>>>  				vmx->nested.last_vpid = vmcs12->virtual_processor_id;
>>> -				__vmx_flush_tlb(vcpu, nested_get_vpid02(vcpu), false);
>>> +				vpid_sync_context(nested_get_vpid02(vcpu));
>>>  			}
>>>  		} else {
>>>  			/*
>>> @@ -5154,17 +5154,17 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>>>  			__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR,
>>>  				vpid02, operand.gla);
>>>  		} else
>>> -			__vmx_flush_tlb(vcpu, vpid02, false);
>>> +			vpid_sync_context(vpid02);
>> This is a pre-existing condition but coding style requires braces even
>> for single statements when they were used in another branch.
> I'll fix this in v2.
> 

Can also remove the braces from the "then" branch.

Paolo

