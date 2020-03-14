Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE9C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FBB20575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJUt3Mdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCODCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:02:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgCODCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584241324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=giOlNu135jDQe/FKEMcGw/BC8BU4lfJK5ujS4orsAm0=;
        b=YJUt3Mdm7qP47EMqWpcZMGIw2bsTauwqKKgpEJ0G0J2d6x08fOtWZLLwAIsWiy8fngAGwy
        Vp3fizqJUbfKvhKU1/El3bfu4fh8MJbEt1+p/14T1aneJR99t8vQzrW8E/6oPsFhlW57eF
        MK7WejjntHoNnXVuKP+Ff8h0AJmudRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-xCj1j2wiO_CTrPRm1BAbCw-1; Sat, 14 Mar 2020 06:58:38 -0400
X-MC-Unique: xCj1j2wiO_CTrPRm1BAbCw-1
Received: by mail-wm1-f72.google.com with SMTP id a13so4101128wme.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 03:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giOlNu135jDQe/FKEMcGw/BC8BU4lfJK5ujS4orsAm0=;
        b=ZMlORI5YfB8f/VpLeiMk9K6dSN62DR0HoZVcLiJwT3iRCFP6whcw4Xj1yYFbqCzBs4
         2ig6Nh2M9SZ677cRF73nCgbK31CgHAM5QojZsALtfFcmGHHpjUPe306cS8RFxHczyrlZ
         tZMYQQ9ymzkVGlykEP6lY/fTwFThfRiBkawEY6eim5Oid8mPBKSI0KKoDZJL95GfFxKo
         DSsQNyYoqsux7/ZVqmIcrvX3igVakz9lQWC37+kdA+x0atZakoUIfC6dT9Ju00xHtvnJ
         xTsQ5g+vRnxYxv50MzH4mg3DOa+ugkZWWs0go8UIT4VGOw6eqRCIzY4tcUfm/O41lrdX
         xXZg==
X-Gm-Message-State: ANhLgQ0q10G6hAn5m6pRcTpYgyo3b2bfso0B7qENmDPGXcOf6oJppaFo
        lleXWOD7MjdxSOsjxYsIrqSHTkcxv6YFKtFMCCptItFTZpJqB5mlUoYVrVr5iqeirgt+18SRKda
        BrriesZhYFtPTgNYoKL9ADh4X
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr16885677wmb.154.1584183517447;
        Sat, 14 Mar 2020 03:58:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsGETEdTZbPVYcVKeouirEvFBFvFjo2cNdzYaZmV8zBekptEpxlZphJXKRy3YxQS36aE8dvYA==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr16885664wmb.154.1584183517224;
        Sat, 14 Mar 2020 03:58:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id h81sm8042151wme.42.2020.03.14.03.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 03:58:36 -0700 (PDT)
Subject: Re: [PATCH] kvm: svm: Introduce GA Log tracepoint for AVIC
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     joro@8bytes.org, jon.grimm@amd.com
References: <1584009568-14089-1-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66820077-421a-1807-4ee8-588fb380c34d@redhat.com>
Date:   Sat, 14 Mar 2020 11:58:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584009568-14089-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/20 11:39, Suravee Suthikulpanit wrote:
> GA Log tracepoint is useful when debugging AVIC performance
> issue as it can be used with perf to count the number of times
> IOMMU AVIC injects interrupts through the slow-path instead of
> directly inject interrupts to the target vcpu.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c   |  1 +
>  arch/x86/kvm/trace.h | 18 ++++++++++++++++++
>  arch/x86/kvm/x86.c   |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 24c0b2b..504f2cb 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1208,6 +1208,7 @@ static int avic_ga_log_notifier(u32 ga_tag)
>  	u32 vcpu_id = AVIC_GATAG_TO_VCPUID(ga_tag);
>  
>  	pr_debug("SVM: %s: vm_id=%#x, vcpu_id=%#x\n", __func__, vm_id, vcpu_id);
> +	trace_kvm_avic_ga_log(vm_id, vcpu_id);
>  
>  	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>  	hash_for_each_possible(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index f194dd0..023de6c 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1367,6 +1367,24 @@
>  		  __entry->vec)
>  );
>  
> +TRACE_EVENT(kvm_avic_ga_log,
> +	    TP_PROTO(u32 vmid, u32 vcpuid),
> +	    TP_ARGS(vmid, vcpuid),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, vmid)
> +		__field(u32, vcpuid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vmid = vmid;
> +		__entry->vcpuid = vcpuid;
> +	),
> +
> +	TP_printk("vmid=%u, vcpuid=%u",
> +		  __entry->vmid, __entry->vcpuid)
> +);
> +
>  TRACE_EVENT(kvm_hv_timer_state,
>  		TP_PROTO(unsigned int vcpu_id, unsigned int hv_timer_in_use),
>  		TP_ARGS(vcpu_id, hv_timer_in_use),
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5de2006..ef38b82 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10514,4 +10514,5 @@ u64 kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vcpu)
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pi_irte_update);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_unaccelerated_access);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_incomplete_ipi);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_ga_log);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_apicv_update_request);
> 

Queued, thanks.

Paolo

