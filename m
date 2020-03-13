Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D0AC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8120674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fb7uWYOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCMSFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:05:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35567 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCMSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:05:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so8313269qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDlxU+1XKAxrrsgNFuO7SmcWGCGnxac2HBDzdZLOJKA=;
        b=fb7uWYOIDRZuM0lLutv+Kq/0ARim7AfCnQP88HW1imxu6xzWuwDjMG08m+4FIMKxJE
         /Vl6pThzwWkWYcNb4MZDNXtJ1UkWDKE0hm6hBOhFcOtE6sm9Lif/W0vFCFT9whB8LDQe
         jyl6t0vluYzD176kp+F4ShQkv/VQGjfFnuAXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDlxU+1XKAxrrsgNFuO7SmcWGCGnxac2HBDzdZLOJKA=;
        b=lJrcvZMDCoGMJPACXAi1Ap0+EZu7zBedaBCpuA7BE6ggkjZ8VpwI1hFrC618iS1IZr
         ktobI3m+KhhGSZ23Cr/egB9ybmWJJe5N5u0ADZ7/W862S/lztT+6Vn1H8QfNEBsStHjo
         izAUd4jqMSUqHXYsZi5FvLI7EzJJQtPmMfhdqYvBDQb3HII6x4hQA6qTYBBPr8vMs/lT
         gYOpzTmDYLXrkqN4ytSkBjxYY4HvLUIUCHWBjn4GR32pQsNHLEIaKEWmJDQBqJFo2eYo
         XR8XINoi99Xjj1H7Thkl2xd0R5ONGcHnt4W5h4k4cxIjXoaeuLJgRB/baKi5rXzGFjox
         VyQQ==
X-Gm-Message-State: ANhLgQ08G6Lf5GSu858rNMvi23imoteV1zxBetXJoCAXZZSM0LpU9Hfj
        Ck1WN37MphhCo1Jd6PxdLBgf6j9yI8U=
X-Google-Smtp-Source: ADFU+vuSb72H9Dz0NKI0BvvFOcxqaObjb1TSCn4zm9xliexYGupRf/MWPQWJe45HCF+3bP+IHqZZcQ==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr13942724qtj.104.1584122736997;
        Fri, 13 Mar 2020 11:05:36 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id x89sm15753267qtd.43.2020.03.13.11.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 11:05:36 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id r15so5080212qve.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:05:36 -0700 (PDT)
X-Received: by 2002:a05:6214:972:: with SMTP id do18mr13241291qvb.12.1584122735338;
 Fri, 13 Mar 2020 11:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200313180333.75011-1-rajatja@google.com>
In-Reply-To: <20200313180333.75011-1-rajatja@google.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 13 Mar 2020 11:05:24 -0700
X-Gmail-Original-Message-ID: <CA+jURctTtUCJyD0Rdd+urMiaASqyipg_mPrOBW3CEdmkVWHeOA@mail.gmail.com>
Message-ID: <CA+jURctTtUCJyD0Rdd+urMiaASqyipg_mPrOBW3CEdmkVWHeOA@mail.gmail.com>
Subject: Re: [PATCH v3] Input: Allocate keycode for "Selective Screenshot" key
To:     Rajat Jain <rajatja@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 11:03, Rajat Jain <rajatja@google.com> wrote:
>
> New chromeos keyboards have a "snip" key that is basically a selective
> screenshot (allows a user to select an area of screen to be copied).
> Allocate a keycode for it.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team

> ---
> v3: Rename KEY_SNIP to KEY_SELECTIVE_SNAPSHOT
> V2: Drop patch [1/2] and instead rebase this on top of Linus' tree.
>
>  include/uapi/linux/input-event-codes.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 0f1db1cccc3fd..c4dbe2ee9c098 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -652,6 +652,8 @@
>  /* Electronic privacy screen control */
>  #define KEY_PRIVACY_SCREEN_TOGGLE      0x279
>
> +#define KEY_SELECTIVE_SCREENSHOT       0x280
> +
>  /*
>   * Some keyboards have keys which do not have a defined meaning, these keys
>   * are intended to be programmed / bound to macros by the user. For most
> --
> 2.25.1.481.gfbce0eb801-goog
>
