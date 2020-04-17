Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF41C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0530A20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgDQNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:39:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbgDQNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:39:08 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7JrG-1jJvxW4056-007hg7 for <linux-kernel@vger.kernel.org>; Fri, 17 Apr
 2020 15:39:07 +0200
Received: by mail-qv1-f43.google.com with SMTP id 37so851428qvc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:39:06 -0700 (PDT)
X-Gm-Message-State: AGi0PubB03N3FejNS2V9aDhVkuNbvOGgYyL/Na19TpheZ2HO3Cug6B/c
        owi0qDPw5QRt+fQEfpX+HjkbfqEmldK2oyYbJgY=
X-Google-Smtp-Source: APiQypJ8irngO+1Ay2Qmn/6r4a3jcgvfzkIeaDc5o7jraj1FOyZS3PM+g31/LCWKu1vc/QXz3V2g9+Z0horB1x3FjxA=
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr940799qvm.222.1587130745816;
 Fri, 17 Apr 2020 06:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
In-Reply-To: <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Apr 2020 15:38:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com>
Message-ID: <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum special bits updating support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:y1LVnjqUIvg7ZEG3s8SeFmDTKFtb/p7ghShoY0LG16NxjGXvEbD
 l7utkWbE7DBi+rZTf1jgugJ2+2ZbZKCc8i4+pULIQQ9qaNBg+EuAeOfWKMOkcnFy/v5Bj63
 be/2857eGOH0yCzEirmYutjrwNONtyMEZ7Lyh/FHSTU3AbWSb4UYIQ9oMpN2IEth/cxAjdy
 y5NlOQOtI3qmUe2nW4ebg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KULVD5VQ+xY=:pDWpxapKm4uye64p5xxiCm
 qiPgSO2/DjWIghCWCdrkcX+Klw7f6Ql2BljItK/Pm6aMP67U0ITmSpyB92HkKu5wd4/SCE+sE
 NuLHCSd2vzzTjmNgYVkDtM7+1TkPqiV1nwvWsQFFQBmpsw5Ggj7/9OJasJpuHJmDlwksla+Hz
 P4UY5giaDCfoynBtbkUEVjFXVBMb8DwdESfYOQGp/RzJYcXQFZzYeDhOnHxCmZEx0P5+Zr/qr
 wF27mlFxprbuXN9cV0u5h09h1qGle0aNolsEfg7aexeXPNBzKp6j85lKbEPWeOBLTPTJ4o2cW
 9Go/sAlsMC+62AWkQN7RKUD6o1r9bgwXR30d2W1Be5FkKrptER/jsNTnsVXBIRS59p8zoc45a
 t589NYphLCfZv10fOP/kYYMZk/wPvvmfCPhqWEm6488nreiWYss4ivCvMURRvo1XC/5uZjIRs
 sqd7cEqTjiyHdtTnEmxPgVHWCROfSDc5LW7Q+5UxuywgTFGeRuFYL3bPlYMKlUHXc6TO6plR6
 K44eSSjZu9cUUaU7IeraLJQjTFEYB4DKVeObrPx048QCVB56jJgLLGs3hd0kxhw9MLDVXIYXU
 VzQcR/jYnfNsgU7n74WXzlha6ZP+XGBvm2KbmPxp5Ftb1fN7CACYo1juppDySjbFbuNwxQ1gS
 8izdw7pKRC2+Rqvu9z+Te1UX9+UXg0bAH9lVUuDm3vrP69+sNxb+AZU4gl8im8/NBO/0aKiIQ
 4k2oTvKgJ+Cn2LJ7g99cQmHKvEujAkix7A3NB/SqU2vICH+jf5RARiflIOnsFKaHgk8cCMlI4
 uYt2VuAh1U81LG/+VkrxR+SUof5wJUc9fkNoVvwRjEonq3HJLk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 4:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> + *
> + * Note: there is a potential risk when users want to set and clear bits
> + * at the same time, since the set/clear method will always do bits setting
> + * before bits clearing, which may cause some unexpected results if the
> + * operation sequence is strict. Thus we recommend that do not set and
> + * clear bits at the same time if you are not sure the results.

Would it make sense to have a

WARN_ONCE(set && clk, "%s: non-atomic update", __func__);

in the code to check for this?

> +static int sprd_syscon_init(void)
> +{
> +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> +
> +       return 0;
> +}
> +core_initcall_sync(sprd_syscon_init);

This no longer breaks at runtime based on the changes in the other
patch, but I still don't like how you have to manually load this module
on spreadtrum platforms.

What I meant to suggest in my previous reply was to add the regmap_bus
instance into drivers/mfd/syscon.c itself.

      Arnd
