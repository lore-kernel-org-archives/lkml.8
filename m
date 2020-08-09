Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F16C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832F8206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596932234;
	bh=uzR2Q9T845pna8XP3B5MtZKhh2vQixFYmQxSnDQle0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eyhAS37c6EmcrqwakXynG5DhTI8JFBo0SO0N4G5n4FAVo0+wpf/WR73BRzVYGCAcG
	 cCVQFih61kL/lTmFghXg/KppUi6Tt8BX0FIZDT1ULYGSd6d+Aadp+PQ+inu1bVzNal
	 SQBBy8cUhwjYkehErafVaG6ESXJuXBrpmlSvBtTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHIARN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgHIARM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:17:12 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD8D2067D;
        Sun,  9 Aug 2020 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596932232;
        bh=uzR2Q9T845pna8XP3B5MtZKhh2vQixFYmQxSnDQle0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vv9wm6DIxUbHozRvA1AyxMizji9rUv8gSn3bnmKzgNyQUT59XCuSpVianl1FP2xDO
         NSa6d3yKuHd8zLwIotp5zI0vf34jeLzSopbflNOV58GA3NKWOO1xrTfdkvhQG92GG4
         0YgAHkE74fzWggP0wdmyN1FmG2fZVztME3deAnKA=
Received: by mail-ej1-f50.google.com with SMTP id bo3so5827444ejb.11;
        Sat, 08 Aug 2020 17:17:12 -0700 (PDT)
X-Gm-Message-State: AOAM530dcZJV9hhkZg6Fm9HRvXQM03xfY2zkSjKW98wMOAAh6wb8TrEj
        nd2ZuCgkMByNvbUHZFJJ5UicZBeFsejk9TB1sg==
X-Google-Smtp-Source: ABdhPJxtuqSyNCglh1lnoj77PKcLmVpUqyOklSdTDUwAHMVSJ1wm9tl/cLlSapqD2wcderKhmNy5ajxAxrVAyBhhL3s=
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr15560600ejk.94.1596932230832;
 Sat, 08 Aug 2020 17:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de>
 <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69>
In-Reply-To: <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 08:16:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com>
Message-ID: <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=888:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> as i made a mistake in cover-letter, it is not assigned to the series.
>
> to show its content, i send it here as comment (instead of resending the =
whole series):
>
> based on series from David Woodhouse [1]
> i moved more display-nodes out of mt7623.dtsi to new mt7623n.dtsi
> and changed last part from my series [2] to add these nodes to this new d=
tsi
>
> the depency of dtsi-dtsi-dts is already done for mt7623a, so i guess it's=
 a good
> way to use it for mt7623n too.
>
> this first set is an RFC if all nodes are in right order and if it is wan=
ted to move
> them out as i have no technical document about mt7623a/n which describes =
which parts
> are available on both or only on one of them
>
> added MTK DRM Maintainer CK Hu, Ryder Lee and Sean Wang, maybe they can g=
ive me some advice
> how to proceed further here
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D32=
9209
> [2] https://patchwork.kernel.org/patch/11700699/

I would like to put all device in mt7623.dtsi with some device's
status is "disabled" and change its status in platform dtsi.
I would like to see all device in mt7623.dtsi because of its name. If
you move some device to platform dtsi, we would trace all platform
dtsi to find out how many device in mt7623. One day a new platform
enable different devices, you would reorganize all these platform
dtsi?

Regards,
Chun-Kuang.
