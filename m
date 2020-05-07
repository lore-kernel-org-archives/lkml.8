Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EFC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D626D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKlfhGtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEGWeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbgEGWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588890844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6LcYSbiruJMZTX1IqqyKZmdj0QYBFKURVtqzLOdhOY=;
        b=eKlfhGtcuNNah26DWFn8xHj1KcTjZqTiKtF/webaaqvCsqQcWJcpL4Pn1od2E0f4jeuMyr
        y279vczx0nARvUyBOMrHJtusIPf9Z1ItBPlTtDEEGxHyOLVbYYi8Dd5JDM9GBhT7nBmDpd
        926VWqtvSMw4IpiWFvh1Jm150pnB+c8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-5aOJO3i6NOGFjp0J07w0Uw-1; Thu, 07 May 2020 18:33:59 -0400
X-MC-Unique: 5aOJO3i6NOGFjp0J07w0Uw-1
Received: by mail-wr1-f72.google.com with SMTP id q13so4273438wrn.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6LcYSbiruJMZTX1IqqyKZmdj0QYBFKURVtqzLOdhOY=;
        b=UloTuV9hq2IQIc5lqEE3N4YT3pfd3a/9ZqJDhXZNg9SG6nrDh+B9cxS8ZDeLpd1w4S
         Lbp9Bi8DHZoXG1FtDyANt8eyCS9/RwYwRFYcFUX63tak8fe+6ffkyVh0BqNvoBV51rg1
         xYPkjFkv96tpHJkOhkWshKZEhT1MFbCoKAJFJY/dmoE/EJrI6q630JHZfgaH4VcBBoAs
         8uOkmtBFu6z4AyBlb+HVu9+Qky5uu0ZJkX/PBsmmAc0GgbYKycuHhdFwN826dTaFw6Y8
         QYGdt8601jr575DkUbwQy5x33p0cExKyhzbc5KKX8dcwuEgtD5bZcKl00/1ekDQYzMAL
         /cNQ==
X-Gm-Message-State: AGi0PuZL1NXihSMhUFMzctRzncaALfR24yS/ow/rnN/2LdDwYp6Fhqq2
        AnIHQR09o03MCA5b1n8xU1d8WAeHl7X/R5NktNWm09h0so1IvKwTdx8EA1l5ilZQ+t01JoozQXw
        /mExT+KEfImHhLhXAdKydW0/B
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr13257317wme.102.1588890838734;
        Thu, 07 May 2020 15:33:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJFQjWpHKrGVTS42cCRtRce69jHzd8zAhp5V7FZjYl/ngImOnPRxZo7IHJfA8JrWwI+PbW5UA==
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr13257293wme.102.1588890838456;
        Thu, 07 May 2020 15:33:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id t17sm9481511wro.2.2020.05.07.15.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 15:33:58 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] KVM: x86, SVM: isolate vcpu->arch.dr6 from
 vmcb->save.dr6
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-9-pbonzini@redhat.com> <20200507192808.GK228260@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd8eb45b-4556-6aaa-0061-11b9124020b1@redhat.com>
Date:   Fri, 8 May 2020 00:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507192808.GK228260@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 21:28, Peter Xu wrote:
>> -	svm->vcpu.arch.dr6 = dr6;
>> +	WARN_ON(svm->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT);
>> +	svm->vcpu.arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
>> +	svm->vcpu.arch.dr6 |= dr6 & ~DR6_FIXED_1;
> I failed to figure out what the above calculation is going to do... 

The calculation is merging the cause of the #DB with the guest DR6.
It's basically the same effect as kvm_deliver_exception_payload. The
payload has DR6_RTM flipped compared to DR6, so you have the following
simplfications:

	payload = (dr6 ^ DR6_RTM) & ~DR6_FIXED_1;
	/* This is kvm_deliver_exception_payload: */
        vcpu->arch.dr6 &= ~DR_TRAP_BITS;
        vcpu->arch.dr6 |= DR6_RTM;
	/* copy dr6 bits other than RTM */
        vcpu->arch.dr6 |= payload;
	/* copy flipped RTM bit */
        vcpu->arch.dr6 ^= payload & DR6_RTM;

->

	payload = (dr6 ^ DR6_RTM) & ~DR6_FIXED_1;
	/* clear RTM here, so that we can OR it below */
        vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
	/* copy dr6 bits other than RTM */
        vcpu->arch.dr6 |= payload & ~DR6_RTM;
	/* copy flipped RTM bit */
        vcpu->arch.dr6 |= (payload ^ DR6_RTM) & DR6_RTM;

->

	/* we can drop the double XOR of DR6_RTM */
	dr6 &= ~DR6_FIXED_1;
        vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
        vcpu->arch.dr6 |= dr6 & ~DR6_RTM;
        vcpu->arch.dr6 |= dr6 & DR6_RTM;

->

	/* we can do the two ORs with a single operation */
        vcpu->arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
        vcpu->arch.dr6 |= dr6 & ~DR6_FIXED_1;

> E.g., I
> think the old "BT|BS|BD" bits in the old arch.dr6 cache will be leftover even
> if none of them is set in save.dr6, while we shouldn't?

Those bits should be kept; this is covered for example by the "hw
breakpoint (test that dr6.BS is not cleared)" testcase in kvm-unit-tests
x86/debug.c.

Thanks,

Paolo

