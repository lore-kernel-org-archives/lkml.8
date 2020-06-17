Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618F62088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUwEnnVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQUXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:23:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F8C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:23:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so1834857pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=eps4Ei5p4v0C3v2/fz1NIeuMiErn9v1jAL+UTG1cAZ4=;
        b=KUwEnnVuoDexMEaNIhuG4RLuBUPsEa0c8mx/p66yeGTJknY5jo5chKwZr87y1L3H+5
         FLevFJUpgH8KfcLzKSALX5DDxCB7+s9Mqo++j4RM5/MFcO9wC+IcBRKXSPpo8C7wyHud
         dj86nf9Qb1XbOuSKdsBKTtZI7uk0dkGUjuwmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=eps4Ei5p4v0C3v2/fz1NIeuMiErn9v1jAL+UTG1cAZ4=;
        b=QnPvWcKErSL6Hx5fF8YNd0ZvDTnu333PYiHVj6QqqMa9B76ax4ahh7c+k7Uyj08DNb
         yX8a+U4DQQ/QLxEhqliFVPDGQhjHWiwYaeqU157z6Hdg5PBSrvBLZHIsNHCQYzthdbwS
         1iapNocsrLJHcBT3AaSKLVmJyeer3tjunFsV2dexc1krvDORfnF2nbNknEmYzmhIrMdg
         2+JARULCHZVFLUiXDMUv/qUJtsMEyjo83FjjS1PDgiAZfnqhPAV65KtWYgp7vVkEcYDm
         XTByiJlSfHceZHF8jV+zfLwDCJNrokKBHAToeIlk2gk660oGj2RqP4VCTCFzJU+GXlXo
         Ytig==
X-Gm-Message-State: AOAM532xlX7yhaR/3as733nTxDtA9cCt+pmRucvLjNUaJsN29aSSJtMF
        xUGJdYnS0LoiMwMmkejFziRi7A==
X-Google-Smtp-Source: ABdhPJwWQgEdOfbFG7zAFOTYs510ibb89tg4xrESspvF0suYJlxtlkHG0lqpc/fh7RGBgnoPvxH+kg==
X-Received: by 2002:a65:6550:: with SMTP id a16mr452402pgw.183.1592425393877;
        Wed, 17 Jun 2020 13:23:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s21sm615275pgg.8.2020.06.17.13.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:23:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200617113851.607706-7-alexandru.elisei@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-7-alexandru.elisei@arm.com>
Subject: Re: [PATCH v5 6/7] arm_pmu: Introduce pmu_irq_ops
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        maz@kernel.org, Will Deacon <will.deacon@arm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Jun 2020 13:23:12 -0700
Message-ID: <159242539231.62212.11549121838391298623@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-17 04:38:50)
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index df352b334ea7..17e5952d21e4 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -26,8 +26,46 @@
> =20
>  #include <asm/irq_regs.h>
> =20
> +static int armpmu_count_irq_users(const int irq);
> +
> +struct pmu_irq_ops {
> +       void (*enable_pmuirq)(unsigned int irq);
> +       void (*disable_pmuirq)(unsigned int irq);
> +       void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *dev=
id);

Does 'cpu' need to be signed?

> +};
> +
> +static void armpmu_free_pmuirq(unsigned int irq, int cpu, void __percpu =
*devid)
> +{
> +       free_irq(irq, per_cpu_ptr(devid, cpu));
> +}
> +
> +static const struct pmu_irq_ops pmuirq_ops =3D {
> +       .enable_pmuirq =3D enable_irq,
> +       .disable_pmuirq =3D disable_irq_nosync,
> +       .free_pmuirq =3D armpmu_free_pmuirq
> +};
> +
> +static void armpmu_enable_percpu_pmuirq(unsigned int irq)
> +{
> +       enable_percpu_irq(irq, IRQ_TYPE_NONE);
> +}
> +
> +static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
> +                                  void __percpu *devid)
> +{
> +       if (armpmu_count_irq_users(irq) =3D=3D 1)
> +               free_percpu_irq(irq, devid);
> +}
> +
> +static const struct pmu_irq_ops percpu_pmuirq_ops =3D {
> +       .enable_pmuirq =3D armpmu_enable_percpu_pmuirq,
> +       .disable_pmuirq =3D disable_percpu_irq,
> +       .free_pmuirq =3D armpmu_free_percpu_pmuirq
> +};
> +
>  static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
>  static DEFINE_PER_CPU(int, cpu_irq);

Same question as above.

> +static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
> =20
>  static inline u64 arm_pmu_event_max_period(struct perf_event *event)
>  {
