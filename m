Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C2C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332EE20767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7h7XgIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCTRnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:43:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35350 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgCTRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584726199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7krMgYrLviqR5RFlOfg+d+WWKR25x9POwU7DsBJYErA=;
        b=I7h7XgIUuqyMi5Vg+BRSWzKMKxZJ6lGRdLqOHOgyf2+KTBla379qt6IqtuJOJwPoqRWfUm
        WCPaaEbuk5PkijZXQFbXrNA2uerfC8duK3jZ9agIrdzsRUnyvGLEGLWICEw6NsC9Znq6a/
        WYkRpnGzqgt/W49RnrZ4F2dPFmZnfWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-AEfW2_GsOveHXeCgeR03tg-1; Fri, 20 Mar 2020 13:43:17 -0400
X-MC-Unique: AEfW2_GsOveHXeCgeR03tg-1
Received: by mail-wm1-f72.google.com with SMTP id v184so2078176wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7krMgYrLviqR5RFlOfg+d+WWKR25x9POwU7DsBJYErA=;
        b=WUYmVfxNFjxXNe9NaW7F4fAEcowL0cgzS7B4fFBDX/5Ih0bOumuLcqLljPtEaOm6WW
         DRLZyYs5vzHOiZr9FcSQ5j5CbD8LuViL918pTby4vQkzRcrzcJQnwLO6pirXC+X/cnRc
         J371XfaLu0B5r3zCxKwNYT3X6akuVkkwGQESo6Iki7xbshC3Ok5+5iwJ2mmRAs2awSrd
         9It3pbvd/RDu4blH5MtdjD4629hF8NM66/TqcrDzHsage4TnL9iUd4ccN3CpdjwJSfxH
         XOx7VRif5lx9Z9NT+oobha3B58g53YQ3pc7vPGvVzWI9XTeIkNOicGZUgvzDDfb+aMlB
         4Mhg==
X-Gm-Message-State: ANhLgQ16toTHKByDx4r3jbepY4B9p86LY87mTrXsX49F1tQxXFeJ2tp+
        fsHPJr6ohhOedO/rM7lQZ5XpWgpMR8fpuJxiHPxlHhjj/JVx07hKtOvH1Ny+4O8ZEfV2bND9E9a
        iwtF/cmkYJ+jrM3KLWAMeZApJ
X-Received: by 2002:a1c:8108:: with SMTP id c8mr11432332wmd.50.1584726194461;
        Fri, 20 Mar 2020 10:43:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsAtEWKoguJOc/KY7Vn81oqAla4zRc1CqqIumjVg73UvF25mFsHXlpV+BDb1BfgzQqXX+HPyw==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr11432291wmd.50.1584726194078;
        Fri, 20 Mar 2020 10:43:14 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id f10sm9339428wrw.96.2020.03.20.10.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 10:43:13 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Issue WBINVD after deactivating an SEV guest
To:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Rientjes <rientjes@google.com>
References: <c8bf9087ca3711c5770bdeaafa3e45b717dc5ef4.1584720426.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db38f194-cdd0-23a0-00d9-78ef5eaa1534@redhat.com>
Date:   Fri, 20 Mar 2020 18:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c8bf9087ca3711c5770bdeaafa3e45b717dc5ef4.1584720426.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 17:07, Tom Lendacky wrote:
> Currently, CLFLUSH is used to flush SEV guest memory before the guest is
> terminated (or a memory hotplug region is removed). However, CLFLUSH is
> not enough to ensure that SEV guest tagged data is flushed from the cache.
> 
> With 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations"), the
> original WBINVD was removed. This then exposed crashes at random times
> because of a cache flush race with a page that had both a hypervisor and
> a guest tag in the cache.
> 
> Restore the WBINVD when destroying an SEV guest and add a WBINVD to the
> svm_unregister_enc_region() function to ensure hotplug memory is flushed
> when removed. The DF_FLUSH can still be avoided at this point.
> 
> Fixes: 33af3a7ef9e6 ("KVM: SVM: Reduce WBINVD/DF_FLUSH invocations")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/svm.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 08568ae9f7a1..d54cdca9c140 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1980,14 +1980,6 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
>  static void __unregister_enc_region_locked(struct kvm *kvm,
>  					   struct enc_region *region)
>  {
> -	/*
> -	 * The guest may change the memory encryption attribute from C=0 -> C=1
> -	 * or vice versa for this memory range. Lets make sure caches are
> -	 * flushed to ensure that guest data gets written into memory with
> -	 * correct C-bit.
> -	 */
> -	sev_clflush_pages(region->pages, region->npages);
> -
>  	sev_unpin_memory(kvm, region->pages, region->npages);
>  	list_del(&region->list);
>  	kfree(region);
> @@ -2004,6 +1996,13 @@ static void sev_vm_destroy(struct kvm *kvm)
>  
>  	mutex_lock(&kvm->lock);
>  
> +	/*
> +	 * Ensure that all guest tagged cache entries are flushed before
> +	 * releasing the pages back to the system for use. CLFLUSH will
> +	 * not do this, so issue a WBINVD.
> +	 */
> +	wbinvd_on_all_cpus();
> +
>  	/*
>  	 * if userspace was terminated before unregistering the memory regions
>  	 * then lets unpin all the registered memory.
> @@ -7247,6 +7246,13 @@ static int svm_unregister_enc_region(struct kvm *kvm,
>  		goto failed;
>  	}
>  
> +	/*
> +	 * Ensure that all guest tagged cache entries are flushed before
> +	 * releasing the pages back to the system for use. CLFLUSH will
> +	 * not do this, so issue a WBINVD.
> +	 */
> +	wbinvd_on_all_cpus();
> +
>  	__unregister_enc_region_locked(kvm, region);
>  
>  	mutex_unlock(&kvm->lock);
> 

Queued for kvm/master, thanks.

Paolo

