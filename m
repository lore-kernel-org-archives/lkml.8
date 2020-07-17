Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E7C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8C02076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zim79ws6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGQC4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGQC4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:56:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E835C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:56:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so4796720pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X8T8pz6At13CJCWKdkd4IkrZllcC3cL7n3XGkpoToo=;
        b=Zim79ws6Kq+0W4jp69vTApwxJi1ab1GZiZQmbPoc8ugOhcIoSw9LPZl0ztw2hGBqH1
         RKTDPHVJeM/qAS+KJdbxz7Jfxlu5ZwFIBaHVeX1uk8yLjjwI/qqF8/umOtCiA1fFvZrN
         4Mz1DgYnXqNWeRV+YbDi5KeqC2BsqGaa4DLXBB7nV8GDbekcrBrK36qc9L4AUuH/I2y7
         rJ8oSx9wMCp+IakhSKuK5+iyDQKabeC0JHx6OQBKCMdC3Rub/G2hu+RoZeqkEL/SOOQ4
         nIhE93A2nBDdvijxUUk5f0cNH6d7aqkqR/DWAHjgXuS2/jBKt2G39gjbPxdozOjKsL53
         Iwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X8T8pz6At13CJCWKdkd4IkrZllcC3cL7n3XGkpoToo=;
        b=I2spcDizXyvioaUMQMgIEr45Q3B+SnXTcoOoIQyn4HGSBIHUb9hoD69hT72GaofNtW
         E3xDh25JUX77bJiztNWqttvSPrAYcC2ev+jooOzo8zb0vsPHNGZ77MjRovufhWq/roGF
         VWPrUnzHRQ1ZKle/sqYpVqw75N7q/x56wBn6R9lwSEQ8NvoioN5DcX80pRKfi+CYoUN4
         Rd60VLyR+toF8s1R4RWDWuG1vj7a4c+wojTz/Mw+W3FW2xyMF5xL/cxgIwPULh2/IBVo
         VgPL2iYjupwns89vYQzWjh3/75Ivw4GR7quMpJ7MEVG19JhYuWQaUfZcuqTG1/7Pxttv
         yIDg==
X-Gm-Message-State: AOAM5307MnFdzbf+LrPoyvq4YIgZrfyzk+uX5EalWMt0UxHzyrBtFZUJ
        2+Ic9xZ0plZGWj10kx1ss11gD3/D9k8mVuBq5fECAA==
X-Google-Smtp-Source: ABdhPJyZ06nWdGCY8udX+H9WVLsopOuNsRhvU02zYFga6C7Wo1f6074+kEATFxvtpKfRKQE0LABLbsIy3/c1apoANY4=
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr5977536pls.244.1594954576802;
 Thu, 16 Jul 2020 19:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
 <f47e8a1e70c982ecf6245db573630f51@kernel.org> <1592490123.10773.16.camel@mtkswgap22>
 <1592894173.10773.42.camel@mtkswgap22> <3dc953265ed4cd4300bd9600bf7e33d6@kernel.org>
In-Reply-To: <3dc953265ed4cd4300bd9600bf7e33d6@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Jul 2020 19:55:41 -0700
Message-ID: <CAGETcx-daJxJ=Werw9fkmWHz=iUq1S-S63fz8KaKB4S-D+0oZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>, wsd_upstream@mediatek.com,
        Loda Chou <loda.chou@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 1:37 AM Marc Zyngier <maz@kernel.org> wrote:
>
> + Saravana
>
> On 2020-06-23 07:36, Hanks Chen wrote:
>
> [...]
>
> > Hi Marc,
> >
> > I want to break the dependency between ARCH_MEDIATEK and CIRQ/SYSIRQ,
> > because we need to follow the GKI.
>
> This isn't what GKI mandates. GKI requires that the SoC code is compiled
> as modules, not that it is dissociated from its platform (which would
> be completely pointless).
>
> > Could I add the MTK_CIRQ and MTK_SYSIRQ into defconfig?
> > (arch/arm64/config/defconfig)
>
> I don't deal with defconfig at all. That's a patch for the arm-soc
> people.
>
> >
> > It would ensures all platform are executable.
> >
> > e.g.
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> >
> >  CONFIG_QCOM_PDC=y
> > +CONFIG_MTK_SYSIRQ=m
> > +CONFIG_MTK_CIRQ=y
> >  CONFIG_RESET_QCOM_AOSS=y
> >
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -572,4 +572,18 @@ config LOONGSON_PCH_MSI
> >         help
> >           Support for the Loongson PCH MSI Controller.
> >
> > +config MTK_SYSIRQ
> > +       tristate "Mediatek interrupt polarity controller"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       help
> > +         Interrupt polarity controller driver to swap polarity for
> > +         interrupts for Mediatek mobile chips.
> > +
> > +config MTK_CIRQ
> > +       bool "Mediatek low-power interrupt controller"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       help
> > +         Low-power interrupt controller driver to monitor IRQS
> > +         in the sleep mode for Mediatek mobile chips.
> > +
> >
> >
> > P.S I'll make the irq-mtk-sysirq driver as a loadable kernel module for
> > GKI
>
> You might as well turn both drivers into modules. Saravana was working
> on a set of patches to ease this transition.

Sent out v2 of that patch now.
https://lore.kernel.org/lkml/20200717024447.3128361-1-saravanak@google.com/T/#u

-Saravana
