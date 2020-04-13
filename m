Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8526D20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L22luGuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgDMJNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:13:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57968 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgDMJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586769229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ushgHlBusXZ5xLnyH3insFe724nmN2oRiWHOqt2DcZI=;
        b=L22luGuojAtovYD03qK8xwkA+AbMKpewFFq80SPM9F3CwdK2BcclObraI7vAZgAGQqYvDL
        GjCep9jQH350UOvzjyNGJ86wWnsToPiW9sCyuLcjdwSJa1go0RcgdqJOrE62bs0t7WzOZm
        iCk2hsbkKPdqZaIF275QBsc0XQQGZ/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-vMAtjbFbNkOiCYH_RgSQiw-1; Mon, 13 Apr 2020 05:13:48 -0400
X-MC-Unique: vMAtjbFbNkOiCYH_RgSQiw-1
Received: by mail-wm1-f70.google.com with SMTP id f128so857316wmf.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ushgHlBusXZ5xLnyH3insFe724nmN2oRiWHOqt2DcZI=;
        b=ZUltmgxpTvnz9yk4J3SjWRxPj6S6R6hhzUV0d8RpSucU2MsuBPUloY8kC89ZFSbQ/K
         NqaWZUh5kssPv/PK0j6VtNvXQCDmU8XU38y0L/JqGyS9no3fcYTyGr4iOAwm3LujO4wU
         CxfMXeoGKK6NnRj2F2929hSraQTq9lQrLV3hr0A5WlW2ts25PX4dXGt0NnTNUd+9klrU
         PouDEBT3b6roJfZw8yx2wgJuy3MnFQlI6WWklZIYUejC+5UlyL7kPDpck1gKq5ote8bU
         QmyCu2OuPAqr1y19eIGI4H0cQZpKZxhw7V8z/58SU7a8qSZ2OQWR+mJqq/qNwG+fFyDz
         sYEw==
X-Gm-Message-State: AGi0PuYE5BGJqvee5mnIHl7BWSx9+e3WXhBR3EPiSSLpn8SOwYCfdj30
        rV1VVsw66WN09HW20MI5SvbowHMhiSStvjhIuxwhsUOslyggqfs/LJKJFSI7vMWfuz1LvIdna+D
        lHZAkANbYG2AB2DaNLMrZGW7C
X-Received: by 2002:a7b:c959:: with SMTP id i25mr17437766wml.20.1586769226825;
        Mon, 13 Apr 2020 02:13:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIffcw9nxIKvrpcNgjxV7Ji1hEM66g5Yl/JVJewO14MkPUY3DVlBtE0CycNOSBmc3hIcKgFpw==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr17437745wml.20.1586769226632;
        Mon, 13 Apr 2020 02:13:46 -0700 (PDT)
Received: from [192.168.8.101] ([194.230.155.239])
        by smtp.gmail.com with ESMTPSA id f23sm2536891wml.4.2020.04.13.02.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:13:46 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: move kvm_create_vcpu_debugfs after last failure
 point
To:     Paolo Bonzini <pbonzini@redhat.com>
References: <20200331224222.393439-1-pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <c66a8be9-c27c-9824-f287-f87e0d4edc35@redhat.com>
Date:   Mon, 13 Apr 2020 11:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331224222.393439-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2020 00:42, Paolo Bonzini wrote:
> The placement of kvm_create_vcpu_debugfs is more or less irrelevant, since
> it cannot fail and userspace should not care about the debugfs entries until
> it knows the vcpu has been created.  Moving it after the last failure
> point removes the need to remove the directory when unwinding the creation.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

> ---
>   virt/kvm/kvm_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 027259af883e..0a78e1d874ed 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2823,8 +2823,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>   	if (r)
>   		goto vcpu_free_run_page;
>   
> -	kvm_create_vcpu_debugfs(vcpu);
> -
>   	mutex_lock(&kvm->lock);
>   	if (kvm_get_vcpu_by_id(kvm, id)) {
>   		r = -EEXIST;
> @@ -2853,11 +2851,11 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>   
>   	mutex_unlock(&kvm->lock);
>   	kvm_arch_vcpu_postcreate(vcpu);
> +	kvm_create_vcpu_debugfs(vcpu);
>   	return r;
>   
>   unlock_vcpu_destroy:
>   	mutex_unlock(&kvm->lock);
> -	debugfs_remove_recursive(vcpu->debugfs_dentry);
>   	kvm_arch_vcpu_destroy(vcpu);
>   vcpu_free_run_page:
>   	free_page((unsigned long)vcpu->run);
> 

