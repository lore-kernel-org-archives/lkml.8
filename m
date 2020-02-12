Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85B7C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C060420675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVpL90OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBLLpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:45:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728099AbgBLLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHa7p/GKnBvLzuu4QbsQ7jX/HvnO0aLikEJRRufEnjE=;
        b=jVpL90OBLhGoK3xQiG6dz6Wa8tmCguw1lzAzc6BmurKRXqOQeWTZ6TcvrzNQaX2QrHusZC
        rUYNY44pVa9aSpCZgaJ/csc9h1TVMzPxZ+ieNzdAbYGz3m1pFxzxENNKZU3ZId+fyAa8G/
        h1s+uTT6+jynKO2AD9pAtK1BwvBWpf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-e6Dw7l45Pb6WF0dPnZoDiA-1; Wed, 12 Feb 2020 06:45:39 -0500
X-MC-Unique: e6Dw7l45Pb6WF0dPnZoDiA-1
Received: by mail-wm1-f71.google.com with SMTP id p2so846940wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xHa7p/GKnBvLzuu4QbsQ7jX/HvnO0aLikEJRRufEnjE=;
        b=hbDwxbwGkgNm6VCAILnpjU6kFoRWTtRcFPF4lS0VL9nIwrNYLexLIHhauxBhtBCESY
         TOMmTveGA6mF4UBROCJQqXIQvNdrsT4VylrggGCksRSRY9RfMGSepoOrcfAA3bTdLnhB
         cLc8aSreqMchq4zaAUr3et3brr622YV+jYPCUiSkAum+I5uF4dUGYt3ll9U6CbxgldEg
         /P1Wrn6Y6pN0FsiEx53vVGet8+qUh2U2njG76j9GxupNEYc+ZbLgEADak9/KQ7/YVKnW
         HB1KyNkNGwWDTkQiWhgNzQvbIho6/8rRqSwyDbNco8La5BZs4nLa3kzPTEk4ls0pxIz+
         Cfjw==
X-Gm-Message-State: APjAAAUptnQny5F6qqhu+rxDIwlwt/5FclFUlhSiHD0iywC92omeGHjH
        QV9gKlZmQqNZ5dOrqxwZZsl6e09UsrN13aItXQXG+wCrmJo0a1oqqVSOG6WWb39dHLWVZkBJCBa
        LxBloBjpWhk6GwSV4xQKI5XtW
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr15120666wrq.104.1581507937026;
        Wed, 12 Feb 2020 03:45:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqymgry8s5CPyNlN/xpDmM97UGbnWzc/qdRpwVaty0USC4aB2hAo5lCGpzT0Ossub3L7KFkQWQ==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr15120639wrq.104.1581507936776;
        Wed, 12 Feb 2020 03:45:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id r5sm297552wrt.43.2020.02.12.03.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:45:36 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86: remove duplicated KVM_REQ_EVENT request
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581089271-3431-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55eb3a20-9660-4155-1e2a-ece8b31dbbfc@redhat.com>
Date:   Wed, 12 Feb 2020 12:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581089271-3431-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 16:27, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The KVM_REQ_EVENT request is already made in kvm_set_rflags(). We should
> not make it again.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> v1->v2:
> Collected Vitaly's R-b
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..212282c6fb76 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8942,7 +8942,6 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  
>  	kvm_rip_write(vcpu, ctxt->eip);
>  	kvm_set_rflags(vcpu, ctxt->eflags);
> -	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(kvm_task_switch);
> 

Queued, thanks.

Paolo

