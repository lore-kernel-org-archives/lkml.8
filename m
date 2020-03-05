Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39654C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E0720732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWVFmafN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:35:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34696 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgCEOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583418950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+FJnm7Fm4V1rR1qQ4GNpZknpP4SxNgpuyciDKENuMo=;
        b=FWVFmafNXPr4XneB5Q/VpvKXtT2PKmwNLsrxTM1COz/tJho5+D9UgxRZZUYRVCkqT9Zfth
        A6ALkvDC0artyTSnaeTXwQ0R6VAXIeHEei9J8Sv0OfhIMo9dMIRAluWT1tkPiKln2WUhhb
        luEhlFMzD2UjkUNQnCkluhFSGKRnLWU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-GOVhq_AEP6WnAvJ8fpOyJQ-1; Thu, 05 Mar 2020 09:35:49 -0500
X-MC-Unique: GOVhq_AEP6WnAvJ8fpOyJQ-1
Received: by mail-wr1-f71.google.com with SMTP id t14so2371549wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m+FJnm7Fm4V1rR1qQ4GNpZknpP4SxNgpuyciDKENuMo=;
        b=tTECGhXiCKqivnggL5bUWwHGh+MhVU1wT+NM6Eo7EnizVKBR1cORyBdFUY/FXSGG+d
         jzN+Ew0DXAwFtzD3rZfeutaamNM/ph88J1+BMTthNoWaLJ1RU+1fUO2xmIaN0Ookzv99
         WAprTlP6sapKDGy8dq0pr6AO8a8x8ruB/8aP/pROQJZY5/aH6L9XQu1qmYcKliaDTaUo
         +8kdckeyGUYdC0MN36s1qLuqJHtigew7CX8EOwTUeKIG3UlbnLotba9Dd/iQQF0xd4iL
         BWRnkWgwZ6YCe4obMWOmfii8E/xgWMTNgt5dbWJQgpcd1KOutUZszLqiJu+P+2+4xc/l
         RK2g==
X-Gm-Message-State: ANhLgQ3uLJkmkVL6kFWGYuz14pe4WnenPGrfX4taZyJyRjLLnta6weIw
        6ZqO6iIyTRZ8etSiBl/OlJuMqxJVchW2LeVZoAQsN23yzjBbgrkkGbRN1Xin3LIRPjewj4SWZNM
        KImYxhLApEvuBEgHx/oVE6knj
X-Received: by 2002:a1c:df45:: with SMTP id w66mr9864507wmg.171.1583418947819;
        Thu, 05 Mar 2020 06:35:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsXRoDPOxh+lCD/rkrCx71ZIw8ngiGyWWdgfROAkX9kpjzShuavDX/8KrTgguqrRQ1r1TPNtA==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr9864473wmg.171.1583418947539;
        Thu, 05 Mar 2020 06:35:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id h20sm23970095wrc.47.2020.03.05.06.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:35:46 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: small optimization for is_mtrr_mask calculation
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1583376535-27255-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b678644-fcc0-e853-a53c-2651c1f6a327@redhat.com>
Date:   Thu, 5 Mar 2020 15:35:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583376535-27255-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 03:48, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We can get is_mtrr_mask by calculating (msr - 0x200) % 2 directly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/mtrr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
> index 7f0059aa30e1..a98701d9f2bf 100644
> --- a/arch/x86/kvm/mtrr.c
> +++ b/arch/x86/kvm/mtrr.c
> @@ -348,7 +348,7 @@ static void set_var_mtrr_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
>  	int index, is_mtrr_mask;
>  
>  	index = (msr - 0x200) / 2;
> -	is_mtrr_mask = msr - 0x200 - 2 * index;
> +	is_mtrr_mask = (msr - 0x200) % 2;
>  	cur = &mtrr_state->var_ranges[index];
>  
>  	/* remove the entry if it's in the list. */
> @@ -424,7 +424,7 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  		int is_mtrr_mask;
>  
>  		index = (msr - 0x200) / 2;
> -		is_mtrr_mask = msr - 0x200 - 2 * index;
> +		is_mtrr_mask = (msr - 0x200) % 2;
>  		if (!is_mtrr_mask)
>  			*pdata = vcpu->arch.mtrr_state.var_ranges[index].base;
>  		else
> 

If you're going to do that, might as well use ">> 1" for index instead
of "/ 2", and "msr & 1" for is_mtrr_mask.

Paolo

