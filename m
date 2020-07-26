Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85E9C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9796A2053B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pW3nnfGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGZD6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 23:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgGZD6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:58:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A4C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 20:58:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so7325194pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcaev1Cp7bKZYJR/UD71l80ZfPg2FMWy0HIr5qj2bGY=;
        b=pW3nnfGF9WNDmVTg3erlNCt9uor03x6BZY37vmHSdP/xICtKgeoqTIYUtOqGOGI6kx
         wuXTf9SMQ2Z/ErYmpP7TYebvPZRaAte8jmiOKquFASWUAxefXF8STiy/6P/Jv7R00kBl
         57dQfKZ8WNigXDUijzvOgs/mNBoEIxbs9PlpEC38RImsjO2WVr8iPSXNIl87vtl9a9qq
         i3tHldUSxyybwQGYKtwc1pCYThrLKg67f/t+eRlWvRje+OjBVUmB/EbiwIKg5Ks97btC
         yz7ob2Qp8v5wYvw5b7+lebRQDzRVb9I7zg9817yrUOdm0QQ/Spsbpv7a9Cyl4JlpmWF6
         x7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcaev1Cp7bKZYJR/UD71l80ZfPg2FMWy0HIr5qj2bGY=;
        b=qTEAq43Q8gmD9a/vymQACHosxCDt0Roo1fVSDIx/qAAOxEmVqecIUUI6LDQYMcct17
         jxHcJ5v03LdDTlKNmRWyCFJDo1q2ZtXE098xYjQdb3uEFMQykvr5iPifGE0i8hw6iXIx
         6grDej7LU+yqbIym79JgsFrLZ0EHEEIitCrv6wwmkdJOqN5UhGjppc9xv3Z4gF0Yv6SJ
         gdHXqDnXCCuU4uTUyB2nSxONTtCDMZKChT0M9B690a9ldUQ8PLrDNXnQBEF4+gT86KoS
         v+wWso/QV5kKkKvKvsDklNj2rhxJVc1e/ugbUthbYkHOO8vIUkJFld6B3XGE1F9i6hTl
         5P8Q==
X-Gm-Message-State: AOAM530pRDipUfxpbhrXnWy+oBIMl5cdUzL7kBuX6qH8/iet6x/qa7gv
        //Ik4Af99x+7fEtFjpEEiR2bbtpTpP6vsYPIRaJq3599
X-Google-Smtp-Source: ABdhPJwXraTjC6SZ1tebNEZfR+TFnQAO2mmQKDrLOibMydwILen7cWd7OX+0bEwRfZm/OlR0+VbdaTmWP6YaljsQzW0=
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr1036997pjb.51.1595735922224;
 Sat, 25 Jul 2020 20:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com> <159568680935.564881.11936174169505990646.b4-ty@kernel.org>
In-Reply-To: <159568680935.564881.11936174169505990646.b4-ty@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 25 Jul 2020 20:58:06 -0700
Message-ID: <CAGETcx8qyn8TmwvTrXkYEj78MdCNr+HxV0x7JTc8Wvo0VanKEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] irqchip: Add IRQCHIP_PLATFORM_DRIVER helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        marex@denx.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Loda Chou <loda.chou@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 7:23 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 17 Jul 2020 17:06:33 -0700, Saravana Kannan wrote:
> > Made a series out of the previous v2 patch + some example uses of the
> > macros.
> >
> > Not sure if the MTK changes work (just compile tested), but saw that
> > Hanks was trying to make those drivers into tristate. So I assume
> > they'll work as platform drivers. Please wait for MTK Ack before picking
> > up patches 3 and 4.
> >
> > [...]
>
> Applied to irq/irqchip-5.9, thanks!
>
> [1/4] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
>       commit: f3b5e608ed6d17bdf04dacbf2374f10d51fe9b09
> [2/4] irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper macros
>       commit: 04741740254cd83fb4f2b7747aeb35202104f8fe
> [3/4] irqchip/mtk-sysirq: Convert to a platform driver
>       commit: 3ae3022690e6787839dafa8ea3496450248b53e1
> [4/4] irqchip/mtk-cirq: Convert to a platform driver
>       commit: 538b63351607960ff2249460089daa31337ddeba

Thanks!

-Saravana
