Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9676C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A747720768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFNJdaR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFZEzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFZEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:55:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A143C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:55:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so7463803otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wi1GFCWALRog62SpR3oo7ajuACihs+N37wB4PqfLs6Q=;
        b=LFNJdaR0AkSuh3MJcgNrsQlDU/7wrBA3cC9RvNe5/S1FtK59iGcfNz1pqPRCOOZOHM
         D8oaKjuHKvY6H/P77GhepO6B2WNZrUoi6FKBVN7WfMu5721zquQvROmijyOcMMjgU8KS
         zanPdyNJEkfk2FvZ/WiZyQyGddNJ+XFEiseu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wi1GFCWALRog62SpR3oo7ajuACihs+N37wB4PqfLs6Q=;
        b=dVL6MwCJUc9eisQDyRccvNanfwaSPJ9aOkNu4WnQAMHcZsrRHYqK9Dm+tjq8PwW2O2
         T8cBkc/D31AdrMmah9b0Zfx+vOke2iSuMa2GlCbYTljvmrZOD5iNDwXNvdUIIaXTv7hn
         oCIuCQo0nOQfL8bKBIsHx9sDU+nuYlXy4BNd9188WXRx9PCZ631Z2L2RyjRIvSK3cqK7
         x2d8h+CiCHfsoAbgYSGRjpjisZb2HLpUtkv/6yxGqopMvxPw72jNhCGzbyjr4qkqTipu
         QhZZhFWxZsaHMYuGL0Lv//qIaLtyrO+wSY66mLVZNgOKpmKcdIvYFW5Qp4+zjWlMZRge
         K5VQ==
X-Gm-Message-State: AOAM531MvJYxPFeYPOvegajRfyuNwmjEAeiNM/gP/S2x9UMn/2qUBKTL
        nhK+awsyb3VDMTOSjMbevIZlVXoBCV4lCw==
X-Google-Smtp-Source: ABdhPJycGleI8AUpvBiuCoFCus9uysRebTkaZzTCdJ2F/osX9+AErMXFqL3/WB6PRd2HKWuRfcp0xw==
X-Received: by 2002:a05:6830:15c3:: with SMTP id j3mr945401otr.2.1593147311875;
        Thu, 25 Jun 2020 21:55:11 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id x131sm3712897ooa.31.2020.06.25.21.55.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 21:55:10 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id m2so7456939otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:55:09 -0700 (PDT)
X-Received: by 2002:a9d:64da:: with SMTP id n26mr976709otl.36.1593147309361;
 Thu, 25 Jun 2020 21:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200520082723.96136-1-acourbot@chromium.org> <20200520082723.96136-7-acourbot@chromium.org>
 <1592551593.32358.1.camel@mtksdaap41> <CAPBb6MXOPMhtSrAa+F+0BcC7Uzc4UJQU29eBMi5fv1zjF2D0jA@mail.gmail.com>
 <1592875738.26708.5.camel@mtksdaap41>
In-Reply-To: <1592875738.26708.5.camel@mtksdaap41>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 26 Jun 2020 13:54:57 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU6GRwaSkJWkdt3_0a=TDoCuoBTv3QKuRDbDQ0htCYS5A@mail.gmail.com>
Message-ID: <CAPBb6MU6GRwaSkJWkdt3_0a=TDoCuoBTv3QKuRDbDQ0htCYS5A@mail.gmail.com>
Subject: Re: [PATCH 06/10] media: mtk-vcodec: venc: specify supported formats per-chip
To:     Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiffany,

On Tue, Jun 23, 2020 at 10:29 AM Tiffany Lin <tiffany.lin@mediatek.com> wrote:
>
> On Mon, 2020-06-22 at 21:44 +0900, Alexandre Courbot wrote:
> > On Fri, Jun 19, 2020 at 4:26 PM Tiffany Lin <tiffany.lin@mediatek.com> wrote:
> > >
> > > On Wed, 2020-05-20 at 17:27 +0900, Alexandre Courbot wrote:
> > > > Different chips have different supported bitrate ranges. Move the list
> > > > of supported formats to the platform data, and split the output and
> > > > capture formats into two lists to make it easier to find the default
> > > > format for each queue.
> > > >
> > >
> > > Does this patch pass v4l2 compliance test?
> >
> > This should not change the behavior towards userspace at all (it's
> > just moving data around and making it more flexible), so the test
> > results should not be affected either.
> >
> I remember that passing compliance tests is required for upstream.
> The tests try to make sure that all V4L2 driver implement interfaces in
> the same way.
> So user space applications could find/enumerate HW capability.

I have confirmed that this CL does not introduce any regression with
v4l2-compliance.
