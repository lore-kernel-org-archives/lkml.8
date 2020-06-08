Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5FA2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD3JeeTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFHMlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:41:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728973AbgFHMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0sVcMM99LpfRV7ttxnn+jnkFBBzRSlg/gHypsc5uAg=;
        b=YD3JeeTcZxZrg6648Kv0H1l7f8Wj5HKNiTu1bHh3WA4z+ldD9uK16KytBpG9cSEFXM4FJe
        kC/Dh28VVVB8wMlas1r8Xs2MB+c8PdJ8iXeEithFnnWrRD45Qo2prNWUwDjTYBk4mjoF1r
        929HCtXEpj+jSm/RWr34qTJxoK5G9Sk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-52T3fHVrP7ugA86gvdhbMw-1; Mon, 08 Jun 2020 08:40:52 -0400
X-MC-Unique: 52T3fHVrP7ugA86gvdhbMw-1
Received: by mail-wm1-f69.google.com with SMTP id c4so1365556wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0sVcMM99LpfRV7ttxnn+jnkFBBzRSlg/gHypsc5uAg=;
        b=I3pgmky/ljdRJRV3KfayQhYtUpgr2LUkKAS+CsiceTOjG6gNVsmVWCIntDLe3AjTY7
         8k2AYchafLSWwIBY/WSeOX64WfJc5FSS3a5UxrzptBKXkpUtIGECpH8dYdCcnj5BXLnr
         EtGMwYWTj2pWilUOA3FW3RQQCY43QUd5gnQ7D+Nr5USbv+zrkIlfBSaAtYJtuCUUljnl
         gJWG2Y1imVtgr9uhHmEyRa5Jwm7LLomcGI2EeSGdDv/pgpfyTisy1PkFbXei8RdXdivc
         gBEZZG66V+QRqc/WWo4szaHdbF3efnr/QuCHCd7+7vXxQz12CzL3p7gHMzANUQlUmAEo
         Uhiw==
X-Gm-Message-State: AOAM533HqOQJzwXmHXxUjGGc9YcIIAqE4S1rZys2E53DFuwrx8aq+TbR
        DyzBxF4iMVjS6MGhFTur/RCUXNLACo8im2jrVxhD+mrBoGRWo2pDohfWm3U0Q/A6kKiC9CbsrO2
        IAyGGwyADFVxQgLai25IkdiF8
X-Received: by 2002:a5d:6305:: with SMTP id i5mr22829725wru.268.1591620051749;
        Mon, 08 Jun 2020 05:40:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAnmKWJBBEGl3LVgjqRZIiFj7LTTEcbtcVe2jhQZRFhFcZIR5dJUfI4tzfArvnjChj0xSCFQ==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr22829696wru.268.1591620051462;
        Mon, 08 Jun 2020 05:40:51 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
        by smtp.gmail.com with ESMTPSA id s132sm23360931wmf.12.2020.06.08.05.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 05:40:50 -0700 (PDT)
Subject: Re: [PATCH kvm-unit-tests 1/2] svm: Add ability to execute test via
 test_run on a vcpu other than vcpu 0
To:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200608122800.6315-1-cavery@redhat.com>
 <20200608122800.6315-2-cavery@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb1c2a81-cdd2-3f11-2be9-173bdb4eacc1@redhat.com>
Date:   Mon, 8 Jun 2020 14:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608122800.6315-2-cavery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 14:27, Cathy Avery wrote:
> When running tests that can result in a vcpu being left in an
> indeterminate state it is useful to be able to run the test on
> a vcpu other than 0. This patch allows test_run to be executed
> on any vcpu indicated by the on_vcpu member of the svm_test struct.
> The initialized state of the vcpu0 registers used to populate the
> vmcb is carried forward to the other vcpus.
> 
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
>  x86/svm.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  x86/svm.h | 13 +++++++++++++
>  2 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/x86/svm.c b/x86/svm.c
> index 41685bf..9f7ae7e 100644
> --- a/x86/svm.c
> +++ b/x86/svm.c
> @@ -367,6 +367,45 @@ test_wanted(const char *name, char *filters[], int filter_count)
>          }
>  }
>  
> +static void set_additional_vpcu_regs(struct extra_vcpu_info *info)
> +{
> +    wrmsr(MSR_VM_HSAVE_PA, info->hsave);
> +    wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
> +    wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_NX);
> +    write_cr3(info->cr3);
> +    write_cr4(info->cr4);
> +    write_cr0(info->cr0);
> +    write_dr6(info->dr6);
> +    write_dr7(info->dr7);
> +    write_cr2(info->cr2);
> +    wrmsr(MSR_IA32_CR_PAT, info->g_pat);
> +    wrmsr(MSR_IA32_DEBUGCTLMSR, info->dbgctl);
> +}
> +
> +static void get_additional_vcpu_regs(struct extra_vcpu_info *info)
> +{
> +    info->hsave = rdmsr(MSR_VM_HSAVE_PA);
> +    info->cr3 = read_cr3();
> +    info->cr4 = read_cr4();
> +    info->cr0 = read_cr0();
> +    info->dr7 = read_dr7();
> +    info->dr6 = read_dr6();
> +    info->cr2 = read_cr2();
> +    info->g_pat = rdmsr(MSR_IA32_CR_PAT);
> +    info->dbgctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +}

Some tweaks are needed here:

- DR6/DR7/CR2/DEBUGCTL should not be needed, are they?  Same for PAT
since it's not modified by the tests and defaults to the "right" value
(0x0007040600070406ULL) rather than zero.

- HSAVE should be set to a different page for each vCPU

- The on_cpu to set EFER should be in setup_svm, rather than a separate
function

- The on_cpu to set cr0/cr3/cr4 should be in setup_vm.

Paolo

