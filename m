Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE55C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1C221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZeNkSpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGA1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:27:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B37C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:27:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so316907qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pr3xuIT/L2i3hs6u3JZdrwHzOnv8eTozYZNC83bZXcE=;
        b=SZeNkSpJ5Nl6wRV7ZTpi9NNo80pZV2D30qx7OSj9Eye1pTLauuPlh7TKcTYIPBoyuU
         UbhGRr2W7m0E1zsfjnbJFWMHtvqRSpMNljuTZNmpd08Zx183JRQOPj70cSgnlc05bQAy
         n1847kOe64sO16z4+37GfB9gskV1FV3A+k0cdpHEaGXkjJmA5/OLrp10Nx9ZYKhJtK7j
         3Z5ZTKtPRvY71Kaphdtf1DHPrnpY/zg09FqEjWDmd5OdsoeujGYEooa2c783hOKbfPZq
         onnR4PFKaWIb+rx9CeoEgypX7sc8Ug/kmzynC2db2eiUmiz8OdR/JVU6E6xIpKRwQuQ4
         OCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pr3xuIT/L2i3hs6u3JZdrwHzOnv8eTozYZNC83bZXcE=;
        b=YaEPUJi8K+dFqJcz6vHdDP/wftgNfbzTpsCpXB9RahBH4dAbChEg9WX2AOx8NkiU4a
         w67JngTAaR3E8aR7r1E1aO85vW13k5uQVtJAng8eIzCOzeWwYD+m3KjJWBHhYNcgNPv0
         Ur5fX1vj1bU36/VsA3biATe2xMEj+SowWSj7EgwHpln00TWpusMymh2Tvs2ppia8cN9l
         YHTZuJYQvCtLlmac0z79e1kZQSTvsYXFlcAkYoFteqcyo+NK/rgh2WABhltQOKT/gXlV
         uTkqDaaP+a76yw3wJITnrFox67Ff+8+ATgHbFT19d59TqVFkAGh2ggDmK0E2vrqVASUP
         /ncw==
X-Gm-Message-State: AOAM531j7+x16zwq4rYCDcQq7F/r2d+4KSH6kB8bAnQ7o1sdQdO3X5UE
        w8qUpNqKXlMbOfApyIxpJc0=
X-Google-Smtp-Source: ABdhPJw6pYGi6ZTy+IdzHP7qFQNmGKABTYzAxOR2Ej0HDOXaw6mq7QfWblYzmf/HI87QeIuDIFZScw==
X-Received: by 2002:a05:620a:c88:: with SMTP id q8mr11124529qki.49.1596760035406;
        Thu, 06 Aug 2020 17:27:15 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m15sm6455881qta.6.2020.08.06.17.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 17:27:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2682927C0054;
        Thu,  6 Aug 2020 20:27:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 06 Aug 2020 20:27:13 -0400
X-ME-Sender: <xms:358sX3nxg9IZh_i4xA2Unhi3_7yDBxWbc8fjQ5RlQlvOx97x4BvRbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehfedujeeuffejleektdegleellefgfffhhfdvhedtkeevheejiedvjeeguddu
    geenucfkphepuddtuddrkeeirdegjedrkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:358sX62iov61-pXuK4bAPNSWn2nQfgwpxH_3i2jBOUedSVN-ZlKQsg>
    <xmx:358sX9oJQ34fh0bkZM_y5eB-mqV3MrFFDbzHYk1BWIm-3WHydzY2Tg>
    <xmx:358sX_l5QGME5JXkwOsEBvJwLHgu48slPLRdaT7fgnhNYiveEI0U8Q>
    <xmx:4Z8sX98ZgYJlFMXM0aIraXbJqIsO-WNGE4EzBocHdT7S5DOiHL0G6g>
Received: from localhost (unknown [101.86.47.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 09DBB3280059;
        Thu,  6 Aug 2020 20:27:10 -0400 (EDT)
Date:   Fri, 7 Aug 2020 08:27:05 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Message-ID: <20200807002705.GA889@tardis>
References: <20200806170544.382140-1-posk@google.com>
 <20200806170544.382140-2-posk@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200806170544.382140-2-posk@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 10:05:44AM -0700, Peter Oskolkov wrote:
> Based on Google-internal RSEQ work done by
> Paul Turner and Andrew Hunter.
>=20
> This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU.
> The test quite often fails without the previous patch in this patchset,
> but consistently passes with it.
>=20
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  .../selftests/rseq/basic_percpu_ops_test.c    | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>=20
> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools=
/testing/selftests/rseq/basic_percpu_ops_test.c
> index eb3f6db36d36..147c80deac19 100644
> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> @@ -3,16 +3,21 @@
>  #include <assert.h>
>  #include <pthread.h>
>  #include <sched.h>
> +#include <stdatomic.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stddef.h>
> +#include <syscall.h>
> +#include <unistd.h>
> =20
>  #include "rseq.h"
> =20
>  #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> =20
> +#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU	(1<<7)
> +
>  struct percpu_lock_entry {
>  	intptr_t v;
>  } __attribute__((aligned(128)));
> @@ -289,6 +294,180 @@ void test_percpu_list(void)
>  	assert(sum =3D=3D expected_sum);
>  }
> =20
> +struct test_membarrier_thread_args {
> +	int stop;
> +	intptr_t percpu_list_ptr;
> +};
> +
> +/* Worker threads modify data in their "active" percpu lists. */
> +void *test_membarrier_worker_thread(void *arg)
> +{
> +	struct test_membarrier_thread_args *args =3D
> +		(struct test_membarrier_thread_args *)arg;
> +	const int iters =3D 10 * 1000 * 1000;
> +	int i;
> +
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): =
%s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +
> +	for (i =3D 0; i < iters; ++i) {
> +		while (true) {
> +			int cpu, ret;
> +			struct percpu_list *list_ptr =3D (struct percpu_list *)
> +				atomic_load(&args->percpu_list_ptr);
> +

What if the manager thread update ->percpu_list_ptr and call
membarrier() here? I.e.

	CPU0			CPU1
				list_ptr =3D atomic_load(&args->percpu_list_ptr); // read list_b
=09
	atomic_store(&args->percpu_list_ptr, list_a);
	sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi=
 to restart rseq.cs on CPU1

				<got IPI, but not in a rseq.cs, so nothing to do>
				cpu =3D rseq_cpu_start(); // start a rseq.cs and accessing list_b!

The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
is outside the rseq.cs, simply restarting rseq doesn't kill this
reference.

Am I missing something subtle?

Regards,
Boqun

> +			if (!list_ptr)
> +				continue;  /* Not yet initialized. */
> +
> +			cpu =3D rseq_cpu_start();
> +			struct percpu_list_node *node =3D list_ptr->c[cpu].head;
> +			const intptr_t prev =3D node->data;
> +
> +			ret =3D rseq_cmpeqv_cmpeqv_storev(&node->data, prev,
> +					&args->percpu_list_ptr,
> +					(intptr_t)list_ptr, prev + 1, cpu);
> +			if (!ret)
> +				break;  /* Success. */
> +		}
> +	}
> +
> +	if (rseq_unregister_current_thread()) {
> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d)=
: %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +	return NULL;
> +}
> +
> +void test_membarrier_init_percpu_list(struct percpu_list *list)
> +{
> +	int i;
> +
> +	memset(list, 0, sizeof(*list));
> +	for (i =3D 0; i < CPU_SETSIZE; i++) {
> +		struct percpu_list_node *node;
> +
> +		node =3D malloc(sizeof(*node));
> +		assert(node);
> +		node->data =3D 0;
> +		node->next =3D NULL;
> +		list->c[i].head =3D node;
> +	}
> +}
> +
> +void test_membarrier_free_percpu_list(struct percpu_list *list)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < CPU_SETSIZE; i++)
> +		free(list->c[i].head);
> +}
> +
> +static int sys_membarrier(int cmd, int flags)
> +{
> +	return syscall(__NR_membarrier, cmd, flags);
> +}
> +
> +/*
> + * The manager thread swaps per-cpu lists that worker threads see,
> + * and validates that there are no unexpected modifications.
> + */
> +void *test_membarrier_manager_thread(void *arg)
> +{
> +	struct test_membarrier_thread_args *args =3D
> +		(struct test_membarrier_thread_args *)arg;
> +	struct percpu_list list_a, list_b;
> +	intptr_t expect_a =3D 0, expect_b =3D 0;
> +	int cpu_a =3D 0, cpu_b =3D 0;
> +
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): =
%s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +
> +	/* Init lists. */
> +	test_membarrier_init_percpu_list(&list_a);
> +	test_membarrier_init_percpu_list(&list_b);
> +
> +	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> +
> +	while (!atomic_load(&args->stop)) {
> +		/* list_a is "active". */
> +		cpu_a =3D rand() % CPU_SETSIZE;
> +		/*
> +		 * As list_b is "inactive", we should never see changes
> +		 * to list_b.
> +		 */
> +		if (expect_b !=3D atomic_load(&list_b.c[cpu_b].head->data)) {
> +			fprintf(stderr, "Membarrier test failed\n");
> +			abort();
> +		}
> +
> +		/* Make list_b "active". */
> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_a);
> +		/*
> +		 * Cpu A should now only modify list_b, so we values
> +		 * in list_a should be stable.
> +		 */
> +		expect_a =3D atomic_load(&list_a.c[cpu_a].head->data);
> +
> +		cpu_b =3D rand() % CPU_SETSIZE;
> +		/*
> +		 * As list_a is "inactive", we should never see changes
> +		 * to list_a.
> +		 */
> +		if (expect_a !=3D atomic_load(&list_a.c[cpu_a].head->data)) {
> +			fprintf(stderr, "Membarrier test failed\n");
> +			abort();
> +		}
> +
> +		/* Make list_a "active". */
> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_b);
> +		/* Remember a value from list_b. */
> +		expect_b =3D atomic_load(&list_b.c[cpu_b].head->data);
> +	}
> +
> +	test_membarrier_free_percpu_list(&list_a);
> +	test_membarrier_free_percpu_list(&list_b);
> +
> +	if (rseq_unregister_current_thread()) {
> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d)=
: %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +	return NULL;
> +}
> +
> +/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
> +void test_membarrier(void)
> +{
> +	struct test_membarrier_thread_args thread_args;
> +	pthread_t worker_threads[CPU_SETSIZE];
> +	pthread_t manager_thread;
> +	int i;
> +
> +	thread_args.stop =3D 0;
> +	thread_args.percpu_list_ptr =3D 0;
> +	pthread_create(&manager_thread, NULL,
> +		       test_membarrier_manager_thread, &thread_args);
> +
> +	for (i =3D 0; i < CPU_SETSIZE; i++)
> +		pthread_create(&worker_threads[i], NULL,
> +		       test_membarrier_worker_thread, &thread_args);
> +
> +	for (i =3D 0; i < CPU_SETSIZE; i++)
> +		pthread_join(worker_threads[i], NULL);
> +
> +	atomic_store(&thread_args.stop, 1);
> +	pthread_join(manager_thread, NULL);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (rseq_register_current_thread()) {
> @@ -300,6 +479,8 @@ int main(int argc, char **argv)
>  	test_percpu_spinlock();
>  	printf("percpu_list\n");
>  	test_percpu_list();
> +	printf("membarrier\n");
> +	test_membarrier();
>  	if (rseq_unregister_current_thread()) {
>  		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d)=
: %s\n",
>  			errno, strerror(errno));
> --=20
> 2.28.0.163.g6104cc2f0b6-goog
>=20

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl8sn9YACgkQSXnow7UH
+rjiHQf/fJpwAY8SZvR+JcVF/c8SVaeCyYI9dfblAYjO3L/olqZ9jlr7SfDUthHs
gqrNNWpLxSbStIdogWCsnm+cMcipISOyKAQABjYuCD6EL4EE0fVElt4STpu7w7Mm
emsvZamuEiOyqrQY6WjU51q/O771UAfo2nqPLWGVB6dPZMALTtUxWYqTGrj6IMjL
uvp7BNdVvvnqkdSvfdQDER6t//c3mvjT35si1o66FZQyOTsZujgB/j+GE/qh4vef
BrOYWYVFbHi9JA2kTE+o7Hi5yVYrUFnIkCdrKVZnIvIMR7TFsshzz9iQMGKWQMa0
JbHzRewB2nPNIeBnQcc+MGLvDoIjuw==
=hwwt
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
