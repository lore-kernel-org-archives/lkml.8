Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9DC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491A9208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3o3rbnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEGT2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:28:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35976 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588879694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9obrI+I5ySmag9Pa2ybFm1Lh3tAlP9Wg1QXo7JHVYM=;
        b=Y3o3rbnzf7mPu1EQGYeWPRg1C8Qgz/rSHXPkgwL7jAj31/VK0oZmaqzU5MjekJi4vJNXVq
        tt7WX+7kF+bIZL/Z1OlkeJenZibv4kW9AVA3HClgbaLfUfNS2PIdJa4UvaYaqfwJnO4boX
        C0W2QQaqUE+Bl+EJqrHw0kHN/uh3WYw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Ks9XDQMiNdGgVmj6UVtq7A-1; Thu, 07 May 2020 15:28:11 -0400
X-MC-Unique: Ks9XDQMiNdGgVmj6UVtq7A-1
Received: by mail-qt1-f198.google.com with SMTP id w6so7927409qtt.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9obrI+I5ySmag9Pa2ybFm1Lh3tAlP9Wg1QXo7JHVYM=;
        b=X73DQ8S7nVkD9Gq/m2UQDwQ87220vsjbD9InZqH93hyJ/l2kxx+DhgkYv0fekbTrZW
         Ri2io0KothGdNOwyjwr24+9ryKOYiLVlWbNzTXXv4Ukm/PoERmG6nfRvAAFcE/Zgfpky
         t3HEjZfRgsdNbpj/IYeE/IRuCuJ0rma62NYLpaidmWOvLJAfP5SHKXMTjC+soAZHmOZ+
         lFf4HFRuvfqsfwZ1i61Mtf9H/3bBkkxxmDaRVIeUmm5mGbO6dAUgkdwcULCn0dUizhT2
         PzXL4SmzPd2BNQM9wCBOrTubC/F7QT/Vio7OqvvlzDM/6dQlCArCqlT8vpoDjTABEEPf
         /gbw==
X-Gm-Message-State: AGi0PuZLGXekRgChtDtIXtXzScoosX/j+x5eDpPeRcyWNxlGqoprfqAG
        8pjcXgQRYRsjSG5f0OUmoX8XkOMFQNL0iazTTQjDlLBQe8HPWhnmjg4JLWCZGiTGYaUM5El7x0y
        xBmN1jOClhaUwPm3/v2OYjtZc
X-Received: by 2002:ac8:27b4:: with SMTP id w49mr11286824qtw.111.1588879691164;
        Thu, 07 May 2020 12:28:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpH33jmgoLRBXKHI5mRYHl+RR5ikyN0bvOn1bz5L/I4wON5UkdlgUfdaK8Jrk2hZUurzzYGQ==
X-Received: by 2002:ac8:27b4:: with SMTP id w49mr11286802qtw.111.1588879690866;
        Thu, 07 May 2020 12:28:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id q6sm5111564qte.72.2020.05.07.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:28:09 -0700 (PDT)
Date:   Thu, 7 May 2020 15:28:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 8/9] KVM: x86, SVM: isolate vcpu->arch.dr6 from
 vmcb->save.dr6
Message-ID: <20200507192808.GK228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507115011.494562-9-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:50:10AM -0400, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1a547e3ac0e5..9a2a62e5afeb 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -633,10 +633,18 @@ static int nested_svm_intercept_db(struct vcpu_svm *svm)
>  
>  reflected_db:
>  	/*
> -	 * Synchronize guest DR6 here just like in db_interception; it will
> -	 * be moved into the nested VMCB by nested_svm_vmexit.
> +	 * Synchronize guest DR6 here just like in kvm_deliver_exception_payload;
> +	 * it will be moved into the nested VMCB by nested_svm_vmexit.  Once
> +	 * exceptions will be moved to svm_check_nested_events, all this stuff
> +	 * will just go away and we could just return NESTED_EXIT_HOST
> +	 * unconditionally.  db_interception will queue the exception, which
> +	 * will be processed by svm_check_nested_events if a nested vmexit is
> +	 * required, and we will just use kvm_deliver_exception_payload to copy
> +	 * the payload to DR6 before vmexit.
>  	 */
> -	svm->vcpu.arch.dr6 = dr6;
> +	WARN_ON(svm->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT);
> +	svm->vcpu.arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
> +	svm->vcpu.arch.dr6 |= dr6 & ~DR6_FIXED_1;

I failed to figure out what the above calculation is going to do...  E.g., I
think the old "BT|BS|BD" bits in the old arch.dr6 cache will be leftover even
if none of them is set in save.dr6, while we shouldn't?

Thanks,

-- 
Peter Xu

