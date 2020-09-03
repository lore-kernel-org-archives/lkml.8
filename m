Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6AFC10DAA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B67A2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599173686;
	bh=UXKo8kyys7Jj/KQr45tWL3zKiNH9QtHrNfzW2RvKWt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eW0IMeK3asiUUEiJNq3xNr4Xfl8imta19UKC5ItmYLFHi8ICHiI6hSmohIXUs/z9j
	 jOLclRC74LVIb6tylmPG2aDna7MJy/3aoe5gRa98yl8MY8feNSjhOdhaTd9dyuej5b
	 tmWHbIgOjWvcQTfcSUVvyeWdzvDBpSjCSdDJQKuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgICWyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgICWyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:54:44 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23022083B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599173683;
        bh=UXKo8kyys7Jj/KQr45tWL3zKiNH9QtHrNfzW2RvKWt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmXfwBYt3D5p90EF4QL4KaB9rOBoRovhKKBkFVE8uGA5dui+0P8hxZrd3FY69Wliu
         TTk9c/A0IjU+NziYUsCaN76rxm3L/o0iaout5mKVSD5nkUgrmwzBBpATVKe/S5ftGP
         8y9pRGpGCh2RjzS9I/QpFRr1OIiFLmH8uoXa9OuQ=
Received: by mail-ed1-f43.google.com with SMTP id a12so4247770eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:54:43 -0700 (PDT)
X-Gm-Message-State: AOAM533Ud/YfR6M2w0JOH6/p0oSzGFD5knbHB9gr7Tfswo1P7cnwWTjG
        vdOJxQeRrbSDmipOVZIpzIV6bw8Q2KCGokBlbw==
X-Google-Smtp-Source: ABdhPJxV4e9JXF8pl9lR06Tx6AQ3q1ACWUDkZvY2hawRP5jIfK2LoCgaT7r5tM+Hy5bnYViKitxKW+Li7urVLN9lTTw=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr5713705edu.288.1599173682230;
 Thu, 03 Sep 2020 15:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081752.4805-1-linux@fw-web.de> <3B754053-BA89-4DB7-A089-665C5B6B34CC@public-files.de>
In-Reply-To: <3B754053-BA89-4DB7-A089-665C5B6B34CC@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 4 Sep 2020 06:54:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9TYUWWNg+1zT4LwomrabBsiZQKXAS9jTHCFKiAmCm4PA@mail.gmail.com>
Message-ID: <CAAOTY_9TYUWWNg+1zT4LwomrabBsiZQKXAS9jTHCFKiAmCm4PA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] make hdmi work on bananapi-r2
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <linux@fw-web.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B49=E6=9C=
=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi
>
> Any opinion about DTS Patches? Which maintainer will include it in tree? =
Is any ack/review needed?

According to maintainer list [1], the maintainer is

ARM/Mediatek SoC support
M: Matthias Brugger <matthias.bgg@gmail.com>
L: linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L: linux-mediatek@lists.infradead.org (moderated for non-subscribers)
S: Maintained
W: https://mtk.bcnfs.org/
C: irc://chat.freenode.net/linux-mediatek
F: arch/arm/boot/dts/mt6*
F: arch/arm/boot/dts/mt7*
F: arch/arm/boot/dts/mt8*
F: arch/arm/mach-mediatek/
F: arch/arm64/boot/dts/mediatek/
F: drivers/soc/mediatek/
N: mtk
N: mt[678]
K: mediatek


Regards,
Chun-Kuang.

[1] https://www.kernel.org/doc/linux/MAINTAINERS

> regards Frank
