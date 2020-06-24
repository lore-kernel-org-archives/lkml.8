Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A47BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397BE20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mh1QeBar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbgFXL6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390753AbgFXL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:58:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E86C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:58:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so2200803ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfoFbTp1jr2I0obymTUaIsffNufAQrxCZnD5n4W9cLQ=;
        b=mh1QeBarXUNA+BpPNkuVYPczl6ELMrnlr7iG8xE/noQvhbCpusVzCoBhSnKDAuHh6W
         LlTBWpRYN88ysR3tnIIqi6NS9JG11ypRdeDuCdEPLvKedQBvEpwiCQbf2QGSlTDO9R7K
         PpVq0v8UXTXcsDkLtvJ2TdJn0e335AK1FJNeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfoFbTp1jr2I0obymTUaIsffNufAQrxCZnD5n4W9cLQ=;
        b=ARVhuYdvrCUPCZgAWz5j5ccxfZ/aWhUHxsYvttmPI3FoHqr6V1k2Na3zJMafmjYUX7
         6T2bGnR00mEPVI5cEOtDjfLfZQa7idNNBg4MQudP+HnS1PBy2oBHkzlDe7nMtskn0K6E
         ulqUL0yUuAxstRF8FJZcZgofsyI/FqBOghgM3Ga9EkMGTPuq77ESbI6snaG9u1E9NgcZ
         TDNMzIy7H5B3Gy1IZiO9ZXnwOhLlLafvZz7R8DlbzDp8RXNEuoOYj90Fqb9t1KVkcGBv
         uJWEgqwV286CHBc+nxEqXo70vI8OGaLtuA2eVpqIPbqB2ZxuNxOtqeZeEFMJa8GbbFgk
         PCXA==
X-Gm-Message-State: AOAM532C8M0PN3ejqblrXRPhOglfeFrQn7TMkq2pheZEE7W2CNw85SaG
        IvBHxF4LXiprxQRY/8rsk/q/6m8Xn+xbsQ==
X-Google-Smtp-Source: ABdhPJzAO5j61DeFn836fT0sxN/WhEYNpEdhPdiM0YpBPjvejqRX73c7xnVH8apC10bJSHcvFvCWaQ==
X-Received: by 2002:a17:906:8d2:: with SMTP id o18mr16696208eje.183.1592999930029;
        Wed, 24 Jun 2020 04:58:50 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id n17sm15301116ejj.75.2020.06.24.04.58.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 04:58:49 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id o8so2053564wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:58:48 -0700 (PDT)
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr30008672wmk.11.1592999928401;
 Wed, 24 Jun 2020 04:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR04MB06602E7221CC7455F3142540A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <07fb9000-ae00-efcd-e91a-48765ff3d4bf@xs4all.nl> <20200624115419.GA20764@pi3>
In-Reply-To: <20200624115419.GA20764@pi3>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Jun 2020 13:58:37 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CW0CL-s6=UOPsm37Mg+kswM_DTXEEnQMHC3kc2LxAY5w@mail.gmail.com>
Message-ID: <CAAFQd5CW0CL-s6=UOPsm37Mg+kswM_DTXEEnQMHC3kc2LxAY5w@mail.gmail.com>
Subject: Re: [PATCH 00/11] media: exynos4-is: Improve support for s5pv210 and
 parallel ports
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, kgene@kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 1:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Jun 24, 2020 at 01:39:50PM +0200, Hans Verkuil wrote:
> > Can someone from Samsung or someone who knows this SoC take a look at this series?
> >
> > This series looks sane to me, so I'll probably merge this if nobody replies
> > in the next two weeks or so.
>
> Unfortunately I don't know the media part on S5Pv210 at all so I cannot
> provide any feedback. There are not many active users of these SoCs
> nowadays. One of hem is Jonathan, so if he wants to change something he will
> mostly break/affect his own setup. :) Therefore I think it is safe to merge.

I think this driver is also used on Exynos4210 and on some setups with
4412 where the ISP is not used.

I can't promise anything, but I'll try to do a high level review.
Hopefully I still have some memory from the time I used to play with
this hardware.

Best regards,
Tomasz
