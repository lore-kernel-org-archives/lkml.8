Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4CF207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AP39QCkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgHYDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgHYDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:23:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:23:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k10so2637382lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwIDiEHCgFI/z0l9AbVx2Rus6kHSaCq0t8VGnTYdsUg=;
        b=AP39QCkNHRTcbqx+ihKM5zWiPHxMHcuqzIowLMsHSF/RASXPkPnRzIdPyED03bfHDC
         LI3F5BPC5wAsogVm2imEiJ+A+91OaT9KuD3IHhTTgHaccrekJfROD011iHpxBNG0liOZ
         4IZdlSJZu+4hI60EzW8jat/PIPnyu/NDg7Y8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwIDiEHCgFI/z0l9AbVx2Rus6kHSaCq0t8VGnTYdsUg=;
        b=RaGrS+YLHRNC65mzNVMV2JDC3f9PSVU57BcOWbOBAgbjlJljamnDde9P/TxDH0LGtu
         qHBKhScW28McQHJCDxhQnyRYFwSdp4c5A4JLUkMknFu5ho/BwEazpQwGH439Vy2jYuWH
         EhnQSb5cuRkblEpwMrFlfykvs9eBlGkywlPy0iCs02daeVtywf2wBmbgKnTGnalIXmWM
         rNmrNRUb8JnQ0pd0lFm0NaUCar0eb7crSzEI13I2+CB649E5SsYg5IWd/zTt6ZaSGKf2
         IuQN/cx00YCbJ8j0p8YLZhUl4U9pmzQD1G3UdVURvobjzeYXLjHGu7QDIZ0+U4HPEFRb
         28Kw==
X-Gm-Message-State: AOAM532+PtmYpqyay7pvNHp8S3BwipL+/CxrkAVpBfetYL/Sv54KJ7sv
        tPkNBQQyWRkLuqgVl3xPDJ80NiLUqoGI2w==
X-Google-Smtp-Source: ABdhPJyiSxmB7flo4tnMOsYRtH3HyTcn5HjzKHda2E8uRB6vHG/odbHxuPDB1KNNadcy2L6vjCFVPQ==
X-Received: by 2002:a19:ac02:: with SMTP id g2mr3925426lfc.155.1598325807772;
        Mon, 24 Aug 2020 20:23:27 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 133sm2126280lfa.70.2020.08.24.20.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 20:23:27 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v4so12112689ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:23:26 -0700 (PDT)
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr3731295ljg.305.1598325806305;
 Mon, 24 Aug 2020 20:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
In-Reply-To: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 24 Aug 2020 20:22:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft4zqA8mwt5UYBrBYNUzF4cQdg7m=Zv48ffe1Pbm1HXv4Q@mail.gmail.com>
Message-ID: <CAE=gft4zqA8mwt5UYBrBYNUzF4cQdg7m=Zv48ffe1Pbm1HXv4Q@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Show bandwidth for disabled paths as zero
 in debugfs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:50 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> For disabled paths the 'interconnect_summary' in debugfs currently shows
> the orginally requested bandwidths. This is confusing, since the bandwidth
> requests aren't active. Instead show the bandwidths for disabled
> paths/requests as zero.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Looks good to me. I briefly mulled over the idea of showing the
disabled flag as a separate column, but I can't really think of how
that would be useful.

Reviewed-by: Evan Green <evgreen@chromium.org>
