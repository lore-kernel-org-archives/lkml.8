Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B170C2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VuMywMwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbgG1Tl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgG1TlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:41:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223DC0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so1005951plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Tt1oB5/JSSIBPEzmzmS6Al56/2k10JRnudrRTsEkyZQ=;
        b=VuMywMwH4C3Ma1CCFFnox7L/OmRNnabVKzronEoZ8l7QdrS7X5/ruXnrNyq8alv7LW
         1G+/r/eNciDtwh7ZSnopK2Fs3z33cMoCMidZlzUQcmIJNqnMerfcU6fFrp/yg9J5Znc0
         46kAToYneS/NNtzmdKWno8JYWL3gg2S10G+qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Tt1oB5/JSSIBPEzmzmS6Al56/2k10JRnudrRTsEkyZQ=;
        b=BTySwb3mh4OHUvMdCAvSo4GGHTbbbK3aIQh5CUVyhBf+eBKZTl2AQWgXriZcovIXEQ
         OJV3pQtzJuyJ6ycSgrip9u1fT2HU8kWEY/IdCYyYoM8Yd7o2Ux77BZRL4glgPvIxHRsp
         EO+Mu1eBWF9/3oIYTVXHd5aISt9ybnPNzdL34XHPbi74hFR2fSibReBgzsNu9nhbW2f+
         5EbZhxTXM3l2O99DzuF1jCbeEIoixlOAWEOOFzPNl7dL6K8o9MuKap0GILapFSYeKw1X
         yVPy9FHSYkhW/R1OL+kUUUw6oq9qFPkVd0Mixqo9DHnWOBXr/ew8zkw9UMwazQ1o5TaY
         33yA==
X-Gm-Message-State: AOAM53324+3/l34ylldY6CEpl4dVJmUs951053pAk43bFGj3jgHrPQ9c
        0j8oAiNEr8q28cj+ZrUf7EY40G4FRU4=
X-Google-Smtp-Source: ABdhPJwlkYDk4n1LB04qDyenqfvxkpJupbQgya8o8bgR/rB9e/SY9pWSIBYqYLvMJRDPFGVNQitSoQ==
X-Received: by 2002:a17:90a:2a09:: with SMTP id i9mr6035315pjd.50.1595965285476;
        Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o16sm5792491pfu.188.2020.07.28.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
Subject: Re: [PATCH 11/15] iio: sx9310: Use variable to hold &client->dev
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:41:23 -0700
Message-ID: <159596528373.1360974.13960095456763695577@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:54)
> Improves readability by storing &client->dev in a local variable.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
