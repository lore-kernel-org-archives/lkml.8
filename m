Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6529C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841F720709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sds5eDkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgERKwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:52:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43324 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbgERKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589799173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7i73MdO6mSnLJfSeLQzf3Paj06/1AUhoEWhZbMxx9q4=;
        b=Sds5eDkSDDBKiEruJAxlEAMvXfj1nRHniI33DRO+keO2JLxkaplN2vDsEPW1/tstDfGo0d
        lO+v1263d3xH2VieU8V+Qu7+ToatFCAf/PeTRgzPwLVzgBWNjkcICG60qGpfnXV4V/7dax
        ukeJyYcvD9JotL1JuKk3/7ZVT7UV1fs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-q_fNrSQ7NEWOhYgI_w6_Tw-1; Mon, 18 May 2020 06:52:50 -0400
X-MC-Unique: q_fNrSQ7NEWOhYgI_w6_Tw-1
Received: by mail-wr1-f69.google.com with SMTP id e14so5473154wrv.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7i73MdO6mSnLJfSeLQzf3Paj06/1AUhoEWhZbMxx9q4=;
        b=CFOzWjkPxi9x6D5Z8IcBhv9KEPKPzPJlBPAj/XAht33gnTE+icaZ3ZfeZ7WQ+gULDt
         i+5QcNKbQ5rxoQ3zuo9z3tM6CnKkBE+tZlA+DPDNZWS/Bz+wVQASHuIFvkG/xFIccc/9
         bOILPlEF8pnE3KhnAhqLNGw3JClsDQXOG0a+3PWrqHaZV+D8lY8+PdngARgy2g2VSurS
         Aib213H65WPlkUI/OQ3U5Mb3RfH1ZAJb2plF6LG+Eb4dp/pcyvvuqTHyLH6lEwkZ7sC7
         3I5/jGzbcKWO0iJkNBkxc+y7wMr3VnvY1awn9QevanPd65v0aJX1v5J0j59kxGU55Mbw
         MLvA==
X-Gm-Message-State: AOAM530BlYepH6oU91Kgja5YFaqSvbFMhYT6YUFCpyhzR7oWgnwaf8FW
        XomKa/nfedEATAEwhqdgjjp1AYMdrnA8o/Dx88N98Kh0gJG7F+91+e3j12AbEaFgzrVhJhhTRcA
        RBFft2YaYZXfslBFiCNKoR6AD
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr13204927wmj.118.1589799169119;
        Mon, 18 May 2020 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb5bJSjhIwujoAPyEeSV2lEHQs6rr/TIG41qjwncep2S48dLrjzAAz5OSj0DtYMHlyn0kYKA==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr13204900wmj.118.1589799168906;
        Mon, 18 May 2020 03:52:48 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id x17sm15630846wrp.71.2020.05.18.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:52:48 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: VMX: replace "fall through" with "return" to
 indicate different case
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1582080348-20827-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50b2bf9b-d4c3-e469-1ef9-3d58b44f4de8@redhat.com>
Date:   Mon, 18 May 2020 12:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1582080348-20827-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 03:45, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The second "/* fall through */" in rmode_exception() makes code harder to
> read. Replace it with "return" to indicate they are different cases, only
> the #DB and #BP check vcpu->guest_debug, while others don't care. And this
> also improves the readability.
> 
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a13368b2719c..5b8f024f06c2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4492,10 +4492,8 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>  			return false;
>  		/* fall through */
>  	case DB_VECTOR:
> -		if (vcpu->guest_debug &
> -			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
> -			return false;
> -		/* fall through */
> +		return !(vcpu->guest_debug &
> +			(KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP));
>  	case DE_VECTOR:
>  	case OF_VECTOR:
>  	case BR_VECTOR:
> 

Queued, thanks.

Paolo

