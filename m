Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B432083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILHC9Twd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDIPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:17:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgDIPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586445459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xz/x7+R3F325gRCdi+IZ/dfc0jmeQMCDLQzXTFYiwII=;
        b=ILHC9TwdRqFWUn1c4+2x2uVdf+FZ1IpXuI/ougN8rK9Q+gqm7spcKO9e603l3m8FQClLOx
        qCdF5jhzmDl04oD0GqWynalKoO7P2HaYAlGUC6gznt9YSpE3mF6LdyyLSec8G9pi05Rs55
        h1vV6f/Z0btHZlKvBctnmUFi4foSJbQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-adyNKr4HNWm3hz2IROT0Xw-1; Thu, 09 Apr 2020 11:17:35 -0400
X-MC-Unique: adyNKr4HNWm3hz2IROT0Xw-1
Received: by mail-wr1-f72.google.com with SMTP id 91so6563868wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xz/x7+R3F325gRCdi+IZ/dfc0jmeQMCDLQzXTFYiwII=;
        b=s2PeakwGugbru4mGnUvTN6DTqfVPrANi7zNkudvOTMr+gpiX7Ctecwqmi9lubfYOkb
         6o29PdFtP/cJ8qGAI+yvAOv8tB1LugXYILSMK79M2F5mIyEnOKShVHL+kUaeK3C0XcPb
         4K0kWwnKepufumbow0Zw8T6oPfAX8di1hWUiWUTXCzlvDRFL3ugP3yIFeN3TtIJVYf9Y
         4a35JvOxj7FGjolMeXq3EFRnwOu+A1P7Gm9ICawM6XmDyF69trVw54dBDu2FnRsK1QmL
         3YvAtnbhz1mFqKRYdxqGFLhqwot+ZVcNx9HvKfkAihillMP7cl1CzA/9IqLa3qSfG2AB
         aJRQ==
X-Gm-Message-State: AGi0PuZNXJb45eSZE6TfP32HsBMWct5gBHsVnkbanDPuNYewoS6cK5QU
        UKDE9XS5R2WQPIwb1NfacoU393Cflv6l7wPT+HiGV/nFMJxyyk/58XglHVhPtobLOa/3f2KU6mC
        jnagd0sh5wLA22gR7Vol7taD9
X-Received: by 2002:a5d:6183:: with SMTP id j3mr14822044wru.83.1586445454648;
        Thu, 09 Apr 2020 08:17:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHzBMEQqCXfIoBEX+rooZW9MeTLAzADd/bCoZQger9W2poqui6FuOadw72A9pT8T34FS1Qfg==
X-Received: by 2002:a5d:6183:: with SMTP id j3mr14822020wru.83.1586445454436;
        Thu, 09 Apr 2020 08:17:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id w15sm31255987wra.25.2020.04.09.08.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:17:33 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <c09dd91f-c280-85a6-c2a2-d44a0d378bbc@redhat.com>
 <4EB5D96F-F322-45BB-9169-6BF932D413D4@amacapital.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <931f6e6d-ac17-05f9-0605-ac8f89f40b2b@redhat.com>
Date:   Thu, 9 Apr 2020 17:17:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4EB5D96F-F322-45BB-9169-6BF932D413D4@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20 17:03, Andy Lutomirski wrote:
>> No, I think we wouldn't use a paravirt #VE at this point, we would
>> use the real thing if available.
>> 
>> It would still be possible to switch from the IST to the main
>> kernel stack before writing 0 to the reentrancy word.
> 
> Almost but not quite. We do this for NMI-from-usermode, and it’s
> ugly. But we can’t do this for NMI-from-kernel or #VE-from-kernel
> because there might not be a kernel stack.  Trying to hack around
> this won’t be pretty.
> 
> Frankly, I think that we shouldn’t even try to report memory failure
> to the guest if it happens with interrupts off. Just kill the guest
> cleanly and keep it simple. Or inject an intentionally unrecoverable
> IST exception.

But it would be nice to use #VE for all host-side page faults, not just
for memory failure.

So the solution would be the same as for NMIs, duplicating the stack
frame and patching the outer handler's stack from the recursive #VE
(https://lwn.net/Articles/484932/).  It's ugly but it's a known ugliness.

Paolo

