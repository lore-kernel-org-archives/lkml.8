Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E8BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C6720878
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHchiWv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbgEYMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbgEYMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:23:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:23:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so20569139ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1neDSVvo2exAwO7XG1Q7asHC8C/uLbtbXAanu+QhUvY=;
        b=mHchiWv9d+bl7TypEyswUYJoJBznRNEzkaqNXJ6yZYcwVhCmDlHeQE5uaH/HclG1/A
         Bx4Cg9tDzYVicfaKmVDBhYVOUgLefRTuPj7YFVjqzZ8YnTP/1LLLJTykYqXl+FHN2pZL
         g8xP1m6SXMaHEiGtmqiEB2IP7G+kpZcs9VS8hZv85N+n3X6CdpddRhU6y1nCKsAQzFCY
         4rfmeLIz/oOwhxkepv8pd1oS85BdwpikntEpMCfo0gVE3d09pfC4AhwFL/nAFV+L4+Zb
         mwcQqn4CqSg3gj+nOH2kk2AibQMFcCPYOzlGhx/9SXJpErxweRkVif+GCa4LGQO8gvT9
         9trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1neDSVvo2exAwO7XG1Q7asHC8C/uLbtbXAanu+QhUvY=;
        b=KwG927CvdKv9oPKBcjpLCD5XGsAOh1GUiaTOMn085gX+9tWb8e3xzqusqaC80rM1RK
         4lUqlcyDTsvQwV/tmwPPdtHL4YH4fsUHPckBsLwsyBaa8GOsIou+nLstlLPF35LUzb/Q
         dM41zM2E5QUg9BSAXgIehKs8QzateE3NHDLXckQJrUnTza3Y43EPIZ8G6Wz6ETbrzK51
         3YHvtml+qhMxnFM6lwcP0ILui3QmxtB/npiywqa09FbK054+N8XBtLojwSVon5kS4cmZ
         Wt4moA35ZQWbUvTF4MO0AH6IjgCSBmBQx1NL/mp5dPJI4mu7D7/kC37UgH0fVuThM3Ka
         vv2A==
X-Gm-Message-State: AOAM5329Gj7XZH4q4Wn5Pa2ZIoV4Hd4rLDsRRDELAgNSvH7Iqfx5pk+s
        aEE1GMAg2RzJsT8VoaCzx9s1BHaccwbvKgS6gVmGNw==
X-Google-Smtp-Source: ABdhPJyf5wZA8Fh7xQjtaNnLLHBTpAkEbLAQIKhyb7JglaMhaJDSU7UOMtER0/cndL74Gsc/vcIt53XFGmKsX5AJ0t0=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr13451102ljc.104.1590409434478;
 Mon, 25 May 2020 05:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com> <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:23:43 +0200
Message-ID: <CACRpkda26eQZGMfbq-FL9X532mK=Z87GotjYMu2MWNGgNohp7A@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 5:46 AM <dillon.minfei@gmail.com> wrote:

> From: dillon min <dillon.minfei@gmail.com>
>
>     This driver combine tiny/ili9341.c mipi_dbi_interface driver
>     with mipi_dpi_interface driver, can support ili9341 with serial
>     mode or parallel rgb interface mode by register configuration.
>
> Changes since V3:
>
>     accoding to Linus Walleij's suggestion.
>     1 add more comments to driver.
>     2 reduce magic number usage in the driver.
>     3 move panel configuration from common place to system configuration.
>     4 reuse MIPI_DCS_* as more as possible.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
