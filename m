Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC21C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E4B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAx3Y9f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:50:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56015 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726671AbgDJPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586533840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbv9dpmY197904b6GS2826/Wmyt1SaRkI6kEH+Y6rqI=;
        b=jAx3Y9f1Gz4v7FpAx1NlkMd/BzdwVk0oeWvmm8PV7kCYLYauCXXdWi5++msSUZoR3T2gsg
        aG4ql8LdI3fobyNfc1zsGocdYVxwoZAwn9oM/DSmctU0aL+tc7ypnoLOLsN3lQjupz7GY8
        unRSGh7yi/dkHdI4L3WaHxYVUgB1YqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-jgp4hXydPfq_cvcuTqDxJA-1; Fri, 10 Apr 2020 11:50:38 -0400
X-MC-Unique: jgp4hXydPfq_cvcuTqDxJA-1
Received: by mail-wm1-f69.google.com with SMTP id 14so784161wmo.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbv9dpmY197904b6GS2826/Wmyt1SaRkI6kEH+Y6rqI=;
        b=gViMaIuMGy1rBgRB/0LcBDbRrbqWk5kVFF+tDDOG9BDQEylKGfTmhxSERtFRfMQkGo
         kJSutSerQLt9pteQU1K14cpbC4BE2hqpeT4WHGdXXv60SrNegSNwUwK/m93ruHscBEgP
         f9Y7L3vQ93BcWXJKxT4GjbkIrejI2gjOpflLzl60WC/+bQooHZbFgNwAvOAJMPHPayro
         DugNRj6fAl1JTdoHK4lh4i0WF9uRUJ7KkTa9YYFwMGCvAH4XNk33g13LGt/Sg+cfcP9o
         XDNv6lQi8TznuF6bbIVmR347fU4QMncMsdzzV+lOWFS8O/HGDmtTRqiBPwwGseRgl4vx
         wtjg==
X-Gm-Message-State: AGi0PuYshY+awbryNKX43YuWBTloLD6m9rtAvWsvof96FNHhIst13ayA
        Lsoj+fU8mGyQweQIFOMOAQscvherp+Xg+K0Qav/LKgWTVGZZ50JAhf2fWj2vEtFl1pDOlHuMjQK
        mcjmFTYGHKo//txlnx8qjvo4F
X-Received: by 2002:a7b:c417:: with SMTP id k23mr5859668wmi.147.1586533837598;
        Fri, 10 Apr 2020 08:50:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpRTANLwLNZGK/YcNONJDjAo50QC72EEpTSJ/RKdGUXrt8aC4++t3sHoHsg4ERsBQwwj3OwA==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr5859648wmi.147.1586533837336;
        Fri, 10 Apr 2020 08:50:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b7:b34c:3ace:efb6? ([2001:b07:6468:f312:f4b7:b34c:3ace:efb6])
        by smtp.gmail.com with ESMTPSA id v186sm3273773wme.24.2020.04.10.08.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:50:36 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: X86: Ultra fast single target IPI fastpath
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1586480607-5408-1-git-send-email-wanpengli@tencent.com>
 <20200410153539.GD22482@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f51251cc-885e-2f7a-b18d-faa76db15b87@redhat.com>
Date:   Fri, 10 Apr 2020 17:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410153539.GD22482@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 17:35, Sean Christopherson wrote:
> IMO, this should come at the very end of vmx_vcpu_run().  At a minimum, it
> needs to be moved below the #MC handling and below
> 
> 	if (vmx->fail || (vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
> 		return;

Why?  It cannot run in any of those cases, since the vmx->exit_reason
won't match.

> KVM more or less assumes vmx->idt_vectoring_info is always valid, and it's
> not obvious that a generic fastpath call can safely run before
> vmx_complete_interrupts(), e.g. the kvm_clear_interrupt_queue() call.

Not KVM, rather vmx.c.  You're right about a generic fastpath, but in
this case kvm_irq_delivery_to_apic_fast is not touching VMX state; even
if you have a self-IPI, the modification of vCPU state is only scheduled
here and will happen later via either kvm_x86_ops.sync_pir_to_irr or
KVM_REQ_EVENT.

Paolo

