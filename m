Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D75C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A47D20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8IRp2Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBCJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:59:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52477 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727337AbgBCJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580723954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hN0XJ3e40Iv8crpZTtg0MhsXfkxzrtU4D3I/YBNqM/A=;
        b=P8IRp2Cl8t0XzxGn5IxtpP8hRjcazyGUY1LN3aJLCQfxzNPfFq+bNInKiZBLQoIcO51Tnc
        4Li1yPkmrJ14V543hytcbhJ7Som6BimTf8+Y3JlNpQSq80R8z6JhuV4sSt+l8XMikfEglC
        QVv3wiDNOUnl2eYbLW2LiOQ69nZGqXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-ypO9tWPKOKmBlP3Npb96oQ-1; Mon, 03 Feb 2020 04:59:13 -0500
X-MC-Unique: ypO9tWPKOKmBlP3Npb96oQ-1
Received: by mail-wr1-f69.google.com with SMTP id c6so7918841wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hN0XJ3e40Iv8crpZTtg0MhsXfkxzrtU4D3I/YBNqM/A=;
        b=n1B+F412kVIS1gh0kpwO6LfIjOrd0vxW3smIJaDRPSCuhdRYjSEFd6IIUMQVOCjCom
         4tCp1tXTZSxeCShtbxem6gf4SfyvU9Yd7stJ8na/1Ju9zXOamC+z1N41DokoeI566VAN
         iM8t4HcQukJ5GZlgKPIZ1KiW4RNREkB98/wyj3vIZMXFSoDL0XtrkOd97xCuAQjk9pQR
         Gff6TyqAnoC3UThYQrGVm6sJ9t1fwQFCx8wgUTtopiVlJBtxPJY3CDphXD9GbVmAc9Vo
         RnsjWqmZ0Tqg8hCjgqgq7BUMR1Y2N4eZolIzMzMmzTqynvMmA13ctXIII2QsYOyXlsfT
         LeBA==
X-Gm-Message-State: APjAAAV0mDXgJwkYYLKERaZ4p0frDuFMB52EF8jcjB2GKfKz4Xq/Fh7F
        RGhK29bd55iX24d+iCIeV0cctVWUDVKzfpiOayYJV2IB7HasN0ta7jzs+L1nFQXCIhCcE5WYI5+
        VpG775+ivDz2zzXKsiJywN0nw
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr14441999wrt.100.1580723951852;
        Mon, 03 Feb 2020 01:59:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDAvmfMXcckG8AgL2ChzxwLTNuiI4b5o73iz78EgHDkT4RkhlyGqE1J1fmtfqviYtwd3HB7g==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr14441966wrt.100.1580723951639;
        Mon, 03 Feb 2020 01:59:11 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y6sm24389481wrl.17.2020.02.03.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:59:11 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: do not setup pv tlb flush when not paravirtualized
In-Reply-To: <20200131155655.49812-1-cascardo@canonical.com>
References: <20200131155655.49812-1-cascardo@canonical.com>
Date:   Mon, 03 Feb 2020 10:59:10 +0100
Message-ID: <87wo94ng9d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:

> kvm_setup_pv_tlb_flush will waste memory and print a misguiding message
> when KVM paravirtualization is not available.
>
> Intel SDM says that the when cpuid is used with EAX higher than the
> maximum supported value for basic of extended function, the data for the
> highest supported basic function will be returned.
>
> So, in some systems, kvm_arch_para_features will return bogus data,
> causing kvm_setup_pv_tlb_flush to detect support for pv tlb flush.
>
> Testing for kvm_para_available will work as it checks for the hypervisor
> signature.
>
> Besides, when the "nopv" command line parameter is used, it should not
> continue as well, as kvm_guest_init will no be called in that case.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  arch/x86/kernel/kvm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 81045aabb6f4..d817f255aed8 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -736,6 +736,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  {
>  	int cpu;
>  
> +	if (!kvm_para_available() || nopv)
> +		return 0;
> +
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {

The patch will fix the immediate issue, but why kvm_setup_pv_tlb_flush()
is just an arch_initcall() which will be executed regardless of the fact
if we are running on KVM or not?

In Hyper-V we setup PV TLB flush from ms_hyperv_init_platform() -- which
only happens if Hyper-V platform was detected. Why don't we do it from
kvm_init_platform() in KVM?

-- 
Vitaly

