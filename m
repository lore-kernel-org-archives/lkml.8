Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E1FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768DB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgGaTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:22:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:22:07 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbBQU-1kd7HJ2768-00bYsV; Fri, 31 Jul 2020 21:22:05 +0200
Received: by mail-qt1-f170.google.com with SMTP id e5so9772810qth.5;
        Fri, 31 Jul 2020 12:22:05 -0700 (PDT)
X-Gm-Message-State: AOAM531U25yWP4IVhLVN1bcjMmajZSEUKmxxvRC6V995dF/Viybm+BjO
        Tl//jFAOY8NSjmskQabFwQQwwsiZ99VR9lUAUeM=
X-Google-Smtp-Source: ABdhPJyuFPh2OD+eEy9S9KdQ+GPvofr/sZPZjrogQb73cQsUrsGw9ikC9N+ACXw8zufq6uO/bUNQzszNvuarP8lRTiQ=
X-Received: by 2002:ac8:5195:: with SMTP id c21mr5280181qtn.304.1596223324287;
 Fri, 31 Jul 2020 12:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200729150748.1945589-1-daniel@0x0f.com> <20200729150748.1945589-3-daniel@0x0f.com>
In-Reply-To: <20200729150748.1945589-3-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Jul 2020 21:21:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2DY8kNMzZs6vpcsvpU1CaEQy6yCiHq40txEgUBn8d=wA@mail.gmail.com>
Message-ID: <CAK8P3a2DY8kNMzZs6vpcsvpU1CaEQy6yCiHq40txEgUBn8d=wA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: mstar: remove the binding
 description for mstar,pmsleep
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vCQI2QiFOYMtBPokBrSUEZMR/u8y4jbMb9lQouPzNxGteUJlz1G
 YGFMWgAaZymszT3NLMx5fMmEWVi0NfLFj41mIlAIraa9fE89XPV2JYgi1HEMSZYSqHk5Ssa
 2f+9FdPN7RQ3W5zzLu33ew+S/XwIUZ+7i+xYD1jDQonqQZv95KWZi6ma4VyUYn98TNZETA9
 ioyxenYCkWN6R7iPSSXcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jK3/XfaA6jY=:PyE+mVFUEXkthDhZHk7O32
 +cc5cfvliY+GSAYbO8KPweQew6UUMhKI0v+Du++YBPfc3vj7vkvdRTWg7zap5PR0JWqcYFFK5
 dEXOPhUi2FWM6tuoiD2i3M3SGyNmDDkIbChLR8brqycqKH7b2or4Cjc935JrCrhrlFv+JGkvo
 be6AZiEKWwmb1W0Bq2GYyIM5GfabONVJo06mRKLXrgfbehKqx1I5QiYGLHLm9tsuYhBlx1N3w
 OPsyy0VJ6gsqFNAy4pt/4iRQrLIcnXEYPOF8SJ3SL/7CKlQZkADBpBDBmMcUfXK5rV2/3ZE++
 bZHHuB0jR4bcF2//XKuivN4JG8zYGNPBvlpp5BiADC0Jr6sD3vAGJWNOg4p8SdBnUnd7GHLAf
 SfXTr2CviWApqGQFHb0D5+5TOb2BDWGcPeJWkE6IXGBPXVkKr5yQ63Si7qgE0XxlGTsevLDxW
 SjHMBRlJGohD2i1LK/nOez07ispOOr6WNuO9uq0ZU8OmQfW9P7WXS57Bq4ozPol2CBkAkCRlk
 XUqegd+VwNNhqw/GG1eiCgD/8UWWSJWvjaeorvlvLR6WCMHMyGlpy1bXHwMHLKN0OovSm/Wej
 QDQs5crLTLsv0pjJ1GcU0H+/OZJyJRaLWZ7u7zWSGjQWa1MMcKvihqVjZqtlM7K4BYF5RDTFp
 GMSpIcBYyvev6AFsrM2AjOMWJD8Jboki6FagIZPt3iTV4hLOW8dI3im/cbYRvzpRVih4SxvDp
 VsiyJl6YjIeVlu5pGluE0JcGH7F69YLpLJyP6X76gfohHvkoEaPV194srno63RvpnTagHhdic
 Xerf++YMtxlRQzgsRWjoWI5TsA6pZ1TtA19nPrgef61fU4lRPn6t6I/6e1/AOFQc44voQdc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 5:08 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Remove the unneeded binding description.
> Compatible string is in mfd/syscon.yaml now.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

This patch for some reason did not apply, so I ended up removing the
file manually and using your changelog.

      Arnd
