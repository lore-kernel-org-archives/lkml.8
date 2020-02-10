Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6EC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9220733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjIiU+YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJLwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:52:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42108 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:52:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so3968075lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TSUn8xPcd6H5fjophC7T+z3GxaUtEa64TR/ndAUqog=;
        b=EjIiU+YGccj3kIRt1MhzLYhws7v879uEZ889Ve+TSTVdSqoqRFW0jM+7pskiGaf0xe
         t6javzVHeGfoVJfweIX1ECBduHJDfBctQlFQmvGhANEwrXZICkD3IZxgTkNqDVZJx+tG
         M34XypGWKZFWHX9buWHvh/3K7pyQZq3RqgsmlV1rAx0gaBbuTUjcpPtQt2/zDWHtayFb
         ecg4uzTZm1F0JxtDkP6RfUklVnqkCXNmm9jZMq1YRONE4tZTNzUjWsZYfqa1s3v1xhke
         SbkTGUoDoyGuWIsPKdpASDHVbNRsWsuNeQbGUZiogCejAeVE4u1sK/fIj+tQtdFtEcUm
         C15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TSUn8xPcd6H5fjophC7T+z3GxaUtEa64TR/ndAUqog=;
        b=tTj0ducdOjcz/iPQw7xai1irCg3Gm5mW/C8ovGWSTsSk34JgSvInxMMDKoXZf62U8c
         LaQqcfebxYFbvmWuNfLgk4611EU/pnkosP86JQiTBQBnM2sSCB2X6vKh1PH/4jpiluEG
         LP/1ds9fAZdos8xtb0LnBX7I3PAPm278T5LQNPnXDfy8/6muNXCDM43W5TqRMOJpsT7r
         fr2/JtQiQFJpqReqLX7mAarQPiUJRBDoB4m77utoySywF9bnr8wQ0wNagEirJ/7crM/T
         klBXvq5CKZiZDx4PUd8aIp8ycMbn+5Xf6aAmTCxkKm1DJy+6DJGLknzQElV74JlnMvB4
         bkPQ==
X-Gm-Message-State: APjAAAUDpvA+6eBSfTTvk4Ct2HvCeQjKSfdPisrz1xRS9SQW1dxpfK91
        Dh/XPIQMKqHqhRYUjpm90Fpc4ZuNLyB1RsIWXN+phQ==
X-Google-Smtp-Source: APXvYqzv7ZFAJVm8UDa2eHfp6BEfq1DCHyjIQeu1nId0TRH9xJlhezpl6EtuyJBfI40CcQuahPCeUz44MwQ+mtM6MeA=
X-Received: by 2002:a19:40d8:: with SMTP id n207mr594507lfa.4.1581335559768;
 Mon, 10 Feb 2020 03:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20200125221410.8022-1-pthomas8589@gmail.com>
In-Reply-To: <20200125221410.8022-1-pthomas8589@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 12:52:28 +0100
Message-ID: <CACRpkdZjFpyp=fySNRfMCnm6-JJ0xY-sGU4deDc6i6iPOuAG+w@mail.gmail.com>
Subject: Re: [PATCH] GPIO, Fix bug where the wrong GPIO register is written to
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 11:14 PM Paul Thomas <pthomas8589@gmail.com> wrote:

> Care is taken with "index", however with the current version
> the actual xgpio_writereg is using index for data but
> xgpio_regoffset(chip, i) for the offset. And since i is already
> incremented it is incorrect. This patch fixes it so that index
> is used for the offset too.
>
> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
> ---
>  There are many different ways to correct this, I'd just like it to get
>  fixed. I've tested this with a 5.2 kernel, but this patch is against
>  5.5rc7.

Fixed up the subject and applied, added a tag for stable.

Thanks!
Linus Walleij
