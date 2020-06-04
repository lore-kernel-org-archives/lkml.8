Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E61CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE490206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAY6TZyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDNH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFDNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:07:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C90C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:07:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so5063047qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ClLrIavOqOGDJWYrPRq16jGapJaGkyGJvYKPH8Mh8Y=;
        b=hAY6TZyUVLdwz5BG4D68XEohh0RwANhV9ipETDtzkliGovl5W+0bYcARhxU0/Rh4tg
         Cvqr17MrqBWl38Um1cwF9l4iaxAZGbZZyGAsHBTEf2lkSEmVBNePGowfVBYm1WIOQVZ0
         O2MG10e9I2akcCxna1eN2iTse4VgW3QaZ0Qvoo7xvvwJ2Bp0fjONh0JArZBHueoWmdZE
         LddK3d+yCLkBw4ukLnwHMKqdyS8u8HJW/VRnDqzwUASK0JOS5C3JrvADDMwWvlSUul26
         voh3frxAjPQnNGQMI6oPUYkOu6OMFXD6YttSDnm4FIlwMAJInUn6GnbhklJQnso3BP0i
         UpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ClLrIavOqOGDJWYrPRq16jGapJaGkyGJvYKPH8Mh8Y=;
        b=snD5HNVWzrsS3ShrckP+2UM4gNwbxSvy2uL1EFvgqRrvE+qxb1BMnKpRjJlvd2VF05
         NvWbCWLqlfa8weRyb4KHKdCs3PsGgcReOCp19/z5T7jPAghQM8+Gt5v5ZQhClS8BlbfG
         t5ORMq3WsVhNi26cSEZW1zDPiO5X+dYUKwsew4PWKUxVE5jn4fL3NOuuBfNBREzrAWd5
         iqxHrIUmMa2yltswv9Rhsp8NbNwxzsjWLz6diEpoUx7f8sYZjAGwD1OmaIhXWeutXtj5
         AXpYQMZV9AQzw7N9KfBZlDHpK6uHH3KLl2mZOhjDC8OXjyjpFQnALOqSesvYZr0wRMEW
         JGZQ==
X-Gm-Message-State: AOAM530sovGIgYwUGlYjr96EGyeeyR2T9dvNUvXJQiyfDSQvuTrcEywS
        rJXPo0XvVZbditCLyOuF9iMayPNyO4iOJNuVt5ZKUQ==
X-Google-Smtp-Source: ABdhPJzANH3aPPcoaGhaBOl/6Y4FjEYA167aD7BW2mye/1hE+No7niiOsusJLz1E0fH+Dh1MaO3Jd7aWqFfF+Hy+E/o=
X-Received: by 2002:ac8:7a87:: with SMTP id x7mr4566443qtr.50.1591276043290;
 Thu, 04 Jun 2020 06:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com> <5889efe35e0b300e69dba97216b1288d9c2428a8.1585233617.git.andreyknvl@google.com>
In-Reply-To: <5889efe35e0b300e69dba97216b1288d9c2428a8.1585233617.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Jun 2020 15:07:11 +0200
Message-ID: <CACT4Y+ZR0FvQeRvfsTpwUMQ8gFfMT4BKPt79PdTN-_HCN8pdAw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] kcov: move t->kcov_sequence assignment
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Move t->kcov_sequence assignment before assigning t->kcov_mode
> for consistency.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 888d0a236b04..b985b7a72870 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -318,10 +318,10 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
>         /* Cache in task struct for performance. */
>         t->kcov_size = size;
>         t->kcov_area = area;
> +       t->kcov_sequence = sequence;
>         /* See comment in check_kcov_mode(). */
>         barrier();
>         WRITE_ONCE(t->kcov_mode, mode);
> -       t->kcov_sequence = sequence;
>  }
>
>  static void kcov_stop(struct task_struct *t)
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
