Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C2EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3192120732
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="h2WHITZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgB1LMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:12:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35877 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1LMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:12:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so2515044wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJgpsPTAOyTEQskkZCcN8WPjUqHPIZGQG/IVbQt6n/E=;
        b=h2WHITZOQEvnJndGhZ+TDX7M952DgLQOWgr31Ngcy/m/dAg0BxFgqGvir/enXuUlsK
         kcF7X6vJmNR1YHmdV01i0/Irr8N33dYBwfdc9meKii+Dc5O3Eyo+N1F4IE0ROgq55uBw
         Lp3epqMDKrMRhCGZHzO7XQkqHKFZz0us+lB/RYxYAt9/B4x/waJnwlVxcBZAJ/O63+KT
         Az8tRKMz0QfKvcEEoXp5Z4wj/ZQunjOj8ZKo/h1lM8UjbTSk9jNl1tVL2M+jFoHsTbl5
         BExPopLr535QXki47KTKxzX0gw87dLNq4T3TZeieLI5slCMLO7xK7sKTwcynKlm4EUCL
         ohIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJgpsPTAOyTEQskkZCcN8WPjUqHPIZGQG/IVbQt6n/E=;
        b=t03uo/nOJkbtSWTu3zsQIAVpHTaDMjNDIP3F6lurT1KdeZdvCr08iDatV5ALwx3n+n
         HoTBU4ig5Ykj8vWFg3N+sA1D4ickbJnC60fK5Y3O/qxX8Ej4qu9hgW99XLZ0oabwFNY6
         jOTZK2YPQrYxxx9o7h66cE+FiO76FZX6Un+XJwjqh2sPE6IXvnf/zz30EgYNHABj3aNP
         Z14MIqpfnUQrSNQHgRB+Z8DP0aNZQvR3PCaD93+B4MUOEarBV/j4AMVr1zsFlDPKf2WG
         LfnhxKJuOj6CObFp9yxuD7v8jLy8y1pyUgo7SizKj7wGMRFp0TYKVDyWzqfcQenq7JHf
         ogaQ==
X-Gm-Message-State: APjAAAXHptAYcM087KsNFPF16U5XRuxphLwEX1hiXTr3Lc3nQSm8egO3
        aWq+mZSEP2egqLBuIoX9WuVXWRGeprEQfkONYScrNA==
X-Google-Smtp-Source: APXvYqy6KcgmbPb1fw5V3WytN081I6/VutL5m3T3ZlzWnw7MV1kE3qIKSqavYxfdsKdocmu8raau8/qoViKot+DHhpk=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr4484559wrw.6.1582888371081;
 Fri, 28 Feb 2020 03:12:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200228094033eucas1p2fa2f6cea3b882e758992d97da2fc50ed@eucas1p2.samsung.com>
 <20200228094026.26983-1-m.szyprowski@samsung.com>
In-Reply-To: <20200228094026.26983-1-m.szyprowski@samsung.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 28 Feb 2020 11:12:10 +0000
Message-ID: <CAPj87rOH6o593kkPKibfWr7K2JYQ8yvTHuAwSu=rjhWGKgKJGA@mail.gmail.com>
Subject: Re: [PATCH v2] drm: panfrost: Silence warnings during deferred probe
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 09:40, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Daniel Stone <daniels@collabora.com>
