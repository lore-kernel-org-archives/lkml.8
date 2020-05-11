Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46AC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A082070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D76+5ve1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgEKR3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:29:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730952AbgEKR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589218160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcjLXdSIU3UxVcedEoJ6SH5pMrdBTnR+Dd6Ysme7bQE=;
        b=D76+5ve1oQwO7U++ELBZev1PyZGyX3rX2nsCpN2VLvpFyIA5rlgk9kR+Co6YZN9l0lJSjE
        vrfCNQWMIri7yhj9f2xonYFJY2RVme3ldxAuryKtqBDw/Y2uY/gYQvl9vOIY+cbj4FK1Kx
        EpzaJxsorPVI+/HWXil106g8VW7P/M0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-fItiiMMwPbmNsfUNwH5h6Q-1; Mon, 11 May 2020 13:29:18 -0400
X-MC-Unique: fItiiMMwPbmNsfUNwH5h6Q-1
Received: by mail-wr1-f71.google.com with SMTP id q13so5569165wrn.14
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VcjLXdSIU3UxVcedEoJ6SH5pMrdBTnR+Dd6Ysme7bQE=;
        b=Wsc3/QG9eKzy06QeSGuSY3R9q7sR6RFVxs8eBklYhC42p8FigorKAjKMmGRUSeF+TL
         CfTsMY3aSJFVLV/gKJzCDnNPnbwfNMkFj1yNlxjCeGHCKZyFXR+TYbX81HHQWw+yu+w3
         RajYMMhfgwWBANIWRlZKN9WXb3v1BDI6wZxkj/rHAajkh/XXYIah9O84A16ZfVnsiSNg
         YK/Y87b+jf6eZ+ImnEcWsQl+egY3ZD3ihkDnRGEPmn6aqeTJoS/T8sC/YfTBt7j4GbKZ
         LaPySieoiXUpx8EspyQjYjStevenem0MLhyzgr5/8WZTwOGWzDNXMhbDO6j5eLCXkDCO
         AG1w==
X-Gm-Message-State: AGi0PuYuq+AjUjCdKC0e5VRRkkBiFVo8U8uh9HPlzt4UEm+bxfajrbN4
        rVWh86KWIiF1NrOkCcHNfOuoszPI8Icbd6AoG1dHN7nGe3HCto/wpp1aMXKp8CKCTpzq1KmwE6s
        hCHCsdUyrKtw55mR0xaz6Abok
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr31160514wmf.97.1589218157428;
        Mon, 11 May 2020 10:29:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJRZVFO2OwNtcnrU/NHaU9Vp39q1pCtEQ+KrkvJyuh7MR6CBPU7MVFLvb96H+TnVnPZLr5rCw==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr31160491wmf.97.1589218157189;
        Mon, 11 May 2020 10:29:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4c95:a679:8cf7:9fb6? ([2001:b07:6468:f312:4c95:a679:8cf7:9fb6])
        by smtp.gmail.com with ESMTPSA id m1sm19333411wrx.44.2020.05.11.10.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 10:29:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: VMX: Invoke kvm_exit tracepoint on VM-Exit due
 to failed VM-Enter
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200508235348.19427-1-sean.j.christopherson@intel.com>
 <20200508235348.19427-2-sean.j.christopherson@intel.com>
 <551ed3f8-8e6c-adbd-67ff-babd39b7597f@redhat.com>
 <20200511170823.GD24052@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e391daa9-9c3b-3e3c-6d09-bb0a825a2f67@redhat.com>
Date:   Mon, 11 May 2020 19:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511170823.GD24052@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/20 19:08, Sean Christopherson wrote:
> On Sat, May 09, 2020 at 02:54:42PM +0200, Paolo Bonzini wrote:
>> On 09/05/20 01:53, Sean Christopherson wrote:
>>> Restore the pre-fastpath behavior of tracing all VM-Exits, including
>>> those due to failed VM-Enter.
>>>
>>> Fixes: 032e5dcbcb443 ("KVM: VMX: Introduce generic fastpath handler")
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> ---
>>>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Squashed, thanks.  Though is it really the right "Fixes"?
> 
> Pretty sure, that's the commit that moved trace_kvm_exit() from
> vmx_handle_exit() to vmx_vcpu_run().  Prior to that, all fastpaths still
> flowed through vmx_handle_exit().
> 

Indeed, fast path was never handled in vcpu_enter_guest.

Paolo

