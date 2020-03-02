Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C1FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBFB20863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOBQYN/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCBNBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:01:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34127 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727173AbgCBNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583154072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFEYElovxs1he3jW2L/2OIMoWJCYaK4R5aZbj7powQE=;
        b=DOBQYN/nO1B99/m2vL4RH2ddwwn+T3Q5sZPL4wjzlUzY73bkg2G9lZSOSKfUmO9WLqJvtw
        m4PY+B2iMIGi9k2SoaW8TnISiwrcF3nisZMQIW1gUm+sPCEy7snQoHH4VJNtvMiSKwVAI8
        lviySL18v8A5avqAmXu16ExE3+lUdxQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-mGqsF8LtPxKFCUSTL0Dxww-1; Mon, 02 Mar 2020 08:01:11 -0500
X-MC-Unique: mGqsF8LtPxKFCUSTL0Dxww-1
Received: by mail-wr1-f69.google.com with SMTP id y28so5727039wrd.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vFEYElovxs1he3jW2L/2OIMoWJCYaK4R5aZbj7powQE=;
        b=KuQEYxakWtH/LCOxlGY6UZtxcvQyDr5+lsnoOFm+meXPVu60/LAdkFX/obamCRda4B
         2D43oC/eg90bYl2tmE7esgEUMd8Qv/aFQJlsmX/YdOGTTKrUrz5UK0fE27Lng1uX0RXY
         Gkruj+pgCYHlU/QVZVwmm66TRN9daqp0L3/qpYTaasLD94v41evo0GVPhNTEAcb5pufE
         JQoW3mMo1whO631nRaxTKk8kEcFixTiqlrpYlGpEer4VGh7+uLSRwidD2LDRAn5zy9AM
         MkdHO/Z3dJ5DWv1cJsDydF52j8QNpXWr6AGLedn8AaZclkLnKCZzBCm+hcvjltu5AzI+
         M5og==
X-Gm-Message-State: APjAAAUo7j4/rEDn820dunztCBeQoRDRNQ1SMKXdrSi+uOlG6irw9Bly
        UtNnipWp5G4uyrqm1nXJvZClbqkl7LUMUWieiP0YQkZ9NBzB8ywSpltsK5mZm0R5SGouVQeVDmH
        JTwBEDgfWntuVHW7OpeL6behT
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr19492297wmj.59.1583154068053;
        Mon, 02 Mar 2020 05:01:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqytInT/vs8uW+zSLol0sFtoMeXPxy5TDYEfalNY4crz/GnJg2mECfgk9LJfq+x+gQ9Zc8kXIg==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr19492281wmj.59.1583154067821;
        Mon, 02 Mar 2020 05:01:07 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i204sm16306020wma.44.2020.03.02.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 05:01:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3] KVM: X86: Just one leader to trigger kvmclock sync request
In-Reply-To: <1582859921-11932-1-git-send-email-wanpengli@tencent.com>
References: <1582859921-11932-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 02 Mar 2020 14:01:06 +0100
Message-ID: <87lfoihpwt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> In the progress of vCPUs creation, it queues a kvmclock sync worker to the global
> workqueue before each vCPU creation completes. The workqueue subsystem guarantees 
> not to queue the already queued work, however, we can make the logic more clear by 
> make just one leader to trigger this kvmclock sync request and save on cacheline 
> boucing due to test_and_set_bit.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v2 -> v3:
>  * update patch description
> v1 -> v2:
>  * check vcpu->vcpu_idx
>
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fb5d64e..79bc995 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9390,8 +9390,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (!kvmclock_periodic_sync)
>  		return;
>  
> -	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> -					KVMCLOCK_SYNC_PERIOD);
> +	if (vcpu->vcpu_idx == 0)
> +		schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> +						KVMCLOCK_SYNC_PERIOD);

I would've merged this new check with !kvmclock_periodic_sync above
making it more obvious when the work is scheduled

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5de200663f51..93550976f991 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9389,11 +9389,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
        mutex_unlock(&vcpu->mutex);
 
-       if (!kvmclock_periodic_sync)
-               return;
-
-       schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
-                                       KVMCLOCK_SYNC_PERIOD);
+       if (vcpu->vcpu_idx == 0 && kvmclock_periodic_sync)
+               schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
+                                     KVMCLOCK_SYNC_PERIOD);
 }

>  }
>  
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)

With or without the change mentioned above,
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

