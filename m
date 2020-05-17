Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 06:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69434207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 06:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZNd9WxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEQGjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgEQGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 02:39:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C5C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 23:39:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y198so1629958pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=giiyGxJpm87EbQlUnTEEY4T8mtfUuD9q9mhH9A0THMY=;
        b=KZNd9WxGab+Wxx2FQYpQK99sEhKX0EoKcsTEvjvPB2y7NMoUBoKvcSkv/v7QP331tU
         e7dKpZXYUuyFm2A/aNXm06Aznk0GzKC0K0Am1PGl3RkaVdFNo4vKQhxgs0988c7wx34D
         jDvN0kI+j4vwpSac+x/zh69hjXxP2U4DI4Xu+AW7RWR01urRVl87VyYNZJd802nvta/k
         wfVEkrY3BeUMOjhlZF0tO+xAlFPTm2f5BcMEMEaJkdC6EqVGI7AcMTSfPRKJWM1d/iKr
         cXSlLOPPkDJo8rwy3R9/Oe9CQvTfi4K2ak7rUHsObV6Cspny7FsZ1zxgMGDd0dURsxDU
         kCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=giiyGxJpm87EbQlUnTEEY4T8mtfUuD9q9mhH9A0THMY=;
        b=sgY0iS0Q+EcR1vPJCaHCg4MZE8mX2F3TeFXA3fZrt2E/lwHZe6UsntSO7RUhQTdWip
         q26PtNLX4XzwhWfaogVdSm0c+tgsO8zQ3HCVpffnROSlenQHvAaN3bbirk66brjkbWhR
         pxuxwWz6cmhR4qyHDDl0zgbwVOmZdFA8zV1cjInkWzElhPP7Z7zQ0jzYFA95AFmj/tVT
         JP+eAvJLHoTTc5CnJUGwaSJfjsXjWPgPdnHev4sRLAIK3Y0Y++rRuiVFfORVayPvKKvK
         TLILjMq4epOVVswFg8T6m5IKCMd7fPZQTHvVh6Pf+KnOj6QZiPLxCDjNkVHjqxrV8Mz9
         vogQ==
X-Gm-Message-State: AOAM531SYpgHqbarTEyBwwLcGyIYzPFE4ejG65EapIOkqYm6G84F3N6Z
        d0sHKmdwgE6P+Q6q4xpAWAafEjRqW6Be6g3G6MGbKV6e
X-Google-Smtp-Source: ABdhPJz9Wc0b/rXgXC6zFchEKbbitNBEl08NrzHB+VnONl/exhhVxqMdiNhlz3AsS5yawpaD9vqc40/WfnFbO0q8OHQ=
X-Received: by 2002:a62:e51a:: with SMTP id n26mr11295162pff.301.1589697564158;
 Sat, 16 May 2020 23:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200516124857.75004-1-lecopzer@gmail.com> <20200516124857.75004-2-lecopzer@gmail.com>
In-Reply-To: <20200516124857.75004-2-lecopzer@gmail.com>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Sun, 17 May 2020 14:39:13 +0800
Message-ID: <CANr2M1_Jzw1Z6A2Gw4DgcKiZqUd1-Bzn-GM+g1CCHgQP597FBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm_pmu: Add support for perf NMI interrupts registration
To:     linux-kernel@vger.kernel.org
Cc:     Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, acme@kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, linux-mediatek@lists.infradead.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was some mistakes when merging this patch.
The free nmi part is not present :(

The following part will be added in V2 next weekend.

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index fa37b72d19e2..aa9ed09e5303 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -544,6 +544,38 @@ static int armpmu_count_irq_users(const int irq)
        return count;
 }

+static void armpmu_teardown_percpu_nmi_other(void* info)
+{
+       /*
+        * We don't need to disable preemption since smp_call_function()
+        * did this for us.
+        */
+       teardown_percpu_nmi((uintptr_t) info);
+}
+
+static void _armpmu_free_irq(unsigned int irq, void *dev_id)
+{
+       if (armpmu_support_nmi())
+               free_nmi(irq, dev_id);
+       else
+               free_irq(irq, dev_id);
+}
+
+static void _armpmu_free_percpu_irq(unsigned int irq, void __percpu *dev_i=
d)
+{
+       if (armpmu_support_nmi()) {
+               preempt_disable();
+               teardown_percpu_nmi(irq);
+               smp_call_function(armpmu_teardown_percpu_nmi_other,
+                                 (void *)(uintptr_t) irq, true);
+               preempt_enable();
+
+               free_percpu_nmi(irq, dev_id);
+       }
+       else
+               free_percpu_irq(irq, dev_id);
+}
+
 void armpmu_free_irq(int irq, int cpu)
 {
        if (per_cpu(cpu_irq, cpu) =3D=3D 0)
@@ -552,9 +584,9 @@ void armpmu_free_irq(int irq, int cpu)
                return;

        if (!irq_is_percpu_devid(irq))
-               free_irq(irq, per_cpu_ptr(&cpu_armpmu, cpu));
+               _armpmu_free_irq(irq, per_cpu_ptr(&cpu_armpmu, cpu));
        else if (armpmu_count_irq_users(irq) =3D=3D 1)
-               free_percpu_irq(irq, &cpu_armpmu);
+               _armpmu_free_percpu_irq(irq, &cpu_armpmu);

        per_cpu(cpu_irq, cpu) =3D 0;
 }




Thanks,
Lecopzer

Lecopzer Chen <lecopzer@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=888:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Register perf interrupts by request_nmi()/percpu_nmi() when both
> ARM64_PSEUDO_NMI and ARM64_PSEUDO_NMI_PERF are enabled and nmi
> cpufreature is active.
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  drivers/perf/arm_pmu.c       | 51 +++++++++++++++++++++++++++++++-----
>  include/linux/perf/arm_pmu.h |  6 +++++
>  2 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index df352b334ea7..fa37b72d19e2 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -559,6 +559,48 @@ void armpmu_free_irq(int irq, int cpu)
>         per_cpu(cpu_irq, cpu) =3D 0;
>  }
>
> +static void armpmu_prepare_percpu_nmi_other(void *info)
> +{
> +       /*
> +        * We don't need to disable preemption since smp_call_function()
> +        * did this for us.
> +        */
> +       prepare_percpu_nmi((uintptr_t) info);
> +}
> +
> +static int _armpmu_request_irq(unsigned int irq, irq_handler_t handler,
> +                              unsigned long flags, int cpu)
> +{
> +       if (armpmu_support_nmi())
> +               return request_nmi(irq, handler, flags, "arm-pmu",
> +                                  per_cpu_ptr(&cpu_armpmu, cpu));
> +       return request_irq(irq, handler, flags, "arm-pmu",
> +                          per_cpu_ptr(&cpu_armpmu, cpu));
> +}
> +
> +static int _armpmu_request_percpu_irq(unsigned int irq, irq_handler_t ha=
ndler)
> +{
> +       if (armpmu_support_nmi()) {
> +               int err;
> +
> +               err =3D request_percpu_nmi(irq, handler, "arm-pmu",
> +                                        &cpu_armpmu);
> +               if (err)
> +                       return err;
> +
> +               preempt_disable();
> +               err =3D prepare_percpu_nmi(irq);
> +               if (err) {
> +                       return err;
> +                       preempt_enable();
> +               }
> +               smp_call_function(armpmu_prepare_percpu_nmi_other,
> +                                 (void *)(uintptr_t) irq, true);
> +               preempt_enable();
> +       }
> +       return request_percpu_irq(irq, handler, "arm-pmu",
> +                                 &cpu_armpmu);
> +}
> +
>  int armpmu_request_irq(int irq, int cpu)
>  {
>         int err =3D 0;
> @@ -582,12 +624,9 @@ int armpmu_request_irq(int irq, int cpu)
>                             IRQF_NO_THREAD;
>
>                 irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -               err =3D request_irq(irq, handler, irq_flags, "arm-pmu",
> -                                 per_cpu_ptr(&cpu_armpmu, cpu));
> -       } else if (armpmu_count_irq_users(irq) =3D=3D 0) {
> -               err =3D request_percpu_irq(irq, handler, "arm-pmu",
> -                                        &cpu_armpmu);
> -       }
> +               err =3D _armpmu_request_irq(irq, handler, irq_flags, cpu)=
;
> +       } else if (armpmu_count_irq_users(irq) =3D=3D 0)
> +               err =3D _armpmu_request_percpu_irq(irq, handler);
>
>         if (err)
>                 goto err_out;
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 5b616dde9a4c..5b878b5a22aa 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -160,6 +160,12 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
>  static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0;=
 }
>  #endif
>
> +static inline bool armpmu_support_nmi(void)
> +{
> +       return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI_PERF) &&
> +              system_uses_irq_prio_masking();
> +}
> +
>  /* Internal functions only for core arm_pmu code */
>  struct arm_pmu *armpmu_alloc(void);
>  struct arm_pmu *armpmu_alloc_atomic(void);
> --
> 2.25.1
>
