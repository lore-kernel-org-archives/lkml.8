Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23858C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F5A246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIfckeK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1LCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:02:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgB1LCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582887741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOTz3z0myDtGSUcHKtKThQsvvaepkhJ6MlijLPxcArE=;
        b=TIfckeK5wTlt6m9FaIprpYIo+9la7P8qehUi94W3a1VwjNXPYsR5Gx29k7HHyIjrPiE4Rq
        Hty8lT12aTn4WTwNMdJ1Mt6okdXFKbFaFu6IKU9pk+vUBgTMDhlNHM8wFtmJlKgMd073u4
        iaU4/UVtN34nLCvGVhuMAH/v25SDyrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-dCqvLQKgPtekP0giXB2Jhg-1; Fri, 28 Feb 2020 06:02:16 -0500
X-MC-Unique: dCqvLQKgPtekP0giXB2Jhg-1
Received: by mail-wr1-f71.google.com with SMTP id w18so1192025wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOTz3z0myDtGSUcHKtKThQsvvaepkhJ6MlijLPxcArE=;
        b=lfmmwwa39qOYDjTtXaF/L9zddPPj7iEyV6W9U/uH0h5RE95WMUR0sdGJs/8NXJliIs
         BRoFDVdo/kXpqSTJnQpKhoWE4Rz7q//msfDDEu7f3o5Fqg9GxPF7HolfKxU7HaBsW+pb
         AtNi1miILHq6P3kQSBKxGHPT6yHfIVvhZBrnRW0CCE6X3P1XxTj4RBzci0MlGh7urRW5
         XF5G/+FQHPzNCytIO9MkkBu+Ez7+8eDx+rPcQnI1txamdlUpf5O71wh0xe+frRPGGCGx
         9m8P9Z3UWaMtLj7gM8tmfz/UhpFvb2JOfVndcO41Ye3R++weZO+a4ubmyYWUxEl6ysf6
         0Wrg==
X-Gm-Message-State: APjAAAV7NGn4wu2VrgplzaR5pqewrKyfo70XjSXXEqK8GOKU6pgBh1/m
        XYdTvnUPjrSF7+mZQLgCN5mi2128ln8F/4wRONcjQsmuGO2WFs2P3UEnWPjNYuVHqq9AKYxP4QF
        IWO8j+E4RCfJ4ONUer+1iJ++Q
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr4146216wrn.45.1582887735283;
        Fri, 28 Feb 2020 03:02:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYzo5jWtbCUw/gasLgNeSunW7IecGRNnJbOzVwXdtCCwDB8bX7TOPJ7q5DZQk06thQaq8xCA==
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr4146191wrn.45.1582887734990;
        Fri, 28 Feb 2020 03:02:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id y17sm11692186wrs.82.2020.02.28.03.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:02:14 -0800 (PST)
Subject: Re: [PATCH 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200227223047.13125-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72839897-3ed7-8151-178b-9f266fefc8ba@redhat.com>
Date:   Fri, 28 Feb 2020 12:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227223047.13125-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 23:30, Sean Christopherson wrote:
> Patch 1 fixes a a theoretical bug where a crashdump NMI that arrives
> while KVM is messing with the percpu VMCS list would result in one or more
> VMCSes not being cleared, potentially causing memory corruption in the new
> kexec'd kernel.
> 
> Patch 2 isn't directly related, but it conflicts with the crash cleanup
> changes, both from a code and a semantics perspective.  Without the crash
> cleanup, IMO hardware_enable() should do crash_disable_local_vmclear()
> if VMXON fails, i.e. clean up after itself.  But hardware_disable()
> doesn't even do crash_disable_local_vmclear() (which is what got me
> looking at that code in the first place).  Basing the VMXON change on top
> of the crash cleanup avoids the debate entirely.
> 
> Patch 3 is a simple clean up (no functional change intended ;-) ).
> 
> I verified my analysis of the NMI bug by simulating what would happen if
> an NMI arrived in the middle of list_add() and list_del().  The below
> output matches expectations, e.g. nothing hangs, the entry being added
> doesn't show up, and the entry being deleted _does_ show up.
> 
> [    8.205898] KVM: testing NMI in list_add()
> [    8.205898] KVM: testing NMI in list_del()
> [    8.205899] KVM: found e3
> [    8.205899] KVM: found e2
> [    8.205899] KVM: found e1
> [    8.205900] KVM: found e3
> [    8.205900] KVM: found e1
> 
> static void vmx_test_list(struct list_head *list, struct list_head *e1,
> 			  struct list_head *e2, struct list_head *e3)
> {
> 	struct list_head *tmp;
> 
> 	list_for_each(tmp, list) {
> 		if (tmp == e1)
> 			pr_warn("KVM: found e1\n");
> 		else if (tmp == e2)
> 			pr_warn("KVM: found e2\n");
> 		else if (tmp == e3)
> 			pr_warn("KVM: found e3\n");
> 		else
> 			pr_warn("KVM: kaboom\n");
> 	}
> }
> 
> static int __init vmx_init(void)
> {
> 	LIST_HEAD(list);
> 	LIST_HEAD(e1);
> 	LIST_HEAD(e2);
> 	LIST_HEAD(e3);
> 
> 	pr_warn("KVM: testing NMI in list_add()\n");
> 
> 	list.next->prev = &e1;
> 	vmx_test_list(&list, &e1, &e2, &e3);
> 
> 	e1.next = list.next;
> 	vmx_test_list(&list, &e1, &e2, &e3);
> 
> 	e1.prev = &list;
> 	vmx_test_list(&list, &e1, &e2, &e3);
> 
> 	INIT_LIST_HEAD(&list);
> 	INIT_LIST_HEAD(&e1);
> 
> 	list_add(&e1, &list);
> 	list_add(&e2, &list);
> 	list_add(&e3, &list);
> 
> 	pr_warn("KVM: testing NMI in list_del()\n");
> 
> 	e3.prev = &e1;
> 	vmx_test_list(&list, &e1, &e2, &e3);
> 
> 	list_del(&e2);
> 	list.prev = &e1;
> 	vmx_test_list(&list, &e1, &e2, &e3);
> }
> 
> Sean Christopherson (3):
>   KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support
>   KVM: VMX: Gracefully handle faults on VMXON
>   KVM: VMX: Make loaded_vmcs_init() a static function
> 
>  arch/x86/kvm/vmx/vmx.c | 101 +++++++++++++++++------------------------
>  arch/x86/kvm/vmx/vmx.h |   1 -
>  2 files changed, 41 insertions(+), 61 deletions(-)
> 

Queued, thanks (but still awaiting "counter-review" on the patch 1
suggestions).

Paolo

