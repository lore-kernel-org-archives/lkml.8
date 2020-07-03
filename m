Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3E72073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjD4dhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGCQaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:30:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E652DC061794;
        Fri,  3 Jul 2020 09:30:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so34877154ejj.5;
        Fri, 03 Jul 2020 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZ1+T6J0Ni960NYvo1eswvIO/HAOFnUlkVGnAMuIgxk=;
        b=lBjD4dhVanRWSWvbuR+jiGQEGFbptLkYYnLLhxXlf0G+nlF1EsP1YfRCSVx54CVl4o
         lzVgNVYXuFq7MIf+8jM47uEU3T3FK6N8kVN3WpsSfQjfJpSxcOhG/B2ph/a4NvrAgGZf
         Z+0qLSFrTZtBaaUzVxqmexECPEdFLLdZPjmpil5i9MRzuOtvQdTyvwWQeve1a0kARlDZ
         bZldku7ExsXTgjR88sjv/dgPWJMaHZrbYeKTtJgq3iSNEs+CztNZ1g8lnfEzlFOc7tzx
         y4uZJeaYg4heElWq32vF0eNPOXwCZO4uymQnBMCts3FHRKM7GewWqJAZ6kOKriEpwbLU
         fnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZ1+T6J0Ni960NYvo1eswvIO/HAOFnUlkVGnAMuIgxk=;
        b=MY1frqnOpAngA+26YuPhu9thHG23zg/cye5g4AICOhEoX7cLskg2JlD2iYbns+p51P
         V529w0iX+AvPtbZt3YyQ/Q1PHrS3DM1sUDMSCv8oNaJcDqosQtmeJFNmdJ1vW++lRPLq
         bi8HP+s7uYxuBlB1QUWw7Eaah2W3v72ZHaZnxBBYv1Z7Ww1mj2xEKntjTCxUr5cSHQC1
         DOV7NoKdiHpOJrZlUXTGrM8+Y8cfVUoJgEBgwZs9zVnXlZmf4hMVvxQ/KcYfubOUF4YD
         meudKw2qkaF4aDNjSkLykVwN6sHmBL25bR+LuZdwL413rVa6YCuujPXdgAC3uhD4Nkvm
         zZZw==
X-Gm-Message-State: AOAM530pdFK8TXsGAzbJEGYYxacTew3os4SoMpjXOF9vGdn2UiOR4e9/
        d2LRn524rIl5Q2kXSvZhFg+ZmFLqQ6dpAqb5Vdc=
X-Google-Smtp-Source: ABdhPJyrpPvbvu+7fsLvXQ5QwrtZszjqtmjACLXCYmIRdtOpRb5SPnOXOESXhJKYkGa42B79UNHA5NRDA6f12+i3JOw=
X-Received: by 2002:a17:906:ae56:: with SMTP id lf22mr32577974ejb.59.1593793809278;
 Fri, 03 Jul 2020 09:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200703155645.29703-1-valentin.schneider@arm.com> <20200703155645.29703-2-valentin.schneider@arm.com>
In-Reply-To: <20200703155645.29703-2-valentin.schneider@arm.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 3 Jul 2020 19:29:58 +0300
Message-ID: <CADxRZqxcLXz4wp6Bj7=MWx04BJ7cHmHy6o_f+1V9_yNXNHH6-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] sparc64: Deselect IRQ_PREFLOW_FASTEOI
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 6:58 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> sparc64 hasn't needed to select this since commit:
>
>   ee6a9333fa58 ("sparc64: sparse irq")
>
> which got rid of the calls to __irq_set_preflow_handler() first installed
> by commit:
>
>   fcd8d4f49869 ("sparc: Use the new genirq functionality")
>
> Deselect this option.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/sparc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index da515fdad83d..ed35760043e8 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -81,7 +81,6 @@ config SPARC64
>         select RTC_DRV_STARFIRE
>         select HAVE_PERF_EVENTS
>         select PERF_USE_VMALLOC
> -       select IRQ_PREFLOW_FASTEOI
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
>         select HAVE_C_RECORDMCOUNT
>         select HAVE_ARCH_AUDITSYSCALL


tried/tested this patch on my test sparc64 ldom , boots ok
