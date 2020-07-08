Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1BC206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFoPELJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGHRkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:40:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17D9C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:40:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e8so20954897ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwDgxFCXr0uJ8qujk1ORpK/adzRU9BSyTB6b1vh6Wk8=;
        b=uFoPELJVqSFesxbICf9eVKoWj8OmBJ5VTT22sWGDN9tRH1k20axQkHI2pv4ramRlCO
         s0dSvKU0Txc8Darp9YtKIP51Hv6jJ9NzttBKGf9f3FGrA19EwFpnOWzXEBCDyqN4kdNZ
         pYrcTe1r2PaQq5Qt5nEZGUL6tiw6PrvOZzRkhF8IOWZiEPab71U9OlCGqIvxKt9d4OGZ
         oB8TTwM/Y2506+yqJ90TEE9wGyzZ44GGXFYyVLuZuOPf7p3/llocQgtjkW5tQglnH3Sr
         eAd2M0M2lerKhsq8sLO5LTaNhJu/77kiYQt1iNhCoq6MLleSwtzmwEYt8ZQf1I06xXYW
         mwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwDgxFCXr0uJ8qujk1ORpK/adzRU9BSyTB6b1vh6Wk8=;
        b=E3Iu0pc1aTYbo9/7uzq7ljes3XxooSxITzSvrxj6eyn4Pbsv9Fh0SeWU5tH/Et4brD
         /18WiEF0vWo7x0GhqcpBearmtgG7UKVm51QXcBXhvSyBc4Z1g+6uiR528prGTQzZ5Juh
         PmjcYUJ5Jdv/AV1H1VBhzB+3nL6RAPp889k+XfhLlRA3DkiScFsVAbCSLFfN/hH3+lhD
         f4w2Bi32m53ka1vyAt+MAihNCXajo4ZRTAl1bBlKu+l+AWEB5U7ySltjzUMyKIP7FYW8
         4DfzFC/f+Ls2wqmGOZ04lb8pqC+L6doHdeLtfnp3ep/SbD695KowAW4VBDg+U+Em7W1b
         iJfw==
X-Gm-Message-State: AOAM5315iWMMpdYpUWv9u9sleMYUh89DXIW7uQkHJgt++Hd8V342l7ij
        NIcQkthYiKgPwmg2gcLs1RGqD2F48Mx53Qcjp58=
X-Google-Smtp-Source: ABdhPJzXDvwZUj6IBKZGlL5in5MlTfdNhdws7UbSGX+WsHrKAdeZiQT4V34RlxwpoIKWZ+PrJOCuVo80ln/4bDUWTKs=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr23646581ljh.218.1594229998031;
 Wed, 08 Jul 2020 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <1593764337-8267-1-git-send-email-hongxing.zhu@nxp.com> <1593764337-8267-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1593764337-8267-2-git-send-email-hongxing.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 14:39:46 -0300
Message-ID: <CAOMZO5ADpNehEBybs_SispLa1i6AvmanSrrEcu52JxBa5C1wxw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qp-sabresd: enable sata on imx6qp sabresd board
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Fri, Jul 3, 2020 at 5:23 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Enable SATA on iMX6QP SABRESD board.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
