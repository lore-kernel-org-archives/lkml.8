Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575A12076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvsM8/Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440705AbgDPH4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440644AbgDPH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:56:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBABC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q19so6721720ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMPtB/qA9n4HSaCSGb/6f9EwCAFkZ6rP/1whAbdIn9g=;
        b=kvsM8/LkXMpyV2rwPs8DlvQWEgGy38v1FnW5pfXAehq+Qe5XtkljcYiGpvhAx61cA7
         Ca9wfZkTyOhlDDuWu21855wvXMz1kl8tQOqPwhJK9bCgZZfOU3scVNpV2PohAs8IjV10
         7gH1ZHuxS628yADfWX4rIyWvRCTP0F9i8ZXdfKGnODvzJo02vaXJ8U0FLsdT4tXqYjnC
         6pe9REbPR8Y8xROdwKcOkPtD/XFd69zFRgI9ZunqJGQEClo6pMCZ3HSQq2hXm8bF76HW
         jmkUnP9Gul+08o74+R8Nl/jxtOjLHHTBE6wtTjx2W2baZx8Uv1d+WrlSTPzDa7/dQv0c
         61Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMPtB/qA9n4HSaCSGb/6f9EwCAFkZ6rP/1whAbdIn9g=;
        b=hR/Rlt+51e8Lv5anhRsSM3P/szmNUFe0bIiNGYyTeFefR3q+NM6qGa8o9ySGC+CImV
         KjpBhIeHjyGBfSxY9TqV0WqPVNfQj7WOJkVhjzXQ4mp/EWbshqw/bwn6WB6IqZPbgcSG
         FlDvImECEh5i4P1pwqKCLzym8f/z/Kz0oKbn5Qvyp6KTcw7n+3sYqzBPeAGLcamDJp41
         kk2QmYughdDgp2iVxZvJse5gMZ0WBGJQxD7S/hHysD25LmGwsWZ8uWiNOhztFTUKoEAP
         8k5TLWkKDXeO+hq42Cz1HrnpPvcxOwJKZHbdCAxdlFKnxNsGmtRwj6uG4PxE+bHSJYhV
         +Kqw==
X-Gm-Message-State: AGi0PuYpuyGfZTiPwYLnzoQrsX44S9KEhNQFYYT2Bcd7/Fpdz2QU8dDY
        wY2h0EXaqQsAEbPneCLL4Nr8qIcbyiWStXNIq1ybYw==
X-Google-Smtp-Source: APiQypJcmQRDFwooP+VIrqUkTrQ++SnGSWcitvwwWR2ZjguUj/BI4ZlkDGD8/57sEAr+kX5uCQw8BvzROFjLhAmc+Qw=
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr5771834ljj.39.1587023794382;
 Thu, 16 Apr 2020 00:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <1585554986-26521-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1585554986-26521-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 09:56:23 +0200
Message-ID: <CACRpkdbAZJ8F04iAQqBv-ag7WWPLaKw0Tq0RB4ygPommWpZb0A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik:remove unneeded variable
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:59 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:

> ret is unneeded, just return 0.
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Patch applied.

Yours,
Linus Walleij
