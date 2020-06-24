Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F7DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BE820781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YTQ2sWvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbgFXNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391062AbgFXNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:54:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B140C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:54:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so1679130qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NQkrsxjDdsmZEVxqxY+8ufwWus4F7B1Od4+L9++jURM=;
        b=YTQ2sWvOoPM2vQR7+lyfwWEExK+4ZvBkqBaulOwGNu3XDUTwalaF56D+5SYCBDNAXn
         1svBlVQdpFrYUfyIUqhWeqKSNNTtcq+JXd27nIK/FTFMezR7qMx3MrK8OOis/qbVZWpk
         c1ImTfp7UE62pdQVk1QO6d5GWAIXqfqZFcQkvcWfDA7YsdzA1GcbpSeGi9rHObuwwpbP
         L1GokQ0XQBDxDqSCBCHyDFfNJ9KPBo9kzNFvyCmXvPe9HLnUe6CwkbIKcVGCDk2MvhJZ
         A+2Lt0REfh1DDU8PO09p+U2fqsBs6bslJdrHXk/nq6qeu/QghSct2AGya7RU0llG5QHr
         8G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NQkrsxjDdsmZEVxqxY+8ufwWus4F7B1Od4+L9++jURM=;
        b=krJrNtEnqSLrOakYzkF/fsTEytCXQEvG5SE0cZb+umL6VgWTR9QqFJE3ZtUkQyP6OM
         RAf+auaMzvugjG91ASN4yW0fAsfEknAZr9ZcKGiNnlo1/D61lzPeXZ45m6POw85zc3wP
         L+fou3NgXCxFQW3vMqPVsTyPCW4xp/PKxwuH6Ax/oIcSVW2v7cLFVV8Ms3a+QioEf1nz
         jsbvn8dTNRkbxnNW/fzvqocFnFwq4jwa5hN4xgxxtohRmWRw/r3I+jyDk8koSs8wMRvG
         OVJnhW9u0eHabDJTJMAKTiVyLzHWUcu5dAH3CZZmHHfTzrOdxXyPlLOFnBVtWLrqgWZs
         RGIQ==
X-Gm-Message-State: AOAM533LvwTGAvK/AXnWj9Rth02g0qKTWmhPDV0VliSNoEVEWyz5PUDU
        2z3sFjZcOc3sDSx1CthZxkcEhKTqvXKu6ryFQgVe0A==
X-Google-Smtp-Source: ABdhPJwcHIikenXP1O+2YczuwWCzJOygplvP6C/CH5w1IHNKGD5NlVsw8prqjeL4PK2NNrrxL+PW48GOXE6r6+Mow60=
X-Received: by 2002:aed:2a75:: with SMTP id k50mr11067272qtf.27.1593006849420;
 Wed, 24 Jun 2020 06:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-8-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-8-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:53:58 +0200
Message-ID: <CAMpxmJXNakO6Lu0XFUnKS4tc2pg9D39iLs_Y3+jx+tUkovsmjg@mail.gmail.com>
Subject: Re: [PATCH 07/22] gpiolib: cdev: remove pointless decrement of i
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:02 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Remove pointless decrement of variable, and associated comment.
>
> While i is used subsequently, it is re-initialized so this decrement
> serves no purpose.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
