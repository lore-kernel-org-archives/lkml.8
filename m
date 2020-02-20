Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B7EC11D0F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DABE206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy0PiBsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgBTQdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:33:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbgBTQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLonCBUOUjLc0CmEPRN1BygsqRkakx9D4QOI0lbDDos=;
        b=Yy0PiBsNWBmOfqmvm+3Z7fJQn3t56xOJVjqcZzVZzwevKXhUXKe0ULYmI2UzgSvMM5e+7C
        19YUoqj0gYZ++os5LUEIGFKlWcEFBhEwVE6wTBRiYOIzgbYscSJZZbHFe7fp243OMHVOPD
        MNl+BsWE4ZC8PJnV7VWGTJbZ+5RcyKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-1A-sLOg3PBeK2UXKicdNvg-1; Thu, 20 Feb 2020 11:33:20 -0500
X-MC-Unique: 1A-sLOg3PBeK2UXKicdNvg-1
Received: by mail-wm1-f71.google.com with SMTP id f207so797024wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fLonCBUOUjLc0CmEPRN1BygsqRkakx9D4QOI0lbDDos=;
        b=Me3q3x7mty5BP1xljKl4c1b4rYL4RcI6YddMvxwB16EB5NcL0FahtKWgv1MCMi7H5g
         avOLDWTAh1NraKzKbEKmfGJtpX2oobII0+KjDj3h38GBOEG3rVev1U2g9pNPExHrmB3Z
         5MvaKivN4kYYGsN7hHMG1TYEvxzumTTkZt2N/1iKUVRa+NzYohUN8k2W6XQWJvJz9+SL
         6sWMRIlaxJTxtIcLnr+P9Ys5n5urlcqAGLllpmjxeN8JG0IzqXOdU1RwI/QKnV09QDUB
         0sw+PVhl36XUAqAROPQB9Ljufg7TtCiEY+OrKx0OiHFi5N67L41Stx/tSaxa2TDB6kJu
         N1mg==
X-Gm-Message-State: APjAAAU3u5mJCAXN5Jtcl6gDAnl3A1PpBFVzLLXPCz1skrrWiDu/JkpE
        /TA/eaw7W7N/8ulN5E5Umce1TZU1Q6S00fVKiBdTZ/N4sxdTxIvV+wgp14KmEA71wZN3zdVX5It
        xzD9P7lhZLftARLclDopmQmnb
X-Received: by 2002:a1c:e007:: with SMTP id x7mr5250315wmg.3.1582216399425;
        Thu, 20 Feb 2020 08:33:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRHj5vuBzGfQvaITDv9sfER6wfON7w4T7TTLU9Vtme/FwYOA1F5VpAtAdFuc4WikvP/UsG4w==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr5250287wmg.3.1582216399222;
        Thu, 20 Feb 2020 08:33:19 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 133sm5765628wme.32.2020.02.20.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:33:18 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: apic: avoid calculating pending eoi from an uninitialized val
In-Reply-To: <1582213006-488-1-git-send-email-linmiaohe@huawei.com>
References: <1582213006-488-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 20 Feb 2020 17:33:17 +0100
Message-ID: <8736b56wxe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> When get user eoi value failed, var val would be uninitialized and result
> in calculating pending eoi from an uninitialized val. Initialize var val
> to 0 to fix this case.

Let me try to suggest an alternative wording,

"When pv_eoi_get_user() fails, 'val' may remain uninitialized and the
return value of pv_eoi_get_pending() becomes random. Fix the issue by
initializing the variable."

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4f14ec7525f6..7e77e94f3176 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -626,7 +626,7 @@ static inline bool pv_eoi_enabled(struct kvm_vcpu *vcpu)
>  
>  static bool pv_eoi_get_pending(struct kvm_vcpu *vcpu)
>  {
> -	u8 val;
> +	u8 val = 0;
>  	if (pv_eoi_get_user(vcpu, &val) < 0)
>  		printk(KERN_WARNING "Can't read EOI MSR value: 0x%llx\n",
>  			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

But why compilers don't complain?

-- 
Vitaly

