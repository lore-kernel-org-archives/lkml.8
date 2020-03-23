Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16EC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B82620714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUsSAKQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgCWTkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:40:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58345 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgCWTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584992408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFP2aeHKGeRXBgby7kJAWTWaWKoNQIcpjzLubNvUNy4=;
        b=NUsSAKQ9ZmOrJgHFT8MflBf3INebznK7Lz8ERTLaDp8wCdwL2Mv1SSZAd30oR+0u9yZCSW
        dITccrY/H5k9Opp0rMN8zoeTMXunZ+yAkoZEf3RE+YY3goF6Ta5CXSUfG4fJiOZ93fpXok
        dB9sG6V4u4MGxfkuJKY3zDQ7DQxBmNo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-bzV2pHVHN5m3Zx_cYMhIow-1; Mon, 23 Mar 2020 15:40:01 -0400
X-MC-Unique: bzV2pHVHN5m3Zx_cYMhIow-1
Received: by mail-wm1-f70.google.com with SMTP id t22so244564wmt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFP2aeHKGeRXBgby7kJAWTWaWKoNQIcpjzLubNvUNy4=;
        b=ds4Es/3D+UlX7AKHM0Exu9k/X13KM2lhTVGOV7t+S0/oMU925PXI9UXI3fYCGckb+n
         S+Rlsi30dJG/1iGZSj/Ij/17ZzwD+3F0CzuxSB3FvEel+hRbYSL/9qOMI4lIjvYrZz27
         KkHIRP8CFOtv7wnDr7O74vmkDGjpqOOLPr12wPF5RChFjtZQ3bpKPqrHlN4c/hBUbiNd
         pivRTjo4r+c3Qp9yAG1soJmQDmYQgIk/oMnkq23Y9bH8R7mxhvUMOIIkIY8ldcS4oFk/
         TseOZ8W2u9H7bDooyjJdm1PtUmUg+GKnszUOh5Z7psqZ7LEB7Mnz1HHgUyxJfUkqldiS
         +QTw==
X-Gm-Message-State: ANhLgQ3hbHa9C61JdSWPj53r6z9T5zh4NkaGgTiCk1XYpRTge7AVirtW
        uN2hUxJDMHnCH+u3XXE65CUgY6ZVjzrQu/lC4f0Xav0n+WkPhBoAeeq84Zkagn/octisoWj49gI
        oBTuVkz6R56pS7fcH9LnisiVD
X-Received: by 2002:adf:f68b:: with SMTP id v11mr15340125wrp.270.1584992400615;
        Mon, 23 Mar 2020 12:40:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtb9sJ0klZwvu/ku5OHvFSKtheHaljJAS9COoNF60eMSuAIuFOCsUvPZQRvAlkMozUi9uetmA==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr15340093wrp.270.1584992400294;
        Mon, 23 Mar 2020 12:40:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id c23sm25417876wrb.79.2020.03.23.12.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:39:59 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 handle_external_interrupt_irqoff
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <000000000000277a0405a16bd5c9@google.com>
 <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
 <5058aabe-f32d-b8ef-57ed-f9c0206304c5@redhat.com>
 <CAG_fn=WYtSoyi63ACaz-ya=Dbi+BFU-_mADDpL6gQvDimQscmw@mail.gmail.com>
 <20200323163925.GP28711@linux.intel.com>
 <CAKwvOdkE8OAu=Gj4MKWwpctka6==6EtrbF3e1tvF=jS2hBB3Ow@mail.gmail.com>
 <CAKwvOdkXi1MN2Yqqoa6ghw14tQ25WYgyJkSv35-+1KRb=cmhZw@mail.gmail.com>
 <CAG_fn=WE0BmuHSxUoBJWQ9dnZ4X5ZpBqcT9rQaDE_6HAfTYKQA@mail.gmail.com>
 <CAG_fn=Uf2dDo4K9X==wE=eL8HQMc1an8m8H18tvWd9Mkyhpskg@mail.gmail.com>
 <CAKwvOdntYiM8afOA2nX6dtLp9FWk-1E3Mc+oVRJ_Y8X-9kr81Q@mail.gmail.com>
 <CAKwvOdn10Ts_AU6i+7toj7NkMwK-+0yr5wTrN0XEDudBWS0sPQ@mail.gmail.com>
 <CAKwvOdnwhoHe8ouao2VBo1meRd8H4EOC7Nr8hnFkbXBACWRm9w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <887add8e-cc74-b50b-46f8-f51d39c12dff@redhat.com>
Date:   Mon, 23 Mar 2020 20:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnwhoHe8ouao2VBo1meRd8H4EOC7Nr8hnFkbXBACWRm9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 20:30, Nick Desaulniers wrote:
> <ndesaulniers@google.com> wrote:
>> So maybe we can find why
>> commit 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
>> added THUNK_TARGET with and without "m" constraint, and either:
>> - remove "m" from THUNK_TARGET. (Maybe this doesn't compile somewhere)
>> or
>> - use my above recommendation locally avoiding THUNK_TARGET.  We can
>> use "r" rather than "a" (what Clang would have picked) or "b (what GCC
>> would have picked) to give the compilers maximal flexibility.
> So I've sent a patch for the latter; my reason for not pursuing the former is:
> 1. I assume that the thunk target could be spilled, or a pointer, and
> we'd like to keep flexibility for the general case of inline asm that
> doesn't modify the stack pointer.
> 2. `entry` is local to `handle_external_interrupt_irqoff`; it's not
> being passed in via pointer as a function parameter.
> 3. register pressure is irrelevant if the resulting code is incorrect.

Yes, this is fair enough.  I've queued your patch and will send it
shortly to Linus.

Paolo

