Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FBCC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F65520656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+nb5LY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgBQRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:13:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgBQRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvr7zosO7XOdlphEaMtlcsDU2QFGlchxOoZ2XJ+sfA0=;
        b=N+nb5LY2AMIvvt1qePZLKPXwPw+SanZb25pja0W6AiayNKEvdk1p6sLKi8Ht10lgzVvNP6
        Bs2gYmTTzBH0v5Qkk57nCc1cHyIFEd7I+QMx5Ucfo4+kBYzfsKpmahotBTtAyg5e8wpb9g
        jcHpzYPJqmIIipWNcLVqQmoAbcC7+yM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-p-MiJ9dcO4Ghapn10HhIuw-1; Mon, 17 Feb 2020 12:13:42 -0500
X-MC-Unique: p-MiJ9dcO4Ghapn10HhIuw-1
Received: by mail-wr1-f71.google.com with SMTP id w17so9278424wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvr7zosO7XOdlphEaMtlcsDU2QFGlchxOoZ2XJ+sfA0=;
        b=lVf05gSr1z2yjcSp+SnYcClFPfa0cFzy2wPzb6UlURJ3Sa4URUOSTkGTydQRk+4Tat
         00x8JOZ8URRWdfll2DwtYf4LHA7y5mGmAtzI189lEPT1p49gjH6tgfp1SjHriDP2OXxz
         EWT8F5JDDqxYZ4WxJmRNQj1W/9dQNAMUR+uY4L6QaNXaOL1hJZMhOd92UIiTchy3oYkG
         aQhtv0gG5H4sz+1Pzr2UUf/sF/jk450gAJB1d8IPqfDXv+K7rJsvY1+DZX7TeWd5FbhU
         9evCtrxHux2EnO/xL/AiHnl5Htv38BzY2wl2qHhHNIwrxEO3L0rw77XqivlrELy0/IUP
         wPIQ==
X-Gm-Message-State: APjAAAWBg9YzmkPhhPjRtNbCxX+dzqGckdJyK2LmVnfvKyCADVcS45zZ
        +PcUdp+bgjS0fxyctXqeRYuiK9PNX28109s6Hep2wylwgnHxJq/C3To1E7FbqKCH6yacaOFRKHi
        r90JLtgS4qT4hWYulWrEs1QHc
X-Received: by 2002:a5d:4289:: with SMTP id k9mr23874622wrq.280.1581959621315;
        Mon, 17 Feb 2020 09:13:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOSN9Nebz0glINr0cP2RhJRrWjeL0Lcx1XGFRkQ6RFQce1iHmupUMsZFekj+Py6SXpZywzVw==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr23874595wrq.280.1581959621047;
        Mon, 17 Feb 2020 09:13:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id z19sm54313wmi.43.2020.02.17.09.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:13:40 -0800 (PST)
Subject: Re: [PATCH] KVM: apic: remove unused function apic_lvt_vector()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
References: <1581561464-3893-1-git-send-email-linmiaohe@huawei.com>
 <2fb684de-30c1-ed67-600f-08168e64d6c7@oracle.com>
 <87blpx9mfw.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8d6f864-7014-64cf-da3a-3761385f123b@redhat.com>
Date:   Mon, 17 Feb 2020 18:13:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87blpx9mfw.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 18:02, Vitaly Kuznetsov wrote:
> 
> Also, apic_lvt_enabled() is only used once with APIC_LVTT as the second
> argument so I'd suggest we also do:
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index afcd30d44cbb..d85463ff4a6f 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -289,14 +289,14 @@ static inline void kvm_apic_set_x2apic_id(struct kvm_lapic *apic, u32 id)
>         recalculate_apic_map(apic->vcpu->kvm);
>  }
>  
> -static inline int apic_lvt_enabled(struct kvm_lapic *apic, int lvt_type)
> +static inline int apic_lvtt_enabled(struct kvm_lapic *apic)
>  {
> -       return !(kvm_lapic_get_reg(apic, lvt_type) & APIC_LVT_MASKED);
> +       return !(kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_LVT_MASKED);
>  }
>  
> -static inline int apic_lvt_vector(struct kvm_lapic *apic, int lvt_type)
> +static inline int apic_lvtt_vector(struct kvm_lapic *apic)
>  {
> -       return kvm_lapic_get_reg(apic, lvt_type) & APIC_VECTOR_MASK;
> +       return kvm_lapic_get_reg(apic, APIC_LVTT) & APIC_VECTOR_MASK;
>  }
> 
> in addition to the above.
> 
> -- Vitaly

Sounds good.

Paolo

