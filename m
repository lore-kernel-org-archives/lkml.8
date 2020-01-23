Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208EAC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79A522522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBw4nAeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAWITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:19:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728205AbgAWITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579767540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bysCcDvz/jfiZfCpE98ZIttDvvt27rdUT5PWLkNOfig=;
        b=ZBw4nAeXivrRa7Jwj367RgvLmLVqbmLSX09//tDKoqcb4HqOvX1fCgigjdFT+NHJ1WIabq
        OKulI97B8IRljTy++pIkQENMAXI6g7hjTyyQmPL69Md/oD/2WPT1OR3kg9sT3WXhv1Ricg
        Wx8CBf31/yq0JaItSGhdg/xx8WS6PRY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-8hoNFMOvO2COHb3wUZ9eTg-1; Thu, 23 Jan 2020 03:18:59 -0500
X-MC-Unique: 8hoNFMOvO2COHb3wUZ9eTg-1
Received: by mail-wm1-f71.google.com with SMTP id l11so428958wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 00:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bysCcDvz/jfiZfCpE98ZIttDvvt27rdUT5PWLkNOfig=;
        b=jg6dFn/0AC9icsOHoVWfnawFMEbI/eqTDQmyHuvOW7E9UYqbGoVlHUXLOYMD2Fdhfu
         zlTmsDtNqTQLhE2dtSK6pHEfKuiqqiFZSnxsbBEZeeQ0ydBTucylEI+MlVwoaBXr/oiE
         CaO0ROe0oBb6pDnt8HMESLWmGUprsb/o8XqVyV2tU/gWoUu+xRg5+/g8GQ7/t5O2NKXx
         /xx+lqlKw7hPA6FNNcjxLfo77nS+TzxF+vRwiBKRlz3ki5gWdq34DRpvNhbfms06mmQ1
         N5D5311xgm9UC47sWhHYfFsJ4SVcGIB9lLsrnJIAmCzZhbExP99W5dWGGQOAgoGnaTQX
         XzJw==
X-Gm-Message-State: APjAAAVB5b2wYReTBe9cO8H1p5OA1DVPl/53fka+xpc1HHyJRudYHjP8
        lBy6KIpk3vu8/hI0cHxtmp7qehK875gLqjLab5lFLbVaIOmo2M+OXly1qJpVALvfoAIKuh8U/LC
        ph5BDoAWCKpK1kkkrL3VJVPTY
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr16502170wrm.345.1579767538340;
        Thu, 23 Jan 2020 00:18:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwNFQVhHKQZr8hBPP16Ectz0uGnw/P9B76b7XHQvlf45dLRX4kMNIvzwba00hvwIxTzZLG/g==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr16502152wrm.345.1579767538096;
        Thu, 23 Jan 2020 00:18:58 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x6sm1627676wmi.44.2020.01.23.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 00:18:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: nVMX: delete meaningless nested_vmx_run() declaration
In-Reply-To: <1579745300-13029-1-git-send-email-linmiaohe@huawei.com>
References: <1579745300-13029-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 23 Jan 2020 09:18:55 +0100
Message-ID: <875zh2shzk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> The function nested_vmx_run() declaration is below its implementation. So
> this is meaningless and should be removed.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 95b3f4306ac2..7608924ee8c1 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4723,8 +4723,6 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  	return nested_vmx_succeed(vcpu);
>  }
>  
> -static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch);
> -
>  /* Emulate the VMLAUNCH instruction */
>  static int handle_vmlaunch(struct kvm_vcpu *vcpu)
>  {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

