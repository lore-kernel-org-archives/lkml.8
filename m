Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10076C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9F62073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOIeizyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCELtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:49:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgCELta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583408970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjEqvtB2T3AtCQceC0s+9bXMXtVod456eAE+2om8cIk=;
        b=SOIeizyGvYWj68f4RSRcZb/HaxrU+Ik5AX5PlpS4FCuhl2skEbCDm3QJPsrEyOuxKcKEk/
        4pUjQCR9rA4kBJslGlSJ9/6XDdXZcK5Fw8yDJknKsaFiM5Lc01otBM+lqPoFZx5udmn+Ju
        FHN/U/sMusFni08Vk7hi/DtJu5dZid4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ngi2RAUtPYe8VXkTWGKpDg-1; Thu, 05 Mar 2020 06:49:28 -0500
X-MC-Unique: ngi2RAUtPYe8VXkTWGKpDg-1
Received: by mail-wr1-f69.google.com with SMTP id z16so2188041wrm.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 03:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjEqvtB2T3AtCQceC0s+9bXMXtVod456eAE+2om8cIk=;
        b=hTWSvfDBLkgh1o0uddBljrOqaFfTnUB1GD5HbzjTjNTtY+njLjAA03VcW4dKEBzlqc
         1RnTbInUQrmeWEN1AEPLVkt7G9weIxO/8RdmjHseQd2p0197ZUz81ZvTuicrFgqEovMB
         0+3xNMptsubEUtYcl8lk73xIXAdo6vbZlCzmRL9WINWUDz+vogMyVQfK7iCHWRbF/uab
         +kwvKt7TrK+P4Z4LCtAWamgrnj/sFA+jbvxbpNSqm2D+YYJd4AtvGVKbt+a0kTtzH2Ox
         6yktnGL2HI1a8NJBj5d+bXDg4ow/i0latD5D9qg4LiWsIQYNAoVuzGoDhjuSgUtg22sT
         moWw==
X-Gm-Message-State: ANhLgQ2Oe6soz/4RCtHclqb76mIYevYeYLpOvvoIh714Xz70sPtCq6yT
        81Ekr6aQDvrQoiXknwIpTSYkUFMsVV/JNd2NXlzp9wrHG+R2tasIsH5pocV2ZJhJC64SKKAWwzS
        5FE4pbxaQCmi++Nnz0Y5GvkoL
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr9700616wru.336.1583408966553;
        Thu, 05 Mar 2020 03:49:26 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvWp4hDVBVG1qtAYBSlwG0TuP+swcJOdAhM8+FTa0BbErmeYy/trLgrnVFpjM/xmz56FptGfA==
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr9700595wru.336.1583408966345;
        Thu, 05 Mar 2020 03:49:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id n3sm9523174wmc.27.2020.03.05.03.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 03:49:25 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro
 ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1583375731-18219-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5aaab6f-8111-8d12-754f-027989fd4b06@redhat.com>
Date:   Thu, 5 Mar 2020 12:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583375731-18219-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 03:35, linmiaohe wrote:
> (X86_EFLAGS_IOPL | X86_EFLAGS_VM) indicates the eflag bits that can not be
> owned by realmode guest, i.e. ~RMODE_GUEST_OWNED_EFLAGS_BITS.

... but ~RMODE_GUEST_OWNED_EFLAGS_BITS is the bits that are owned by the
host; they could be 0 or 1 and that's why the code was using
X86_EFLAGS_IOPL | X86_EFLAGS_VM.

I understand where ~RMODE_GUEST_OWNED_EFLAGS_BITS is better than
X86_EFLAGS_IOPL | X86_EFLAGS_VM, but I cannot think of a way to express
it that is the best of both worlds.

Paolo

 Use wrapper
> macro directly to make it clear and also improve readability.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 743b81642ce2..9571f8dea016 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1466,7 +1466,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  	vmx->rflags = rflags;
>  	if (vmx->rmode.vm86_active) {
>  		vmx->rmode.save_rflags = rflags;
> -		rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
> +		rflags |= ~RMODE_GUEST_OWNED_EFLAGS_BITS;
>  	}
>  	vmcs_writel(GUEST_RFLAGS, rflags);

