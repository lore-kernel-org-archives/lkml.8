Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDA620776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="czFUd1Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgFSIdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbgFSIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:33:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA15C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:33:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so1514591pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DxLF1QSYdlhCh6NZL9lmn8uNXMfSoRVrgwAtr7oZT4g=;
        b=czFUd1Jfcxsr/gudLfab9c+CCTq3xnDtsEMHFd3r480lJ4fgsRGvMZQDDhTIPFxXrX
         cIxDj30f/Wk7M/+djM0hRt7UZ8DA0X5MD7qP6m6ddEKjqhzxGWuzCBV95HWA5BN+SbF2
         CuTiI6mPAfQUJoVB8yd+LKok9tIbAJj/vpMUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DxLF1QSYdlhCh6NZL9lmn8uNXMfSoRVrgwAtr7oZT4g=;
        b=b/uvGWSgnogaxAQVMSt72H8leuEb6GGJjfgTywq+JNuTtqrScpYOa24ZoxnwOrtSMU
         LARw7ofMZqENahfFtf1ENiOZAzZY+tWmqsvfz5bzUHoNxpqd+Ibbw0994q6A99MSuwxM
         HaRT9S7FRFWvHS4mCqpNcffOOZL5C4506nc2HKoXvui2gq4JscC/0jMItUc4KquhtvdV
         IQVvLG8sbV3eDL4npLPhitL0yEGOQbqj4vTyal+wndty7lSR3h3zJgbgodzuiQHS1ETT
         UyMAQTznZ4SMISEnMKNDUKVGwmXGMAg9R6JIQES0+lBCanaG32ZUb+MQv3YHwQjtrooc
         O5bQ==
X-Gm-Message-State: AOAM532m69gfEUU8GcpMgrGJS/jkBX059/+rKszWla6hXMbwrKbx0pvb
        qYJpYIB+QiKXcivKTtAgdZKHKA==
X-Google-Smtp-Source: ABdhPJxh9NkKuR5QgKNed2psurq5OoIwxIxtvYn54t0bYKHdssnhTLFQ5n/2YwUBvXXcSHO6doPqJg==
X-Received: by 2002:aa7:9acc:: with SMTP id x12mr7140195pfp.24.1592555586085;
        Fri, 19 Jun 2020 01:33:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a7sm4578348pjd.2.2020.06.19.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:33:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8db25400-5a01-18f6-d362-af3ad229361a@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-7-alexandru.elisei@arm.com> <159242539231.62212.11549121838391298623@swboyd.mtv.corp.google.com> <8db25400-5a01-18f6-d362-af3ad229361a@arm.com>
Subject: Re: [PATCH v5 6/7] arm_pmu: Introduce pmu_irq_ops
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        maz@kernel.org, Will Deacon <will.deacon@arm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 01:33:04 -0700
Message-ID: <159255558463.62212.4785740630471861314@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-18 03:51:24)
> Hi,
>=20
> On 6/17/20 9:23 PM, Stephen Boyd wrote:
> > Quoting Alexandru Elisei (2020-06-17 04:38:50)
> >> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> >> index df352b334ea7..17e5952d21e4 100644
> >> --- a/drivers/perf/arm_pmu.c
> >> +++ b/drivers/perf/arm_pmu.c
> >> @@ -26,8 +26,46 @@
> >> =20
> >>  #include <asm/irq_regs.h>
> >> =20
> >> +static int armpmu_count_irq_users(const int irq);
> >> +
> >> +struct pmu_irq_ops {
> >> +       void (*enable_pmuirq)(unsigned int irq);
> >> +       void (*disable_pmuirq)(unsigned int irq);
> >> +       void (*free_pmuirq)(unsigned int irq, int cpu, void __percpu *=
devid);
> > Does 'cpu' need to be signed?
>=20
> I'm not sure what you mean. The cpu argument comes from
> drivers/perf/arm_pmu_platform.c::armpmu_free_irqs -> arpmu_free_irq, wher=
e is the
> iterator variable used by the macro for_each_cpu. The documentation for t=
he macro
> states:
>=20
> /**
> * for_each_cpu - iterate over every cpu in a mask
> * @cpu: the (optionally unsigned) integer iterator ^^^^^^^^^^^^^^^^^^^
>=20
> I could write a patch to convert to an unsigned int, but it seems like un=
necessary
> churn to me.

Ok. It would be nice to make it unsigned in the arm_pmu_platform.c file.
Not required for this patch series.
