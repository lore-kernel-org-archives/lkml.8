Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE12C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0D217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U093wRe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBEQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:57:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27207 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726748AbgBEQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580921825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxFkSdvrYLxIEAwQWaBaRc6nRKIPOYjssvLU1SdT+6A=;
        b=U093wRe37lr9NqEC+BhSd4vcVng3O56aQ2w9MBM5ZIXcBCK7WbjxkCrBjZ9k+5KsElccw/
        Qe6CIH4t7hxzvhU8hZlAnZ16ojZl5/c8mCLoSNmW3OlAcgbmB2tCZvvYPM//ZrCLFCcTMf
        xAQ0SxNKJNYStoduFBgqp9DXUlMZJVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-UXIawgWcNUGU1yXfJPM82A-1; Wed, 05 Feb 2020 11:57:02 -0500
X-MC-Unique: UXIawgWcNUGU1yXfJPM82A-1
Received: by mail-wr1-f69.google.com with SMTP id s13so1464384wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PxFkSdvrYLxIEAwQWaBaRc6nRKIPOYjssvLU1SdT+6A=;
        b=VL8Xp62HOjKkqAvcM0QrVEEsIWw/ByRzAfkEEEZcZyXbhXsPXIeNgs2KcsLpguIMMp
         AcS32Xyfd34x406FHE5jmn4/yR0w8lSxKkvCrEO6TqdHukJev04x9AK+CkGhvyqxSuem
         QPOPAoUeYIYVBvNjvu7zrNOzYd7BaVf3K4WI2iANmq+43z4xZBzCo3JxfzKK1JdkNpxr
         XhPm3H5RKs/j78U06zoH67NZ4+Mt0uLPq23398YvUuH3MPDsqzzTF3VBuXD1MJL5gmLV
         egImVTRaM+NPafeF9lvOOcIFPrUScqwWvh/BF2D6dvPEQ+FkDNgXxL/rSPSrSxGN9F6c
         wpqA==
X-Gm-Message-State: APjAAAXKO877wk3tqOFWywzq02z+WGLJ4AJvX0JSlzAtnVDuJy5nfH3z
        3fOC7V+fDd/9rJiNYQE0zPEzuA2l0YRDKkDXOoDq7Y/2ADDeONM446GnYbAJ8Pymbdv8sGyBuDj
        po3MIDxE4RPUoStdaKDi7c/Q2
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr4617855wml.50.1580921821171;
        Wed, 05 Feb 2020 08:57:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6o+ESIGmO/3zFWtD1tm/ePiEllQhG+yeSmmbQ8rnxhegcVzud2hRMO5aLmfS0Rt3YXlUp7A==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr4617845wml.50.1580921820988;
        Wed, 05 Feb 2020 08:57:00 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v14sm559308wrm.28.2020.02.05.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:57:00 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: vmx: delete meaningless vmx_decache_cr0_guest_bits() declaration
In-Reply-To: <1580916833-28905-1-git-send-email-linmiaohe@huawei.com>
References: <1580916833-28905-1-git-send-email-linmiaohe@huawei.com>
Date:   Wed, 05 Feb 2020 17:56:59 +0100
Message-ID: <87r1z9j7l0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> The function vmx_decache_cr0_guest_bits() is only called below its
> implementation. So this is meaningless and should be removed.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 678edbd6e278..061fefc30ecc 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1428,8 +1428,6 @@ static bool emulation_required(struct kvm_vcpu *vcpu)
>  	return emulate_invalid_guest_state && !guest_state_valid(vcpu);
>  }
>  
> -static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
> -
>  unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

