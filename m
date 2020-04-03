Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8542C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07CF2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQyFfia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbgDCM5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:57:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728001AbgDCM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585918668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTKwbcJ3kLG2qGb0SbTmuAeYvvl4mKOAMCfy9jepaP8=;
        b=jPQyFfiaqSgYclk/YW3GpWyl4QHu0MAKdrmPrLi0/iJuLoGUxctULzo/htpnqYdcyKey0U
        6DuFJi9wdH8b4cVNX8c5JdZtItt/EW1P17dB6Tk8JATQZF5kEHK+5EIeQ5btowqNDYfWhf
        vrfqd1nhjlBqLSveHse36HHW63M40lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vToPcn05Ne68qPrzzRoXog-1; Fri, 03 Apr 2020 08:57:46 -0400
X-MC-Unique: vToPcn05Ne68qPrzzRoXog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C914800D53;
        Fri,  3 Apr 2020 12:57:44 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC2A25E000;
        Fri,  3 Apr 2020 12:57:37 +0000 (UTC)
Date:   Fri, 3 Apr 2020 20:57:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, bp@suse.de,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        srutherford@google.com, luto@kernel.org, brijesh.singh@amd.com,
        kexec@lists.infradead.org, lijiang@redhat.com, bhe@redhat.com
Subject: Re: [PATCH v6 14/14] KVM: x86: Add kexec support for SEV Live
 Migration.
Message-ID: <20200403123529.GA107255@dhcp-128-65.nay.redhat.com>
References: <cover.1585548051.git.ashish.kalra@amd.com>
 <0caf809845d2fdb1a1ec17955826df9777f502fb.1585548051.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0caf809845d2fdb1a1ec17955826df9777f502fb.1585548051.git.ashish.kalra@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ccing kexec list.

Ashish, could you cc kexec list if you repost later?
On 03/30/20 at 06:23am, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Reset the host's page encryption bitmap related to kernel
> specific page encryption status settings before we load a
> new kernel by kexec. We cannot reset the complete
> page encryption bitmap here as we need to retain the
> UEFI/OVMF firmware specific settings.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/kvm.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 8fcee0b45231..ba6cce3c84af 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -34,6 +34,7 @@
>  #include <asm/hypervisor.h>
>  #include <asm/tlb.h>
>  #include <asm/cpuidle_haltpoll.h>
> +#include <asm/e820/api.h>
>  
>  static int kvmapf = 1;
>  
> @@ -357,6 +358,33 @@ static void kvm_pv_guest_cpu_reboot(void *unused)
>  	 */
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>  		wrmsrl(MSR_KVM_PV_EOI_EN, 0);
> +	/*
> +	 * Reset the host's page encryption bitmap related to kernel
> +	 * specific page encryption status settings before we load a
> +	 * new kernel by kexec. NOTE: We cannot reset the complete
> +	 * page encryption bitmap here as we need to retain the
> +	 * UEFI/OVMF firmware specific settings.
> +	 */
> +	if (kvm_para_has_feature(KVM_FEATURE_SEV_LIVE_MIGRATION) &&
> +		(smp_processor_id() == 0)) {
> +		unsigned long nr_pages;
> +		int i;
> +
> +		for (i = 0; i < e820_table->nr_entries; i++) {
> +			struct e820_entry *entry = &e820_table->entries[i];
> +			unsigned long start_pfn, end_pfn;
> +
> +			if (entry->type != E820_TYPE_RAM)
> +				continue;
> +
> +			start_pfn = entry->addr >> PAGE_SHIFT;
> +			end_pfn = (entry->addr + entry->size) >> PAGE_SHIFT;
> +			nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
> +
> +			kvm_sev_hypercall3(KVM_HC_PAGE_ENC_STATUS,
> +				entry->addr, nr_pages, 1);
> +		}
> +	}
>  	kvm_pv_disable_apf();
>  	kvm_disable_steal_time();
>  }
> -- 
> 2.17.1
> 

