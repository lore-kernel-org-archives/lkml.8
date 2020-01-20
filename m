Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE35C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46992087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwxR5gT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgATQdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:33:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727573AbgATQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579538011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1zcq54gP0pXiBRG1fF2BRNY1nGBgHmf0naqBgZVYZA=;
        b=iwxR5gT83uFT4qHL3bgMpZLjEgc/NmQMjbwfWnZ8B2Gx8l9RuiG/6aOCPTTRzzqGXy7Et9
        qBdwKHcuQtr3xkpCUK2O5FJdxHV3EInYYvIr5vBIRFisvuQbIIsHTlUXgvHnXwX/o9NaWt
        L3AVuZ8xJQu9QprMbtJCw7oMBsdvhdI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-61nwOdH4Ny-fYnobaSQlXA-1; Mon, 20 Jan 2020 11:33:29 -0500
X-MC-Unique: 61nwOdH4Ny-fYnobaSQlXA-1
Received: by mail-wr1-f72.google.com with SMTP id z14so42670wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=K1zcq54gP0pXiBRG1fF2BRNY1nGBgHmf0naqBgZVYZA=;
        b=XjBVc981wUl3zilrYKTqxwrQyillIi+WA03cYXsj8bmkmHeSbW6PKFHBvG1EWN/9YF
         OpwtdPGSCfoM5Zl6v2itT7SBh57gFOwm3N0xHkoY9E4QBVpBy5INeNiYRTOt+tvndF16
         jF8AoofMGzvWIpNgb5cJ3+2Os0nJ41+MG5H+IxkNIfAE/BpSKUUDmP9zPRgSIIU94d82
         KFVfzcADWXWEKoRo7GMKRT5PsL9Q1rwCgzM7g+WxWeyDlnd3BqpQH/+FgrplRflQfvaT
         ilRsQEgyyViBJgANUXsmQm472EqcTe+FuE4ORRzkVBZASawQ91dzjDql+zIeMlBr8Wjr
         Qquw==
X-Gm-Message-State: APjAAAXQX9CLhJgUp2I7LArf9nxPvGz8+tuDXPt+ZfqhyZdJvxQHCw2A
        4dwMg3zu5ZS8QoSyMR2YjODODDvT9g/oDVMlwnYOHWMgZW9xxqY5K0skYM/4+dxceuxIQMI1fkK
        d+saUdFJGCmc7o14Hn1Hr8Y/G
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr298150wrs.303.1579538008685;
        Mon, 20 Jan 2020 08:33:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyH1y6QHBvoU2MiBx+BCIkxLVbqTXcXlc6sAqVsfOSnE//yyWWeKTqmGdEFekqNwtFNoZ6hIw==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr298137wrs.303.1579538008452;
        Mon, 20 Jan 2020 08:33:28 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v22sm22281449wml.11.2020.01.20.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:33:27 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [RFC] Revert "kvm: nVMX: Restrict VMX capability MSR changes"
In-Reply-To: <30525d58-10de-abb4-8dad-228da766ff82@redhat.com>
References: <20200120151141.227254-1-vkuznets@redhat.com> <30525d58-10de-abb4-8dad-228da766ff82@redhat.com>
Date:   Mon, 20 Jan 2020 17:33:26 +0100
Message-ID: <87k15mf5pl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 20/01/20 16:11, Vitaly Kuznetsov wrote:
>> 
>> RFC. I think the check for vmx->nested.vmxon is legitimate for everything
>> but restore so removing it (what I do with the revert) is likely a no-go.
>> I'd like to gather opinions on the proper fix: should we somehow check
>> that the vCPU is in 'restore' start (has never being run) and make
>> KVM_SET_MSRS pass or should we actually mandate that KVM_SET_NESTED_STATE
>> is run after KVM_SET_MSRS by userspace?
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> I think this should be fixed in QEMU, by doing KVM_SET_MSRS for feature
> MSRs way earlier.  I'll do it since I'm currently working on a patch to
> add a KVM_SET_MSR for the microcode revision.

Works for me, thanks)

The bigger issue is that the vCPU setup sequence (like QEMU's
kvm_arch_put_registers()) effectively becomes an API convention and as
it gets more complex it would be great to document it for KVM.

-- 
Vitaly

