Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F54C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98DF2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY3ORXiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbgEYPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:22:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404004AbgEYPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590420135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TJhizQZw710Ykbd4e66mhSmTv6uHiaL8SGhqXCINH4=;
        b=UY3ORXiqOGsLo6vSKXtCAFswteIAA8F94Rz//CV/57i0Caz7Y1USkhgMVa00kHZLWi3iY/
        n4I3fBooRsI7W2m0Jb1MXrH5DGCU+Lm48lRWIX9BBOgSrr6OPSF66ZV/ssZGNF73vj0AxA
        NrIiOAVYPp/F68aB5pex/z6PFbEkzhs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-mcjKydEXN6SnVWXLEC5ICQ-1; Mon, 25 May 2020 11:22:13 -0400
X-MC-Unique: mcjKydEXN6SnVWXLEC5ICQ-1
Received: by mail-ej1-f69.google.com with SMTP id lk22so6451987ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3TJhizQZw710Ykbd4e66mhSmTv6uHiaL8SGhqXCINH4=;
        b=kbtaawptgxr8JcFEEXhIj+ujCUCs+Tt8DL2a74SGXiXR1jGZWZOf2ryU2Tw2A1zg94
         mYuVEM/i2jdd29nFSbPEGQizZgHNvHHpUGt8E5kkI8ehusQN4oGmg7SRfPT/13x3wKos
         uarB3jF18KRsoL74xo+D4Oh9ZlfdTxmvLPlaH8tIo1NVCxQcWmNXKYrYnIQnyOSf4PR/
         IHYz5gHeNr/laFywyv8HAfaoPyos4sSoJLzz5YguCPbEYd1FVZuyG0B68G5/c5NNHQ/i
         5hyjTE7wRooCwR4uZmGZFAfPmsX0lfzh3Q5RDICLIoRY/JH6g+z2b+ySdgKP/LZEfFDA
         fmVw==
X-Gm-Message-State: AOAM532mjXheTQSD7yxODHaj7PQQVg+V4g7NX243X83V/v1BYdcG7g6y
        uVIK1Ow03rEzoUVgprvftENq4r69aO5maLtkxc3mzQRSeZW5nNlUJ+vdlIdp6sraHeTUKoNibsK
        /c+8C+9IFwNqjwjhLZHkvoX0Z
X-Received: by 2002:a17:907:392:: with SMTP id ss18mr20203737ejb.156.1590420132121;
        Mon, 25 May 2020 08:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHlp16CRg1vF1duz4SE4yZIQh96KMOz7B1Iv5p6TQx/Ia7dapZMBxC7JxsIRul4uyMhi9igw==
X-Received: by 2002:a17:907:392:: with SMTP id ss18mr20203709ejb.156.1590420131831;
        Mon, 25 May 2020 08:22:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cd12sm16045340ejb.95.2020.05.25.08.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:22:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe\, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen\, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 13/16] x86/kvmclock: Share hvclock memory with the host
In-Reply-To: <20200522125214.31348-14-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com> <20200522125214.31348-14-kirill.shutemov@linux.intel.com>
Date:   Mon, 25 May 2020 17:22:10 +0200
Message-ID: <875zck82fx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> hvclock is shared between the guest and the hypervisor. It has to be
> accessible by host.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/kvmclock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 34b18f6eeb2c..ac6c2abe0d0f 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -253,7 +253,7 @@ static void __init kvmclock_init_mem(void)
>  	 * hvclock is shared between the guest and the hypervisor, must
>  	 * be mapped decrypted.
>  	 */
> -	if (sev_active()) {
> +	if (sev_active() || kvm_mem_protected()) {
>  		r = set_memory_decrypted((unsigned long) hvclock_mem,
>  					 1UL << order);
>  		if (r) {

Sorry if I missed something but we have other structures which KVM guest
share with the host,

sev_map_percpu_data():
...
	for_each_possible_cpu(cpu) {
		__set_percpu_decrypted(&per_cpu(apf_reason, cpu), sizeof(apf_reason));
		__set_percpu_decrypted(&per_cpu(steal_time, cpu), sizeof(steal_time));
		__set_percpu_decrypted(&per_cpu(kvm_apic_eoi, cpu), sizeof(kvm_apic_eoi));
	}
...

Do you handle them somehow in the patchset? (I'm probably just blind
failing to see how 'early_set_memory_decrypted()' is wired up)

-- 
Vitaly

