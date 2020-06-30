Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6158BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5492065F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yBqVphZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgF3KoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbgF3KoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:44:02 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8116C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:44:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so15154598qtf.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bCn6yAxhhKfFCMfxCVtciONp8WZ4qR8ToxEEMbZF44=;
        b=yBqVphZLN2l+GICEPyL10FeKN9ReRzetzIG7z/Dw1a13xJeahZY2dwtnbAhgVfE2EI
         M4urXR3MvtejtzNKSjigzTH1DgbCjMwrU9xh+v3JX+n5Di6cw0Pd6JFWNggY+1YqGdZr
         bsJ2t9s9KU5sTYq+gN5JY2lFjfseubEdMPUBNbQqX9cIwnv7/8kJ1xmXmGP0ZTp2oqeZ
         XVSTj0z3XFyhtrxvzb3sUOcJ1Xarw0F0oe0OpoUgNJKv5k2VWqwHSQu6K8CZUV4jjr8T
         rEwyjRixkrYP8Jz28ynJzG+jy1hPUdvO4HQ8pfaRZYB72hYb0LnS9l2NIenJi2bQSRZ+
         n9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bCn6yAxhhKfFCMfxCVtciONp8WZ4qR8ToxEEMbZF44=;
        b=kYWgJqktyoAmqS7M7EkjCcKVE8DXUJKzmdRZqa5+NT6ZYtK8VHOlxZtQVoK2aEEDKC
         Vt1anUx36VUgWO1gXwU+B3OUiEMJFYO1rodNVY5zoaUl7BmJI5jNkokCzU4E10POgwrd
         bfQ99rN7u5AiOpQdWapwyAmEbdOEIpeAqbx0I+rdcYeEmxd1NOpiKguViYJ1mn4mFdgK
         tGEMq1iHg5rpnnUzEwIie4VV++jC81GB+WPG/NkbJzgFlqxNAYkovHFt5M0My2IQObvs
         81xDHZBEaJokwiXYi3sc/9gloH4a3C68kLNssJALTi4zw+whW2NZqLTxzgrxB53LRE2W
         WqIQ==
X-Gm-Message-State: AOAM533l6ulIZvJXtYkdB8G8PnecEPMaXJR/bVVPzYQivHFy7gmIBVKF
        w3i6UQPjNGLhJDreieSS53/bQCUD6hdJgqTN+xgzxA==
X-Google-Smtp-Source: ABdhPJxgyHTPl/MdV/H9MRuo4y6SteuggF7clPqfYLQbfABBIYlSRtJ9cr2JB8tHJDCz+48DSc/0k9bEa0nCm5jNi3w=
X-Received: by 2002:aed:21da:: with SMTP id m26mr723714qtc.197.1593513841134;
 Tue, 30 Jun 2020 03:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-23-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-23-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 30 Jun 2020 12:43:50 +0200
Message-ID: <CAMpxmJUNHnPxgv3hvvx2GuVZHjCE3DJ4CiEqA5o5+KBg3Udw7w@mail.gmail.com>
Subject: Re: [PATCH 22/22] tools: gpio: support monitoring multiple lines
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 6:03 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Extend gpio-event-mon to support monitoring multiple lines.
> This would require multiple lineevent requests to implement using uAPI V1,
> but can be performed with a single line request using uAPI V2.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
