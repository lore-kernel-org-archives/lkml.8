Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC7206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LabYeO3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGUIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727935AbgGUIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595321218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpXiietiHo/uebrG4FqVDk0/hTImFXNdoWg6rWOirEA=;
        b=LabYeO3jDvUbGxb7c0+ltyUz574QOMzWDojwFU1cGWfd4pxGWZqW6YnoGHdPBAbGum4w08
        jPCxts04NXJ3JcpxDRFPmTag5eUg9YCfDeXBfDOPJsG/3BfPkP6iL9n/opil4yhaRpZLZf
        +eZsnzVe6c73KT/M9IhUAg3qxROcgXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-aSAwTXFQOdCYoK3XRuLjxg-1; Tue, 21 Jul 2020 04:46:52 -0400
X-MC-Unique: aSAwTXFQOdCYoK3XRuLjxg-1
Received: by mail-wr1-f72.google.com with SMTP id e12so1762477wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GpXiietiHo/uebrG4FqVDk0/hTImFXNdoWg6rWOirEA=;
        b=dGz9HBaBlIB15pxh8//WToqKo0M5rbRVSXhRQqyKmohDe6O2zh20C+NeEubdwQz15X
         Q3Y0g5g2JVtsAaZnUYtzUYYBZX3tn4Kppz7hmvEuxkQuLywYmbldTDLKBWPjJ2XiKK89
         jEszmt7AqiLKEKXGM1WY70tk1mxybJ6qxfWWYlE1kY5+B0mt7GsJh+ewbw8w9fJCl77W
         bqT8VvrVUUd8BhFSMVEynnm7G02BD4euRf23DZy1ERk4/KwNMqZt2Pm09ZLvr4ATfdpr
         9b/rIgC4IOhoXrYQhz3zwqrpLHK8xlcnvK32ufExc8YjajzxlW1+Sit9PB29crfx68xL
         jNuQ==
X-Gm-Message-State: AOAM530f9cUmgtQF9kECw5Bq++jY5AEnxJ62pygDQIFq49Y/zOFSJ9rT
        iwAbQ5CXwviPVI/G30HgdANIjIcM4HMw7McafQTe4Ro3fvAxNifPchDcG0viJ1tixcsgCNDHOax
        lV8Czzk7pOlNatf/aWU0x1gcU
X-Received: by 2002:adf:d08d:: with SMTP id y13mr5657128wrh.313.1595321210866;
        Tue, 21 Jul 2020 01:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSoX0Zk8SgUFV/+ujTmFHSuwajjuxuCf1dMZIdKNE9RX8hdTDqEE63PdpE9IZfAbOOQXS+ug==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr5657106wrh.313.1595321210666;
        Tue, 21 Jul 2020 01:46:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b23sm2680832wmd.37.2020.07.21.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:46:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: Using macros instead of magic values
In-Reply-To: <4c072161-80dd-b7ed-7adb-02acccaa0701@gmail.com>
References: <4c072161-80dd-b7ed-7adb-02acccaa0701@gmail.com>
Date:   Tue, 21 Jul 2020 10:46:47 +0200
Message-ID: <87tuy1p85k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

> From: Haiwei Li <lihaiwei@tencent.com>
>
> Instead of using magic values, use macros.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>   arch/x86/kvm/lapic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 47801a4..d5fb2ea 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2083,7 +2083,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, 
> u32 reg, u32 val)
>
>   	case APIC_SELF_IPI:
>   		if (apic_x2apic_mode(apic)) {
> -			kvm_lapic_reg_write(apic, APIC_ICR, 0x40000 | (val & 0xff));
> +			kvm_lapic_reg_write(apic, APIC_ICR,
> +					    APIC_DEST_SELF | (val & APIC_VECTOR_MASK));
>   		} else
>   			ret = 1;
>   		break;
> --
> 1.8.3.1
>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

