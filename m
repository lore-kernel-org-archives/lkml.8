Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F264C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C2B24680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g96lKX2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbgAVJhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731650AbgAVJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579685840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6yEULGDzE/nInvw9JSJB7gTt3H5wvwQ6ls0gr1oQVY=;
        b=g96lKX2KqcMqcZjB64N3nYR5Tjin/Ib7L8Sc8hQBU46+aqe/XYQMwjpLvEgjKdfvqXTffU
        Aw3eCb2G/dcFkrTE8k8Tbm2tRk7XWUPyYtFM7WaYIzxsZvIlKLlBVm8nq+ZNg39IbFncpR
        KC4nhm68AmoXtUcIMdz1DbTLSp10+Rc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-i1bZkeShMji0lNzOVe2ocg-1; Wed, 22 Jan 2020 04:37:19 -0500
X-MC-Unique: i1bZkeShMji0lNzOVe2ocg-1
Received: by mail-wr1-f69.google.com with SMTP id o6so2771297wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 01:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=W6yEULGDzE/nInvw9JSJB7gTt3H5wvwQ6ls0gr1oQVY=;
        b=HlUmHeBe34WBeHCBg7bETLyapmFzF1o/HaMMAPS0etCMIx4IjyFBF7gJnvcO3UM6Ef
         oDXbwyAFa42Xqzj2OgU/FxstA2/MZqqOrciafgK3k3nM6o1UDwX7pcOlgTskh57rqNzu
         1/tmhWPB38AEV152ZmBuqKQTpzG3vZqfDaJXKf1wQw+WDwx2l2wl90RnKRn2cZspjUmf
         hcCBHn1RJlg53fBRVA2ephSyvcwsNDNcC71aA2VS9AQbWl4eDDt86sMu6JqKc5/7lRMF
         HI+P3UxMFxl5OApqGYv2WX7mGTUCqqLg2a6Yl5DPIB8602XlSt7eYHfhJvv5HxnUEb4s
         dSBw==
X-Gm-Message-State: APjAAAX1WGUX9SJ812JUVQYKk1A9jjfgp0fD62DUJlCgBJRkQwQCaX5v
        rZCAVmOwsC3FvM5ULbyBjlOxy3+E9/1uIR+uU2GYZFqyiRsJYbnHX7VqehquQSYbBhKzMaMCkQb
        grHqUWNZ5NZu1Oi/ksEo7wsaH
X-Received: by 2002:adf:d846:: with SMTP id k6mr9578104wrl.337.1579685838124;
        Wed, 22 Jan 2020 01:37:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqWhY53TzrvajxcRumOsfe7V0LUooFHe3j3uQkZe4Gzh7e9aIgcb7kzXkxzrsSylqS9LEr5Q==
X-Received: by 2002:adf:d846:: with SMTP id k6mr9578074wrl.337.1579685837856;
        Wed, 22 Jan 2020 01:37:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b17sm57898390wrx.15.2020.01.22.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 01:37:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <20200122054724.GD18513@linux.intel.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com> <20200122054724.GD18513@linux.intel.com>
Date:   Wed, 22 Jan 2020 10:37:16 +0100
Message-ID: <87zhefsugj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Sat, Jan 18, 2020 at 10:42:31PM +0100, Paolo Bonzini wrote:
>> IMHO the features should stay available in case the guest chooses not to
>> use eVMCS.  A guest that uses eVMCS should know which features it cannot
>> use and not enable them.
>
> Makes sense, wasn't thinking about the scenario where the guest doesn't
> support eVMCS or doesn't want to use it for whatever reason.
>
> Rather than update vmx->nested.msrs or filter vmx_get_msr(), what about
> manually adding eVMCS consistency checks on the disallowed bits and handle
> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES as a one-off case by simply
> clearing it from the eVMCS?

Unfortunately, this doesn't work because ... Windows. Not only Hyper-V
enables SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES, it actually expects it
to work (somehow) so when I do

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 72359709cdc1..e6c30eec2817 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -361,11 +361,5 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
        if (evmcs_already_enabled)
                return 0;
 
-       vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
-       vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
-       vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
-       vmx->nested.msrs.secondary_ctls_high &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
-       vmx->nested.msrs.vmfunc_controls &= ~EVMCS1_UNSUPPORTED_VMFUNC;
-
        return 0;
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bb8afe0c5e7f..cd1f5a1c884b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1590,7 +1590,7 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
                        evmcs->pin_based_vm_exec_control;
                vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
                vmcs12->secondary_vm_exec_control =
-                       evmcs->secondary_vm_exec_control;
+                       evmcs->secondary_vm_exec_control & ~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
        }
 
        if (unlikely(!(evmcs->hv_clean_fields &

Hyper-V 2016 with > 1 vCPU fails to boot :-(

-- 
Vitaly

