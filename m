Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8220753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg0ZFkiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:31:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41470 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgCRRb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584552716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIEdAWs2IdQALzDuEkemxXWdr2rAA5T/LFwoILQOC80=;
        b=Bg0ZFkiWarRj0LI+ktYqCH68UBXBuBXiF7LCEAxs+SPMc5n2po3o/qpDs5QsVHfre37yTF
        ovLz6eG+w8Kpjxn0Erb0hoEDz9g8JdIqq6xBOJvhtRCsTmvxxu/GdjwMxpln2M2ahH5X4C
        msgeuglfEe6s9SpKB9q4D78nUqFJJSs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-0CGrEspdMTe-dwDWNeCVtQ-1; Wed, 18 Mar 2020 13:31:55 -0400
X-MC-Unique: 0CGrEspdMTe-dwDWNeCVtQ-1
Received: by mail-wr1-f71.google.com with SMTP id u12so10261501wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bIEdAWs2IdQALzDuEkemxXWdr2rAA5T/LFwoILQOC80=;
        b=ZjYEwOjNQ52Sw4McHOvDH4xuQv/vnJ3ivsq+mI8zTz9Sbsywa6hwqLMk9LKDoReDzr
         p7wZ3M/yU2Oat8naLXF0A//nw8ohIL03o2WY73qGSsu8mcFxZJlA5Zrue33qHj/lSo/X
         bnSWmk7YLbH7nQ86zoh+LdrG3uBaeiFeN5PUXx2N+Q4KXTSbvljHR9px0nJqGTn/nMFN
         Ms5cEBVt2u0NjYaKeigp3Rmv10n0f2eqB1/CgWc09kH49uOmMTi1C/gCqMGgTFs0tdY7
         hGFVsdQI1nVIZOdTIxzNM/cQXQr/O+1P3SnCg3rjLoiUbiwUPT9OGdUMyJCVC1aSsrJy
         SXpQ==
X-Gm-Message-State: ANhLgQ30ELJLzAZ9x7uCCPFhQX6bisL2IPGkBJEdujCI/9afs+O5RGwy
        Br0WUF43S5b05kcdP5+NQuvm4M8ds/ct6E5g83MrmyVcqeTrvrgeElI52FbC/kbPJl0LmcqMSTz
        NBTQdlnD9jMVACdPzX4CN+qBg
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr6943176wrb.90.1584552713813;
        Wed, 18 Mar 2020 10:31:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvMOb5pOQOV0P/ATjTil/qiszSghckBJJr6fWehPfragC3y/9MOIQObyV9hSemvUTYNKmqFBA==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr6943159wrb.90.1584552713550;
        Wed, 18 Mar 2020 10:31:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id p8sm10385903wrw.19.2020.03.18.10.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 10:31:53 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] KVM: VMX: cleanup VMXON region allocation
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200318171752.173073-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d992436-ada6-3674-9085-060f930a949e@redhat.com>
Date:   Wed, 18 Mar 2020 18:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318171752.173073-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/20 18:17, Vitaly Kuznetsov wrote:
> Minor cleanup with no functional change (intended):
> - Rename 'kvm_area' to 'vmxon_region'
> - Simplify setting revision_id for VMXON region when eVMCS is in use
> 
> Changes since v3:
> - Rebase to kvm/queue
> - Added Krish's Reviewed-by: tag to PATCH1
> - Re-name 'enum vmcs_type' members [Sean Christopherson]
> 
> Vitaly Kuznetsov (2):
>   KVM: VMX: rename 'kvm_area' to 'vmxon_region'
>   KVM: VMX: untangle VMXON revision_id setting when using eVMCS
> 
>  arch/x86/kvm/vmx/nested.c |  2 +-
>  arch/x86/kvm/vmx/vmx.c    | 44 ++++++++++++++++++---------------------
>  arch/x86/kvm/vmx/vmx.h    | 12 ++++++++---
>  3 files changed, 30 insertions(+), 28 deletions(-)
> 

Queued, thanks.

Paolo

