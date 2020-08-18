Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D851C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65388204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgsXpBMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHRHPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgHRHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597734905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnkZLMte3116urPzW5jKDlxRd4vsRM7I0r+mSa2q174=;
        b=MgsXpBMtXmMOJ0hyIw7fG34i/pFZBlY/c3tPAgPL3QDlViBcKKKXvymJatVimXD/Sa3yuZ
        fIY0XO9CKD1blC5EmSqH2r+ON5e1tuQIstWc9og2P+C7xaeZTetcE4MJ2UUfo6NxmaZjvR
        vgs/WBIJaCVNkEXDA2FxHm2J+zjrybI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Xy10gfRmMWWXdyFdRV1i0Q-1; Tue, 18 Aug 2020 03:15:02 -0400
X-MC-Unique: Xy10gfRmMWWXdyFdRV1i0Q-1
Received: by mail-wm1-f71.google.com with SMTP id q15so7030789wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VnkZLMte3116urPzW5jKDlxRd4vsRM7I0r+mSa2q174=;
        b=UOCnanfXTZq6IBIssE7kT3EHu7oDiu0zwfytKam+n3IBQr84Xwv75MPJ1bWb8MGy3a
         jQgb6QGfzfJwXRrK+Uryk2bInr4nni0vajVIxEq4EeTCLnwhLgXZWadURIW3Rl3mDnDF
         Z2o/uboKGZZitt1sFoRV4EJSQv2H0c5cjk3mt/4Q72+7yVf4nATx2KhVRjH/+ZYvBvi9
         tyC0X7/RzcGwVbKI5Yv8tGECHXOUOSWA0BiNSJyO2krfJ1c/6HlvZ85KUYG/qy7l2iLO
         aYIMkaLr5y5hS7Gh01FoR6HPLJaVClalJV5bu5MoDGk+Hx3MX5EkCFtH9GFdoFFD9Q5B
         Fnig==
X-Gm-Message-State: AOAM532S5+jY63qQs8LGVEcPA3bJh5izFnN4grU3kjNvpXbxBLIeCDcN
        +5kqtiD/P6gWf+yw1fW+94g+rWyIx+q59WZ4/CjSXFKsyTiR4/3KkeSTlTARvqiF8lTPHiDCnN/
        4kmw5yAyAPQn6zkdh6OlsbfVv
X-Received: by 2002:adf:b312:: with SMTP id j18mr19499391wrd.142.1597734900805;
        Tue, 18 Aug 2020 00:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxDBVc6FNobMFPmLaQ8JBtEJ0j8nc00thHTm7+HAm5Z27/zTChbr9Q9OWX0Of8Uc7BLJHy1Q==
X-Received: by 2002:adf:b312:: with SMTP id j18mr19499363wrd.142.1597734900475;
        Tue, 18 Aug 2020 00:15:00 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id t14sm32631227wrv.14.2020.08.18.00.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 00:14:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] x86/cpufeatures: Add enumeration for SERIALIZE
 instruction
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Cathy Zhang <cathy.zhang@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, fenghua.yu@intel.com
References: <1594088183-7187-1-git-send-email-cathy.zhang@intel.com>
 <1594088183-7187-2-git-send-email-cathy.zhang@intel.com>
 <CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com>
 <20200708022102.GA25016@ranerica-svr.sc.intel.com>
 <87eep3ywz0.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be322917-0f10-de4c-9b7c-308d667277eb@redhat.com>
Date:   Tue, 18 Aug 2020 09:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87eep3ywz0.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/20 01:02, Thomas Gleixner wrote:
>> I am cc'ing Fenghua, who has volunteered to work on this. Addind support
>> for SERIALIZE in sync_core() should not block merging these patches,
>> correct?
> Come on. We are not serving KVM first before making this usable on bare
> metal.

This in the end was merged in 5.9, but: why not?  It is just an
instruction with no other support code needed in the kernel (or KVM for
that matter except for marking the CPUID bit as supported).  It is
common to run hosts with an older kernel than the guests, and by this
line of reasoning, we should not even have enabled support for FSGSBASE
in KVM.

Paolo

