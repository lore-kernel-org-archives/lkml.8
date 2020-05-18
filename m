Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1291DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B4020829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEy766Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgERSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731456AbgERSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:13:12 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E0C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:13:12 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k4so3807023uaq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR1d4UXEmFjNR7Y1gBIt8dbUg7S85JgRbyJVZPiIUNk=;
        b=AEy766LoSKCS9tRJqLmQ8eXHjd6CTGkG13kkjyRfr8RerSWhhwwtAQutlNvpijGw+g
         tAyMZi/q4UPtECrrPB7WdElU6oPs6M7zJdUK6GJXj2vTn5iRSEbnwcWAZ0OlhiuZv+Po
         1dwYV7bHLxCqNFwps10f6CT7PHXDI0v7N6MeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR1d4UXEmFjNR7Y1gBIt8dbUg7S85JgRbyJVZPiIUNk=;
        b=ozzl3BR5JqFxFTZFWuJCgMjAY5thSmIariDkCiBZCADZ/Afn2JVBHkVKcXQvodaXBf
         HthyEqpwY1VMhztz8kxIRV/+QEfCDejIw2mteZWqlGDTcc3xMgMVfCpZZxj9Nqr3Kr4V
         ov1ncS3aMqnuCJTPsvE/0r6Muo2deTvdECQy4awVrlWDGtYn175V2OEUSDJKZxkJ4otf
         yQTpgDgJiTa4xV84mKW+IWXDURB7D5FoGz+XqkG/IzIggZEVVPl3b1gQ2dz9NKNPYyUr
         v+3u0u7EijnUPYrimddZuh/Xm2o0H6NKtDGQjEpj+yM56Z3dbBNXDm/uP7fSnHvPE5wl
         U2MA==
X-Gm-Message-State: AOAM533wjtjGhHF6R+mN73B3FYL9CXqot7CtMEEuFL3+XldQ3Y6AjfPV
        JdQE9Js0B2gbPpph/XB9xtbCQ8sroyZr32lbWeL2tA==
X-Google-Smtp-Source: ABdhPJwfNlsAPqdUXufA61B/Ydm/oJiD59x98ZHXZ4VEeSGl7nby7Ozpmih+bLDyGLq7VRWMT69tGjfOcWtFRuhNFVg=
X-Received: by 2002:ab0:6605:: with SMTP id r5mr4696251uam.115.1589825591243;
 Mon, 18 May 2020 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200514131338.v2.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
 <8BFF0708-07AF-4034-8FEF-C1D95975404B@holtmann.org>
In-Reply-To: <8BFF0708-07AF-4034-8FEF-C1D95975404B@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 18 May 2020 11:12:59 -0700
Message-ID: <CANFp7mUUJS9kxz5U+EMetfmDb=-Vn+Foz2G0ZuHTyuLCJmtDuQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Enable WBS support for wcn3991
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, bgodavar@codeaurora.org,
        Alain Michaud <alainm@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marcel.

On Mon, May 18, 2020 at 1:03 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > WCN3991 supports transparent WBS (host encoded mSBC). Add a flag to the
> > device match data to show WBS is supported.
> >
> > This requires the matching firmware for WCN3991 in linux-firmware:
> >        1a8b0dc00f77 (qca: Enable transparent WBS for WCN3991)
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Rename struct to qca_capabilities and fix enum naming
> >
> > drivers/bluetooth/hci_qca.c | 23 +++++++++++++++++------
> > 1 file changed, 17 insertions(+), 6 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
