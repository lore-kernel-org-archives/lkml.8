Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04842C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5602465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8gwmQFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCBSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:02:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCBSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583172167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yD5hbojE45I5UYgGJAZzmvYTSa8iAlNKgqw5IjcBjbc=;
        b=c8gwmQFEFeUG3ZrOUik1gFGxl8PR2+rhl167nugU7SMt3XBvMvY7RJ6YgqFsy0bbyxZmgq
        XqQ1MMYsQB8oISzrAbitr7S5ChE1avT9RsTGW7noyPFKblth6UDOPhbWq+/J3+xhcE4CU8
        URUAH1jpcVY8vvnLOsmkkaoOHyhmOCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-g0VUJTFgNGquv1TWLwW5wg-1; Mon, 02 Mar 2020 13:02:45 -0500
X-MC-Unique: g0VUJTFgNGquv1TWLwW5wg-1
Received: by mail-wr1-f70.google.com with SMTP id n12so35511wrp.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yD5hbojE45I5UYgGJAZzmvYTSa8iAlNKgqw5IjcBjbc=;
        b=kk6Rnr9MkhSpWAlQ+tzSlStF268mWZmcso/zIs4aDWR6GjXLYSaKZiS4u/JJ37C/m0
         sSy9enGp8Eub0GSX11JskmxGJOJLPkt8JYN4OugLWNzT/Z1eTON1Wfjy+Ni2j/IkceiD
         84ihb4U+bqU/SWCQV0LC0xmCkgqChZR8owes1MQZW+WxOwxHn2E9XoxJ7Fny8b//WnVr
         R5T/NFNkj/IpBIHEW9GSEKGsE3ckwvDar8iFnp3wICnoYprzHfOnHZb7o6bf+uKmul1N
         UibIAEuuF1qLAHg3YLeU/ACKVGICK6AnVXOYvLozHWqPrX3OSDOLUfYvuBYuuwM0es5M
         hGIQ==
X-Gm-Message-State: ANhLgQ3gL2koSHkeB3N0NdBopbvtLYTr5JJm/a9PjyqDKkjr1abJPAuZ
        LU5W99EHY/AzO/d4PJiH++kywdX+dlo+wdNniK2qFFSxCmkv11ocut1YaYBbqhopBwpLDH7iMjn
        /2EloIo2ZmNyYhCbOqfuxEb00
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr254408wmi.108.1583172161674;
        Mon, 02 Mar 2020 10:02:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvnDdxXMDxb+073m/6FgQ+6hKR1fRUhw2fF6Rkr7smuqXbzAyvrEli0YvGlH3qZ+ybKBGn1qg==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr254378wmi.108.1583172161435;
        Mon, 02 Mar 2020 10:02:41 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id s14sm17033764wrv.44.2020.03.02.10.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 10:02:40 -0800 (PST)
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     Jim Mattson <jmattson@google.com>
Cc:     linmiaohe <linmiaohe@huawei.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
 <CALMp9eSaZ557-GaQUVXW6-ZrMkz8jxOC1S6QPk-EVNJ-f2pT5w@mail.gmail.com>
 <a1ff3db1-1f5a-7bab-6c4b-f76e6d76d468@redhat.com>
 <CALMp9eQqFKnCLYGXdab-k=Q=h-H5x8VnV20F3HH9fDZTDuQcEQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e173c489-dee7-a86d-3ec4-6fe45938a2d8@redhat.com>
Date:   Mon, 2 Mar 2020 19:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eQqFKnCLYGXdab-k=Q=h-H5x8VnV20F3HH9fDZTDuQcEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 18:44, Jim Mattson wrote:
> On Mon, Mar 2, 2020 at 9:09 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 02/03/20 18:01, Jim Mattson wrote:
>>>> And in fact, it's not used anywhere. So it should be
>>>> deprecated.
>>> I don't know how you can make the assertion that this ioctl is not
>>> used anywhere. For instance, I see a use of it in Google's code base.
>>
>> Right, it does not seem to be used anywhere according to e.g. Debian
>> code search but of course it can have users.
>>
>> What are you using it for?  It's true that cpuid->nent is never written
>> back to userspace, so the ioctl is basically unusable unless you already
>> know how many entries are written.  Or unless you fill the CPUID entries
>> with garbage before calling it, I guess; is that what you are doing?
> 
> One could use GET_CPUID2 after SET_CPUID2, to see what changes kvm
> made to the requested guest CPUID information without telling you.

Yeah, I think GET_CPUID2 with the same number of leaves that you have
passed to SET_CPUID2 should work.

Paolo

