Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED4C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19F72076B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URZGgZAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgDUNCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgDUNCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587474165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaEA8A65Hjd1q8vy0RpNkfQhEN5T+ZQ/o66hncuahbw=;
        b=URZGgZAIS6pjZ9/5Q0VixmcbsHjMCrQYifEv56W5JqfCJoQ9ziZ9rPdYryPFmThdHCdVpk
        dfJdEpdTcWIZobUv3FFwzKkGRRh2jvrCcL2Gr6YX4IDewWq5KN6bpDimK4lTY6UEFzi8SP
        /sFU6vQ/B4R+Cf6Z/1arQOjMGIljlkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-vYck52OANe-3vSEiErherg-1; Tue, 21 Apr 2020 09:02:44 -0400
X-MC-Unique: vYck52OANe-3vSEiErherg-1
Received: by mail-wr1-f72.google.com with SMTP id r17so7455939wrg.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aaEA8A65Hjd1q8vy0RpNkfQhEN5T+ZQ/o66hncuahbw=;
        b=XSHhGSbNjwhTKT/4FxFJoy4Fz0blHBypr+1Hxh8anGdgB6jqoFQHQoWqmVbH2WK5K1
         3IhuKqOHnCJo8UFGRcfUeoytDucBOq7+w81dJeSzZQyQTsmnA8M9ssTSaMOFAvckV+HD
         mg+DiHmnAgi5wI6cIaKl4oCUo1DvxmSj4HzbMq4dHKMrc5+jwGTuhyo35YyUZXK3MJX3
         cNt5xjQcebabcix+JIZzkuOSMOPWja6w44zQ6XkIOUBa92TjAFvXltNu3D3GXSKEB5IA
         x68Tya28m3m1pto+/h+jU9u5kyM3FoxyZLE7c9AWW1HfawGQeyzVQs2IL/q2BfKp3vyW
         gQwg==
X-Gm-Message-State: AGi0PubsAMkxLN1NaZX+nCyCAWo4UwFU5MJw6t9EFIshZ2cfTMuBpulN
        rkOyiEPX+rqu7s+gfsJQF80rgUlTvn5Hcgqka2wEx4Dnds+04Bzhhm07JUFdFSixMToSkYhWRb8
        eQ684hFIER8dqUeJaZ93TIAHK
X-Received: by 2002:adf:ab09:: with SMTP id q9mr16345100wrc.240.1587474162903;
        Tue, 21 Apr 2020 06:02:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKNiKj9wds+sx5QIkXpkgfDNGj8TNZk53XoVrqBO6RLLn2LkQt5e4hi3w/czp7u6Ns5Jcm8Fg==
X-Received: by 2002:adf:ab09:: with SMTP id q9mr16345068wrc.240.1587474162502;
        Tue, 21 Apr 2020 06:02:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b2sm3941512wrn.6.2020.04.21.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:02:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/hyperv: Add definitions for Get/SetVpRegister hypercalls
In-Reply-To: <20200420173838.24672-5-mikelley@microsoft.com>
References: <20200420173838.24672-1-mikelley@microsoft.com> <20200420173838.24672-5-mikelley@microsoft.com>
Date:   Tue, 21 Apr 2020 15:02:40 +0200
Message-ID: <87y2qpq9e7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Add definitions for GetVpRegister and SetVpRegister hypercalls, which
> are implemented for both x86 and ARM64.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 1f92ef92eb56..29b60f5b6323 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_VP_REGISTERS			0x0050
> +#define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> @@ -439,4 +441,30 @@ struct hv_retarget_device_interrupt {
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>  
> +
> +/* HvGetVPRegister hypercall */

Nit: 'HvGetVpRegisters' in TLFS

> +struct hv_get_vp_register_input {

Nit: I would also to name it 'hv_get_vp_registers_input' (plural, like
the hypercall).

> +	u64 partitionid;
> +	u32 vpindex;
> +	u8  inputvtl;
> +	u8  padding[3];
> +	u32 name0;
> +	u32 name1;
> +} __packed;

Isn't it a REP hypercall where we can we can pass a list? In that case
this should look like

struct hv_get_vp_registers_input {
	struct {
		u64 partitionid;
		u32 vpindex;
		u8  inputvtl;
		u8  padding[3];
        } header;
	struct {
		u32 name0;
		u32 name1;
        } elem[];
} __packed;

> +
> +struct hv_get_vp_register_output {

Ditto.

> +	union {
> +		struct {
> +			u32 a;
> +			u32 b;
 > +			u32 c;
> +			u32 d;
> +		} as32 __packed;
> +		struct {
> +			u64 low;
> +			u64 high;
> +		} as64 __packed;
> +	};
> +};

I'm wondering why you define both
HVCALL_GET_VP_REGISTERS/HVCALL_SET_VP_REGISTERS but only add 'struct
hv_get_vp_register_input' and not 'struct hv_set_vp_register_input'. 

The later should look similar, AFAIU it is:

struct hv_set_vp_registers_input {
	struct {
		u64 partitionid;
		u32 vpindex;
		u8  inputvtl;
		u8  padding[3];
        } header;
	struct {
		u32 name;
		u32 padding1;
		u64 padding2; //not sure this is not a mistake in TLFS
            	u64 regvallow;
            	u64 regvalhigh;
	} elem[];
} __packed;

> +
>  #endif

-- 
Vitaly

