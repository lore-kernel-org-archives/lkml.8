Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCECB2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRTjWikw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgH0Pxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgH0Pxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:53:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839A2C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:53:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 12so3184023lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/7v0OcLJd+85B4m0F6GgazrXp90bsSaI2++Fve0hkc=;
        b=XRTjWikwCTqOtz9bbWGyp8OyFKmj9u05cm8ItyXDCZfAjMAEDGPs+Ex9Yx2UPe6Dm8
         2cb8Qd2SgkqPNSPhFXuT4pqi0rjEDuCemp9J3oW6hd08gaJykCyddOfpma2cfrRoQE+W
         XCPPaQQVb0tmAN6vg13HZ9o2ovap9IIpoKcbcm9RBwaVzXthorSyyJKmijKsM44EOtdI
         bNo+AlZpZQJBd23E+jbJsKBFTvKWYnL5/i7cOA2T33vv3BciYjMdEdZy0WR5dLDlC8eV
         ZzTLV7SwEO9X6UhfZdMHXsUBIhbhlVbm+kt1Z3od07M/IrU1dlsEIpKN2GXeSrWKR5dX
         f/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/7v0OcLJd+85B4m0F6GgazrXp90bsSaI2++Fve0hkc=;
        b=UOvFSdwjhLRSB1clOKgtUsFBLmP376gWc5ycS5oopDJat10sHL9RF14qmrCb+d/i2j
         gwmrb1P/r5CM9hPKwEERRx81QjKWxXohAXgoQHX+yToAdPKix2jNfxCRMU4GRTDNUTZl
         5pAhJgvJrOGP65ETfYxG4lFLGlgmn5WnG7l/sAdTrOJrJmgotXIyQAuQlfcvWBXyFfM1
         JzdALs4Pq7xIbVjg5WF052OkKOlrlbTcYL8N4AYH33AbQf0qSqHRDwdmrOvyx+/yyAec
         y1XS1QBgHOehEJoNJeAZI/qiU+go6quQHY5ozwssRgltGJsde78Eajb7eS/BA5RjKBuH
         cmuQ==
X-Gm-Message-State: AOAM532+uqQyEZmG0Uoe9rI4pWUfeCcQB4a659EK47LR/p6vWr+wcJl6
        NDpSa2N4Pv1ebXXzlNRxDNrdcg34BrbkmDik4z6HJwvAFIo=
X-Google-Smtp-Source: ABdhPJwLrXSTFfL8l6OPWP62eY6kq6VVP22QbZDNnM2HqMybIQf2yJcCQ35jcn6ZYb4WQv+tOKgaMoTY26doX3rNs9s=
X-Received: by 2002:ac2:4d16:: with SMTP id r22mr10168810lfi.21.1598543619936;
 Thu, 27 Aug 2020 08:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200827140020.159627-1-warthog618@gmail.com>
In-Reply-To: <20200827140020.159627-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Aug 2020 17:53:28 +0200
Message-ID: <CACRpkdZZMbfpKy4gcfAzNq53LkYLcL9wm3Qtzyj_K8vkUW9RfQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] gpio: cdev: add uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:00 PM Kent Gibson <warthog618@gmail.com> wrote:

> This patchset defines and implements a new version of the
> GPIO CDEV uAPI to address existing 32/64-bit alignment issues, add
> support for debounce, event sequence numbers, and allow for requested
> lines with different configurations.
> It provides some future proofing by adding optional configuration fields
> and padding reserved for future use.
>
> The series can be partitioned into three blocks; the first two patches
> are minor fixes that impact later patches, the next eleven contain the
> v2 uAPI definition and implementation, and the final seven port the GPIO
> tools to the v2 uAPI and extend them to use new uAPI features.
>
> The more complicated patches include their own commentary where
> appropriate.

I'm ready to queue this now. Certainly any remaining snags can be
fixed in-tree.

It kind of keeps in tradition with proper software projects "plan to
throw one away" which is what we have traditionally done several
times: the first Bluetooh framework was tossed, JFFS was tossed
for JFFS2, Video4Linux was tossed for V4L2. So let's do this.

Anyone against? I will put it on an immutable branch and then merge
that in for devel.

Yours,
Linus Walleij
