Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747D7206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FisQMVwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDHAaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:30:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbgDHAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586305823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MZBPDUxV9RhejRmNfB7mo4jhMQj38Op7zbCkOjFq48=;
        b=FisQMVwgqk+QwiHEkbn6jdK0Kbd1WBvj96xXljwx59nz8XjQGsXWsvmmu+YWIu+zZkXJnW
        UrI1P4KNe9qICM9+WJVkHj7bV95vWg0sAVNgaG5TTZjLcDwB/PqCzdsF2+nDjngj7qZWx3
        nSxOvdkvB2CqcNk1FPBn3q+925dDBco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-EZpimOQhPbC83Gl1p9Fgdg-1; Tue, 07 Apr 2020 20:30:21 -0400
X-MC-Unique: EZpimOQhPbC83Gl1p9Fgdg-1
Received: by mail-wr1-f70.google.com with SMTP id x9so1191305wrq.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MZBPDUxV9RhejRmNfB7mo4jhMQj38Op7zbCkOjFq48=;
        b=iqQC4QiksuYrwsNTjJPqy0JYcDl7lETT0PqatQCGr6Z/1/mGTjsRUU6MBb3u8O0Gkk
         XgkD+F/99uPUg/cBkuSs51I1+p+b+1V+Esjw8BncKDACXAOV4T+gWX113UxhFtXIPq2i
         ukyaUl1iupE/NYfJi54V1l2+ZVmxXQ6LMIXj8VlSWcFaZ1HrqlfGlLXo8LFe2pGH46uH
         PyTcAruzLNvvch0slceXPTmo5Zcqo6j0DQg/8wIXnP+jZiFVxRo9HeDbLGG9f6W3DclH
         Zy2bxnxGtn3nJBaqBpel9LDDaEubAQK77LpIP2dMVJ4AYlPHxc3uFR7+ulKVhev8mcaN
         zs5A==
X-Gm-Message-State: AGi0Pubf2VpzlFlToanlE7OP2XOeWDRa2K2na6XcDUUf4FpxZ+yRIGj9
        F+K0nt0KfDmGgAk0UZ+pmMFoYsKndYLfm6Q0RWlDWS9j3NJndouAzD19c3GAkgV0482LLbZfM5K
        KAUF6XYcqjf57V7cB4kZMsiTm
X-Received: by 2002:a5d:4085:: with SMTP id o5mr5042786wrp.327.1586305820545;
        Tue, 07 Apr 2020 17:30:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoQMFSt24mcYF1v+WDBRR73pOTR2uHEj2ttnoL4Vy/+kjZdxsveaYn+BYQj9ifCX3Vaxkjhg==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr5042763wrp.327.1586305820293;
        Tue, 07 Apr 2020 17:30:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id n124sm4772405wma.11.2020.04.07.17.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 17:30:19 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <2776fced-54c2-40eb-7921-1c68236c7f70@redhat.com>
 <0255CF03-D45D-45E0-BC61-79159B94ED44@amacapital.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c2499b0-a303-8d91-357e-99b78cbfdc23@redhat.com>
Date:   Wed, 8 Apr 2020 02:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0255CF03-D45D-45E0-BC61-79159B94ED44@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 00:29, Andy Lutomirski wrote:
>> I prefer #VE, but I can see how #MC has some appeal.  However, #VE has a
>> mechanism to avoid reentrancy, unlike #MC.  How would that be better
>> than the current mess with an NMI happening in the first few
>> instructions of the #PF handler?
>>
>>
> It has to be an IST vector due to the possibility of hitting a memory failure right after SYSCALL.

Not if syscall clears IF, right?

> I think #MC has a mechanism to prevent reentrancy to a limited extent. How does #VE avoid reentrancy?

In hardware, it has a flag word and delivers a vmexit instead of #VE if
that word is not zero (see towards the end of 25.5.6.1 Convertible EPT
Violations).  Here it would be the same except it would just do the page
fault synchronously in the host.

Paolo

