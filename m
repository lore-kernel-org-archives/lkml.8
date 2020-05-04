Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461DAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2004B206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyCUA9Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgEDRD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:03:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729459AbgEDRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588611805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOROlQMiNPJWfRV7/CSrwARih59v8ZpS7QsX9oW6VGM=;
        b=UyCUA9BrzCxMDC21j2Zz07Dktly2+N02hcjXilh/D+9IGGyKMh8LdRBO4A2f+Brz8vZgey
        qIQ7+Jcazts8M+gQIvwWD9g53jQjE/gBZkXOD+wsnf02E5F+cZjD1hRihSpRlcO2hFcdvj
        ykowQ5qG2kL095S5qPsdY6Xqy2pkuQc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-_rTKAYnLM3Oh9Hb8lKnZbg-1; Mon, 04 May 2020 13:03:20 -0400
X-MC-Unique: _rTKAYnLM3Oh9Hb8lKnZbg-1
Received: by mail-wm1-f70.google.com with SMTP id t62so143951wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DOROlQMiNPJWfRV7/CSrwARih59v8ZpS7QsX9oW6VGM=;
        b=glMU7p8eZ6l/smzp3rVG8Cekd3SP/egKB0xx2YgeWwgR5WuOdLKTsofLsNYt/3uY6d
         x7AuERmplSxKakIdz5vx0bWn+CMzgx65LG3nK1XNjW2zFM4ZIUCM9qBuYMYkesaJM+7E
         3ZKumjZ8TYgDAM4iXWj7tTZRphsxdhbZ+F/poQCTghwM5t8JPkYZJbuCjB7eLwhA4Y9n
         rl8UXVkUeaCaD2nbmbfNwVVbng4tBdvqUPVm8uRp0oXIPIUc12CDjnYMXESI95n8owZH
         OV+7V4KSZQWy2hiZRY48BjpWdrRjBlP2ocbOot54Zq29s/xUJ3ak2t51nZ0pyP51xpxy
         CakQ==
X-Gm-Message-State: AGi0PuZj7hDYCq+1dryebSBPK96edTSpZbnA4iEI6NRfIHeu62lVpoeZ
        p6SIZ0pocGZo0x2EWcTjjMG3g5mrdCHrqOqnryWsGG8qTNoKR1zklTEHZSbwGruyHBt+mhHyuAY
        097L8KkjkoUuTLTRf6K8ltOY9
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr270410wrp.294.1588611799201;
        Mon, 04 May 2020 10:03:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEGqngqTL62vANmYw8MNZ/t78mH/tWUZAgBtAwMIclNwNoRLiI8cvg/NcnHiR4qg2MaM+vNA==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr270388wrp.294.1588611798970;
        Mon, 04 May 2020 10:03:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id c190sm69917wme.10.2020.05.04.10.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:03:18 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: nVMX: vmcs.SYSENTER optimization and "fix"
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200428231025.12766-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61ba7eb0-4c51-0001-1d99-ef1478750c78@redhat.com>
Date:   Mon, 4 May 2020 19:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428231025.12766-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 01:10, Sean Christopherson wrote:
> Patch 1 is a "fix" for handling SYSENTER_EIP/ESP in L2 on a 32-bit vCPU.
> The primary motivation is to provide consistent behavior after patch 2.
> 
> Patch 2 is essentially a re-submission of a nested VMX optimization to
> avoid redundant VMREADs to the SYSENTER fields in the nested VM-Exit path.
> 
> After patch 2 and without patch 1, KVM would end up with weird behavior
> where L1 and L2 would only see 32-bit values for their own SYSENTER_E*P
> MSRs, but L1 could see a 64-bit value for L2's MSRs.
> 
> Sean Christopherson (2):
>   KVM: nVMX: Truncate writes to vmcs.SYSENTER_EIP/ESP for 32-bit vCPU
>   KVM: nVMX: Drop superfluous VMREAD of vmcs02.GUEST_SYSENTER_*
> 
>  arch/x86/kvm/vmx/nested.c |  4 ----
>  arch/x86/kvm/vmx/vmx.c    | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 

Queued, thanks.

Paolo

