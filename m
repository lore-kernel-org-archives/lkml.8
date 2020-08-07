Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C08C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB732086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="TpoohK+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHGR4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:56:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D800C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:56:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so1865835edx.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5oXFMw+ipS3NkqrrnKB1VbNotWPhvVuWWOOkcuHhNQ=;
        b=TpoohK+tF4wMzEF31mfX3oXnglXMAEjG/Sa0g9HCs54/gAI19UrsQ4DLnBj20Vr8ZG
         uFbOW5M3Pf4Wg0wmM45ojXJ3WNS8Yt9WJCG9c4sVZpb00X09QCFqxa+GuuOQC+Gw52u5
         tWNESJ1+tujIMG5vgPBIdXhNg+z2nRvNQ0odT4e1H/CGmVo4GXZuPMpKs6b8v5ZWoW5Z
         HkjVf4GcyVT6EVpOHe6vcMuXpMWAiwwa49gWXqUU3SG0hGxKgK8C8bmH2rAg6LxXXJxX
         l5vIPHoNqs3mHaWE1m/zkR10DNfF8CWmJQdm7UdqbkGdw+aShQkxjQudgwrUyTwdv71U
         Nwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5oXFMw+ipS3NkqrrnKB1VbNotWPhvVuWWOOkcuHhNQ=;
        b=Cyp/174XEM+udDPYJa0UqnXdGWIAw5016UVLkELGcC3CIfSidASyZt2R+7b3jplT/1
         zgRVlOaO7x7CJRxROSNzj+GCP0I7xCE/MwxZhenIB0gWqHMv8fzAo/1/vL7K2sxf9Sqk
         Bc1smOSeNaMcq4a5cXkaHUe/NeOBYT5LYy9u0EgPU9by7ZacnzHiBLwZfEUAUIsxJ3VL
         Dg0tB6sW2Y4Gr36gs/OrOBO459rWS0xaE1H6E5atO6hydogfbbnm9it/B558rqnWzS5x
         y73nKenJxaxdaPvsum2F6eLnym1L+7Pqr2ThFtuj2izYqhw3IA5SYXXMMO1H6tIna4E8
         Y7iw==
X-Gm-Message-State: AOAM532RJi5f6VnatAbpUmPMPr+nUKjLBUysur+qthpA6/P+K/R4njBa
        vHSV/F4SfHZgGHXwQGi41/+M7YKWCWhSJ1KWEfuAPA==
X-Google-Smtp-Source: ABdhPJzNhPHbHNs7TQmhNU8mN5/Lvr10dlETLTt5TOP9B5l2aa2Veiv1Ilb89rBMdxM3WSnYq2z0rtEOXODuq8NfoSM=
X-Received: by 2002:a50:da44:: with SMTP id a4mr2837738edk.36.1596822967842;
 Fri, 07 Aug 2020 10:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200806170544.382140-1-posk@google.com> <20200806170544.382140-2-posk@google.com>
 <20200807002705.GA889@tardis>
In-Reply-To: <20200807002705.GA889@tardis>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 7 Aug 2020 10:55:57 -0700
Message-ID: <CAFTs51VNdN8t79Gr7R6H0rYVYSx1Qyd6YC4P89OYSmHKn_PXLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:27 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Thu, Aug 06, 2020 at 10:05:44AM -0700, Peter Oskolkov wrote:
> > Based on Google-internal RSEQ work done by
> > Paul Turner and Andrew Hunter.
> >
> > This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU.
> > The test quite often fails without the previous patch in this patchset,
> > but consistently passes with it.
> >
> > Signed-off-by: Peter Oskolkov <posk@google.com>
> > ---
> >  .../selftests/rseq/basic_percpu_ops_test.c    | 181 ++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >
> > diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > index eb3f6db36d36..147c80deac19 100644
> > --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > @@ -3,16 +3,21 @@
> >  #include <assert.h>
> >  #include <pthread.h>
> >  #include <sched.h>
> > +#include <stdatomic.h>
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <stddef.h>
> > +#include <syscall.h>
> > +#include <unistd.h>
> >
> >  #include "rseq.h"
> >
> >  #define ARRAY_SIZE(arr)      (sizeof(arr) / sizeof((arr)[0]))
> >
> > +#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU   (1<<7)
> > +
> >  struct percpu_lock_entry {
> >       intptr_t v;
> >  } __attribute__((aligned(128)));
> > @@ -289,6 +294,180 @@ void test_percpu_list(void)
> >       assert(sum == expected_sum);
> >  }
> >
> > +struct test_membarrier_thread_args {
> > +     int stop;
> > +     intptr_t percpu_list_ptr;
> > +};
> > +
> > +/* Worker threads modify data in their "active" percpu lists. */
> > +void *test_membarrier_worker_thread(void *arg)
> > +{
> > +     struct test_membarrier_thread_args *args =
> > +             (struct test_membarrier_thread_args *)arg;
> > +     const int iters = 10 * 1000 * 1000;
> > +     int i;
> > +
> > +     if (rseq_register_current_thread()) {
> > +             fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
> > +                     errno, strerror(errno));
> > +             abort();
> > +     }
> > +
> > +     for (i = 0; i < iters; ++i) {
> > +             while (true) {
> > +                     int cpu, ret;
> > +                     struct percpu_list *list_ptr = (struct percpu_list *)
> > +                             atomic_load(&args->percpu_list_ptr);
> > +
>
> What if the manager thread update ->percpu_list_ptr and call
> membarrier() here? I.e.
>
>         CPU0                    CPU1
>                                 list_ptr = atomic_load(&args->percpu_list_ptr); // read list_b
>
>         atomic_store(&args->percpu_list_ptr, list_a);
>         sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi to restart rseq.cs on CPU1
>
>                                 <got IPI, but not in a rseq.cs, so nothing to do>
>                                 cpu = rseq_cpu_start(); // start a rseq.cs and accessing list_b!
>
> The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
> is outside the rseq.cs, simply restarting rseq doesn't kill this
> reference.
>
> Am I missing something subtle?

rseq_cmpeqv_cmpeqv_store is used below to make sure the reference is
the one that should be used; if it is no longer "active", the
iteration is restarted.

>
> Regards,
> Boqun
>
> > +                     if (!list_ptr)
> > +                             continue;  /* Not yet initialized. */
> > +
> > +                     cpu = rseq_cpu_start();
> > +                     struct percpu_list_node *node = list_ptr->c[cpu].head;
> > +                     const intptr_t prev = node->data;
> > +
> > +                     ret = rseq_cmpeqv_cmpeqv_storev(&node->data, prev,
> > +                                     &args->percpu_list_ptr,
> > +                                     (intptr_t)list_ptr, prev + 1, cpu);
> > +                     if (!ret)
> > +                             break;  /* Success. */
> > +             }
> > +     }
> > +
> > +     if (rseq_unregister_current_thread()) {
> > +             fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
> > +                     errno, strerror(errno));
> > +             abort();
> > +     }
> > +     return NULL;
> > +}
> > +
> > +void test_membarrier_init_percpu_list(struct percpu_list *list)
> > +{
> > +     int i;
> > +
> > +     memset(list, 0, sizeof(*list));
> > +     for (i = 0; i < CPU_SETSIZE; i++) {
> > +             struct percpu_list_node *node;
> > +
> > +             node = malloc(sizeof(*node));
> > +             assert(node);
> > +             node->data = 0;
> > +             node->next = NULL;
> > +             list->c[i].head = node;
> > +     }
> > +}
> > +
> > +void test_membarrier_free_percpu_list(struct percpu_list *list)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < CPU_SETSIZE; i++)
> > +             free(list->c[i].head);
> > +}
> > +
> > +static int sys_membarrier(int cmd, int flags)
> > +{
> > +     return syscall(__NR_membarrier, cmd, flags);
> > +}
> > +
> > +/*
> > + * The manager thread swaps per-cpu lists that worker threads see,
> > + * and validates that there are no unexpected modifications.
> > + */
> > +void *test_membarrier_manager_thread(void *arg)
> > +{
> > +     struct test_membarrier_thread_args *args =
> > +             (struct test_membarrier_thread_args *)arg;
> > +     struct percpu_list list_a, list_b;
> > +     intptr_t expect_a = 0, expect_b = 0;
> > +     int cpu_a = 0, cpu_b = 0;
> > +
> > +     if (rseq_register_current_thread()) {
> > +             fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
> > +                     errno, strerror(errno));
> > +             abort();
> > +     }
> > +
> > +     /* Init lists. */
> > +     test_membarrier_init_percpu_list(&list_a);
> > +     test_membarrier_init_percpu_list(&list_b);
> > +
> > +     atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> > +
> > +     while (!atomic_load(&args->stop)) {
> > +             /* list_a is "active". */
> > +             cpu_a = rand() % CPU_SETSIZE;
> > +             /*
> > +              * As list_b is "inactive", we should never see changes
> > +              * to list_b.
> > +              */
> > +             if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
> > +                     fprintf(stderr, "Membarrier test failed\n");
> > +                     abort();
> > +             }
> > +
> > +             /* Make list_b "active". */
> > +             atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
> > +             sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_a);
> > +             /*
> > +              * Cpu A should now only modify list_b, so we values
> > +              * in list_a should be stable.
> > +              */
> > +             expect_a = atomic_load(&list_a.c[cpu_a].head->data);
> > +
> > +             cpu_b = rand() % CPU_SETSIZE;
> > +             /*
> > +              * As list_a is "inactive", we should never see changes
> > +              * to list_a.
> > +              */
> > +             if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
> > +                     fprintf(stderr, "Membarrier test failed\n");
> > +                     abort();
> > +             }
> > +
> > +             /* Make list_a "active". */
> > +             atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> > +             sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_b);
> > +             /* Remember a value from list_b. */
> > +             expect_b = atomic_load(&list_b.c[cpu_b].head->data);
> > +     }
> > +
> > +     test_membarrier_free_percpu_list(&list_a);
> > +     test_membarrier_free_percpu_list(&list_b);
> > +
> > +     if (rseq_unregister_current_thread()) {
> > +             fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
> > +                     errno, strerror(errno));
> > +             abort();
> > +     }
> > +     return NULL;
> > +}
> > +
> > +/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
> > +void test_membarrier(void)
> > +{
> > +     struct test_membarrier_thread_args thread_args;
> > +     pthread_t worker_threads[CPU_SETSIZE];
> > +     pthread_t manager_thread;
> > +     int i;
> > +
> > +     thread_args.stop = 0;
> > +     thread_args.percpu_list_ptr = 0;
> > +     pthread_create(&manager_thread, NULL,
> > +                    test_membarrier_manager_thread, &thread_args);
> > +
> > +     for (i = 0; i < CPU_SETSIZE; i++)
> > +             pthread_create(&worker_threads[i], NULL,
> > +                    test_membarrier_worker_thread, &thread_args);
> > +
> > +     for (i = 0; i < CPU_SETSIZE; i++)
> > +             pthread_join(worker_threads[i], NULL);
> > +
> > +     atomic_store(&thread_args.stop, 1);
> > +     pthread_join(manager_thread, NULL);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       if (rseq_register_current_thread()) {
> > @@ -300,6 +479,8 @@ int main(int argc, char **argv)
> >       test_percpu_spinlock();
> >       printf("percpu_list\n");
> >       test_percpu_list();
> > +     printf("membarrier\n");
> > +     test_membarrier();
> >       if (rseq_unregister_current_thread()) {
> >               fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
> >                       errno, strerror(errno));
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
