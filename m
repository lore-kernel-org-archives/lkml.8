Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2A520758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DFu/enkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgESGzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:55:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25BC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:55:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so14478470wrp.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TANWEOqfTxV9xotVFJrbgUmpK/BcquydUVLVqIzATJw=;
        b=DFu/enkffHVSAltF3ls3sxCDN6A5lKhqggJ1s6HCTXKZzdgcaVMnYYGgQvoe0Lzr1I
         upnnHFOWshBVZDYO/h+mYUAcigT40QMb0+mZqiquUwyY1bJny81btQxlN6YaTgzQi85c
         mBDv4uwqoDBBQDkY1nMvsuvsZ9aQyBTi/piaHdxTUkEotPsdwiXHHn0Bzs166wYgB+vs
         dRqBpkFHa4q0dxXFCO8AR6glcmEAaAT23BWQ1P0yrvD7sfxrdMUEkfGsNMNUK4cmfnMe
         o/12cLMZIuUVsYBjuZEHBUubwSAcYBlmuCAjrfPzJ2PBbdb7InSnw2IhRFAJxFIINlmQ
         e2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TANWEOqfTxV9xotVFJrbgUmpK/BcquydUVLVqIzATJw=;
        b=h/J+mfH0MifEGFX+mR4XcUsmTHhcutIn701lMSRf5NU4guFgS85L1v6djS8Cj40RRk
         eTvS89hCZFcX+YxehL85G/ZBjeveANmPNARyBO73MbqMfBdIEWk465JPFC3L6LshvrOP
         kEepzcb8CQ3M2H2lVBkCeVZkYrxjURsC4rPze387H7Bq2V65SOMTTRFimTTJdg3+Lchk
         feKHTP3UCWd/mn7HzTNFdf3qFaAEWc5881A5RO3tWf4Beb2N5e6vv/Q92FztmlJnJis3
         ymyjX/0s2H/+4Zk9FEEO08GAnAmaeurr2Vp2SlNfMeXrGNKzY8jd4AtTYDXWszVoDWNk
         VZMw==
X-Gm-Message-State: AOAM531VEa5rlTH6RBV6jnl0/zr8MYpSS2xsPe10SYZjlzS4rdxrzwv9
        9AqcEIhU7Pdc2f1DVE3bSwLmojJcAyfbmYEaBDA3
X-Google-Smtp-Source: ABdhPJyQWt5z4SzG/sMVYcC8+mS4N1nabJfc9BlW0x7OsKiZAW/PYP3ibpa34gAe3DBDIbC+UDNWbjyHXXLOPaYNCE0=
X-Received: by 2002:adf:82c3:: with SMTP id 61mr25175979wrc.326.1589871346192;
 Mon, 18 May 2020 23:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518205725.72eb3148@canb.auug.org.au> <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
In-Reply-To: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 08:55:35 +0200
Message-ID: <CAHg0Huy7JKttHs9aEJEaRgwZAM3jcZH-Wb0p8Vy6KBVv9bW0Zg@mail.gmail.com>
Subject: Re: linux-next: Tree for May 18 (drivers/infiniband/ulp/rtrs/rtrs-clt.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, May 18, 2020 at 5:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/18/20 3:57 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200515:
> >
>
> on i386:
>
> ../drivers/infiniband/ulp/rtrs/rtrs-clt.c: In function =E2=80=98alloc_ses=
s=E2=80=99:
> ../drivers/infiniband/ulp/rtrs/rtrs-clt.c:1447:42: error: =E2=80=98BLK_MA=
X_SEGMENT_SIZE=E2=80=99 undeclared (first use in this function); did you me=
an =E2=80=98UDP_MAX_SEGMENTS=E2=80=99?
>   sess->max_pages_per_mr =3D max_segments * BLK_MAX_SEGMENT_SIZE >> 12;
>                                           ^~~~~~~~~~~~~~~~~~~~
>                                           UDP_MAX_SEGMENTS
>
>
> Full randconfig file is attached.
Thanks a lot for the mail. Didn't try to compile this with block layer
disabled :/ Will send a fix for this today.
Best,
Danil

>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
