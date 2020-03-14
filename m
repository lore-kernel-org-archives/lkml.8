Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12321C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE18520575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upxqg79/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCODDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:03:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727473AbgCODDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584241387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqN7yC9dr/9wjtV7DO9ie1xoABQY+WCqIxj6pMJdRtw=;
        b=Upxqg79/O1faznznI/hU6TVmb7Ysif7PNAOSCSu4jWQAF63kwPdEH4HAWv9suunmHRPAH6
        QH3YnL+QBnor2SlMVGdJ3nUzp30xB8R/lDz3/fmOZDL88e4DdB3ySIxS+9Jm3dFC0XSv2u
        xi8ubutU98pyoKIzIcNFE94kxnkuyI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Tuvjg5p-NvqKs2ZdqTVzkQ-1; Sat, 14 Mar 2020 07:00:24 -0400
X-MC-Unique: Tuvjg5p-NvqKs2ZdqTVzkQ-1
Received: by mail-wr1-f70.google.com with SMTP id 31so5837098wrq.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 04:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IqN7yC9dr/9wjtV7DO9ie1xoABQY+WCqIxj6pMJdRtw=;
        b=AWgIKlgxx2YlAsTZdw/1HZSH8bhBMDI9KqI5c41hxdYlMCVvDP05faf7X49F7zLA4/
         CC0+yqwLFHPJfil9uQLwj88gKt89ycCjEFLtoFPzTr2V6yulpWrkkQxEjFmHfH2g/Iu+
         655gs85bl3iANgygN2L4wpu/Do00U96ForyLtEgTfSP/estzJbosbZAzI9GF3J6psGIe
         qmLMzmVcSxo2tW2Uq1zjK+Y/p0Rbp33/NKxPKiCC58j4NrN8no+tJYn/0TSxr61cKBgn
         3bEDpfXLAHDUxB6FObBQqHW/tJMZ0Fw5zmKuXfnlBP3y4VaySvZEdQBmClz4/rUsvKxC
         ikPA==
X-Gm-Message-State: ANhLgQ3a+SAPSisf+30FZ8Lv4MaryeuoXwqX9ecFtaWPIJ40WSBLFui5
        XdUPWxKnpjIH+hNCkuJMQvtF3ijzlDbXXxJL+NgbKVThtw7Ju5pjjoJEU4K4j5vj9BQswmZiLD9
        LbuqZvEj1cjEppiGDoBCFtsvq
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr23165848wrv.353.1584183622987;
        Sat, 14 Mar 2020 04:00:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsb7twEeEjI6N9PLMfvne45vD4UyBWcTtwFAPlo+XiIRsjTK0BGMqrnb5HspCUKm4EPDOwGSw==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr23165830wrv.353.1584183622716;
        Sat, 14 Mar 2020 04:00:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id r9sm13830690wma.47.2020.03.14.04.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:00:22 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: VMX: Micro-optimize vmexit time when not exposing
 PMU
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1584071718-17163-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0776e1d0-f0e0-68ef-a07c-9a4884ea1498@redhat.com>
Date:   Sat, 14 Mar 2020 12:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584071718-17163-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/20 04:55, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> PMU is not exposed to guest by most of products from cloud providers since the 
> bad performance of PMU emulation and security concern. However, it calls 
> perf_guest_switch_get_msrs() and clear_atomic_switch_msr() unconditionally 
> even if PMU is not exposed to the guest before each vmentry. 
> 
> ~2% vmexit time reduced can be observed by kvm-unit-tests/vmexit.flat on my 
> SKX server.
> 
> Before patch:
> vmcall 1559
> 
> After patch:
> vmcall 1529
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * move the check before atomic_switch_perf_msrs
> 
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 40b1e61..b20423c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6567,7 +6567,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	pt_guest_enter(vmx);
>  
> -	atomic_switch_perf_msrs(vmx);
> +	if (vcpu_to_pmu(vcpu)->version)
> +		atomic_switch_perf_msrs(vmx);
>  	atomic_switch_umwait_control_msr(vmx);
>  
>  	if (enable_preemption_timer)
> 

Queued, thanks.

Paolo

