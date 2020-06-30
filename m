Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05EEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB60D206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b43IWOnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgF3I5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbgF3I5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:57:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24EC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:57:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so17827726qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLfyA6kwAk3sFKrISr9s3SubY2mEnwLHD2Bu93ov3kU=;
        b=b43IWOnxRsypW3ZvtE6GOdHeSq1it21xnZfm11oR1prYjnkDmCgV5GI51EaOc9852V
         61fm//3tcUCZ+FHey/EAdlCAcAo90oHSIuxxp9cBo7XEDz0kSmkjixQwrI+Et0UpR7bh
         DJpLgzaBmvF+VzLb5QJeSpgNobbLekRrbWNVmxSEfxclrZhNJrCOdA8xj8YRCjvL1Egk
         zrY5fXKqAg/4t4zZo/1D2odDdaSMrIfS2ROO0J/S8yVDV4ZNkMtBvmzBDoho9cLrl/c7
         5XdqGnX6Z8Sun+Kzw/3ApvKk9X/jm27KJ+E5qFo/HYhsgGG3Jq4PpK4mBAP94J1KGn1X
         BCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLfyA6kwAk3sFKrISr9s3SubY2mEnwLHD2Bu93ov3kU=;
        b=Q2dvSbx03J85AvDmi498suWD6eHbjW1xcnG65xIhoD4yYWO/+PCe3y63C+k6uDV0zN
         mFT9m9wCzwp3MejZoFYOF7J1ga2arHwKk+D/yK6yJQ4P9icKQMfcT2S59RTLp+TDTZQb
         E22reK5W1iYbW9liCSnaPc0+cLkz2kSn8grvX5friKCWnxD5JOo4YmdZ2YIcsRdeLHJl
         xspvHkRKSfQndhJbxfBSzYBbL9Qof7wV1KbZmxssrzEyK7DOSTT7wv1umF2F9HiKs7X8
         n+bsAPGrKPY2DwIPbKHuSi1Er+ay+xDLhnyXu1u2J0TTdFl5o38rlUNxirt0tnKM+MHk
         EyVw==
X-Gm-Message-State: AOAM531G6NFZ35m4Dcp6Up6ugSkrf2/QrFXJIba80ApB/n/hb9FveFUZ
        cDGtiyzy6j73RTWVd/167iAI8+V3q/MyqzCDViqxhQ==
X-Google-Smtp-Source: ABdhPJzps1YB8ezGIBmRJ3hfs+iy1hFiHLPHFZxcAaGXZRtoWn4YonE9966faoaFJCS+TsMSaqxR6nyw0IsMbP1OWOc=
X-Received: by 2002:a37:7741:: with SMTP id s62mr6662405qkc.263.1593507428004;
 Tue, 30 Jun 2020 01:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-12-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-12-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 30 Jun 2020 10:56:57 +0200
Message-ID: <CAMpxmJUDvfaFJSma642BAyprugae16Nag5zSVuApNPakiR-O3w@mail.gmail.com>
Subject: Re: [PATCH 11/22] gpiolib: cdev: remove recalculation of offset
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 6:02 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Remove recalculation of offset from desc, where desc itself was calculated
> from offset.
>
> There is no benefit from for the desc -> hwgpio conversion in this
> context. The only implicit benefit of the offset -> desc -> hwgpio is
> the range check in the offset -> desc, but where desc is required you
> still get that, and where desc isn't required it is simpler to perform
> the range check directly.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
