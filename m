Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A170C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FA420767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8CkoSPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGIRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:25:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbgGIRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594315516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8Qv6SZiSuVo4vD9vQZEd6hGhjNKEb58ljkswnlnFUk=;
        b=H8CkoSPXjOlrVkzY7ejnjBssWKVUJRKZ6Rb4OlL7h9Q+kZEaSrHJblFooGFWJbpDiFPVkE
        95KMg/40AyyS8dEZ2ETFgaIsAVCEcwkiCjlNNKTx9CWvo0KCuHmcxm8TG0bLKAHOMLsA6Y
        kswyLGPOobMS33A3ZdtcdNl5/lINyC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-DR13Bn_aOyizIjOuWL8s2A-1; Thu, 09 Jul 2020 13:25:11 -0400
X-MC-Unique: DR13Bn_aOyizIjOuWL8s2A-1
Received: by mail-wr1-f71.google.com with SMTP id b14so2597194wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8Qv6SZiSuVo4vD9vQZEd6hGhjNKEb58ljkswnlnFUk=;
        b=LPueCw9jFW5/wakKk2ttaCnMRifX4QR9Z493W+sMlH4wrndtEJcT+AskTXoHTZodBJ
         ELAeQjGLPBJmZa+NKL4uRF46F4xGwiz3hJ+Q0RKH42Xll8RSNPSnq/niR7Bvjs0mWXYW
         A2PzXhpv5p5WI4uIANQ6uUcuRACP5601i5vVpO+SZ6PJohZol9SUdi2d3uCSzrh1G82V
         lMSmx4QBajNBb7iMVqXdqTV+ICbnX1sV4XCG/UuZcuSgY0+onQQ0SIl/XeWhGAG9vBhX
         3a2WrnpT+88Ou2h+QWbvnpDCjWbRahr8mAfqzqYTdh6IRkG9oKysGikG9WEI0jvTSun0
         Kc8Q==
X-Gm-Message-State: AOAM531C7DNm1kARVN+gfatxREYbfbaNDlq3FYpi7zIs8h4vW70MLpHv
        xJb5W+ku5P6iL9N4A2sWsQ0vkLv3ecgi+4pFSnljmTe8CfLQ86w1odbJqykguJOxYVVoBj3zjZW
        yXJY5Wux1r2eLK8zF1W81ghaC
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr996534wmk.175.1594315510102;
        Thu, 09 Jul 2020 10:25:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPYqDXYqthnhjM/diEFdFohRcWFAGDvkgioJtDR2c8ynwAtrqLCLcAhiCq+M+J57rHUlqjHA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr996516wmk.175.1594315509869;
        Thu, 09 Jul 2020 10:25:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id e5sm6352773wrs.33.2020.07.09.10.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:25:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: nSVM: vmentry ignores EFER.LMA and possibly
 RFLAGS.VM
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20200709095525.907771-1-pbonzini@redhat.com>
 <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com>
Date:   Thu, 9 Jul 2020 19:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 19:12, Jim Mattson wrote:
>> +
>> +       /* The processor ignores EFER.LMA, but svm_set_efer needs it.  */
>> +       efer &= ~EFER_LMA;
>> +       if ((nested_vmcb->save.cr0 & X86_CR0_PG)
>> +           && (nested_vmcb->save.cr4 & X86_CR4_PAE)
>> +           && (efer & EFER_LME))
>> +               efer |= EFER_LMA;
> The CR4.PAE check is unnecessary, isn't it? The combination CR0.PG=1,
> EFER.LMA=1, and CR4.PAE=0 is not a legal processor state.

Yeah, I was being a bit cautious because this is the nested VMCB and it
can be filled in with invalid state, but indeed that condition was added
just yesterday by myself in nested_vmcb_checks (while reviewing Krish's
CR0/CR3/CR4 reserved bit check series).

That said, the VMCB here is guest memory and it can change under our
feet between nested_vmcb_checks and nested_prepare_vmcb_save.  Copying
the whole save area is overkill, but we probably should copy at least
EFER/CR0/CR3/CR4 in a struct at the beginning of nested_svm_vmrun; this
way there'd be no TOC/TOU issues between nested_vmcb_checks and
nested_svm_vmrun.  This would also make it easier to reuse the checks in
svm_set_nested_state.  Maybe Maxim can look at it while I'm on vacation,
as he's eager to do more nSVM stuff. :D

I'll drop this patch for now.

Thanks for the speedy review!

Paolo

> According to the SDM,
> 
> * IA32_EFER.LME cannot be modified while paging is enabled (CR0.PG =
> 1). Attempts to do so using WRMSR cause a general-protection exception
> (#GP(0)).
> * Paging cannot be enabled (by setting CR0.PG to 1) while CR4.PAE = 0
> and IA32_EFER.LME = 1. Attempts to do so using MOV to CR0 cause a
> general-protection exception (#GP(0)).
> * CR4.PAE and CR4.LA57 cannot be modified while either 4-level paging
> or 5-level paging is in use (when CR0.PG = 1 and IA32_EFER.LME = 1).
> Attempts to do so using MOV to CR4 cause a general-protection
> exception (#GP(0)).
> 

