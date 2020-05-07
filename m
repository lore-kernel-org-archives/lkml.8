Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F50C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1DD206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9JDVXPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGL6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:58:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58409 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGL6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588852719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiPqmyXt2urT2VSeZ8MvHvwecfn5nr3uxgLaKR1t8OI=;
        b=V9JDVXPjNIacWy1fzUjRnsQ3thNdE73vdsh3PJvn7ZOECkg8CjFX3o0gSqcTXUAZFHvwI/
        aZ7AHEawNGxPhWzyy0zHflOgm+/o8cNDc2tfU8q6hBfxMB7gSkZ5fKt2o0jSs21W/0FN0t
        QNZgq7YesQF08OYpzDMiEQZiHJyZn+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-HhJxR_W2OTWRacctIHmApg-1; Thu, 07 May 2020 07:58:38 -0400
X-MC-Unique: HhJxR_W2OTWRacctIHmApg-1
Received: by mail-wr1-f70.google.com with SMTP id q13so3291978wrn.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yiPqmyXt2urT2VSeZ8MvHvwecfn5nr3uxgLaKR1t8OI=;
        b=PEmZv0Ls51v0a10N9CKYe+U5+7R+NMc118C7khVNYOwA7di4pTedB+4v59ph//J4Cr
         Fey8KipkWaPtzlAFMZDi3ORBmJ+vJhZgBWB5UzVgaL+8yIYxR4p7YSbOFj15Z2FUUiug
         dsLY33NBmFE7jIxQSibTtnrtKuTCsh73y+qH3cXFR39fRIejklXyqwXa58dVms268W2X
         1lu628d5KRAEdyt1S5BOnURxo8GVHsNs9J4lFz21HjRe3C7XaGIwSNFSCOP/OXg9kMhF
         b50BSufDnfjWMl1MD1YstT4r4g/do3lluK8rLwsdyjtxz1URze8OLj7KVOcQXfuzg0o9
         6WNA==
X-Gm-Message-State: AGi0PuaY4nP5SlyHtHrejaiN7Cwdw6ggdr8BY99QyI7OJz+4fIH65PgK
        /bmlAf4kLRi+goeJIoCqPvTqo/aRBHgM/NU0nfVRCKyVjBs+/m249BiyKfGvlLE45GyXxmrFe1A
        xSmBavpKVQh/0iDcfZK8I8HO8
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr14667098wrw.305.1588852716397;
        Thu, 07 May 2020 04:58:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzVix44sPWmS0TD7/0MINztaLpqYGgLdl9qHxVJpBT4xptKl3C4qytYcX122+5P0GjR+9v+g==
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr14667077wrw.305.1588852716097;
        Thu, 07 May 2020 04:58:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id e17sm7455415wrr.32.2020.05.07.04.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 04:58:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: nVMX: Skip IPBP on nested VMCS switch
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200506235850.22600-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0cc08cc0-252c-378e-15b3-6d9639ee5552@redhat.com>
Date:   Thu, 7 May 2020 13:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506235850.22600-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 01:58, Sean Christopherson wrote:
> Or as Jim would say, "Really skip IPBP on nested VMCS switch" :-D
> 
> Patch 1 is the delta between kvm/queue and v3 of the original patch[*],
> i.e. I just cherry-picked v3 and fixed the conflicts.
> 
> Patch 2 applies the "no IPBP" logic to copy_vmcs02_to_vmcs12_rare().
> 
> Feel free to sqaush both of these to commit 7407a52f23732 ("KVM: nVMX:
> Skip IBPB when switching between vmcs01 and vmcs02") if you so desire.

I squashed patch 1 and applied patch 2 separately.  Thanks!

Paolo

> [*] https://lkml.kernel.org/r/20200505044644.16563-1-sean.j.christopherson@intel.com
> 
> Sean Christopherson (2):
>   KVM: nVMX: Refactor IBPB handling on VMCS switch to genericize code
>   KVM: nVMX: Skip IPBP when switching between vmcs01 and vmcs02, redux
> 
>  arch/x86/kvm/vmx/nested.c | 13 +++----------
>  arch/x86/kvm/vmx/vmx.c    | 19 ++++++++++++++-----
>  arch/x86/kvm/vmx/vmx.h    |  4 ++--
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 

