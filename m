Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BCC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A043206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRi9J4ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgD2Oee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:34:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgD2Oed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588170872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4kiLu8V0HCQMULCb4mzXR2k3NPYOqPbuW0DbQgjM/E=;
        b=XRi9J4ZQgojT/1ZV9Q5RT2IxbYs5J7YpDI4shl5/bKk+sYlgqajHWUYFOp0zuS02AD09/K
        9I27Fp/nyJFXVJ7t+rYH7oRm8rHvlUvlsy/AsCAJAFbTcB5T0aHo7sAzlSvl/Fr3ImQIEx
        SfDTOqbLzgKzI5faGGXrpOUcDtHEczQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-rV3B72tSNpWkvHMA5LDLEA-1; Wed, 29 Apr 2020 10:34:30 -0400
X-MC-Unique: rV3B72tSNpWkvHMA5LDLEA-1
Received: by mail-wm1-f69.google.com with SMTP id 72so2697539wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=p4kiLu8V0HCQMULCb4mzXR2k3NPYOqPbuW0DbQgjM/E=;
        b=kYU1LWcnKDwbq9ZnySoi6LDqFvtME1pFGT+Nz5GaxmOBdSeiHPvzg35eRdPGAsG++3
         JhRIwkiBFY2GWIjn3AaGmgIuTWdDhB4Rp060de3Lm6v3DPfFiQ4vlyOfLGOU1tAcJkDP
         igK6g6gzQqcGBqdTOiUErqzZGH4xYMRdisBQliqQQCH+eIxI+HTH3W6Lz25qKK6ejwu2
         Lm/jzoYemO+xUrWtUuAnRaMnrB2+vi+jUSnIncWIJIjSWItQa/9sNX+p4n3UrXVE7u+C
         LXmVfW6r+KMKCQ4K+PcX355q4Mbe49/0L+jfaeW3tQfI1iMYkMawAvsbxPJQlmLzXXPk
         ZOsQ==
X-Gm-Message-State: AGi0PuZkubqRUBkVEDS0hYBxgkwx6wOAIm/c0b624TQw1RKV9X2eJePl
        lHKPDCrZkMJJ4a7S3juBo0BoSldPbRKFXgLJgs3zMV1ZD9aqGy1OH8ou+siR6iPurnQHISJdjG3
        uQulcSPrBCqK7jP9C1HudWsVV
X-Received: by 2002:a7b:c459:: with SMTP id l25mr3548733wmi.52.1588170869398;
        Wed, 29 Apr 2020 07:34:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKUYGGAwkA649DZykcL9h0opLmcbvGeZjQ+IUimBYTbNV7txgnKFnO8Th1tobHLYFW8DcCp+w==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr3548713wmi.52.1588170869173;
        Wed, 29 Apr 2020 07:34:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q143sm8603108wme.31.2020.04.29.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:34:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH RFC 6/6] KVM: x86: Switch KVM guest to using interrupts for page ready APF delivery
In-Reply-To: <465678b2-4009-f85b-65ec-6c2c7bbc4fa0@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-7-vkuznets@redhat.com> <ee587bd6-a06f-8a38-9182-94218f7d08bb@redhat.com> <87blnah36e.fsf@vitty.brq.redhat.com> <465678b2-4009-f85b-65ec-6c2c7bbc4fa0@redhat.com>
Date:   Wed, 29 Apr 2020 16:34:27 +0200
Message-ID: <871ro6gy30.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/04/20 14:44, Vitaly Kuznetsov wrote:
>>>> +			token = __this_cpu_read(apf_reason.token);
>>>> +			/*
>>>> +			 * Make sure we read 'token' before we reset
>>>> +			 * 'reason' or it can get lost.
>>>> +			 */
>>>> +			mb();
>>>> +			__this_cpu_write(apf_reason.reason, 0);
>>>> +			kvm_async_pf_task_wake(token);
>>>> +		}
>>> If tokens cannot be zero, could we avoid using reason for the page ready
>>> interrupt (and ultimately retire "reason" completely)?
>> Yes, we can switch to using 'token' exclusively but personally I'm not
>> sure it is worth it. We'll still have to have a hole and reason + token
>> is only u64. Keeping 'reason' in place allows us to easily come up with
>> any other type of notification through this mecanism (if the reson is
>> ... then 'token' means ...).
>
> If we need a "reason" field I'd rather make it separate from the page
> not ready reason, because as we differentiate the delivery mechanism it
> is cleaner to keep them separate.
>
> For example, if the reason is present but separate, the memory barrier
> is not necessary anymore, because apf_reason.token cannot be written
> before the ack MSR is written.  And with #VE there will be already a
> hardware-provided mechanism to avoid reentrancy.

Ok, makes sense. I'll probably use your original idea and use 'token'
for 'page ready' notification exclusively for now. In case of need we
can always extend 'struct kvm_vcpu_pv_apf_data' with the information we
need so we can avoid adding 'reason2' for now.

-- 
Vitaly

