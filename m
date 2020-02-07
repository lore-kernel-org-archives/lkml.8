Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B8C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7251121741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8NZYj7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:56:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBGP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581090996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmOUMNOe+ha2CV99jLyY9keQ7RrGgOD5w7R2KXxGhFU=;
        b=U8NZYj7MhnDlWvq0yU2eswymNurtqyBzw9VRKeYt1f4dYaZeGfjmrbjn7PFhcdRLmqOQ1z
        SgfhfE+CzLCDu/CHuFqpKccELU4/9Rzowq0TK8sbWFwVA41zbNNtdmvxyzY168kHu/6xCm
        hVXQ+rM4Xbafx7xgGThVOrfJZ8S9XO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-fjDf-UkuOrmrmNcBAareRQ-1; Fri, 07 Feb 2020 10:56:32 -0500
X-MC-Unique: fjDf-UkuOrmrmNcBAareRQ-1
Received: by mail-wr1-f71.google.com with SMTP id 90so1470127wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qmOUMNOe+ha2CV99jLyY9keQ7RrGgOD5w7R2KXxGhFU=;
        b=b2aXWp4Ij0NltlJjBIVRe6YwpFTRb+gbwPJLSvylvxdEJnHqi964Vp957f5v8xNewM
         wtWlfMWV2u2KHFbhgzQHqVENgyWgwUoryMr5uWWWqMpybf5etllpEf754FGa51FigO5f
         NlRbL+yhzqwfbWlvsmuB7B+DJ+6pn1NBBZN3nuu3DwhSWwEADl26yYdmahl8/VRuyLh9
         0MjFYXJVqm6PIvFGJr5WZo7U+J/w8lX49DofMfjPyuewYdwOSa0oRA8t6/kDhNlXgX3+
         sQGoTQZAaBMqXMMWGb0mPgQ9tZIjNQGo/Zs8oelMGM/o9LvC43KOrzhqx66E5oelLtwF
         PldQ==
X-Gm-Message-State: APjAAAWdt7kCmygkE+v11uSW2y6nEPI8rVADLHVlxwb+iRkZJppwJDRM
        AVN9Z+0p5dpaBGmWl8lIkE+ulS21EGA/8DDklODhkJf5Yh/HVmUIUyX7MbvQX2by9zmEhuQG/00
        EL/5WZJDBWO/TgWQT+cX/HTg+
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr5678668wrt.229.1581090991476;
        Fri, 07 Feb 2020 07:56:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1rGthp3Ae94Af5kH6GGn1xzAMy3oVIL5FslhKcZp1NzeM9VWWfxT91/XIOBJNpbWv7uFiJQ==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr5678644wrt.229.1581090991179;
        Fri, 07 Feb 2020 07:56:31 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm4350600wrw.54.2020.02.07.07.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:56:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/61] KVM: x86: Refactor CPUID 0xD.N sub-leaf entry creation
In-Reply-To: <20200201185218.24473-10-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-10-sean.j.christopherson@intel.com>
Date:   Fri, 07 Feb 2020 16:56:30 +0100
Message-ID: <878sleqtld.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Increment the number of CPUID entries immediately after do_host_cpuid()
> in preparation for moving the logic into do_host_cpuid().  Handle the
> rare/impossible case of encountering a bogus sub-leaf by decrementing
> the number entries on failure.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 424dde41cb5d..6e1685a16cca 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -677,6 +677,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  				goto out;
>  
>  			do_host_cpuid(&entry[i], function, idx);
> +			++*nent;
>  
>  			/*
>  			 * The @supported check above should have filtered out
> @@ -685,12 +686,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  			 * reach this point, and they should have a non-zero
>  			 * save state size.
>  			 */
> -			if (WARN_ON_ONCE(!entry[i].eax || (entry[i].ecx & 1)))
> +			if (WARN_ON_ONCE(!entry[i].eax || (entry[i].ecx & 1))) {
> +				--*nent;
>  				continue;
> +			}
>  
>  			entry[i].ecx = 0;
>  			entry[i].edx = 0;
> -			++*nent;
>  			++i;
>  		}
>  		break;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

