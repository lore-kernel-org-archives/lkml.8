Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07040C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BD52068F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598866684;
	bh=EHA+yyfRzZHd0hQyJ+TVmjv/gqYm0Gm7uGiiBljNENU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wAJCHMEojikGuVFs4S1+hhLFBlUlvCxoFbWV9h4UqSdxuoSMP6Egaxu4SFmsqxrHL
	 nBV1U8lyME/ngvLbELPu4TdLGPQiVJjz1JYL2LNBMpLL0EKvi+pGJS4YseiIGB4YKS
	 0kLsbkL9tFtKXaGZchxYUN9QZ3zYykplYPBmjRIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHaJiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgHaJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:38:02 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE9020EDD;
        Mon, 31 Aug 2020 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598866682;
        bh=EHA+yyfRzZHd0hQyJ+TVmjv/gqYm0Gm7uGiiBljNENU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CALVGSU60F8LU5w4vSApko60pt22LuuZnUsZWZdQrRcIMd+RYS2RlfAUYzyOhdZZl
         EM75t0oaFSKjURfxkrAT9NrXhX0sfYa1dl1bhJCUo15NqZv+wNG6A6sM7xJ+C+ZEMc
         82t4DqeZAO9Saec+HMmoS6fzS2P3bpfn7Mfh818I=
Received: by mail-ej1-f44.google.com with SMTP id a26so7635712ejc.2;
        Mon, 31 Aug 2020 02:38:01 -0700 (PDT)
X-Gm-Message-State: AOAM5329MdEAlyApLw2pnS3r4l2in8cWUqjs++mktcVRlp3V7/APwCuD
        4s1JBOG2HR3qlRxNAbqFGT+YQdwD8YXo6iIwZIc=
X-Google-Smtp-Source: ABdhPJzEMydj1flQe8yJ1fHDr/f/GID/UjECg9Fvi2J91xAvL9Nrnw1B2S17ifqKsFMYn4zaczyeTsQzAZzitv06LdA=
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr305412ejb.454.1598866680422;
 Mon, 31 Aug 2020 02:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200830135200.24304-1-krzk@kernel.org> <CGME20200830135426eucas1p19a79abc3fcc3580f466782a856eb0c78@eucas1p1.samsung.com>
 <20200830135200.24304-9-krzk@kernel.org> <0f898c36-714c-43ef-2afc-7843d444b41b@samsung.com>
In-Reply-To: <0f898c36-714c-43ef-2afc-7843d444b41b@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Aug 2020 11:37:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfyOo40Jx2M+U0_3TY7Y1=qaszeQ9Sqtu_hzrthoSdtow@mail.gmail.com>
Message-ID: <CAJKOXPfyOo40Jx2M+U0_3TY7Y1=qaszeQ9Sqtu_hzrthoSdtow@mail.gmail.com>
Subject: Re: [PATCH 09/33] ARM: dts: exynos: Add and enable 32 kHz modem clock
 in Origen
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 11:16, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> > The PMIC has a 32768 Hz clock used by the modem which is implemented by
> > driver as a regulator.  Add and enable it to be sure modem get's its
> > signal.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Origen board doesn't have any modem/cp, so I see no point in enabling
> this clock.

Good point, thanks for review.

Best regards,
Krzysztof
