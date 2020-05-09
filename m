Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1CC47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9E0214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5sy+26B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgEIM70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:59:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbgEIM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589029163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQw8wIihcr8z9SG9JkhXrUc3pHs+9HPhqleZu+dS0tc=;
        b=J5sy+26BKRGGq9QC2SIQZUWh6KGsA9VzUVxbKjzX7FXtdr8XKvTGTCyl5o6TbsJMMjAAOJ
        VjZJIXaQ88K6ZgY3r2vGpyLSKEDWdowoaA5E2Wn6O+q5yqz+SMG128MAWXKMB4IyuIcBrN
        mPM+EKRJO8QGWeeyiNZDwYNxTzaH+Y0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-G7_6vJ-iN3y6CC_NZ5ZhOA-1; Sat, 09 May 2020 08:59:21 -0400
X-MC-Unique: G7_6vJ-iN3y6CC_NZ5ZhOA-1
Received: by mail-wm1-f69.google.com with SMTP id a67so305703wme.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQw8wIihcr8z9SG9JkhXrUc3pHs+9HPhqleZu+dS0tc=;
        b=U7cO6ctqZYX+wVUmyDUb3ebmPA7jPVsoeOQbKtXIg7iu134N+DSAuoZBJMmGn0lM0g
         4mGiuFYwnyw11L8z9OQMcx90T/thOCsZ8OUffOZbCBo9oRHYVlELTLSvCZMQrcG6OHWb
         HB0V3ufLbrGlG3lsb9YjuWMoGsQmRNi+UxqoGI0Xcf+UEdTCDzCiKewEUJPA4XhOFid2
         Kp4l/zW4o5IllttEnQdUR5M7Yb7NGmpxKOkQrai6WO4+W8D0ioAqy5b8Ev5c9lbbjDd4
         SnHN9ugmey35iL/rV1k8CR6SGuIfON//aGzJvyND327qHwaVzLEOrBQf3QMJ/wN6+QQ0
         DlaQ==
X-Gm-Message-State: AGi0PuZbwO9aVcB2EJEE24JxS+5VxMIujGeTfRxrsUCtEFDxufzkIMig
        kPhypSlqHQwFIt/mLwrcp++6PxhnOviFpLtw/Cf9XN5LDS1VgPyLQVhvilussjk0Nh1s87g41AW
        vG07Ae+FbhiEyFlNa2RqbZ6U9
X-Received: by 2002:adf:81e4:: with SMTP id 91mr8859431wra.143.1589029160735;
        Sat, 09 May 2020 05:59:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKyvtlkWX1zEIAN3peqtORXIi11YJ6t6OrIjcvtaKt8KFtk61ibvPPJ0tYsrkzhC5wen/OCNg==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr8859378wra.143.1589029160513;
        Sat, 09 May 2020 05:59:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cb4:2b36:6750:73ce? ([2001:b07:6468:f312:1cb4:2b36:6750:73ce])
        by smtp.gmail.com with ESMTPSA id u16sm8073375wrq.17.2020.05.09.05.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 05:59:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: x86: Move pkru save/restore to x86.c
To:     Jim Mattson <jmattson@google.com>, Babu Moger <babu.moger@amd.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mchehab+samsung@kernel.org, changbin.du@intel.com,
        Nadav Amit <namit@vmware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        yang.shi@linux.alibaba.com, asteinhauser@google.com,
        anshuman.khandual@arm.com, Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        steven.price@arm.com, rppt@linux.vnet.ibm.com, peterx@redhat.com,
        Dan Williams <dan.j.williams@intel.com>, arjunroy@google.com,
        logang@deltatee.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>, justin.he@arm.com,
        robin.murphy@arm.com, ira.weiny@intel.com,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        pawan.kumar.gupta@linux.intel.com,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        vineela.tummalapalli@intel.com, yamada.masahiro@socionext.com,
        sam@ravnborg.org, acme@redhat.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
References: <158897190718.22378.3974700869904223395.stgit@naples-babu.amd.com>
 <158897219574.22378.9077333868984828038.stgit@naples-babu.amd.com>
 <CALMp9eQj_aFcqR+v9SvFjKFxVjaHHzU44udcczJVqOR5vLQbWQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90657d4b-cb2b-0678-fd9c-a281bb85fadf@redhat.com>
Date:   Sat, 9 May 2020 14:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQj_aFcqR+v9SvFjKFxVjaHHzU44udcczJVqOR5vLQbWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/20 00:09, Jim Mattson wrote:
>> +       if (static_cpu_has(X86_FEATURE_PKU) &&
>> +           kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
>> +           vcpu->arch.pkru != vcpu->arch.host_pkru)
>> +               __write_pkru(vcpu->arch.pkru);
> This doesn't seem quite right to me. Though rdpkru and wrpkru are
> contingent upon CR4.PKE, the PKRU resource isn't. It can be read with
> XSAVE and written with XRSTOR. So, if we don't set the guest PKRU
> value here, the guest can read the host value, which seems dodgy at
> best.
> 
> Perhaps the second conjunct should be: (kvm_read_cr4_bits(vcpu,
> X86_CR4_PKE) || (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)).

You're right.  The bug was preexistent, but we should fix it in 5.7 and
stable as well.

>>  }
>>  EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
>>
>>  void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
>>  {
>> +       /*
>> +        * eager fpu is enabled if PKEY is supported and CR4 is switched
>> +        * back on host, so it is safe to read guest PKRU from current
>> +        * XSAVE.
>> +        */
> I don't understand the relevance of this comment to the code below.
> 

It's probably stale.

Paolo

