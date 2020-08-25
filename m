Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78541C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52569204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUG8Zr3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHYCJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHYCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:09:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:09:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t185so2983818pfd.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=1MXA3SRqBv7A997PGPLT6iMqC9JgDRP5trVk6SDwSRk=;
        b=UUG8Zr3WLa472hz4nXndYk3436bANr5aJ7JosZ8om/t2IG4ImI2WXuyJqcgupsK3Y/
         0TT8bDU3UZZvSD1h+EcytmBzvt/JO9SVVlItZVT9s3RR+Pecr5CQRhiFpaCHyRL7RsNi
         N6pfkM6zcqjMXUUchzG8hr7yT4X6U8pPXBrHhAW/dbNjJODsYpH9cIsF8yfrWljbxzL4
         9JDRRf8H9cUAUr59iDDoYiTgBphsmKaie8eaUwjieOKU5FeF3lxxceWmZcZgzBw3hmTM
         0C5KRB7qODQJeIEaqbX7c92YL95RwvOhN8OZtGt2W5DHExh7F7K2rCSR7ooV1wUurDk7
         ceAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=1MXA3SRqBv7A997PGPLT6iMqC9JgDRP5trVk6SDwSRk=;
        b=h9WvUwKYkJr6uDqctN89b8/wXlh2kUZNfpuuO+OvffVjygHTEzkxwEG7e7A2fYwKJX
         hju8Q7b7zIRUqaudk0rlMxr8Tq6hJ5ChdSDz5Qpc4EibDrXj7EzeyJV7NDi6JxKYZoZP
         BMY7zbviSatISHGAO2/YKvw8ewBZWHyg9GqMBmbELHpH1Wg2cjiP9a6G7XKtJf5y1hO6
         gpbGfQZTG6UbwMIUGojuAc3TevWMnwr29XQMO774Y2TSp4FVZaAV0u1j5zD94Za5qniW
         MKBSE1Sv5CwYFPcv7qRH3Eyg1pZnJZ+A4Lm3OYZx1TPIWUgUIvy7vAGOpBqUmUcr2020
         52TQ==
X-Gm-Message-State: AOAM532M3y+6R9F94vyc6T7uoFo3VqTgK3uqws70cwNnJRjW9fdDDKQF
        HnRPP3nCiQHa+i8gb5YC1tpQ
X-Google-Smtp-Source: ABdhPJz+BrPFYQSP8XOOfKDFESrUH+ZxyKJZ54XGWUXECVmlABQcYSfB2Q/cGxJhsISKoBOQNq8Uww==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr3541370plb.172.1598321378462;
        Mon, 24 Aug 2020 19:09:38 -0700 (PDT)
Received: from ?IPv6:2409:4072:514:1a63:11c2:1447:3b94:7811? ([2409:4072:514:1a63:11c2:1447:3b94:7811])
        by smtp.gmail.com with ESMTPSA id f3sm13172676pfj.206.2020.08.24.19.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 19:09:37 -0700 (PDT)
Date:   Tue, 25 Aug 2020 07:39:32 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200822230513.GA2260050@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com> <20200822131712.GB5954@Mani-XPS-13-9360> <20200822230513.GA2260050@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/3] Add Actions Semi Owl family sirq support
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <48A6F999-D0A4-4E45-987F-0818E7FEA153@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 August 2020 4:35:13 AM IST, Cristian Ciocaltea <cristian=2Eciocaltea=
@gmail=2Ecom> wrote:
>Hi Mani,
>
>On Sat, Aug 22, 2020 at 06:47:12PM +0530, Manivannan Sadhasivam wrote:
>> Hi Cristi,
>>=20
>> On Wed, Aug 19, 2020 at 07:37:55PM +0300, Cristian Ciocaltea wrote:
>> > This patch series adds support for the external interrupt
>controller
>> > (SIRQ) found in the Actions Semi Owl family of SoC's (S500, S700
>and
>> > S900)=2E The controller handles up to 3 external interrupt lines
>through
>> > dedicated SIRQ pins=2E
>> >=20
>> > This is a rework of the patch series submitted some time ago by=20
>> > Parthiban Nallathambi:=20
>> > https://lore=2Ekernel=2Eorg/lkml/20181126100356=2E2840578-1-pn@denx=
=2Ede/
>> >=20
>>=20
>> You need to preserve the authorship while reposting the patches=2E If
>you'd
>> like to take the authorship intentionally then please explain the
>reason in
>> cover letter=2E
>>=20
>> Thanks,
>> Mani
>
>Thanks for pointing this out, I was not aware of the procedure - this
>is
>actually my very first repost=2E Could you please indicate how should I
>proceed to fix this? I had absolutely no intention to take the
>authorship=2E=2E
>

Below command would change the author of last commit:

git commit --amend --author=3D"Manivannan Sadhasivam <manivannan=2Esadhasi=
vam@linaro=2Eorg>"

>Sorry for the mistake,

No issues!=20

Thanks,=20
Mani

>Cristi
>
>> > Please note I have dropped, for the moment, the S700 related
>patches=20
>> > since I do not own a compatible hardware for testing=2E I'm using
>instead
>> > an S500 SoC based board for which I have already provided the
>initial
>> > support:
>> >
>https://lore=2Ekernel=2Eorg/lkml/cover=2E1592123160=2Egit=2Ecristian=2Eci=
ocaltea@gmail=2Ecom/
>> >=20
>> > The SIRQ controller support is a prerequisite of the soon to be
>submitted
>> > MFD driver for the Actions Semi ATC260x PMICs=2E
>> >=20
>> > Thanks and regards,
>> > Cristi
>> >=20
>> > Changes in v5:
>> > - Integrated Marc's review (more details in the driver patch
>changelog)
>> > - Rebased patch series on v5=2E9-rc1
>> >=20
>> > Changes in v4:
>> > - Simplified the DTS structure:
>> >   * dropped 'actions,sirq-shared-reg' node, now the differentiation
>> >     between SoC variants is handled now via the compatible property
>> >   * dropped 'actions,sirq-reg-offset', now controller base address
>in
>> >     DTS points to SIRQ0 register, so no additional information is
>> >     required for S500 and S700, while for S900 SoC the offsets of
>SIRQ1
>> >     and SIRQ2 regs are provided by the driver
>> >   * 'actions,ext-irq-range' was replaced with
>'actions,ext-interrupts',
>> >     an array of the GIC interrupts triggered by the controller
>> > - Fixed wrong INTC_EXTCTL_TYPE_MASK definition
>> > - Removed redundant irq_fwspec checks in owl_sirq_domain_alloc()
>> > - Improved error handling in owl_sirq_of_init()
>> > - Added yaml binding document
>> > - Dropped S700 related DTS patches for lack of testing hardware:
>> >   * arm64: dts: actions: Add sirq node for Actions Semi S700
>> >   * arm64: dts: actions: s700-cubieboard7: Enable SIRQ
>> > - Updated MAINTAINERS
>> > - Rebased patchset on kernel v5=2E8
>> > - Cosmetic changes
>> >  * Ordered include statements alphabetically
>> >  * Added comment to owl_sirq_set_type() describing conversion of
>falling
>> >    edge or active low signals
>> >  * Replaced IRQF_TRIGGER_* with corresponding IRQ_TYPE_* variants
>> >  * Ensured data types and function naming are consistent regarding
>the
>> >    'owl_sirq' prefix
>> >=20
>> > Changes in v3 (Parthiban Nallathambi):
>> > - Set default operating frequency to 24MHz
>> > - Falling edge and Low Level interrupts translated to rising edge
>and high level
>> > - Introduced common function with lock handling for register read
>and write
>> > - Used direct GIC interrupt number for interrupt local hwirq and
>finding offset
>> > using DT entry (range) when registers are shared=20
>> > - Changed irq_ack to irq_eoi
>> > - Added translation method for irq_domain_ops
>> > - Clearing interrupt pending based on bitmask for edge triggered
>> > - Added pinctrl definition for sirq for cubieboard7=2E This depends
>on,
>> > https://lore=2Ekernel=2Eorg/patchwork/patch/1012859/
>> >=20
>> > Changes in v2 (Parthiban Nallathambi):
>> > - Added SIRQ as hierarchical chip
>> >         GIC <----> SIRQ <----> External interrupt controller/Child
>devices
>> > - Device binding updates with vendor prefix
>> > - Register sharing handled globally and common init sequence/data
>for all
>> > actions SoC family
>> >=20
>> > Cristian Ciocaltea (3):
>> >   dt-bindings: interrupt-controller: Add Actions SIRQ controller
>binding
>> >   irqchip: Add Actions Semi Owl SIRQ controller
>> >   MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
>> >=20
>> >  =2E=2E=2E/actions,owl-sirq=2Eyaml                     |  68 ++++
>> >  MAINTAINERS                                   |   2 +
>> >  drivers/irqchip/Makefile                      |   1 +
>> >  drivers/irqchip/irq-owl-sirq=2Ec                | 347
>++++++++++++++++++
>> >  4 files changed, 418 insertions(+)
>> >  create mode 100644
>Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq=
=2Eyaml
>> >  create mode 100644 drivers/irqchip/irq-owl-sirq=2Ec
>> >=20
>> > --=20
>> > 2=2E28=2E0
>> >=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
