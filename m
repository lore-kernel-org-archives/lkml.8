Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E46C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83542063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGHUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:38:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:38:27 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXpM2-1kPCu53p3E-00YBdb for <linux-kernel@vger.kernel.org>; Wed, 08 Jul
 2020 22:38:26 +0200
Received: by mail-qt1-f170.google.com with SMTP id g13so35637209qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 13:38:25 -0700 (PDT)
X-Gm-Message-State: AOAM532w0UeP0WwBpw/zrbmSv7F14jdVTJTTiUunqsEMm2gFejB7kl/i
        DvlUrvrOyEnhQ04zJQLF0tWJ6uASNymNlEtyW6I=
X-Google-Smtp-Source: ABdhPJz68h0QI29GgcNujCOHJJRLRxCryNllMMt7XOrct3Fz9NvPE7S9FBlPpZcCU/WKTQVPVEde++p5gb0kEQ7QGxY=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr62150452qtq.304.1594240704805;
 Wed, 08 Jul 2020 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122248.52771-1-cristian.marussi@arm.com> <20200708122248.52771-3-cristian.marussi@arm.com>
In-Reply-To: <20200708122248.52771-3-cristian.marussi@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 22:38:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mH4h9=MZiLmqk=YY8_pzQnUUvsvcL1TZQ6uJEdGUf=w@mail.gmail.com>
Message-ID: <CAK8P3a3mH4h9=MZiLmqk=YY8_pzQnUUvsvcL1TZQ6uJEdGUf=w@mail.gmail.com>
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Fix scmi_event_header fields typing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xKvUOf6eoq16hD9HbdtXx1MDQmDNpfPUg3XZB6jOB6YCnvdToTt
 QtUFHLSdMAfwP+er5U+PyHE03lA7JTdaTwvyAdyOLc/27eEwZHcf8EbV3uXM/61OBMXJ2h5
 htoslGBKrKfiQvHC/wT/3VQoN3GFGcAyTG0iIictrxp1UdalWpPkO8JhtF6e/L0swZcaCge
 4FvOhJaFCctEwyE0OEafQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:igD6fevkCF8=:4zr/6OYLQ0wUYpU54A1GTn
 8TnLo7h8MrJwfV0Rffv7t0A2Hl3hC3s8l58EyzKgNRxJyO+Cz0HhbEWg/V0yyxkReo6p+nhK+
 WawDLBHF0jKiXEvkuD+6IjpwbXBFssJ9kfM0PoPCNRiZACEZdLE+HknLXOCwnbOm6WdZ7qX8z
 Y3ZuH1rkcq9xVX6hmViCbMvfWc6nFpL/PNOay4MTOC5O0iFWGx/xs64ugukWoBExJoq9d9Et4
 jzeFP62/HQbUaZvBCYk4lBCuPvXrcUf2qLiDaB6gXPhxdOBKSBWzNTKJp7exCNhUTv5lE3E3K
 zLmQ9x3bzrLQ1+ljkgvRRZ9mPmd3H6lKy5FsEFWIefz+7imz+Ydnxwu6vAGv95/J0QR66XmuV
 pkVNfeNlZYYWERdPMHJAA9OQ77ALvU8/wvZ3Rza9Ta/U3myuDxIOPZORerWVAeBGHqfm/X4/C
 gR4goAktl7mJKzCR7gHVLguCOyi3rJSM7UwXMvmYWavsqVeFDZUveMOsugrl8Gj2JHpJwwJrv
 MisEcJQqmaGxwXwE4wwe5AWK0ByqSm2he7zDD5jwiasfsNrs20QIOQO1ZJzVB6JP+rk1SkSDj
 Ku4gBU7y8lwAck+7RuTDlEjIla5SqTSrHSYPV6t1v9NdLefY7VyxQp7XXBppn4ONi+1VOIFev
 lE7uyrZiR1QPxchcxCvnykP05wHGYa1mVuQSKll0iELjQfNZ2Yq5VQ2LoPP+wEqznKuYO31wG
 jML1sGfZ4FUVh8PB2dv/hxc6tDJ0euwCkelRmyxasiLqjLRGQ/E081DJm71slv1HFITCQcCta
 Idoa+EjqRsKfF58XZXaZj6yBO195ZBWrDlpwl5z+K72VbjatqUDawt8rufKk3fosVavcqKR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:24 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Drop size_t in favour of fixed size u32 for consistency and shuffle
> around fields definitions to minimize implicit padding.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

As you still have implicit padding at the end, I'd either make
that explicit now, or leave the __packed attribute.

The payld_sz is not actually force to be misaligned with the
reordered layout, which is what's most important.

     Arnd
