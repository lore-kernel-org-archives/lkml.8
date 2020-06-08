Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F2CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A82072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8G+wwwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgFHL5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:57:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729549AbgFHL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591617428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktaClkE3MjShq2aZhMBmdcl25fBRPEzNmpeADyl2Hek=;
        b=D8G+wwwG/uFWKAEns5849GU75j2vpIfdLJbItRQvYwsiUMl10Nb4c5q0zSXZ3qmC7hOjFo
        IWzAvjnv/kOVZMs3UQyXf4yfPGCDv/hoIDCBeDYQdel5osLkBpBeCED/n2WOxJoAlGZLxB
        +2BBlnHhxLm414Jg6jUu2iw3eDUPTx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-rBS6SE3GNzqIucCfchZhDw-1; Mon, 08 Jun 2020 07:57:06 -0400
X-MC-Unique: rBS6SE3GNzqIucCfchZhDw-1
Received: by mail-wm1-f71.google.com with SMTP id l2so3860183wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktaClkE3MjShq2aZhMBmdcl25fBRPEzNmpeADyl2Hek=;
        b=cgax1tega/FO0SlDxrGedJOSu3wQs0n9GUJSK7eXJ+u0o4dOuPnOWrhxsJ8m2k6L9h
         3VaVVaQuI6s22NRKy9Db1TN5fx1VZ+0R4Av3oi1C1etKfb7FPRM25iA6Ftt2p9sEX4bT
         anZlgdH6JENKyxxXr9DwGGeRw6q1RNPd/gtvaBlV18JsgW5ysDgd049Yo5S7CgjJOBBO
         k4OXpnfuaSB9brpKNpF+4ave+KpR8ySUYEzrBkYg+rshEpV9befzQ3H5VGlDYiaLxraO
         x0yQvTLIKLErp/Tqv6UH1iTnyRXYd5f4OWFR7qStmbQrfUjQ6NuS+0c2R5lUzfve64Oe
         C/Tw==
X-Gm-Message-State: AOAM531f0cm992zQOFIpZ4SJXpN/F1VpzT0cJmg8OXJt78lvlaS+iwdu
        Zluvwr+73jbJzaiUX3ubG/dQViNeQhVL99WPkISd49VEJgaE5bZop1hYoUUqXwFOnkvAw0ZFNak
        UIOY4drEv6eIB1GdPIplwuc+j
X-Received: by 2002:a5d:42cd:: with SMTP id t13mr22660530wrr.355.1591617425723;
        Mon, 08 Jun 2020 04:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUyKwN5T1nrrk4iLhBXqo9bzdSufX5DbLI/CXNpW9Q8LKuUKlJElowUVhid25ySEur6UpcAQ==
X-Received: by 2002:a5d:42cd:: with SMTP id t13mr22660499wrr.355.1591617425412;
        Mon, 08 Jun 2020 04:57:05 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
        by smtp.gmail.com with ESMTPSA id w17sm23722537wra.71.2020.06.08.04.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:57:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: fix vmx_preemption_timer_test build
 with GCC10
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
References: <20200608112346.593513-1-vkuznets@redhat.com>
 <20200608112346.593513-2-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39c73030-49ff-f25c-74de-9a52579eefbe@redhat.com>
Date:   Mon, 8 Jun 2020 13:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608112346.593513-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 13:23, Vitaly Kuznetsov wrote:
> GCC10 fails to build vmx_preemption_timer_test:
> 
> gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99
> -fno-stack-protector -fno-PIE -I../../../../tools/include
>  -I../../../../tools/arch/x86/include -I../../../../usr/include/
>  -Iinclude -Ix86_64 -Iinclude/x86_64 -I..  -pthread  -no-pie
>  x86_64/evmcs_test.c ./linux/tools/testing/selftests/kselftest_harness.h
>  ./linux/tools/testing/selftests/kselftest.h
>  ./linux/tools/testing/selftests/kvm/libkvm.a
>  -o ./linux/tools/testing/selftests/kvm/x86_64/evmcs_test
> /usr/bin/ld: ./linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):
>  ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:603:
>  multiple definition of `ctrl_exit_rev'; /tmp/ccMQpvNt.o:
>  ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:603:
>  first defined here
> /usr/bin/ld: ./linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):
>  ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:602:
>  multiple definition of `ctrl_pin_rev'; /tmp/ccMQpvNt.o:
>  ./linux/tools/testing/selftests/kvm/include/x86_64/vmx.h:602:
>  first defined here
>  ...
> 
> ctrl_exit_rev/ctrl_pin_rev/basic variables are only used in
> vmx_preemption_timer_test.c, just move them there.
> 
> Fixes: 8d7fbf01f9af ("KVM: selftests: VMX preemption timer migration test")
> Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/vmx.h              | 4 ----
>  .../testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c  | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> index ccff3e6e2704..766af9944294 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> @@ -598,10 +598,6 @@ union vmx_ctrl_msr {
>  	};
>  };
>  
> -union vmx_basic basic;
> -union vmx_ctrl_msr ctrl_pin_rev;
> -union vmx_ctrl_msr ctrl_exit_rev;
> -
>  struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva);
>  bool prepare_for_vmx_operation(struct vmx_pages *vmx);
>  void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> index cc72b6188ca7..a7737af1224f 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> @@ -31,6 +31,10 @@ bool l2_save_restore_done;
>  static u64 l2_vmx_pt_start;
>  volatile u64 l2_vmx_pt_finish;
>  
> +union vmx_basic basic;
> +union vmx_ctrl_msr ctrl_pin_rev;
> +union vmx_ctrl_msr ctrl_exit_rev;
> +
>  void l2_guest_code(void)
>  {
>  	u64 vmx_pt_delta;
> 

Queued both, thanks.

Paolo

