Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03167C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE51E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UH5EmQ8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCBNt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:49:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52065 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:49:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id a132so1283266wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pDQHChPAvHbaHiAh1rx2hc7lXXqfrv2AqyVIgjj3sL4=;
        b=UH5EmQ8xNHA0Plu/McRn1qzyUYWuxXbSKQ2Os9L0yoktOYu7tCx3sdJI7YWZDxYoHd
         +YL3OEUKvM/W7hKB41X+4FFEjSxBJAVk5gdh5ny/LUcvZAIIrr1B3WQhGeUbo8nhyhjJ
         YErz9cLbumJ9EU8Q1wTQxX1Bo4aRM5DcDqFGnmdskcTtTl60EykI71bjpWhvL433KI6k
         1zp5xmHgz0vxdOb2LAhL2niLWDwbVPa+UYR0WaVrxCd+4X1KV0gISqCbaTXsch8ZTvpP
         2pSH5mZIJxey3CFXFP6hifTlnIokOwzOBrOrJD7jVSHNogev7ThF6WI4H0vnNCqvkDfL
         J1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pDQHChPAvHbaHiAh1rx2hc7lXXqfrv2AqyVIgjj3sL4=;
        b=FghGD/79j67E+yxSlYpz8Hxtf2l+i2E04I0AjlfcYzJXifIub0uRQlVn23DLWqi/XT
         PPfdHgjmObGXWbNVBNdunAH3Nz8xfGmQk1dAjRvNHEgVxLT4UllXyYUtT5y9n3V1lski
         NHExUGAkNtqvGnMAGhEcyowBzbCJYzXkVkxN3JRCJl5PsyIjb5rzt/g9WGuoh+7dOEhC
         QNtrSKgdbw97mjcSLlldGlNhcDA67uXqUWC6r+NBmkYUwvyxfeWgUq7VCgO8qr1SKVlr
         q1RiqJPpcLfV2TTZbO910oufaiHpMzjgCU1mFh5wM6CEXpNvNKrD5qMTRvuCsuFsQwWS
         7FDg==
X-Gm-Message-State: ANhLgQ2REJgLTgv2rjFORN2+Cr+M4i/HwT28qCXOpEf6j90SGTLREN6j
        dK00vYU96NgZQ33MKnOGLHJ9lQ==
X-Google-Smtp-Source: ADFU+vvG6MBPGRkXYyxVAEaRWeNUehBlIcQSHO6fOGOEKIiRp511b6KjpX5fIWmrSFxV9Fue65UAYA==
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr7393177wmt.68.1583156963877;
        Mon, 02 Mar 2020 05:49:23 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10sm16163783wml.18.2020.03.02.05.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:49:23 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-g12b: fix N2/VIM3 audio card model names
In-Reply-To: <1583135051-95529-1-git-send-email-christianshewitt@gmail.com>
References: <1583135051-95529-1-git-send-email-christianshewitt@gmail.com>
Date:   Mon, 02 Mar 2020 14:49:22 +0100
Message-ID: <7h8skisw7x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This is largely cosmetic, but Odroid N2 and Khadas VIM3 are G12B devices so
> correct the card model names to reflect this.
>
> Fixes: aa7d5873bf6e ("arm64: dts: meson-g12b-odroid-n2: add sound card")
> Fixes: c6d29c66e582 ("arm64: dts: meson-g12b-khadas-vim3: add initial device-tree")

nit: no blank lines between Fixes tags and others (cf

> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Queued for v5.7,

Thanks for the cleanup,

Kevin
