Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5D2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="vWkTAnIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHaDAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgHaC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:59:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:59:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 31so3510212pgy.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVV4zDgX4bh1ITzZ3P/D8BPBhYzTijWax2Ubo35ykQQ=;
        b=vWkTAnIaI6Tg+5lq3G2zIENEtavt3ptFvX0QsKiZyTAZYTw7cqHJpzgUTsYmiuFTAb
         jodO6/WSjmVfe31B8zbrIHOOewzYS9z4Y7iJZKG4z8ptsq+FBr0OJ+0N8FIbqyTqAoiK
         VEa/jmQEjiDhrK3kTnRT2fvPt8YT1mAcsswlW4SsGO6mL3syWPlngNslF8KMxJXtcsR6
         Thjl9YUslKaYct43GD8MZ834IvroDjCMUTkq+jCg8qQdSIqduVWJtg/8H4aEZW4BYxh8
         pLr+Sz4OdA7lAVARgkkMiDs7MDpGJ7OxBlEyXOQofmM4+eqvhOfQkm/9SCieRAH6SRPI
         Qttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVV4zDgX4bh1ITzZ3P/D8BPBhYzTijWax2Ubo35ykQQ=;
        b=NhLJ53+apgmyfiiCmwX/rwCW1dXIekuZFg28he99IUZSIo4VGw7VxFSIxzwbplqF4N
         YQ6fFjbTnYkVxHlUweputBTeOTxsZ6e2x2nlZUZ+I0jjRIlTQfAiUiuKpGIEDfqFUXbJ
         1RxvfMytQtj3a/nFMtKnpzrlTrR0Rxma0ETJ+5Fpqk2Yykh7FGRa/slaHP6GvsmDtHym
         zXcQaoAMTQ7M/PKNqG8uy8xSDVYAdld4pTJB4PtZ5j222qfbBxs5w9pzlKjH4sos5XoN
         j480UqwD3J3Pwdhe3k/UHQLSZlZv058uku1H8G4ywCalw/Eel/d8adHPY9NGyYAE5h7J
         ciKg==
X-Gm-Message-State: AOAM531D4tR6KOPXLXK+5/fFjK4nt1dYcicslk55KJRmSIW2Nw8rMkPc
        isIoU3l7gnMGa/iQWV3MAHN0HVWIeehjkHjNIvRQ0sWIXz+6Pw==
X-Google-Smtp-Source: ABdhPJzn3r7DcbmTpR91vBNocSxb2riE/BRXhqMjxn5NApnI0uyZfvJNdQG0kA5iI/3hAtN2Q4B7UWDWo35zg5b6g8k=
X-Received: by 2002:a62:64d5:: with SMTP id y204mr733541pfb.97.1598842795785;
 Sun, 30 Aug 2020 19:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200822030055.32383-1-songmuchun@bytedance.com>
In-Reply-To: <20200822030055.32383-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 31 Aug 2020 10:59:19 +0800
Message-ID: <CAMZfGtVTTZ1XZ2sLERpjevGmSO+8ex4PdfPaWLFh7Ro2r5oYYA@mail.gmail.com>
Subject: Re: [PATCH v2] kprobes: Fix kill kprobe which has been marked as gone
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>,
        songliubraving@fb.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Andrew and Steven.

Any other comments or someone can add this to the queue for the
merge window? It's worth fixing it.

On Sat, Aug 22, 2020 at 11:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If a kprobe is marked as gone, we should not kill it again. Otherwise,
> we can disarm the kprobe more than once. In that case, the statistics
> of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
> do not work.
>
> Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
> changelogs in v2:
>  1. Add a WARN_ON_ONCE in the kill_kprobe() to catch incorrect use of it.
>  2. Update 'Fixes' tag in the commmit log.
>
>  kernel/kprobes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index d36e2b017588..9348b0c36ae0 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2143,6 +2143,9 @@ static void kill_kprobe(struct kprobe *p)
>
>         lockdep_assert_held(&kprobe_mutex);
>
> +       if (WARN_ON_ONCE(kprobe_gone(p)))
> +               return;
> +
>         p->flags |= KPROBE_FLAG_GONE;
>         if (kprobe_aggrprobe(p)) {
>                 /*
> @@ -2422,7 +2425,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
>         mutex_lock(&kprobe_mutex);
>         for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>                 head = &kprobe_table[i];
> -               hlist_for_each_entry(p, head, hlist)
> +               hlist_for_each_entry(p, head, hlist) {
> +                       if (kprobe_gone(p))
> +                               continue;
> +
>                         if (within_module_init((unsigned long)p->addr, mod) ||
>                             (checkcore &&
>                              within_module_core((unsigned long)p->addr, mod))) {
> @@ -2439,6 +2445,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>                                  */
>                                 kill_kprobe(p);
>                         }
> +               }
>         }
>         if (val == MODULE_STATE_GOING)
>                 remove_module_kprobe_blacklist(mod);
> --
> 2.11.0
>


--
Yours,
Muchun
