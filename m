Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F38C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11079206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598968401;
	bh=mI5loyu1Y/tc5SvQVWEfX8DOvn19LmCbUnJb4i42P7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S4hnwcxMbgOpX/JZPZFC2jBUzUNrUW11GgSVC1uBCsolaNcB7wXM01zSQyCf2A/zc
	 4Mtic4cpOuLmUhLU6aDNSf5dHm1oKZkvZ/d0Plrbyw4VhfA+b+TPTrqqCL3bcPaNun
	 QH2d+3RA2wX0nV1kfKAPmzq2L8td6BUAG8Pdj+oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIANwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgIANvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:51:54 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AF920FC3;
        Tue,  1 Sep 2020 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598968282;
        bh=mI5loyu1Y/tc5SvQVWEfX8DOvn19LmCbUnJb4i42P7M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X9hapkz+lJuyZ2B5tbcXH7w2Ufo8Rp920wemATCR6WhjDBQ6pEjEHX2Tb5PxLWHBL
         IBPFLC/24evBLDPiFKZALPta4JpAVw8TaZPVNgqtqt7OVkIuZg7xLb3VFq57LM/I1C
         /Vd3AEnS9RCLLC0OCsS599zf++IRqnwoekab5SoI=
Received: by mail-ej1-f54.google.com with SMTP id h4so1794320ejj.0;
        Tue, 01 Sep 2020 06:51:21 -0700 (PDT)
X-Gm-Message-State: AOAM530iXAbM2/yql9A1d9qDNzOmk0VDd4Qjf7ii0rIJ/4Drf3D9acae
        oTqpDltgDqtbVBv0tKF0BaxU5URUJs1IfAWQIHU=
X-Google-Smtp-Source: ABdhPJyMVdPxgQ8C7jJmzqSXYOjNfFjncTudLd43V/VYCjvhae0wrEHggzpOadKxMi2piJ5FsJnbe7lg9Da8X1RKcKo=
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr1530807ejb.454.1598968280357;
 Tue, 01 Sep 2020 06:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
 <c0509b5f-a064-2e73-7e04-51f41a56d222@collabora.com> <CAJKOXPczS_RpSFpjGygZ_1MCYxJ_cUDRjriZvrHd6+zhmq=c8Q@mail.gmail.com>
In-Reply-To: <CAJKOXPczS_RpSFpjGygZ_1MCYxJ_cUDRjriZvrHd6+zhmq=c8Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 1 Sep 2020 15:51:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfT7LvHVpTdaQ1voVi=OtC4aV6hbyzcekmrPMkb+5ebNg@mail.gmail.com>
Message-ID: <CAJKOXPfT7LvHVpTdaQ1voVi=OtC4aV6hbyzcekmrPMkb+5ebNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: exynos: clear L310_AUX_CTRL_NS_LOCKDOWN in
 default l2c_aux_val
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 15:45, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 1 Sep 2020 at 15:34, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> >
> > Hi Krzysztof, Russell,
> >
> > On 10/08/2020 13:22, Guillaume Tucker wrote:
> > > The L310_AUX_CTRL_NS_LOCKDOWN flag is set during the L2C enable
> > > sequence.  There is no need to set it in the default register value,
> > > this was done before support for it was implemented in the code.  It
> > > is not set in the hardware initial value either.
> > >
> > > Clean this up by removing this flag from the default l2c_aux_val, and
> > > add it to the l2c_aux_mask to print an alert message if it was already
> > > set before the kernel initialisation.
> > >
> > > Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> > > ---
> > >
> > > Notes:
> > >     v2: fix flag name L310_AUX_CTRL_NS_LOCKDOWN
> > >
> > >  arch/arm/mach-exynos/exynos.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > I believe this v2 series has addressed all previous comments and
> > you were waiting for the 5.9 merge window to end.  The patches
> > all still apply cleanly on v5.9-rc3.  Do you want me to resend
> > the series anyway or is there anything else needed at this point?
> >
> > Maybe one thing that wasn't completely clear in v1 was whether
> > patch 2/4 was the right approach.  I've explained the reason
> > behind it but didn't get a final reply from Russell[1].
>
> I am sorry, my bad. I already applied this one and 3/4 (dts).
> Apparently I forgot to reply with confirmation and Patchwork did not
> notify you for some reason.
>
> Patch 2/4 does not look like one for me so I would need ack from
> Russell to take. Did you submit it to the ARM patches queue?
> Patch 4/4 will wait for v5.10-rc1 as it depends on 1/4 and it is DTS patch.

Correct: Patch 4/4 will wait for v5.10 because it depends on the DTS patch.

Best regards,
Krzysztof
