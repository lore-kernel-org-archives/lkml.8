Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3739C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A9E2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfrdutoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgETEit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgETEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:38:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF9C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:38:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j145so1847812oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gvGtY5nqJXPbJ1LBsOILjTaDTKNBUV9oTxyk5neDx8=;
        b=dfrdutoU73QiEI7RWhK3Xq9DKlTgEjQ31RRM66E++uRGGez1lIqk/qtQ6nML+l2lZs
         USS7DkFQNTMxvkSA6GtCDuIxqfw0+hctBd7BT2ZqOlAPoPaCtDBsENa2oeLGb7jq8L7x
         7uPnwTa5kqPTFR3E0k4uizFSdSWlFZfZycmtLC0dR4psle5GcCHgAvqTUNW8kWA7qOmn
         L/B0MY1Z3P8UtYz2P6SnWc9qNRvmDximS79CwuLQGp51YGcQIjbjUwRdw5zifkUd7iPA
         6dnNZT8JjtUBMG48gD0jlWbAA7NJXR7qigrkMF66XYS1/QSMKrLrxdKgEIzfyH7L/Z3p
         mFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gvGtY5nqJXPbJ1LBsOILjTaDTKNBUV9oTxyk5neDx8=;
        b=hPW6EjLj844jfewEPCuimNJ945vA/sLy1KxX7WZUtkX/TeXj8LyNyA9RC97D8/ZLr/
         jwppZrwQ+PmlvmAhM0bK53/sTcANv2IEpSdLYbAognhjVR/pHuj2t4X/boU74Z/s50Kh
         mzSGdFmoSvMgKQFJUkkW3Hh/42E6JDHTocKezYoDe3zsXqpM9nHOW6LGxKSNCskR04Bd
         YxMKYa/U45D/Ezkz6rtBJUS8tvSROjoLbKk3TdyncGDefPuNrf/CiKJXD9p+y3mAhMTZ
         x3jcD0hHV1R9A4x6CSEYxyYt/WeaKbKHAlRXahUCUz5TvTb+m3GLlgROjgehzfTtFJ+r
         4cOw==
X-Gm-Message-State: AOAM532uDd8OJ1Wj1LSbKC/wb2k0GVRh5MDM4NcXP6fTmlnxaL0mBZSb
        FJ/XbWx9034dUZm7TDvLkB7NzxAXhQkHbk3pc5ZlsQ==
X-Google-Smtp-Source: ABdhPJz9Do6JGTC2Xjtyghaq1P404WN1SjGSsMaszjfbRq1bSzqPkD5zd4sCBRDHzeDX5e2szj+lCQlb49uh9ew8Mz4=
X-Received: by 2002:aca:f1c2:: with SMTP id p185mr1986908oih.69.1589949523526;
 Tue, 19 May 2020 21:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200520043626.181820-1-saravanak@google.com>
In-Reply-To: <20200520043626.181820-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 May 2020 21:38:07 -0700
Message-ID: <CAGETcx9hYrnMF8JU+KV6jvxExq3jYgdg4Z_-TyjN4RUQnV8qvA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix handling of SYNC_STATE_ONLY +
 STATELESS device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 9:36 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Commit 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
> implementation") didn't completely fix STATELESS + SYNC_STATE_ONLY
> handling.
>
> What looks like an optimization in that commit is actually a bug that
> causes an if condition to always take the else path. This prevents
> reordering of devices in the dpm_list when a DL_FLAG_STATELESS device
> link is create on top of an existing DL_FLAG_SYNC_STATE_ONLY device
> link.
>
> Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Sigh... device links are tricky and hard! Sorry about the endless fixes :(
> Also, how was this not caught by the compiler as a warning?
>
> -Saravana
>
>  drivers/base/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 83a3e0b62ce3..dfd4e94ef790 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -543,12 +543,14 @@ struct device_link *device_link_add(struct device *consumer,
>
>                 if (flags & DL_FLAG_STATELESS) {
>                         kref_get(&link->kref);
> -                       link->flags |= DL_FLAG_STATELESS;
>                         if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
> -                           !(link->flags & DL_FLAG_STATELESS))
> +                           !(link->flags & DL_FLAG_STATELESS)) {
> +                               link->flags |= DL_FLAG_STATELESS;
>                                 goto reorder;
> -                       else
> +                       } else {
> +                               link->flags |= DL_FLAG_STATELESS;
>                                 goto out;
> +                       }
>                 }
>
>                 /*

Forgot to add stable@vger.kernel.org. Doing that now.

-Saravana
