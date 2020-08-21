Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DA62075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pj3kGrYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHUOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHUOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:51:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:51:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k25so1626771edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld9Hjc40uQpHc/M0pxuBHVEW9aIatbrYKjir64u0aDQ=;
        b=Pj3kGrYKcYMYJA2tQFUYnQU1UppXLlE+/Q0n9r28RrerupnKCzI/YnL0J0zZZZRngU
         1IsKU1ZBx3bLBCzTLIhOC2JWM0nCIELGQk99rXPBcDiMD+6a/uO9UUu8ArtDF3bQeSO6
         kKx1MCRvnEf+3d6TITWVBBcokJlVo1mnET0jmkFzK2p4H/gfBcn0lPgOgJqCkpnN+P4z
         my/3tq4NdV8TPZsY6LVyoywL8qsf2c5mw0FDGfwxqpUlLca4WHs3rxuCCSQndE3AuKG2
         XSEUoHdmXV4LLQ+dC7utqmk6JlxExww/jIrw3I5w0fD5X7Dl3AqHuGSOas0sxel8uX4v
         NnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld9Hjc40uQpHc/M0pxuBHVEW9aIatbrYKjir64u0aDQ=;
        b=SnkQJSC/v8Erd3UA7/+ZMnglJTqniGhamJ7+qXedhFk5tbPUS2I/xed3F3x9d254mW
         wOyzJYKLJrGGL6jwHeUeyUL/PaEzGOb/ACRp73L7jfr5B6Fz48fEcdZ8poe4U047KTIn
         Qrzj0OaYtUOLyfTegGDXOiuBM3e5M6SiMvZIJNxBWxJ8N3FFm9YfmlcWymEAtM4Pitjt
         d60HJZdS8iq0L86WICrhyp0K2HgvVtYZLZLn9AiLocaudzuGUSWNeJ45JouUmfoPi2VX
         dqo2+2iVp6ThLy498W7JHVtzUB+WoCaFfFxv3rKIVtCHUvLz1yukqAaFer+QmYEJrY9K
         muNA==
X-Gm-Message-State: AOAM531fWnN7mGpqw7OSO9ME/Cqb8qF8tuE8/OPM6RtwpRMUAS7T6eBo
        hfaflTjl5EUDQWXnXNUojH+igW3YdUkPQs5g9NqUqg==
X-Google-Smtp-Source: ABdhPJyDYES/LSGlFsZw/u1uytwI3ItBT/Dh+8dfUJMFSyKie5LuRLBeyZTOZB8ONOqZMHwWhRONKW67pKcZWf2kwDQ=
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr3206031edb.217.1598021479538;
 Fri, 21 Aug 2020 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200821122544.1277051-1-maco@android.com>
In-Reply-To: <20200821122544.1277051-1-maco@android.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 21 Aug 2020 07:51:07 -0700
Message-ID: <CAHRSSEy0DO9KMCprByLDRKe-Ei59jH1h-RArBYuWMDGSHuQg6A@mail.gmail.com>
Subject: Re: [PATCH v3] binder: print warnings when detecting oneway spamming.
To:     Martijn Coenen <maco@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 5:25 AM Martijn Coenen <maco@android.com> wrote:
>
> The most common cause of the binder transaction buffer filling up is a
> client rapidly firing oneway transactions into a process, before it has
> a chance to handle them. Yet the root cause of this is often hard to
> debug, because either the system or the app will stop, and by that time
> binder debug information we dump in bugreports is no longer relevant.
>
> This change warns as soon as a process dips below 80% of its oneway
> space (less than 100kB available in the configuration), when any one
> process is responsible for either more than 50 transactions, or more
> than 50% of the oneway space.
>
> Signed-off-by: Martijn Coenen <maco@android.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
> v2: fixed call-site in binder_alloc_selftest
>
> v3: include size of struct binder_buffer in calculation, fix comments
>
>  drivers/android/binder.c                |  2 +-
>  drivers/android/binder_alloc.c          | 55 +++++++++++++++++++++++--
>  drivers/android/binder_alloc.h          |  5 ++-
>  drivers/android/binder_alloc_selftest.c |  2 +-
>  4 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f936530a19b0..946332bc871a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3136,7 +3136,7 @@ static void binder_transaction(struct binder_proc *proc,
>
>         t->buffer = binder_alloc_new_buf(&target_proc->alloc, tr->data_size,
>                 tr->offsets_size, extra_buffers_size,
> -               !reply && (t->flags & TF_ONE_WAY));
> +               !reply && (t->flags & TF_ONE_WAY), current->tgid);
>         if (IS_ERR(t->buffer)) {
>                 /*
>                  * -ESRCH indicates VMA cleared. The target is dying.
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 69609696a843..b5b6c9cf1b0b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -338,12 +338,50 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
>         return vma;
>  }
>
> +static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
> +{
> +       /*
> +        * Find the amount and size of buffers allocated by the current caller;
> +        * The idea is that once we cross the threshold, whoever is responsible
> +        * for the low async space is likely to try to send another async txn,
> +        * and at some point we'll catch them in the act. This is more efficient
> +        * than keeping a map per pid.
> +        */
> +       struct rb_node *n = alloc->free_buffers.rb_node;
> +       struct binder_buffer *buffer;
> +       size_t total_alloc_size = 0;
> +       size_t num_buffers = 0;
> +
> +       for (n = rb_first(&alloc->allocated_buffers); n != NULL;
> +                n = rb_next(n)) {
> +               buffer = rb_entry(n, struct binder_buffer, rb_node);
> +               if (buffer->pid != pid)
> +                       continue;
> +               if (!buffer->async_transaction)
> +                       continue;
> +               total_alloc_size += binder_alloc_buffer_size(alloc, buffer)
> +                       + sizeof(struct binder_buffer);
> +               num_buffers++;
> +       }
> +
> +       /*
> +        * Warn if this pid has more than 50 transactions, or more than 50% of
> +        * async space (which is 25% of total buffer size).
> +        */
> +       if (num_buffers > 50 || total_alloc_size > alloc->buffer_size / 4) {
> +               binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
> +                            "%d: pid %d spamming oneway? %zd buffers allocated for a total size of %zd\n",
> +                             alloc->pid, pid, num_buffers, total_alloc_size);
> +       }
> +}
> +
>  static struct binder_buffer *binder_alloc_new_buf_locked(
>                                 struct binder_alloc *alloc,
>                                 size_t data_size,
>                                 size_t offsets_size,
>                                 size_t extra_buffers_size,
> -                               int is_async)
> +                               int is_async,
> +                               int pid)
>  {
>         struct rb_node *n = alloc->free_buffers.rb_node;
>         struct binder_buffer *buffer;
> @@ -486,11 +524,20 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>         buffer->offsets_size = offsets_size;
>         buffer->async_transaction = is_async;
>         buffer->extra_buffers_size = extra_buffers_size;
> +       buffer->pid = pid;
>         if (is_async) {
>                 alloc->free_async_space -= size + sizeof(struct binder_buffer);
>                 binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
>                              "%d: binder_alloc_buf size %zd async free %zd\n",
>                               alloc->pid, size, alloc->free_async_space);
> +               if (alloc->free_async_space < alloc->buffer_size / 10) {
> +                       /*
> +                        * Start detecting spammers once we have less than 20%
> +                        * of async space left (which is less than 10% of total
> +                        * buffer size).
> +                        */
> +                       debug_low_async_space_locked(alloc, pid);
> +               }
>         }
>         return buffer;
>
> @@ -508,6 +555,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>   * @offsets_size:       user specified buffer offset
>   * @extra_buffers_size: size of extra space for meta-data (eg, security context)
>   * @is_async:           buffer for async transaction
> + * @pid:                               pid to attribute allocation to (used for debugging)
>   *
>   * Allocate a new buffer given the requested sizes. Returns
>   * the kernel version of the buffer pointer. The size allocated
> @@ -520,13 +568,14 @@ struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>                                            size_t data_size,
>                                            size_t offsets_size,
>                                            size_t extra_buffers_size,
> -                                          int is_async)
> +                                          int is_async,
> +                                          int pid)
>  {
>         struct binder_buffer *buffer;
>
>         mutex_lock(&alloc->mutex);
>         buffer = binder_alloc_new_buf_locked(alloc, data_size, offsets_size,
> -                                            extra_buffers_size, is_async);
> +                                            extra_buffers_size, is_async, pid);
>         mutex_unlock(&alloc->mutex);
>         return buffer;
>  }
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index db9c1b984695..55d8b4106766 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -32,6 +32,7 @@ struct binder_transaction;
>   * @offsets_size:       size of array of offsets
>   * @extra_buffers_size: size of space for other objects (like sg lists)
>   * @user_data:          user pointer to base of buffer space
> + * @pid:                pid to attribute the buffer to (caller)
>   *
>   * Bookkeeping structure for binder transaction buffers
>   */
> @@ -51,6 +52,7 @@ struct binder_buffer {
>         size_t offsets_size;
>         size_t extra_buffers_size;
>         void __user *user_data;
> +       int    pid;
>  };
>
>  /**
> @@ -117,7 +119,8 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
>                                                   size_t data_size,
>                                                   size_t offsets_size,
>                                                   size_t extra_buffers_size,
> -                                                 int is_async);
> +                                                 int is_async,
> +                                                 int pid);
>  extern void binder_alloc_init(struct binder_alloc *alloc);
>  extern int binder_alloc_shrinker_init(void);
>  extern void binder_alloc_vma_close(struct binder_alloc *alloc);
> diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> index 4151d9938255..c2b323bc3b3a 100644
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -119,7 +119,7 @@ static void binder_selftest_alloc_buf(struct binder_alloc *alloc,
>         int i;
>
>         for (i = 0; i < BUFFER_NUM; i++) {
> -               buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
> +               buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0, 0);
>                 if (IS_ERR(buffers[i]) ||
>                     !check_buffer_pages_allocated(alloc, buffers[i],
>                                                   sizes[i])) {
> --
> 2.28.0.297.g1956fa8f8d-goog
>
