Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064B1C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7320658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQkzqVrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgBYOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:21:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730569AbgBYOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582640510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVSqx3EzAvWE7ZUmVL6oGFZVbwypZGJIj1KXOM4Izws=;
        b=aQkzqVrGK6RBFDyZ2Vtzz6n3AxKchTg0PpkbTlFyFfHpIoaACIKRiPK5WH2bztRK2xu8C0
        dkPQ+BCqN0AMBC26LXvIRvkor6lg/ay4rnuKPXNm0/eAYE7N5LhqFMwq7iEmDYwbQ3+GbA
        qCRLL8sITgdzSE4JocmE+CMyHExU70U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-fC5lnZPPP3uqq-pME6PGzQ-1; Tue, 25 Feb 2020 09:21:48 -0500
X-MC-Unique: fC5lnZPPP3uqq-pME6PGzQ-1
Received: by mail-wr1-f69.google.com with SMTP id u18so7348730wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hVSqx3EzAvWE7ZUmVL6oGFZVbwypZGJIj1KXOM4Izws=;
        b=KnqHJcVStmlju1AII4/iGzKt7f7Vg1RZpl6zIBSoDaYp7IyADr6UOuLAkxHJmaj+TX
         ztSY1Nx9TccRGgkD1nb+GnYoksStm4eX0K9Lb7RsmwyOWNdCN9Rp7+e7nx1Vp2nz2oym
         W39qhDu7hlFCiGFud+a8p0tV/lgyiQXmRFz7ig2abG4QbHTUQdSfwX8rRfTZMJg0rONd
         S5yu+X/oOChM0xjTiY+LfDx4aLDlS4tFLBkbzoTgTkrTh1muFuBMqa2ifXt2li6z8CSO
         D/HPrmmKLH6g6eFO97BIgolrhoIttoW7fjAR11EZKxZMFNf8hn1nkdxboHaVhx3j5c1F
         p4kg==
X-Gm-Message-State: APjAAAUGIiSKDAXYVNWyXRsb0vhqlCbtaFvRJwTkg3NXOZ0f2LZGDrbT
        uEurCd6z0ZUjmUVaH7s4ircUILX+pMkd4qjRiJYtElZNDC2cLt31q55bKlUCMOt3w4a8ByELDft
        el7v+E54ISGGkY8KmekDBhRNO
X-Received: by 2002:a5d:5347:: with SMTP id t7mr72977040wrv.401.1582640507474;
        Tue, 25 Feb 2020 06:21:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZKH29/qzb/cUfFg4C2u8+Ed5dlfSDFPx6sbZ+diRIwyPfeca/Urx5e36yoK+eLMn+VpDe+Q==
X-Received: by 2002:a5d:5347:: with SMTP id t7mr72977022wrv.401.1582640507243;
        Tue, 25 Feb 2020 06:21:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v131sm4551825wme.23.2020.02.25.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:21:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 56/61] KVM: SVM: Refactor logging of NPT enabled/disabled
In-Reply-To: <20200201185218.24473-57-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-57-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:21:45 +0100
Message-ID: <87h7zelpc6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Tweak SVM's logging of NPT enabled/disabled to handle the logging in a
> single pr_info() in preparation for merging kvm_enable_tdp() and
> kvm_disable_tdp() into a single function.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index a27f83f7521c..80962c1eea8f 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1440,16 +1440,14 @@ static __init int svm_hardware_setup(void)
>  	if (!boot_cpu_has(X86_FEATURE_NPT))
>  		npt_enabled = false;
>  
> -	if (npt_enabled && !npt) {
> -		printk(KERN_INFO "kvm: Nested Paging disabled\n");
> +	if (npt_enabled && !npt)
>  		npt_enabled = false;
> -	}
>  
> -	if (npt_enabled) {
> -		printk(KERN_INFO "kvm: Nested Paging enabled\n");
> +	if (npt_enabled)
>  		kvm_enable_tdp();
> -	} else
> +	else
>  		kvm_disable_tdp();
> +	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
>  
>  	if (nrips) {
>  		if (!boot_cpu_has(X86_FEATURE_NRIPS))

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

