Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD0C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F61E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ46d3g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgAMAGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:06:25 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42237 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgAMAGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:06:25 -0500
Received: by mail-vk1-f193.google.com with SMTP id s142so2077612vkd.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 16:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HL17RsQhpvHGVShSuMEnDCDjyjoYw8RfuvSsolxtKc=;
        b=BJ46d3g1EqtVBj1REWG1osVEA0ioMzxPhH28Voa7Awf1EbCYKRi/or0ikFnFF0Xtj5
         e0JfYLf1HxqHlmkqdsJ7sRitHZuL6W1USF1SxIJv60yhpJTNYkDvM4MUVLdt1kUs3sAa
         hn901YxwMn96I/6B6WDo8r63EhWYRW72DyhKp85pfztWr116M8l96gtMgjJ5uoYjgn7i
         qLzV40TO01xhlnShJitRxTqNCZgZL76N2mQr3gFOHb79/NGtJkPvH0DsV1MhgHPflAgN
         Ib0YwyNqtbrWiCbmZVKzEEZUB1P09dM4gNkaqm0cZuppRHBWUK5tW1cUyP8RJaSKvcAT
         JfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HL17RsQhpvHGVShSuMEnDCDjyjoYw8RfuvSsolxtKc=;
        b=mLZe6cfjXCGA692AP4d719uXoNIRRkPSg47tpd8pYDCiRkB1jh5Mqp5X7/t/+1u2Gi
         U9L2ckyat9siTc7mBKj1kVXC+8cX61/f5lFJ3rMXIWc7v7MB6uEusBvzhHXvXFuV8mip
         Kh/gBcJ68VzC8CoR0rbqK380NQelJVnb5uA77QDcxPJiuDfhk12XH1GwPfd6BJ08BM2e
         SBqjx11FQ8CfK8OvwI+fJ06JCZtFywBK7W8Y5ma5a9/tA3is+c6B8bbfM8Opcrswhv+T
         sHnPgms/jXOd5yRUrk2iopbEvSKTvkL6++yFYDSbmAXIhyaG6Da2R35ch6YGF+xm/ah8
         UdWw==
X-Gm-Message-State: APjAAAWhuXcmBXxvfUI6SPJ62iQFzRjWl2lwfNgghFnRM6rOGQM/KIdY
        5IpsEUrO1dHfDoT5J7veHJej+A7qBkLZlMiBqXU=
X-Google-Smtp-Source: APXvYqzGUmlmfiMEzFg+1Y2A/xrmXNSvnyyQzuYUdfcc1RWK1JrFT8cW87AN1eibIhZjvgcBqYpoB/Fmq6QSxuCaLFI=
X-Received: by 2002:a1f:1144:: with SMTP id 65mr5884087vkr.77.1578873984539;
 Sun, 12 Jan 2020 16:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20200110063201.47560-1-yuehaibing@huawei.com>
In-Reply-To: <20200110063201.47560-1-yuehaibing@huawei.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 13 Jan 2020 10:06:13 +1000
Message-ID: <CACAvsv6EG0wvF4XCs=jisEjMDkfVUgMorgURko4uubqc3DOgOQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Fix copy-paste error in nouveau_fence_wait_uevent_handler
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>,
        sumit.semwal@linaro.org,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 at 16:51, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Like other cases, it should use rcu protected 'chan' rather
> than 'fence->channel' in nouveau_fence_wait_uevent_handler.
>
> Fixes: 0ec5f02f0e2c ("drm/nouveau: prevent stale fence->channel pointers, and protect with rcu")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Got it, thanks!

> ---
>  drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index 9118df0..70bb6bb 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -156,7 +156,7 @@ nouveau_fence_wait_uevent_handler(struct nvif_notify *notify)
>
>                 fence = list_entry(fctx->pending.next, typeof(*fence), head);
>                 chan = rcu_dereference_protected(fence->channel, lockdep_is_held(&fctx->lock));
> -               if (nouveau_fence_update(fence->channel, fctx))
> +               if (nouveau_fence_update(chan, fctx))
>                         ret = NVIF_NOTIFY_DROP;
>         }
>         spin_unlock_irqrestore(&fctx->lock, flags);
> --
> 2.7.4
>
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
