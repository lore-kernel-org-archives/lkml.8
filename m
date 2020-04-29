Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62426C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4039321707
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgEuH7wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD2NVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:21:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgD2NVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588166511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh2zEXuRrHJ7OoyUsto1r+1dFw1T/nGXYT4VtCcPwG4=;
        b=HgEuH7wgP1LzHnqsm49bUqTWn7noq1YqGPgjqeS+yxVXNJ0JlmkNJo2YaQ2FQpWVANZ76w
        BQnROPsO6rtJ3q2ZtTypc3BDjBqzjmLgu/r0ayWeQZKnMEYkIxc0vCwTWGdngt/enOfQhx
        LzP2i5h7UqvHJ0wHhBVUFMKroxQe0IA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-5PitX23xNBmeXGVFTE7DJw-1; Wed, 29 Apr 2020 09:21:48 -0400
X-MC-Unique: 5PitX23xNBmeXGVFTE7DJw-1
Received: by mail-wr1-f71.google.com with SMTP id f4so1720865wrp.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kh2zEXuRrHJ7OoyUsto1r+1dFw1T/nGXYT4VtCcPwG4=;
        b=rugP3sU5wEpQixCKuqGC5LYNjyLC4v477F/UOXHfuNjDIoyIIqkyruWLFNLTfFZhzh
         xSEldTGk/aQLSuq2xpvSzl+4NsS+SgTgSYDV1+lQlR2yPkAiNi6mxECylNlYJLkUFY5y
         rP4Rgx7BEd6CJrOq+tZhWxFciR02vqYaMSJudD/Di7fTKDaC84aXGngfDyOdcTw3XF4U
         DNS7wraXQi19fhxkU01CkD/LXLcmUU0Z6BO+bAwXkCyM0xbpSG8wKsvQUkJrJ4XxRdTi
         aHIHn6BmjQ9gnJfa0+8NX15gsBTY6M61meVzrneARR46B2YzUU90Z+dh2H5DlZAK/3G0
         3Vjw==
X-Gm-Message-State: AGi0PuZBd7GPBxU2EvAoZfnH2azd15B/XmESGprLQP4/O/rZvzFYWiPP
        PcJETd9enTCnoJP3qVlTK1fAwjoP0p/M8YpPYq+XnIPt7+KVe30u/05X6Unh4TNDVBGaPVpscjl
        CDvSsDkMwxwedCuisFfkGWoYt
X-Received: by 2002:a5d:574b:: with SMTP id q11mr33967173wrw.324.1588166507578;
        Wed, 29 Apr 2020 06:21:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHNXwnwSe2sR6WV2t9YCV9HVySfV4QKReiL6szz5wDHMQxpkv0Y/6/6o/vsY5sereoKPmpnw==
X-Received: by 2002:a5d:574b:: with SMTP id q11mr33967138wrw.324.1588166507283;
        Wed, 29 Apr 2020 06:21:47 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id x18sm7647996wmi.29.2020.04.29.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 06:21:46 -0700 (PDT)
Subject: Re: [PATCH RFC 3/6] KVM: x86: interrupt based APF page-ready event
 delivery
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        kvm@vger.kernel.org
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-4-vkuznets@redhat.com>
 <546bb75a-ec00-f748-1f44-2b5299a3d3d7@redhat.com>
 <87ees6h3cm.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15c625c5-d551-85fd-8412-f88503e6a86b@redhat.com>
Date:   Wed, 29 Apr 2020 15:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87ees6h3cm.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 14:40, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 29/04/20 11:36, Vitaly Kuznetsov wrote:
>>> +
>>> +	Type 1 page (page missing) events are currently always delivered as
>>> +	synthetic #PF exception. Type 2 (page ready) are either delivered
>>> +	by #PF exception (when bit 3 of MSR_KVM_ASYNC_PF_EN is clear) or
>>> +	via an APIC interrupt (when bit 3 set). APIC interrupt delivery is
>>> +	controlled by MSR_KVM_ASYNC_PF2.
>>
>> I think we should (in the non-RFC version) block async page faults
>> completely and only keep APF_HALT unless the guest is using page ready
>> interrupt delivery.
> 
> Sure, we can do that. This is, however, a significant behavioral change:
> APF_HALT frees the host, not the guest, so even if the combined
> performance of all guests on the same pCPU remain the same guests with
> e.g. a lot of simultaneously running processes may suffer more.

Yes, it is a significant change.  However the resulting clean up in the
spec is significant, because we don't have type 2 notifications at all
anymore.

(APF_HALT does free the guest a little bit by allowing interrupt
delivery during a host page fault; in particular it lets the scheduler
tick run, which does improve responsiveness somewhat significantly).

Likewise, I think we should clean up the guest side without prejudice.
Patch 6 should disable async page fault unless page-ready interrupts are
available, and drop the page ready case from the #PF handler.

Thanks,

Paolo

> In theory, we can keep two mechanisms side by side for as long as we
> want but if the end goal is to have '#PF abuse eliminated' than we'll
> have to get rid of the legacy one some day. The day when the new
> mechanism lands is also a good choice :-)


