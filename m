Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1EC20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGrGbbf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBUQbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:31:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbgBUQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582302708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+/PwYVfKF+sGaYhdBB/ka7rcNSOJveuT3O5v5Xs6QM=;
        b=XGrGbbf7Z4mAPjbwexqJ7IsLnJ5yHXohgwfNxReFPISrRudkd7aLJt8yY5ImgqBQzHqQUY
        vnIyoWFr1zkYlaoJGlHJTL5DTH/OcCLUCoHQrsZsnMX4gcbTVFqVwrZarB8XUt4fjY65gS
        nPh39pTOAKiAHwSwrhLivBRM5r5M5bw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61--R_eFUj0NvKTyAVnVWCB1g-1; Fri, 21 Feb 2020 11:31:47 -0500
X-MC-Unique: -R_eFUj0NvKTyAVnVWCB1g-1
Received: by mail-wm1-f69.google.com with SMTP id p26so834033wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+/PwYVfKF+sGaYhdBB/ka7rcNSOJveuT3O5v5Xs6QM=;
        b=YgVLOSdY9OhKaVoH0nvpHaUIFyUDmIOJx0KMVLBF2YzJ5oSJwYoqPnsDwpcx8Sq/Kl
         /FN5YP019t8XwHnzQU7e6S2IUxHzryG/5qSSCDUrlXUavEXSRC9KzunxxTGkgdCD5+Iy
         UuuDi7B/O4xvvEF5grXvf/R02GISAw1gYlf3Zkg+bSVBT378O1jSIBViJ59/VLzmyqDn
         +VfRfCyGZ25vkIZdsEy4UX+9pxnALYUen3WsnfI4Lw/tNhJgzl9u/pruqQ0mt61QnWRP
         a/vOgDDs+5dxZvCpkO9YCiWbUuNDzbOU2pavFOgVh4vBSpbE9HPyce6p/aI1Tm66oo3D
         vD8w==
X-Gm-Message-State: APjAAAXhrxNZ33bsTmTxUC47ga5brZeVUKG9bk57T1NEDfOEAHL1C2wY
        5ia9Y3+OCcieCUWFKvaC7p7G3+TPR30KpdMrzW6HZXnYgHZjL1RuoZHttP6pt7L9ov/mdjW9Ync
        T8QK4Ri8/XiV/iQMjOtID3xir
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4632378wmc.109.1582302706099;
        Fri, 21 Feb 2020 08:31:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHPzw+vtsYsE0OyDcSB1eD9HXtMyBCN3d5TeUuNu7HSh1hgyKVqB1VcO5l07mSlsTnqf40YA==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4632358wmc.109.1582302705882;
        Fri, 21 Feb 2020 08:31:45 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id w1sm4297148wmc.11.2020.02.21.08.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:31:44 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: eliminate some meaningless code
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     rkrcmar@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1582293926-23388-1-git-send-email-linmiaohe@huawei.com>
 <20200221152358.GC12665@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e393431b-9e5e-9bcb-c03a-d40baeafa435@redhat.com>
Date:   Fri, 21 Feb 2020 17:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221152358.GC12665@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/20 16:23, Sean Christopherson wrote:
> 
> I'm guessing no VMM actually uses this ioctl(), e.g. neither Qemu or CrosVM
> use it, which is why the broken behavior has gone unnoticed.  Don't suppose
> you'd want to write a selftest to hammer KVM_{SET,GET}_CPUID2?
> 
> int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
>                               struct kvm_cpuid2 *cpuid,
>                               struct kvm_cpuid_entry2 __user *entries)
> {
>         if (cpuid->nent < vcpu->arch.cpuid_nent)
>                 return -E2BIG;
> 
>         if (copy_to_user(entries, &vcpu->arch.cpuid_entries,
>                          vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
>                 return -EFAULT;
> 
> 	cpuid->nent = vcpu->arch.cpuid_nent;
> 
>         return 0;
> }

I would just drop KVM_GET_CPUID2 altogether and see if someone complains.

Paolo

