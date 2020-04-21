Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B07C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CFA20661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGgo4tZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDUPjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725613AbgDUPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:39:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E6C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so1485644pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mmoGh7NbU2I6i6mTnfpxZZ+azD3XtCswEGTNXCLuyA=;
        b=QGgo4tZ7skjSV+mL+s3apHVRj1cNzDRfziKAXEk/Ph5dhpMbSxC6LSaVrBDyOosNOK
         STKijhMpCZRlfYKcDyKnjKpDuEHgukjsG9QksyLsh5tsPHAPKnt4bap11a7mmVPNCeHk
         kuWjNX41klD3xtfSylSX8LTC+fZOmuDBCrXcPO4f4CdRE/jS7WJ/cp39nzoEn7PUccHx
         TrpoAUzxh06+NnuC5LnWIpvkQlA7I/fkXcnLdtOil2mnUCUohVyB1FYcc6g+yFf8C4Qe
         1yuzm/rPeZYK0RCv0VwfkhwwK0vPV6pAkaCnEBAAl71uN+PquwZPGfK3Bljp7QkApEUm
         4MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mmoGh7NbU2I6i6mTnfpxZZ+azD3XtCswEGTNXCLuyA=;
        b=BlINY/8yVaK9VMwGlPs9B4OQttxgcrK84Re1tzLsbd8CWjH9rWcFpdXdd9huSX8LJ3
         bUV7WpWZJBdITfVLS2xzk9sKrt8QfCz+RdDiSCAAZlt+6h/9Jfpv7gbDy57Eg53L2Y+9
         KyL4Uq8DXaXjNJ0JzoPgFah1qTfp/7WOnX7HUrfyfTzfOAIlmd/Jjl1gyj2JpG/yRM2I
         iOGHjgPDWjtY6i+3K3wNEevTO8C+x2YWIO26OYWLqf/sZMvFLw4qwvsYi7Me4VHBNsj2
         CgxIl47oGseTGkaVFoQQW6R+tODLo2m7+191sE7CK3S5rS+V1coVCjDSlISqY8C9pxiC
         uuiQ==
X-Gm-Message-State: AGi0PuY2b9oEKyyamq5zXownTNCzUdVk5DOKTOerEB0kMKzRdrhjpLtO
        GAtjwd5gDVnAiNJvWadb6fn6uyq120OhN0NzFBzwfA==
X-Google-Smtp-Source: APiQypJzBHkISyaNz7vwdfY/AkaRhLOXFBDWiH/NMWMtB4A2nC8aZl7bqmoYjFzGBpD6t1rKnGOME089iTi7pJ+kTj0=
X-Received: by 2002:a17:90a:8c93:: with SMTP id b19mr6142175pjo.90.1587483579220;
 Tue, 21 Apr 2020 08:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com> <20200418031833.234942-6-davidgow@google.com>
In-Reply-To: <20200418031833.234942-6-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 21 Apr 2020 17:39:28 +0200
Message-ID: <CAAeHK+xBnxfmS7Q6oY94JRqzVtSzpUpWtsM3u+1S5kixJfZ+yw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 5:19 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> KASAN errors will currently trigger a panic when panic_on_warn is set.
> This renders kasan_multishot useless, as further KASAN errors won't be
> reported if the kernel has already paniced. By making kasan_multishot
> disable this behaviour for KASAN errors, we can still have the benefits
> of panic_on_warn for non-KASAN warnings, yet be able to use
> kasan_multishot.
>
> This is particularly important when running KASAN tests, which need to
> trigger multiple KASAN errors: previously these would panic the system
> if panic_on_warn was set, now they can run (and will panic the system
> should non-KASAN warnings show up).
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 0c206bbf9cb3..79fe23bd4f60 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -94,7 +94,7 @@ static void end_report(unsigned long *flags)
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irqrestore(&report_lock, *flags);
> -       if (panic_on_warn) {
> +       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
>                 /*
>                  * This thread may hit another WARN() in the panic path.
>                  * Resetting this prevents additional WARN() from panicking the
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200418031833.234942-6-davidgow%40google.com.
