Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5535BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D76217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNY4ffNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbgDPODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50991 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgDPNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587044527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/1ZzkqlTi7SRUYHpseP8/ZANbIohPVFGcK3piqF1OY=;
        b=TNY4ffNL0dG78/Oo8KKxKXSg5lRMFyVuD6Ow81OkH+6C6vRnbF4D7xIKIw4Li9Ae4j+y/f
        WHx0eWPRPe9bicthCdxcd2PaOMfW1OeXFiZ4gN8Yr5OR6ML07hbNLN6mbWh5huF1ZAfY9a
        yUJqpFDrPvP28rbi7+NG73ifMkxuRtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-okW0YJh6OXmWSULMjcgr3Q-1; Thu, 16 Apr 2020 09:42:04 -0400
X-MC-Unique: okW0YJh6OXmWSULMjcgr3Q-1
Received: by mail-wr1-f70.google.com with SMTP id i10so1245102wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a/1ZzkqlTi7SRUYHpseP8/ZANbIohPVFGcK3piqF1OY=;
        b=G5Ievk2Eca6lY7K+WGQ33hV5/NYsamhTkZ7Hadm8qiINJPdjZiPXLMG7Sl27GS3hj2
         SekhmTY3q8e0QMztFiIgbgm3yMxDtIW1YiAJMK7qZDr+u1iqLdg8Rl0fZXi1G2ZTh4wB
         jxNaXlDMVXlaF2g4NkLe4CjJ3wKsYXDbMS5aUsml8bnaFSdSimQZN1LV4cwNsqzWhksQ
         hf1WSfn6erJ3/OzUEK5L0W5bSi+GgCBgpyMftZhAlzL211oaCxbuMKia+557dNEpWe6d
         fkh7yS85v9yRILfSHmOV9Mc3yKkaqsmPvE5yGvjVShWLnkhXFOdFALWHCF2QUNWF6Y3S
         1Oww==
X-Gm-Message-State: AGi0PuZEyUP7j8SI+rttBJO+nqW2biYiB0if7z31/KUSl6hjxsCmDx25
        hduXHSzI/4AEShOavcgfa5JqG6ZFJREZlDdTfmW8PLSbl6lPmjid8tNH1SbE9csafvu0ylM/sUm
        i2VvVE05kiKFKLIYC0DD3AmI6
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr5217960wmy.13.1587044522784;
        Thu, 16 Apr 2020 06:42:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzoEVKX7f3apWSf+0ABegyK+KCs7PTPeOkDlwys1PA0/OzOllgPpSCI941twQhqGT7eyIuCQ==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr5217940wmy.13.1587044522536;
        Thu, 16 Apr 2020 06:42:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id o16sm28082541wrs.44.2020.04.16.06.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:42:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: VMX: Add caching of EXIT_QUAL and INTR_INFO
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200415203454.8296-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d449f6e3-ca28-2fac-e4ed-7dea2729d3b5@redhat.com>
Date:   Thu, 16 Apr 2020 15:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415203454.8296-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 22:34, Sean Christopherson wrote:
> Patches 4-5 are the focus of this series, adding caching of
> vmcs.EXIT_QUALIFICATION and proper caching of vmcs.INTR_INFO (instead of
> caching it with ad hoc rules about when it's available).  Patches 1-3
> are prep work to clean up the register caching to ensure correctness when
> switching between vmcs01 and vmcs02.
> 
> The idea for this came about when working on the "unionize exit_reason"
> series.  The nested VM-Exit logic looks at both fields multiple times,
> which is ok-ish when everything is crammed into one or two functions, but
> incurs multiple VMREADs when split up.  I really didn't want to solve that
> issue by piling on more cases where vmx->exit_intr_info would be valid, or
> by duplicating that fragile pattern for exit_qualification.
> 
> Paolo, this will conflict with the "unionize exit_reason" series, though
> the conflict resolution is all mechnical in nature.  Let me know if you
> want me to respin one on top of the other, send a single series, etc...

Queued, I think I fixed the conflicts right.  We'll see if anything
explodes when I test it. :)

Paolo

> 
> Sean Christopherson (5):
>   KVM: nVMX: Invoke ept_save_pdptrs() if and only if PAE paging is
>     enabled
>   KVM: nVMX: Reset register cache (available and dirty masks) on VMCS
>     switch
>   KVM: nVMX: Drop manual clearing of segment cache on nested VMCS switch
>   KVM: VMX: Cache vmcs.EXIT_QUALIFICATION using arch avail_reg flags
>   KVM: VMX: Cache vmcs.EXIT_INTR_INFO using arch avail_reg flags
> 
>  arch/x86/include/asm/kvm_host.h |  2 +
>  arch/x86/kvm/vmx/nested.c       | 29 +++++++------
>  arch/x86/kvm/vmx/nested.h       |  4 +-
>  arch/x86/kvm/vmx/vmx.c          | 73 ++++++++++++++++-----------------
>  arch/x86/kvm/vmx/vmx.h          | 35 +++++++++++++++-
>  5 files changed, 86 insertions(+), 57 deletions(-)
> 

