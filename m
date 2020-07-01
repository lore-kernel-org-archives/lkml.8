Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592C220781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUGb8M2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbgGAQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGAQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:39:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A72C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:39:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f8so15647773ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7kT5F1paIOXtpsQCDYS2bbm2+dXVLidR6UuRvcT11A=;
        b=VUGb8M2sRp9MktZRa+49xew8Ula6N3Ge4GvW92FvXNjlV3/SPDafMdmr05p6HSq+dm
         pQkmECirCAuGgZYlVrUI+MfpG6owRa3aNijbDsqSU1ok9tIJXS+lwoVDeP2RT+t7bJKc
         f5Mig6qrizSSSVkF4Z9LDQF7Row19zadX+eqCVB1vK/kPSMVrydwspXPX3XGquIh7/pH
         7udxcXSvFu+JDDJbZyWhKzfJNGU0ij/tx7+BVVLYm/5tMo2m/qcZLCL6dZ4gnr3AyGht
         9vRiXbPDCLxOh4yC2oDlqvfiqsxYRi3TRsXjF0D5q4t/XVIB63xDYK8MeqjVJNdi96Sf
         mWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7kT5F1paIOXtpsQCDYS2bbm2+dXVLidR6UuRvcT11A=;
        b=M8E2C4YDVycOcVRtqpnVbMl7zledSOoC3guV4VhftIyhV1vaRaIvSuZ8lZa1fDql77
         SHvHmagmihBNKsHN/xxpKUkj80SYAHmsU4TOnEO5mmyGDLX4SFL+iNqoTzlih/d3dPQ9
         jcgoLZD4ZIzWPxqXbbMmhZSmvq/0pIkOvdHxjh/213OStq7dCBJWsJj4KIWR57ilyd0I
         8Rt6kOScy1H0hazQL0/lTCuiY5PpphKPfZXS5qOa3AAaonQLAZlSy3rclnypA+3H2wXb
         8OvvQipfmXstlgZzPl4EnJ/sh3RVbaWzAN1ycC47NChHbewVaRttrBRT4NDa0fICnp7N
         c/ig==
X-Gm-Message-State: AOAM5304dC76uLVR0XheYY3t092qhLOL/D3Rrykd7mNsuaZ2V4jAUfoa
        +CXWhQQb2PyvAJ0S5n7Nkboo+8MVERIM8TkYb52I1Zm2
X-Google-Smtp-Source: ABdhPJxMPtrmjkS2q4us3NvqfvWD4lT5Z0qs9SrLAyN2GMZcWupyaAUAD5uQFIKQN054L5pi629YU6PQCEDoALoePZA=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr4037902ljh.218.1593621553512;
 Wed, 01 Jul 2020 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
 <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
 <CAGngYiWV93yWY-mWM-1YcRU71iWnP=qsLSD6Z5dZkz=Zb+iqRA@mail.gmail.com>
 <HE1PR0402MB3612B2111833521E571DC207FF6C0@HE1PR0402MB3612.eurprd04.prod.outlook.com>
 <CAGngYiXfY0SBEm=H8KMTR+0ztLTEQ+bpjPpquac+igoCLHM=0A@mail.gmail.com>
In-Reply-To: <CAGngYiXfY0SBEm=H8KMTR+0ztLTEQ+bpjPpquac+igoCLHM=0A@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 1 Jul 2020 13:39:02 -0300
Message-ID: <CAOMZO5BYC3DmE_G0XRwRH9vSJiVVvKbtznODyntsAuorF=HoqA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, Jul 1, 2020 at 1:03 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Fabio has already indicated that he's ok with adding a new property.
> Fabio, is that still the case?

Yes, please proceed with adding the new device tree property.

This way we prevent existing imx6qp dtb's breakage.

Thanks
