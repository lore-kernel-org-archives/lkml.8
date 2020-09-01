Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E34C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A2C2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XjFnaTJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgIAQCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731693AbgIAPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:43:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7511DC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:43:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so878331pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=x8Z9wFHU5eJIz7vYKW4wsTnm7g9XBK4yOanCvKB9vjM=;
        b=XjFnaTJZmA5aVtH7IjnlxheI47kFzEJ4agCy9CFsFrJocEXppx1FX7tJFIC+Nsvz5C
         iZskAozotXH0nF+KDwZpSo5ugtemrAbisn6hO6tSABZhue9FEmxd7W++zZ+KWuP5C8V2
         z5x5QUtioFI85El89P/Hqu0++DQotdobhbtGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=x8Z9wFHU5eJIz7vYKW4wsTnm7g9XBK4yOanCvKB9vjM=;
        b=fbxK97cEBsjL+rHwixmpB34QVQ1Dk0HjZT5JHFUW/2U7VmALfD4BXCu9GQmWRhoadl
         evmVdVn87doVmafEvvJj++PKw4bEqcLa/mAQOvLGZRpTF3U3+Wrn0LdFzC8wcZdJSsKU
         TVddZOUagOF4gY2OKk+adk7b8+OxpAuWIH8vTUpkpJaqs4QPBBrFPA5jsiAhoPULKQP9
         w07UfuTqXGQe2+hHQlAhuGfGT6QTpN5/mLAFSF6WOS8WhZN1H/qaBzNSFI83p9IsUdrv
         I5vnEkPtm9q+vho6cEOtrRseS9Weh8fyAUWNjr+iesogoYx1Yqi7Da9uIO6EWMg1HCYu
         V/0g==
X-Gm-Message-State: AOAM531Gce8hcjhC9iG58f267q0LyAtbJH+bFJZLvGSQd/096fSbQwe/
        w7qhwAX5t6sw8hXleFVLZvtyfA==
X-Google-Smtp-Source: ABdhPJyNGI5kBf/qAyktQrVkh0MPvczLzRTDwPGSTM/NCSklPkckoC5nnaCi8Suu2jOejF/FpswMQA==
X-Received: by 2002:aa7:9598:: with SMTP id z24mr2336329pfj.223.1598975028043;
        Tue, 01 Sep 2020 08:43:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s68sm2421932pfb.91.2020.09.01.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:43:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
References: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
Subject: Re: [PATCH v2] iio: sx9310: Prefer async probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 01 Sep 2020 08:43:46 -0700
Message-ID: <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-09-01 08:19:43)
> On one board I found that:
>   probe of 5-0028 returned 1 after 259547 usecs
>=20
> While some of this time is attributable to the pile of i2c transfers
> that we do at probe time, the lion's share (over 200 ms) is sitting
> waiting in the polling loop in sx9310_init_compensation() waiting for
> the hardware to indicate that it's done.
>=20
> There's no reason to block probe of all other devices on our probe.
> Turn on async probe.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
