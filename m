Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83514C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC94246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNxt58cN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB1Tgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:36:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21312 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgB1Tgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582918610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4+Rq4edgfQ2d5X2Wftt+NGWjHUEu6BgwavFrRxlIE8=;
        b=YNxt58cNtZhzwWM9I2gF4crBvKo5LnlyqxaRZ7gCLgZec794GysYowGn0ra14BZJG2W5Zg
        l3wZrPK6ORjr5EsqlT1oYFqXZrbJ8pT3u4k3y+ETmCPNkV6KJhR0ikRHf+KpgM7WhH8OBz
        Ek9i7Hq+kdH/wU6S4OonfViumxCQOG0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-AtCbpoEBN6mup0PCJun0Lw-1; Fri, 28 Feb 2020 14:36:48 -0500
X-MC-Unique: AtCbpoEBN6mup0PCJun0Lw-1
Received: by mail-wm1-f70.google.com with SMTP id j130so1556526wmj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 11:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4+Rq4edgfQ2d5X2Wftt+NGWjHUEu6BgwavFrRxlIE8=;
        b=CVxUrEF8wlOpsaRUi4GqwrxrxiDBALVvso6kFlU45oZuRJuAzKVvDnU0VQ2VT6tXlH
         F+lK5rWGRpuDUq+ssGO3ffX7mNEXDFRebvC4MNkHlA4xDACreaLWT1w4nnn99/NEXNDx
         jEAbJMjfP4wZeXHmcIwcMT4U3BQ70bzTg80itnQsoPKfKyo9RmmUfKbZaNMT1b1VCvQA
         iK9lxl/L15ebccsAzA6dI3JUzotgRt+G0uP+7E7k9WzocWrekM7+7B/HRIS6mQOXSgnt
         Cegv0GypIgixMGYAd4lOXrsSvRGBoDXtVaRJG89/7bz3qekhOW6/cAyAQyw5IhoE1jmh
         zFww==
X-Gm-Message-State: APjAAAWXfKakzDAtu1n2/koeoKmUMZ/x7Us1CgpEz4EjZglQDULiGzXD
        EKfRxRFNSUc6XQqtmxnnF0yktbEeU8G9dWiBvptbEJPafqn8erdGNP1LTnUEnaYI38+lJ0Z0cBO
        purbGuH0bx7ogMrXW5fIWM+lv
X-Received: by 2002:adf:8382:: with SMTP id 2mr5831166wre.243.1582918607478;
        Fri, 28 Feb 2020 11:36:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrWJVgmWIf4acpom3X1WSOc9ysjhsJ/VBWhpdRxPgKzsFioxUjDl9DbqKKlS51ZSwQhKlPQw==
X-Received: by 2002:adf:8382:: with SMTP id 2mr5831152wre.243.1582918607243;
        Fri, 28 Feb 2020 11:36:47 -0800 (PST)
Received: from [192.168.178.40] ([151.20.130.54])
        by smtp.gmail.com with ESMTPSA id d17sm3309385wmb.36.2020.02.28.11.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 11:36:46 -0800 (PST)
Subject: Re: [PATCH] x86/kvm: Handle async page faults directly through
 do_page_fault()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
References: <6bf68d0facc36553324c38ec798b0feebf6742b7.1582915284.git.luto@kernel.org>
 <c80e3380-d484-1b01-a638-0ee130dea11a@redhat.com>
 <CALCETrUG0B2QLYYp8h+5KiZ4LpVDZ00XEPsgh4DbbDX9Mx5-EQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <162c3f40-e413-767b-0b4d-a32208debc87@redhat.com>
Date:   Fri, 28 Feb 2020 20:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALCETrUG0B2QLYYp8h+5KiZ4LpVDZ00XEPsgh4DbbDX9Mx5-EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 20:04, Andy Lutomirski wrote:
>>> +      * We are relying on the interrupted context being sane (valid
>>> +      * RSP, relevant locks not held, etc.), which is fine as long as
>>> +      * the the interrupted context had IF=1.
>> This is not about IF=0/IF=1; the KVM code is careful about taking
>> spinlocks only with IRQs disabled, and async PF is not delivered if the
>> interrupted context had IF=0.  The problem is that the memory location
>> is not reentrant if an NMI is delivered in the wrong window, as you hint
>> below.
>
> If an async PF is delivered with IF=0, then, unless something else
> clever happens to make it safe, we are toast. 

Right, it just cannot happen.  kvm_can_do_async_pf is where KVM decides
whether a page fault must be handled synchronously, and it does this:

bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
{
	...
        /*
         * If interrupts are off we cannot even use an artificial
         * halt state.
         */
        return kvm_x86_ops->interrupt_allowed(vcpu);
}

The same function is called by kvm_arch_can_inject_async_page_present.

Paolo

