Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6416C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846BC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qdfc8f2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBJH1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:27:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33536 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:27:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so5615370qkm.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzcZT/UWGik4t5gs1NKn0cClPiT0b3AGqVBvPjLWL6E=;
        b=Qdfc8f2FzV1RpB9MRVV1aynBc0H4QOGQa7h+tsu2mHtMP2jgv8n9U3W99cY4YIRUY8
         KMfy1kcCCz46qL9KpDceFaN7MqeY2EzD91XBoxUOUT3pn1mp6gyahfqiu9l/3N1occ10
         8yZgNjwyWTfCHVpIHIKd/kS8xQmCPfdoz3SwIqhtQzwPiFu/4WJozEf8ZNEgdW+Ab7Ri
         2+4ZeToxtMvOoguvLIkHGh67Cws1wsv+FDNKcfgAcRUuS7N4tilt+mSmlMs1vPkZkJ5m
         87mUdeqCAI3/Ic0J8EfS7p1e6ddEwNW6tPiSNND0e28k96CxJto9l4vpW4kS2VYgLS2b
         ZWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzcZT/UWGik4t5gs1NKn0cClPiT0b3AGqVBvPjLWL6E=;
        b=HvrUkzqzVXDZlA7yuIPX1IfQXP5mD4nJ7BEN+cuc3o1lUdBKG6QdONDbv2/HLiRWrL
         2JmGsiJbTPuX17WY1l7Mg16owjk+nbixxWAr2y7nURBTCX5wWUOgvV0SMTPgpz/8t6er
         SQYMFgWGDfix0yuSv1fVLBBOqcP77sE1233v9VU5n2QT+k8CfMiA2cFje7GJI0teRehj
         OHhlALB/PzOd0sHXbzq0XMhBpcBO9g/V9bpYZgBs7BeO7WhSSvG982zzAtUmPkEk+0AT
         fmOGzzMcFdwmw51vmJAEnJQHhFgaxbGZSIpbpOaDY4J7ameBxXtwvb6Ta7PEFWGF+83K
         vn1Q==
X-Gm-Message-State: APjAAAXvApMyzQZZLjwPglw/A9xWSB9sJigBqRP3SgWEyWhfF/Etae/s
        mx2dvia3kLWuWkVz/uShZFNQOylUIaXxTv+LfvK8Pw==
X-Google-Smtp-Source: APXvYqznkEYPuGUAjv0MkVzqxTC84niz0mOgxTbarhDOpdF3uqOqX4ys8UPmqfho/6vhZ/VaoLmcF0QjI31AfoyQRFw=
X-Received: by 2002:a37:e30f:: with SMTP id y15mr180681qki.8.1581319653847;
 Sun, 09 Feb 2020 23:27:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581282103.git.jbi.octave@gmail.com> <38efa7c3a66dd686be64d149e198f2fddc3e7383.1581282103.git.jbi.octave@gmail.com>
In-Reply-To: <38efa7c3a66dd686be64d149e198f2fddc3e7383.1581282103.git.jbi.octave@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Feb 2020 08:27:22 +0100
Message-ID: <CACT4Y+aPgahWAyvM8KZm1bY3PfpKGjP_EHgCO8wsvo53EtGBYA@mail.gmail.com>
Subject: Re: [PATCH 10/11] kasan: add missing annotation for end_report()
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 11:49 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at end_report()
>
> warning: context imbalance in end_report() - unexpected lock
>
> The root cause is a missing annotation at end_report()
>
> Add the missing annotation __releases(&report_lock)
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5451624c4e09..8adaa4eaee31 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -87,7 +87,7 @@ static void start_report(unsigned long *flags) __acquires(&report_lock)
>         pr_err("==================================================================\n");
>  }
>
> -static void end_report(unsigned long *flags)
> +static void end_report(unsigned long *flags)  __releases(&report_lock)
>  {
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> --
> 2.24.1
>
