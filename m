Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0820828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGhmu04S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBXPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:34:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727840AbgBXPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582558496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJpm/Tebxdb+Wgu5FleyadSnWEMf3LJQp0WKqRm+nww=;
        b=LGhmu04SUQHKbimh5NVPs6pSKROAdZefAuvGNTQhE1h8UaPJEPtJsaxzBNjImnNzjSVJpw
        XIEeju+FZ/A924ki00YTwEwBycjUU/MLccV32xLQPcr1uTsG2qum7u4Jrbizli8Jj8Ul17
        Fcd0lPjIboOfPUiw+zW+Dzm/frdJW2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-rPY53K0WMA6eE7zlmdj07Q-1; Mon, 24 Feb 2020 10:34:55 -0500
X-MC-Unique: rPY53K0WMA6eE7zlmdj07Q-1
Received: by mail-wm1-f71.google.com with SMTP id f207so2509179wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gJpm/Tebxdb+Wgu5FleyadSnWEMf3LJQp0WKqRm+nww=;
        b=UkMltqszFOEXsBz6xyFt1Di/msNdKQIHMwSA2EJmJGJmZmSOpKRIKyecq7ylZl2Vm5
         HD7qzN5XojiBLk38D0534yDzQpSWE1u3BzmsKvzbWkLf+3hy9sn3v3GtFZFiDGeMZ8ze
         K4mJYGq94m/v4B70GGhvEX67b7E36/nZGnkRg28gBOL0QYJ68FQ5fTxoWsvrC3ZDb4Z3
         h1XR19XYvnId8sVzUVjVhBP6701R2cdWc7OkYCg0YEQK+yUyJ7KLhzvApheDQZluA/lX
         E5w/yxEQBljd/iv5Xz8XEXCSULr5cLwgWc0pRanSUBMbz69yKtb94Jdd1BMC6BmHh69a
         Xm1w==
X-Gm-Message-State: APjAAAWb2EnhkJbTpY4iDKg9PLbY7EJF5eKSJGrk3TAAlMx76cUh3k/L
        R79ujY7Ui5yXMheHHcC9pXwDBqtheCNH6z0mErQZL85G3GTdiQ85frVgWjnXLOIM0EljiLn4Fxe
        5lm1Y3IskR+LOmQRCce6Lq8uc
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr70779367wrs.179.1582558493875;
        Mon, 24 Feb 2020 07:34:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw8uV+kl1oe26PuuKsug4I1PsBgu1fKa3k+NmiwBlb7ilHNgl3jdn80PtQIp1HxIROanNicw==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr70779351wrs.179.1582558493679;
        Mon, 24 Feb 2020 07:34:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n13sm19124830wmd.21.2020.02.24.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:34:53 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/61] KVM: x86: Handle GBPAGE CPUID adjustment for EPT in VMX code
In-Reply-To: <20200201185218.24473-37-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-37-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:34:52 +0100
Message-ID: <87mu98ngmb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the clearing of the GBPAGE CPUID bit into VMX to eliminate an
> instance of the undesirable "unsigned f_* = *_supported ? F(*) : 0"
> pattern in the common CPUID handling code, and to pave the way toward
> eliminating ->get_lpage_level().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c   | 3 +--
>  arch/x86/kvm/vmx/vmx.c | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index f4a3655451dd..c74253202af8 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -416,8 +416,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  	int r, i, max_idx;
>  	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
>  #ifdef CONFIG_X86_64
> -	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
> -				? F(GBPAGES) : 0;
> +	unsigned f_gbpages = F(GBPAGES);
>  	unsigned f_lm = F(LM);
>  #else
>  	unsigned f_gbpages = 0;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index fcec3d8a0176..11b9c1e7e520 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7125,6 +7125,8 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  	case 0x80000001:
>  		if (!cpu_has_vmx_rdtscp())
>  			cpuid_entry_clear(entry, X86_FEATURE_RDTSCP);
> +		if (enable_ept && !cpu_has_vmx_ept_1g_page())
> +			cpuid_entry_clear(entry, X86_FEATURE_GBPAGES);
>  		break;
>  	default:
>  		break;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

