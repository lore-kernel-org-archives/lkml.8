Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD42C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CC220838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWA3gT3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD3IkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:40:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3IkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588236023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BynAcktxklIPD8PUgUO0uMVcQmlqCmJY7NgBZufPOXo=;
        b=aWA3gT3UA+nkLB7tOvfZRielgRbUcgPUrVq/UALpL2uTTfjbvzJbv7oRKyzU7/3gvN8EWi
        KKDdcVx/wcZuaMmbB7bXNVh27KWVH3DWE/xXrhf6v997hwYSxr5CX9jA2DzUsujOSiP+Eg
        ZZgjJ6CEtaCs/H2IddSulcmSb/mvzNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-kp-Lg03HNr6uVVXzlcev2A-1; Thu, 30 Apr 2020 04:40:21 -0400
X-MC-Unique: kp-Lg03HNr6uVVXzlcev2A-1
Received: by mail-wr1-f69.google.com with SMTP id m5so3498671wru.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BynAcktxklIPD8PUgUO0uMVcQmlqCmJY7NgBZufPOXo=;
        b=Hcrxa6RRgxOV7rWFV8QRPmhy1z2LAS/TYNAdDQQdmlGnwL8LNiqB8t8YOstxUipRJk
         /EzEE9N98tDfXAALrTsC0bkgloZuGqiSs8UKfMMGJ+zMH/1Ufc7cMpLNhzsHyxf5lZyV
         yvwvmIF6pUHwChKKypcyzw94mWJluAq1VZ+xUBlayFG64Y/rhiWJ6A63ScwAkmc04FBm
         8+3Tgnqaa0FzA8l1uqKKC/p8+5Ng92FpAGjGoXfS0xNL4DPes5bYTjMTvuwPmTStjTBQ
         lhVGcvuJhOcc++Jihn7Uj3t8dhJqrXkoCfXOgXdxQz3pRQSbUXJHI6e9TZRVBF3cVhap
         v9Mw==
X-Gm-Message-State: AGi0Pua3RXRBpwuexmJZtrJCXY9qbIgWNJSloLhCa+xuU7G/oVKqvTCh
        AgDBCJPqBNH7mR5IWt5Am2X3fkR6uWU8yFd0garHuTvCPwmhgrRCKY8OUcOevXqFXeeYVWcz8Uz
        6NCN+ndKxC3HzPqU61V0GUAWs
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr2755617wrx.229.1588236020376;
        Thu, 30 Apr 2020 01:40:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypLXhPodZd49TSkY6lRac/pxozL7+5BXs4yZBzqyMTsISY3o9bymKF6WlF2UNvbwnTgZcvOtRg==
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr2755594wrx.229.1588236020133;
        Thu, 30 Apr 2020 01:40:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p16sm2891774wro.21.2020.04.30.01.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 01:40:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf page ready notifications
In-Reply-To: <b1297936-cf69-227b-d758-c3f3ca09ae5d@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-5-vkuznets@redhat.com> <b1297936-cf69-227b-d758-c3f3ca09ae5d@redhat.com>
Date:   Thu, 30 Apr 2020 10:40:18 +0200
Message-ID: <87sgglfjt9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/04/20 11:36, Vitaly Kuznetsov wrote:
>> +	case MSR_KVM_ASYNC_PF_ACK:
>> +		if (data & 0x1)
>> +			kvm_check_async_pf_completion(vcpu);
>> +		break;
>
> Does this work if interrupts are turned off?
>  I think in that case
> kvm_check_async_pf_completion will refuse to make progress.
> You need to make this bit stateful (e.g. 1 = async PF in progress, 0 =
> not in progress), and check that for page ready notifications instead of
> EFLAGS.IF.  
> This probably means that;
>
> - it might be simpler to move it to the vector MSR

I didn't want to merge 'ACK' with the vector MSR as it forces the guest
to remember the setting. It doesn't matter at all for Linux as we
hardcode the interrupt number but I can imaging an OS assigning IRQ
numbers dynamically, it'll need to keep record to avoid doing rdmsr.

> - it's definitely much simpler to remove the #PF-based mechanism for
> injecting page ready notifications.

Yea, the logic in kvm_can_do_async_pf()/kvm_can_deliver_async_pf()
becomes cumbersome. If we are to drop #PF-based mechanism I'd split it
completely from the remaining synchronious #PF for page-not-present:
basically, we only need to check that the slot (which we agreed becomes
completely separate) is empty, interrupt/pending expception/... state
becomes irrelevant.

-- 
Vitaly

