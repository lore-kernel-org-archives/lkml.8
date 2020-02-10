Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC7C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574024650
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzcOIJTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgBJH2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:28:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33109 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:28:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so4460348qto.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aJSYcVShjw9Lb0CxygRCx6IiLyoO1qzlgwQMvTtLho=;
        b=KzcOIJThFowfRliZtkVfRl6aidxfG7Hhy2CAIlPr2dOIiXnnvNCJD6PAejFWFmLfKI
         /S4y+W0xcK6BAYIPxVn5DrpPHMnpO8S6aihCp8+r5UdDg15xt3iuiOeXS3im+A3+a/w2
         CMy8t6fiiAk7BXeWD6MoglyrOmAOd67NaSD+edivJXQAPLt+6hIJ8Bla4meSrPlSLapP
         hfuTqe1HFTjvht8kWu86WCpts4qiXUuqf7O3XmgpaR/lqZ7lBd9AYsqVMbzvMO94nPuV
         3vgD0xDw7jyiAhiLV1+4tch70IY4ShQvTcia+iftk52MzXIS6kme4zix7f36CYAc5hFC
         pBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aJSYcVShjw9Lb0CxygRCx6IiLyoO1qzlgwQMvTtLho=;
        b=fFyJYeE/nTNy8F5OfsddoG8+HdBJSFC6SC7Xp9eFtCaajUSrek4/ffH2uF9KA+fbHN
         6QQOjAlYiJiCaUx39O7d1NSVAhcZ5InhrwH5QMMtmcTKEob3V7upgVxbh9FBQ2pW357V
         25R5Sw4GixqWYyq/dmF/jpRz/Jn9e6XqGMGRtlRVih9dZeNmhlCxonf5t3zTAyY1N5pM
         BpEnBXLgBrZjhDNK9xzl3BUUzGJMLvNFN5I0zz56JqXdflHOJzf1/4sR3C1nI4RsQ5eB
         pJAH6c63u7Quj97b4pffAzpJKQ3/yp8yr33jhUhSY29aC1iRnOTdSLkFDSiQFXUabS7t
         qCBA==
X-Gm-Message-State: APjAAAWXlNpAr/J1QABtBmNKijt8V5ZQFgubp0XIQcRp/SIx66tz45Z7
        JW18lCYJMoLlh4ronowfTzYWaSNDrYWfrjIbHTZ8Fw==
X-Google-Smtp-Source: APXvYqzvGDV8241QnMd0vtySTz+Ty3R182/wGhurUpRKMrSSEabtIWqt2bjsWn4Vbaon5w230yBnka5lvOVf+lLs/Z0=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr9011849qtp.50.1581319685983;
 Sun, 09 Feb 2020 23:28:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581282103.git.jbi.octave@gmail.com> <1eca01a2537e0500f4f31c335edfecf0a10bd294.1581282103.git.jbi.octave@gmail.com>
In-Reply-To: <1eca01a2537e0500f4f31c335edfecf0a10bd294.1581282103.git.jbi.octave@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Feb 2020 08:27:55 +0100
Message-ID: <CACT4Y+b61vEqw6t-deuCyZvDoqg2HTRUdVKi1RBcpen+0k0QDA@mail.gmail.com>
Subject: Re: [PATCH 09/11] kasan: add missing annotation for start_report()
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

On Sun, Feb 9, 2020 at 11:48 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at start_report()
>
> warning: context imbalance in start_report() - wrong count at exit
>
> The root cause is a missing annotation at start_report()
>
> Add the missing annotation __acquires(&report_lock)
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..5451624c4e09 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -77,7 +77,7 @@ static void print_error_description(struct kasan_access_info *info)
>
>  static DEFINE_SPINLOCK(report_lock);
>
> -static void start_report(unsigned long *flags)
> +static void start_report(unsigned long *flags) __acquires(&report_lock)
>  {
>         /*
>          * Make sure we don't end up in loop.
> --
> 2.24.1
>
