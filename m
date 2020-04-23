Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968C32077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNs81Mai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWJwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:52:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbgDWJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587635557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfTWHpfgM90dhku3gSYt8YyCxLtENM52kAFB9Xkdy/Y=;
        b=fNs81Mai4744UWS79xKxj69yXxiVs1ju/Y8y1KnFbQRjNI7OP6gSi8Qk6apGMtb1Vspoji
        61W6ktoENzQU2Cte5h4D1sZ2+KPApnam+A4+9rknBEApzjD04SyYynKBZCxmuOmM8fJ2Gk
        ZBsFq0uF1iA8RMUWbjUsDs6WW8za9Kg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-NdgIN125PXW6Q04p7efdBw-1; Thu, 23 Apr 2020 05:52:35 -0400
X-MC-Unique: NdgIN125PXW6Q04p7efdBw-1
Received: by mail-wm1-f72.google.com with SMTP id n17so2094082wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wfTWHpfgM90dhku3gSYt8YyCxLtENM52kAFB9Xkdy/Y=;
        b=X9BLOSlDxvUFExrEcf7FEdZ9wb5HX7d4H5II6sRem5UieLMTo5MixrnQt/qHdBBMVn
         qUX3sy0FreUVLranqSCkG8rU6WlHG0dBBcp0f7IMhlJSYtGBNl8s/u6bz7QwE7bvisHt
         DZh6ZdijQkEPbgASlIrLd/MtS+yPisbAdu+7Y4/uX5qAxI+Kw0+QzqVLKIFHKOpnAyte
         0V6/gXG2OrgDY4i3BVnwbg9JoKO3Daq0ulKtipkxo4xa3eU0FQISnTibrTiTwVOEif1K
         rz210cr2nEwbLc2hT0AQCiVn5RWRY5E/RB52jch+ojvMUbDg9fLnuJ7xDXEKYaUHqNQC
         VoYA==
X-Gm-Message-State: AGi0PubSEtdrPaCArebIi0N9C+rpgcfl5uVgV4OWfQ2bOssTgjGRRY2v
        esrAU3SaSMbvKqa86S9ZUaBYm2bo3alwl7qhd9WUk0d2Xwg/B6pARfo7k66fJFFZSP8A3hjow9L
        G81hbFVdWyzhqxJFMJq+u0zIy
X-Received: by 2002:adf:edc6:: with SMTP id v6mr3935903wro.8.1587635554377;
        Thu, 23 Apr 2020 02:52:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfAiNuOF9QP8LaFJne9ECJ8ndLYf/hYMVlrB3b8SbuEYpG21/xow0J3Jf8cXJSSsfo5rTEWg==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr3935877wro.8.1587635554166;
        Thu, 23 Apr 2020 02:52:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id x13sm3119979wmc.5.2020.04.23.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:52:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] KVM: LAPIC: Introduce interrupt delivery fastpath
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-2-git-send-email-wanpengli@tencent.com>
 <09cba36c-61d8-e660-295d-af54ceb36036@redhat.com>
 <CANRm+Cybksev1jJK7Fuog43G9zBCqmtLTYGvqAdCwpw3f6z0yA@mail.gmail.com>
 <8a29181c-c6bb-fe36-51ac-49d764819393@redhat.com>
 <CANRm+CzFgbuYY6t8E0OihXMzRV8ePjnoZPUPXxGcexbL8gKfEA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c77ae96-09ec-985b-a8d7-a4ba7e80b18f@redhat.com>
Date:   Thu, 23 Apr 2020 11:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzFgbuYY6t8E0OihXMzRV8ePjnoZPUPXxGcexbL8gKfEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:44, Wanpeng Li wrote:
>>>> Would it help to make the above
>>>> 
>>>>         if (vcpu != kvm_get_running_vcpu() &&
>>>>             !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
>>>>                 kvm_vcpu_kick(vcpu);
>>>> 
>>>> ?  If that is enough for the APICv case, it's good enough.
>>>
>>> We will not exit from vmx_vcpu_run to vcpu_enter_guest, so it will not
>>> help, right?
>>
>> Oh indeed---the call to sync_pir_to_irr is in vcpu_enter_guest.  You can
>> add it to patch 3 right before "goto cont_run", since AMD does not need it.
>
> Just move kvm_x86_ops.sync_pir_to_irr(vcpu)? How about the set pir/on
> part for APICv and non-APICv part in fast_deliver_interrupt()?

That should be handled by deliver_posted_interrupt with no performance
penalty, if you add "vcpu != kvm_get_running_vcpu()" before it calls
kvm_vcpu_trigger_posted_interrupt.

Paolo

