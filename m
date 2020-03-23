Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4919CC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDDC20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USfXImCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgCWMsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:48:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41046 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgCWMsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584967691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZZMumaLZJu5X3TxC1ggPEB/siyDp674fd3PHOwNKOk=;
        b=USfXImCFJKadRb001iHR6e1rBoAlfR0GSqjryUxPGTwN1Z1W3SiA6dtMbnEGioY+uGKXYv
        ZlZ4pJQvOkAdc7zn9QpSqdIPTLChLZJpr2MXq4AYt0Qy2OSBD7TttHrL9tpWTAiHHBTuP8
        tfCJbqdZHmruWzxehVs9raf6VVKeP5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-43zl1JrJPmqfMa_dQ5sFVw-1; Mon, 23 Mar 2020 08:48:09 -0400
X-MC-Unique: 43zl1JrJPmqfMa_dQ5sFVw-1
Received: by mail-wr1-f70.google.com with SMTP id p2so7315561wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oZZMumaLZJu5X3TxC1ggPEB/siyDp674fd3PHOwNKOk=;
        b=po1zwL/JKOHQc/Iygw1MRbU8VKoTB8A1DJfwMVCIQRd0S93QM4+NHsjlNOQaBwTdpr
         uw6Lagm2Jm2bl5cZCIhrpjKHnNw9fxWwJusfdAmVVLixZO7SXZIEAXsW1CMuBQ1nGvLR
         11JMtwaVwwMvXoxrdyQYL6Xn9UYktD63pDkcgq3wetNU3YR3Mfj/4Eu0vmfyF9Ti2lDN
         HQ67MygBiBFftue9LP3H5gTQIdiiubi6YYJIEXsenSG8cbXFFu0Xudu64ieRK4Pp8qvx
         qXZEqYlf2SX3nC+oDNyrebuQly6CD2rX/e5nNYWjiVJ4+mWaEUq2JynNYa6cqFWSP1x/
         e5cw==
X-Gm-Message-State: ANhLgQ2UvxVOeDIQHucwWURDniimgWTh2g/WMk+pj0drWKGw9ReZ8dKi
        m/M4NGSuAHtfg8g/v4+0oZ3ilDbHL9tyc+2y+zaeyO/7FxPVK5uSkNqS+6IRBF+r36YwONwMgYJ
        tQgfPlc8vKCd097vPuuVsDMgF
X-Received: by 2002:adf:decf:: with SMTP id i15mr26153365wrn.277.1584967688273;
        Mon, 23 Mar 2020 05:48:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtzfkKiGqY46hQmyiE1uEEqN2+GnJhVE7scycSa3L2yRyeY3La61RQMFCIJXOpzJGHNoWPMLQ==
X-Received: by 2002:adf:decf:: with SMTP id i15mr26153331wrn.277.1584967688007;
        Mon, 23 Mar 2020 05:48:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m12sm15324212wmi.3.2020.03.23.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:48:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] KVM: VMX: Annotate vmx_x86_ops as __initdata
In-Reply-To: <20200321202603.19355-9-sean.j.christopherson@intel.com>
References: <20200321202603.19355-1-sean.j.christopherson@intel.com> <20200321202603.19355-9-sean.j.christopherson@intel.com>
Date:   Mon, 23 Mar 2020 13:48:05 +0100
Message-ID: <877dzb9r0a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Tag vmx_x86_ops with __initdata now the the struct is copied by value

Typo, "now that the struct".

> to a common x86 instance of kvm_x86_ops as part of kvm_init().
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index fac22e316417..eae90379d0d1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7668,7 +7668,7 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
>  	return supported & BIT(bit);
>  }
>  
> -static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
> +static struct kvm_x86_ops vmx_x86_ops __initdata = {
>  	.hardware_unsetup = hardware_unsetup,
>  
>  	.hardware_enable = hardware_enable,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

