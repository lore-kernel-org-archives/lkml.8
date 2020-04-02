Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA3CC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1242078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585864455;
	bh=ifZbGHnq4XSFKpzGjErqKmzIRZfeEHpwbTI1v1xsxf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aC7JTLH4yDoqRr3COyrjshZK6vw83Ac+wFPFfJiLfYsZIke8JvaIgg2pk7IhHLTus
	 IRP4gr4b5RcKpP3ybKRxXkHky8d6klKgdYQRVRkYiFPr6BVPoFBVY+eD7o0RYGCrMI
	 OrTFtrg5HT2Egqk7Dr3pYNoMgqmj05Db83hGlpvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgDBVyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgDBVyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:54:14 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4A020BED;
        Thu,  2 Apr 2020 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585864453;
        bh=ifZbGHnq4XSFKpzGjErqKmzIRZfeEHpwbTI1v1xsxf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qmpu/9EcW2cQevdKXSa7Ez4jHJr0TIo//kHLzYP6SV25MJfyrkS7O6fl2TPIjazFh
         f8sYJ8f2mdDdYaG/9T4D+qWHaW7gZZ4SSFq+f4UITLTDGX9pvDxnxtCST1kc36YYNq
         wJJ3TBj6qnfmXf3waZJFp+T/jM9P9XAosTjMsOGc=
Received: by mail-il1-f175.google.com with SMTP id n13so5251301ilm.5;
        Thu, 02 Apr 2020 14:54:13 -0700 (PDT)
X-Gm-Message-State: AGi0PubWmNgymIv2S/u9Cp+TLFZG3bzKkPgfq2gwTJbJ1wp9qnD3czmv
        MsDdhAUaN+VPlWo5jKvaov7S11nT9cezKOdsEfg=
X-Google-Smtp-Source: APiQypJqE9xAhP2+8cfncIZAPL7MQ3zdxRtHZdA2NaPrRmu/HgB7ZEkrDqNoDL7OcnBWFZSfK8t/QbnQ5WvflzZ9IAE=
X-Received: by 2002:a92:8183:: with SMTP id q3mr5520322ilk.43.1585864452700;
 Thu, 02 Apr 2020 14:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com> <1585128694-13881-3-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1585128694-13881-3-git-send-email-hanks.chen@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 2 Apr 2020 14:54:02 -0700
X-Gmail-Original-Message-ID: <CAGp9LzoULALLvO+x2TnO=K=pSD05bJFowB-usAcrpz0ddEN+Ug@mail.gmail.com>
Message-ID: <CAGp9LzoULALLvO+x2TnO=K=pSD05bJFowB-usAcrpz0ddEN+Ug@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] pinctrl: mediatek: update pinmux definitions for mt6779
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hanks

Just a few nitpicks and then Acked-by: Sean Wang <sean.wang@kernel.org>

On Wed, Mar 25, 2020 at 2:31 AM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> Add devicetree bindings for Mediatek mt6779 SoC Pin Controller.
>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt6779-pinfunc.h | 1242 ++++++++++++++++++++++++++
>  1 file changed, 1242 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/mt6779-pinfunc.h
>
> diff --git a/include/dt-bindings/pinctrl/mt6779-pinfunc.h b/include/dt-bindings/pinctrl/mt6779-pinfunc.h
> new file mode 100644
> index 0000000..4698d2f
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mt6779-pinfunc.h
> @@ -0,0 +1,1242 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + * Author: Andy Teng <andy.teng@mediatek.com>
> + *
> + */
> +
> +#ifndef __MT6779_PINFUNC_H
> +#define __MT6779_PINFUNC_H
> +
> +#include "mt65xx.h"

Use the standard include path instead:  #include <dt-bindings/pinctrl/mt65xx.h>

> +
<snip>
> +
> +#define PINMUX_GPIO209__FUNC_GPIO209 (MTK_PIN_NO(209) | 0)
> +
> +#endif /* __MT6779-PINFUNC_H */
                   __MT6779_PINFUNC_H
> --
> 1.7.9.5
