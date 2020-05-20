Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8D207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="kea5AkX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETLPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETLPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:15:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DDC05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:15:20 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h26so2058669lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5g/o8PUZPrNAJIWyoOWEybfjQaVuCtrfU+HgSjaoumw=;
        b=kea5AkX0ou1aP/8ibJ65TsXqG7JKMLU5s5e4R3yHJGH+a+ozn11pQBzKtTGq34DtKo
         RpweiZTOmY7YZ4KFVqDxsCSVe2OZjBDZBVBIn/jeg4Qwn1W5PwPPJokOlzpOoj3vqshv
         cmORZuq7e91IWNiG9pAOQMeA6/vJ6mMkgATPDXMJg/5XElENes0TWwKd7wN3jFB9mLuO
         BQys++AIoeAGlaFcfW9EcbCvm3aHIe78PLHpGSPlZyBWp3wlWqbLeZ3RiP1G7rqRx0jJ
         lg4doC3DKqJzQHczPWTl76Im8fzgIXX6vJTOHa+LhhD+oYvNwbksAc+SLjunjyGdow94
         JBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5g/o8PUZPrNAJIWyoOWEybfjQaVuCtrfU+HgSjaoumw=;
        b=f5cvWNy++3jKzSVzQpP1Y9t5Aotgnp2L5aeTeC88BRjRHkTanO9yrOmg6pivwr95j9
         d8QeCKAM+xNNj7GpX3rhwS7ic+HMJMMVXFLINoIUIEi0ohAqnETtX55P6CHI79n1cr+d
         EZ3Th0TQ0yAwh1u9YtSOQ/UQrDmzCv7SBstjGhHm+GJIeA1LGWGjEc6RHNyWlqq2EPYq
         ZC9b2H8IchmOR6VoMy6jZVs7HZOSOYxgDRzeKtbTKiWSpvCwrpmLnVztfZvV6MK6IcdH
         ynw5Gn/IUvtHvIXWQ+6flth9Hk1H+dRv+xHWtDmkcrhrmnirO4AVkqBvF1/+CCyh8obg
         W/yA==
X-Gm-Message-State: AOAM5319Uvqeuvjv60GqvSIvrWXudmOa7xHgD5jmEw6kxO7W7A/KWTYp
        vnPCjS4l3ULm3XauRsijqEgNEypmItVpbmkNgzQi3Q==
X-Google-Smtp-Source: ABdhPJy255WD8U21Ushovf34k+G+2sKMGyfVGQ6u/StQOpa9NwmtllVnOahvkS7bR02qE6ErmJ0TOwu/zbsjmgOWYM8=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr2303943lfi.45.1589973318888;
 Wed, 20 May 2020 04:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <1589969500-6554-1-git-send-email-martin.fuzzey@flowbird.group> <d7a0646840374e1d7515bfea7da2badd94df0042.camel@pengutronix.de>
In-Reply-To: <d7a0646840374e1d7515bfea7da2badd94df0042.camel@pengutronix.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 20 May 2020 13:15:07 +0200
Message-ID: <CANh8Qzz4bx8scFdF3Hhe0UsojEyBswBuwiJQ0UW9HPUjrjpd_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: fix memory leak when mapping prime imported buffers
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     stable@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

> Am Mittwoch, den 20.05.2020, 12:10 +0200 schrieb Martin Fuzzey:
> What's the use-case where you did hit this issue? mmap'ing of imported
> buffers through the etnaviv DRM device is currently not well defined
> and I was pondering the idea of forbidding it completely by not
> returning a mmap offset for those objects.
>

I hit this on Android 8 (on i.MX6 using mesa 20.0.6 with gbm gralloc
and drm hwcomposer)  and had a memory leak every time an activity was
started.
I'm not sure exactly why but Android does a gralloc.lock() and
gralloc.unlock() on every activity startup.
Those map and unmap the buffer.

Under Android (at least in 8+) the actual graphics buffer allocations
are done by a dedicated process
(android.hardware.graphics.allocator@2.0-service)
because it uses a "binderized HAL" for the allocation
[https://source.android.com/devices/architecture/hal-types]
This means that buffers are *always* imported (though they are usually
only mmaped for SW rendering or screen shots).

Regards,

Martin
