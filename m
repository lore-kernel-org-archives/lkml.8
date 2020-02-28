Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F33C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05592468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry0VaLzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1TBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:01:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbgB1TBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582916463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiPBqOuIz1/2RBKHODOZDGbhSVpJxU4zscd7lrZcSRs=;
        b=Ry0VaLzznBJHdX08fZ36qNnB7iiTyKRbj5QamxSbD+gyl8zRMXvRR4cRO/FLb35v4q49jd
        Y7Dlg6UCh5hupWJZD8MXz94bZFDftlJthKbelvM51ysFVYQeah8CAdctWLXJH4AtOBzn6T
        ao405gAspcVJxmEEBanfCVj/iX2VfMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Ap8_4ZAAMKy-Jotyb8Mbdg-1; Fri, 28 Feb 2020 14:01:01 -0500
X-MC-Unique: Ap8_4ZAAMKy-Jotyb8Mbdg-1
Received: by mail-wr1-f69.google.com with SMTP id f10so1737753wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LiPBqOuIz1/2RBKHODOZDGbhSVpJxU4zscd7lrZcSRs=;
        b=c9/oYAxNBJxF7x1m/YdA7bqWPJD8IUbpkRoi+8eALj4jn59gLHAUHCp9iicm6nKffI
         JKFkhHZj+iOf3C/V3wmJY4b5RX0jV2O0WRt/RTZ8wtRYfg1KTNupuY37Z7sBxd6LqHu9
         hzYs1SygP7+2YosDSzypfNCIluwOR7WfupU+WuphlF2kP5uTvx8lZMtM1rjypQGJJ0Kc
         Re5BDaj3uTi+oZlcAfqS7M4yxIoJuHyEhCk3skbBP8N1YFrrYkE2Oek5XuLpaGdFEP7A
         iViikXxr3hTh4Q/hGJ5OQk1yuL0pByfctPgWFSXQ+nScvhHzTByIKjUtBGPEcICpwBdD
         LGyg==
X-Gm-Message-State: APjAAAXqG3741i/2h2jw7QnISAgNchwYyIABXSOoLkMBNel3kFXNEpay
        4poPvLMTRwwBQqRBgLUd0/vm6CiVU9ykA4k3XT1MdetonzHE88kIQDql5A2yRtXRt8SMcBXlAzq
        7Gl7aClTEQi+dvOKrgUhEInf4
X-Received: by 2002:adf:fecf:: with SMTP id q15mr6360073wrs.360.1582916460479;
        Fri, 28 Feb 2020 11:01:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUAOtHhcNdh6zAcXkMCkMKGN203lllm4k+2H8nx7TxQKT3GaUWUFcFp7bJ8X90a6ZWDESlqA==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr6360049wrs.360.1582916460182;
        Fri, 28 Feb 2020 11:01:00 -0800 (PST)
Received: from [192.168.178.40] ([151.20.130.54])
        by smtp.gmail.com with ESMTPSA id h15sm6613102wrr.73.2020.02.28.11.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 11:00:59 -0800 (PST)
Subject: Re: [PATCH] x86/kvm: Handle async page faults directly through
 do_page_fault()
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
References: <6bf68d0facc36553324c38ec798b0feebf6742b7.1582915284.git.luto@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c80e3380-d484-1b01-a638-0ee130dea11a@redhat.com>
Date:   Fri, 28 Feb 2020 20:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6bf68d0facc36553324c38ec798b0feebf6742b7.1582915284.git.luto@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 19:42, Andy Lutomirski wrote:
> KVM overloads #PF to indicate two types of not-actually-page-fault
> events.  Right now, the KVM guest code intercepts them by modifying
> the IDT and hooking the #PF vector.  This makes the already fragile
> fault code even harder to understand, and it also pollutes call
> traces with async_page_fault and do_async_page_fault for normal page
> faults.
> 
> Clean it up by moving the logic into do_page_fault() using a static
> branch.  This gets rid of the platform trap_init override mechanism
> completely.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Just one thing:

> @@ -1505,6 +1506,25 @@ do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  		unsigned long address)
>  {
>  	prefetchw(&current->mm->mmap_sem);
> +	/*
> +	 * KVM has two types of events that are, logically, interrupts, but
> +	 * are unfortunately delivered using the #PF vector.

At least the not-present case isn't entirely an interrupt because it
must be delivered precisely.  Regarding the page-ready case you're
right, it could be an interrupt. However, generally speaking this is not
a problem.  Using something in memory rather than overloading the error
code was the mistake.

> +      * These events are
> +	 * "you just accessed valid memory, but the host doesn't have it right
> +	 * not, so I'll put you to sleep if you continue" and "that memory
> +	 * you tried to access earlier is available now."
> +	 *
> +	 * We are relying on the interrupted context being sane (valid
> +	 * RSP, relevant locks not held, etc.), which is fine as long as
> +	 * the the interrupted context had IF=1.

This is not about IF=0/IF=1; the KVM code is careful about taking
spinlocks only with IRQs disabled, and async PF is not delivered if the
interrupted context had IF=0.  The problem is that the memory location
is not reentrant if an NMI is delivered in the wrong window, as you hint
below.

Paolo

> We are also relying on
> +	 * the KVM async pf type field and CR2 being read consistently
> +	 * instead of getting values from real and async page faults
> +	 * mixed up.
> +	 *
> +	 * Fingers crossed.
> +	 */
> +	if (kvm_handle_async_pf(regs, hw_error_code, address))
> +		return;
> +
>  	trace_page_fault_entries(regs, hw_error_code, address);
>  
>  	if (unlikely(kmmio_fault(regs, address)))
> 

