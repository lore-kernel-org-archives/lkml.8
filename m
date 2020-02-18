Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F635C34037
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6867F207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oht+dw0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRMZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:25:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgBRMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582028739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUALy/6rw/WQITi6JawN9LYVRine+PJ4kFmYbzQ+Tno=;
        b=Oht+dw0UVf6hNNCZeVStNhn2Lp5WFgPa9zhrLerzzudFk4XL5ClitIvq5zyKwHymO6wp+/
        zZ9r0O9KxOaPIcs3/GPaFCtfCjcn+g+K2mWDD61g435NAYnXCp9Ubb4jKTH8UblZmnqmv6
        h930uwpdFKM2rocFcnGViR04i5PnoHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-wkp7d5xsN-64sONjtk22uw-1; Tue, 18 Feb 2020 07:25:35 -0500
X-MC-Unique: wkp7d5xsN-64sONjtk22uw-1
Received: by mail-wr1-f70.google.com with SMTP id w6so10720187wrm.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zUALy/6rw/WQITi6JawN9LYVRine+PJ4kFmYbzQ+Tno=;
        b=Z0hyxXfqOKtuQm0ws3/2hg8uss1CNGJPVWrWsCZMNoer6rcKojvbS7ie+lPmpyvJRV
         j9fWgbwK7pr1ScRE4ecQwM6AEVlGKqzjdenDuqbQdMR0TO5Gkq/CK6y7GSTGxmeEVV2k
         THrH9cNteup3s71DKwKvyEPtwIKdsGZMmveUTfdjQPs22GJM237JcC8b4yROz9iIzYmj
         5yNDl9iF+UGUapysrKFu0k/53+16UHXAAlwCB+XfA0EoC2jLbNmmxHY/1TPwPsVQYPlb
         L8JE84jRpIlNERzOI9+ieJ0upvBklq/USPt6/kJUPCBSoZ77OqQVMBUncSMKOxfvG3CG
         bIrQ==
X-Gm-Message-State: APjAAAXtmLfS09ZbvkYLgNydmVVeClxrgNomnm9A2pxOCHPpEYBtsJiO
        9JPK4x6PM47rppw661hzMw401DXdF8GuF8usFMTWog4d3GHV3kPbG0ubYGEStDZHmCCq3hFT+dz
        QdrFpSLmnARYgom/dAfphOv/U
X-Received: by 2002:adf:d84c:: with SMTP id k12mr29071459wrl.96.1582028734673;
        Tue, 18 Feb 2020 04:25:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhU8pdbXEFSvaSqszpm3vIy1yZrm2dReINqHQSVvV2IHiG18n2f1rI2hRMmHYcZjp8GImIvg==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr29071436wrl.96.1582028734500;
        Tue, 18 Feb 2020 04:25:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z10sm3232941wmk.31.2020.02.18.04.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 04:25:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: VMX: replace "fall through" with "return true" to indicate different case
In-Reply-To: <1581997168-20350-1-git-send-email-linmiaohe@huawei.com>
References: <1581997168-20350-1-git-send-email-linmiaohe@huawei.com>
Date:   Tue, 18 Feb 2020 13:25:33 +0100
Message-ID: <87wo8k84le.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> The second "/* fall through */" in rmode_exception() makes code harder to
> read. Replace it with "return true" to indicate they are different cases
> and also this improves the readability.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a13368b2719c..c5bcbbada2db 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4495,7 +4495,7 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>  		if (vcpu->guest_debug &
>  			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
>  			return false;
> -		/* fall through */
> +		return true;
>  	case DE_VECTOR:
>  	case OF_VECTOR:
>  	case BR_VECTOR:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly

