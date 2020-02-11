Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3193C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C769B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2Yt3CFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBKNew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:34:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728040AbgBKNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVpv74UeZElPwmXt341gqDCIg9n10+IYxreY2XfSR7o=;
        b=E2Yt3CFwlIoFSb1juWZWMrN08qJ0qF7KTGRV90C5t9DEuwaCIRkmEE38gLtA74EFOdXZGh
        OKzIVxFCYDcv67B+6ysQtMpl8YqCyHwMr+BkTD32BVgSFNR8Z6nLKlP3ESYqbUwAgf7k3Q
        QOvY27Ds2H7KXHbDFuNx3OTyXxebZjs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-9eSDlTwHPRa1Gui58rUv5Q-1; Tue, 11 Feb 2020 08:34:15 -0500
X-MC-Unique: 9eSDlTwHPRa1Gui58rUv5Q-1
Received: by mail-wr1-f69.google.com with SMTP id w6so6859319wrm.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVpv74UeZElPwmXt341gqDCIg9n10+IYxreY2XfSR7o=;
        b=L7R6YLeBfVGAE/5DemxeeftY1/o48pG1WiQU3p+RvJFTV+IDX37kJAwc7CsJOS0y+d
         zaYk5Y16pJ20mbYg8W2SRSrosWHXN6CZ7G1Nf2xVQep7BWzFHIc7EavqTOM1oEF5f4Vo
         JF1K0F/eMoZbDQwxitZpGRWuXssPWfTk77PgV+Pqji3k8g1ZtLgmO41h09AvrEcLoDzS
         WvHSm+Dnp85k6NpTx5i4qaZA4nP7yAwhKkwLNMgfxGBHeLpuJDMMliAlXVsvN0re4fU7
         I89P5p/Q2F6/c8CTsldgVMzG+HcHC4MUwR40PEjXrirVwgVF3xKUGbC7W6dNaMYaNQSY
         L8UA==
X-Gm-Message-State: APjAAAV3MP84/vealzQit950qN/sajp6nlGWEB0cSd/84xDOseDLKuWn
        6LsIqQX/bIkPBIceyeTWqIF6XaVHjI4tJ0KU26h/MFxVaGjcqT+cM+19lXEorBhcUrXykBGoLHi
        ACKD5j2waMomBuG30QviwgtzQ
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr8245415wrx.145.1581428054199;
        Tue, 11 Feb 2020 05:34:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQg7pOc18gHn8GIarYbHg6cXUxmcv+NXJfVagkH7DlWVbigAr5O/HyU8hGdLlVvhSwg7I/lA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr8245385wrx.145.1581428053838;
        Tue, 11 Feb 2020 05:34:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bd91:9700:295f:3b1e? ([2001:b07:6468:f312:bd91:9700:295f:3b1e])
        by smtp.gmail.com with ESMTPSA id b10sm5167510wrw.61.2020.02.11.05.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 05:34:13 -0800 (PST)
Subject: Re: [PATCH v2 3/6] kvm: x86: Emulate split-lock access as a write
To:     Thomas Gleixner <tglx@linutronix.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
References: <20200203151608.28053-1-xiaoyao.li@intel.com>
 <20200203151608.28053-4-xiaoyao.li@intel.com>
 <95d29a81-62d5-f5b6-0eb6-9d002c0bba23@redhat.com>
 <878sl945tj.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d690c2e3-e9ef-a504-ede3-d0059ec1e0f6@redhat.com>
Date:   Tue, 11 Feb 2020 14:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <878sl945tj.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/20 14:22, Thomas Gleixner wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> On 03/02/20 16:16, Xiaoyao Li wrote:
>>> A sane guest should never tigger emulation on a split-lock access, but
>>> it cannot prevent malicous guest from doing this. So just emulating the
>>> access as a write if it's a split-lock access to avoid malicous guest
>>> polluting the kernel log.
>>
>> Saying that anything doing a split lock access is malicious makes little
>> sense.
> 
> Correct, but we also have to accept, that split lock access can be used
> in a malicious way, aka. DoS.

Indeed, a more accurate emulation such as temporarily disabling
split-lock detection in the emulator would allow the guest to use split
lock access as a vehicle for DoS, but that's not what the commit message
says.  If it were only about polluting the kernel log, there's
printk_ratelimited for that.  (In fact, if we went for incorrect
emulation as in this patch, a rate-limited pr_warn would be a good idea).

It is much more convincing to say that since this is pretty much a
theoretical case, we can assume that it is only done with the purpose of
DoS-ing the host or something like that, and therefore we kill the guest.

>> Split lock detection is essentially a debugging feature, there's a
>> reason why the MSR is called "TEST_CTL".  So you don't want to make the
> 
> The fact that it ended up in MSR_TEST_CTL does not say anything. That's
> where they it ended up to be as it was hastily cobbled together for
> whatever reason.

Or perhaps it was there all the time in test silicon or something like
that...  That would be a very plausible reason for all the quirks behind it.

Paolo

