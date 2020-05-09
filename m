Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A82C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A324420735
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpqzcQ4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEIM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:58:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726807AbgEIM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589029118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMVWh1mEzqEp+H77U0A+zFW74/ES0KTqoqYD9zfDHVk=;
        b=cpqzcQ4By5UH501M6QNbvHuKKlwkHjO4toDRa/GbaN48G4yj+D6ag/D+xP1r4R53TNf5DL
        lDnTH2CiIBuidrqXj1PllEvzaSrn6bpY1oi20SgKaFRYIQ+Zs1NCDt/m4e53ZaTryxyzQM
        vvPnQv+d9p4wcEvcFjtWVAyvNbH+3eU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-tJ57hkl0MZq9ezS9MOSFIg-1; Sat, 09 May 2020 08:58:35 -0400
X-MC-Unique: tJ57hkl0MZq9ezS9MOSFIg-1
Received: by mail-wr1-f70.google.com with SMTP id g10so2350881wrr.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMVWh1mEzqEp+H77U0A+zFW74/ES0KTqoqYD9zfDHVk=;
        b=LwPRBQRTKbppX/whn3V0YRDjl0nE3q623avQgqL7tY1UwFRTP+l3yl5lJKCS8m9zvI
         GNvMrWfVN/LzKlf9sFE+UuVtArDx59yFRHbFnTHDno5C9i8dHSVYCR/wBpr0SmvcSIwN
         f9LCT5nSd8eheDFQVTuP3YIQnuJ1eBAFQCivyB6juiK6o6vm3LhjX/4NFUGhqlUADFbt
         i6frECiEOtM2PGkYrDJYwGZWBFGDaP2I8Pr7Y5u9gRle9NVUoEK2oDHJbIsavlwippPT
         LZ8IzvhCB45PbijjocIK6Ghlg7Q96dkqmyMAsyK2hXhBspePT3QtRNTc3ax+UkW2R5uE
         s+BQ==
X-Gm-Message-State: AGi0PubvJYXJok1WgBF84Oeihccm5v6pOq36WZjn6i5eeaW5Fc1iIcR3
        H6zx0r810uoTwJCSqAkjBj4HLFgdTksXjbSDqzOfMsTlBAGZV+aOfkDZvzDAPSXSspYd6p54Q2Y
        U8LBHYNUtxco5MH+CKD2UShzj
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr1466335wmf.183.1589029113622;
        Sat, 09 May 2020 05:58:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKq4Rk8OD2T4G72wvoaVVvKImJJwsZJ+gbZPfWKklL8AEJZ1rTGr/sDTr1PsG7tp0d8p/dZEg==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr1466307wmf.183.1589029113323;
        Sat, 09 May 2020 05:58:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cb4:2b36:6750:73ce? ([2001:b07:6468:f312:1cb4:2b36:6750:73ce])
        by smtp.gmail.com with ESMTPSA id x12sm8175828wrp.55.2020.05.09.05.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 05:58:32 -0700 (PDT)
Subject: Re: [PATCH kvm-unit-tests] svm: Test V_IRQ injection
To:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200509111622.2184-1-cavery@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4097f4fe-f941-a8ef-8d93-3164f0b0441d@redhat.com>
Date:   Sat, 9 May 2020 14:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200509111622.2184-1-cavery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/20 13:16, Cathy Avery wrote:
> Test V_IRQ injection from L1 to L2 with V_TPR less
> than or greater than V_INTR_PRIO. Also test VINTR
> intercept with differing V_TPR and V_INTR_PRIO.
> 
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
>  x86/svm_tests.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index 65008ba..aa6f3c2 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -1595,6 +1595,153 @@ static bool exc_inject_check(struct svm_test *test)
>      return count_exc == 1 && get_test_stage(test) == 3;
>  }
>  
> +static volatile bool virq_fired;
> +
> +static void virq_isr(isr_regs_t *regs)
> +{
> +    virq_fired = true;
> +}
> +
> +static void virq_inject_prepare(struct svm_test *test)
> +{
> +    handle_irq(0xf1, virq_isr);
> +    default_prepare(test);
> +    vmcb->control.int_ctl = V_INTR_MASKING_MASK | V_IRQ_MASK |
> +                            (0x0f << V_INTR_PRIO_SHIFT); // Set to the highest priority
> +    vmcb->control.int_vector = 0xf1;
> +    virq_fired = false;
> +    set_test_stage(test, 0);
> +}
> +
> +static void virq_inject_test(struct svm_test *test)
> +{
> +    if (virq_fired) {
> +        report(false, "virtual interrupt fired before L2 sti");
> +        set_test_stage(test, -1);
> +        vmmcall();
> +    }
> +
> +    irq_enable();
> +    asm volatile ("nop");
> +    irq_disable();
> +
> +    if (!virq_fired) {
> +        report(false, "virtual interrupt not fired after L2 sti");
> +        set_test_stage(test, -1);
> +    }
> +
> +    vmmcall();
> +
> +    if (virq_fired) {
> +        report(false, "virtual interrupt fired before L2 sti after VINTR intercept");
> +        set_test_stage(test, -1);
> +        vmmcall();
> +    }
> +
> +    irq_enable();
> +    asm volatile ("nop");
> +    irq_disable();
> +
> +    if (!virq_fired) {
> +        report(false, "virtual interrupt not fired after return from VINTR intercept");
> +        set_test_stage(test, -1);
> +    }
> +
> +    vmmcall();
> +
> +    irq_enable();
> +    asm volatile ("nop");
> +    irq_disable();
> +
> +    if (virq_fired) {
> +        report(false, "virtual interrupt fired when V_IRQ_PRIO less than V_TPR");
> +        set_test_stage(test, -1);
> +    }
> +
> +    vmmcall();
> +    vmmcall();
> +}
> +
> +static bool virq_inject_finished(struct svm_test *test)
> +{
> +    vmcb->save.rip += 3;
> +
> +    switch (get_test_stage(test)) {
> +    case 0:
> +        if (vmcb->control.exit_code != SVM_EXIT_VMMCALL) {
> +            report(false, "VMEXIT not due to vmmcall. Exit reason 0x%x",
> +                   vmcb->control.exit_code);
> +            return true;
> +        }
> +        if (vmcb->control.int_ctl & V_IRQ_MASK) {
> +            report(false, "V_IRQ not cleared on VMEXIT after firing");
> +            return true;
> +        }
> +        virq_fired = false;
> +        vmcb->control.intercept |= (1ULL << INTERCEPT_VINTR);
> +        vmcb->control.int_ctl = V_INTR_MASKING_MASK | V_IRQ_MASK |
> +                            (0x0f << V_INTR_PRIO_SHIFT);
> +        break;
> +
> +    case 1:
> +        if (vmcb->control.exit_code != SVM_EXIT_VINTR) {
> +            report(false, "VMEXIT not due to vintr. Exit reason 0x%x",
> +                   vmcb->control.exit_code);
> +            return true;
> +        }
> +        if (virq_fired) {
> +            report(false, "V_IRQ fired before SVM_EXIT_VINTR");
> +            return true;
> +        }
> +        vmcb->control.intercept &= ~(1ULL << INTERCEPT_VINTR);
> +        break;
> +
> +    case 2:
> +        if (vmcb->control.exit_code != SVM_EXIT_VMMCALL) {
> +            report(false, "VMEXIT not due to vmmcall. Exit reason 0x%x",
> +                   vmcb->control.exit_code);
> +            return true;
> +        }
> +        virq_fired = false;
> +        // Set irq to lower priority
> +        vmcb->control.int_ctl = V_INTR_MASKING_MASK | V_IRQ_MASK |
> +                            (0x08 << V_INTR_PRIO_SHIFT);
> +        // Raise guest TPR
> +        vmcb->control.int_ctl |= 0x0a & V_TPR_MASK;
> +        break;
> +
> +    case 3:
> +        if (vmcb->control.exit_code != SVM_EXIT_VMMCALL) {
> +            report(false, "VMEXIT not due to vmmcall. Exit reason 0x%x",
> +                   vmcb->control.exit_code);
> +            return true;
> +        }
> +        vmcb->control.intercept |= (1ULL << INTERCEPT_VINTR);
> +        break;
> +
> +    case 4:
> +        // INTERCEPT_VINTR should be ignored because V_INTR_PRIO < V_TPR
> +        if (vmcb->control.exit_code != SVM_EXIT_VMMCALL) {
> +            report(false, "VMEXIT not due to vmmcall. Exit reason 0x%x",
> +                   vmcb->control.exit_code);
> +            return true;
> +        }
> +        break;
> +
> +    default:
> +        return true;
> +    }
> +
> +    inc_test_stage(test);
> +
> +    return get_test_stage(test) == 5;
> +}
> +
> +static bool virq_inject_check(struct svm_test *test)
> +{
> +    return get_test_stage(test) == 5;
> +}
> +
>  #define TEST(name) { #name, .v2 = name }
>  
>  /*
> @@ -1750,6 +1897,9 @@ struct svm_test svm_tests[] = {
>      { "nmi_hlt", smp_supported, nmi_prepare,
>        default_prepare_gif_clear, nmi_hlt_test,
>        nmi_hlt_finished, nmi_hlt_check },
> +    { "virq_inject", default_supported, virq_inject_prepare,
> +      default_prepare_gif_clear, virq_inject_test,
> +      virq_inject_finished, virq_inject_check },
>      TEST(svm_guest_state_test),
>      { NULL, NULL, NULL, NULL, NULL, NULL, NULL }
>  };
> 

Queued, thanks.

Paolo

