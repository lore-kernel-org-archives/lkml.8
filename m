Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1166EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C652076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mF5nZ7lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHLULH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:11:07 -0400
Received: from mail.efficios.com ([167.114.26.124]:48172 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:11:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AD3612D9703;
        Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CSzXv4Sjoj8w; Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 60BC82D93DB;
        Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 60BC82D93DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597263064;
        bh=SkCjCGZvFqg9HZFDKEC6R02UeAyjRSFhfb987tYqXhY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mF5nZ7lDYbogQli8WHvzVeT86+/gMxG3L/dd76iX/4qrEbJbIEU+NGPo6vr1ot8+m
         aerwiKYfvxOTjIVe64Gtzh3l9UID0jtvEHClr+kitKDD855Thc9w7k6ww/u1ymFbTG
         RwtkbPDH7S4Asu66nboroaa1saZr64t17OLKQf+r2eHcE+DLykDlbhHyBoYh/XpQcs
         OXtRSRdC/nNYx5gLBTKTv6ww74KIEiCbLjV0oA7S1Vl8m8WyzBP3DdQb60rbNuDwJ6
         4kP9JG8z/JRqT1I3eSaozTf09SaZkuRiczJinyiYy3X8V/9zTWgVQ3pP/tGORlEQwV
         aVusP71qs6UJQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9BNy88Xll8KB; Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 51C052D93DA;
        Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
Date:   Wed, 12 Aug 2020 16:11:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <1728409311.6174.1597263064254.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200811000959.2486636-2-posk@google.com>
References: <20200811000959.2486636-1-posk@google.com> <20200811000959.2486636-2-posk@google.com>
Subject: Re: [PATCH 2/2 v3] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: fBmZfkDJLVgz+AjXx8pPpTw2awgmZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 10, 2020, at 8:09 PM, Peter Oskolkov posk@google.com wrote:

> Based on Google-internal RSEQ work done by
> Paul Turner and Andrew Hunter.
> 
> This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
> The test quite often fails without the previous patch in this patchset,
> but consistently passes with it.
> 
> v3: added rseq_offset_deref_addv() to x86_64 to make the test
>    more explicit; on other architectures I kept using existing
>    rseq_cmpeqv_cmpeqv_storev() as I have no easy way to test
>    there. Added a comment explaining why the test works this way.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
> .../selftests/rseq/basic_percpu_ops_test.c    | 196 ++++++++++++++++++
> tools/testing/selftests/rseq/rseq-x86.h       |  55 +++++
> 2 files changed, 251 insertions(+)
> 
> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> index eb3f6db36d36..c9784a3d19fb 100644
> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> @@ -3,16 +3,22 @@
> #include <assert.h>
> #include <pthread.h>
> #include <sched.h>
> +#include <stdatomic.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <stddef.h>
> +#include <syscall.h>
> +#include <unistd.h>
> 
> #include "rseq.h"
> 
> #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> 
> +#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ	(1<<7)
> +#define MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ	(1<<8)
> +

No need to define membarrier commands here if we include <linux/membarrier.h>

> struct percpu_lock_entry {
> 	intptr_t v;
> } __attribute__((aligned(128)));
> @@ -289,6 +295,194 @@ void test_percpu_list(void)
> 	assert(sum == expected_sum);
> }
> 
> +struct test_membarrier_thread_args {
> +	int stop;
> +	intptr_t percpu_list_ptr;
> +};
> +
> +/* Worker threads modify data in their "active" percpu lists. */
> +void *test_membarrier_worker_thread(void *arg)
> +{
> +	struct test_membarrier_thread_args *args =
> +		(struct test_membarrier_thread_args *)arg;
> +	const int iters = 10 * 1000 * 1000;
> +	int i;
> +
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +
> +	/* Wait for initialization. */
> +	while (!atomic_load(&args->percpu_list_ptr)) {}
> +
> +	for (i = 0; i < iters; ++i) {
> +		int ret;
> +
> +		do {
> +			int cpu = rseq_cpu_start();
> +#if defined(__x86_64__)
> +			/* For x86_64, we have rseq_offset_deref_addv. */
> +			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
> +							128 * cpu, 1, cpu);
> +#else
> +			/*
> +			 *  For other architectures, we rely on the fact that
> +			 *  the manager thread keeps list_ptr alive, so we can
> +			 *  use rseq_cmpeqv_cmpeqv_storev to make sure
> +			 *  list_ptr we got outside of rseq cs is still
> +			 *  "active".
> +			 */
> +			struct percpu_list *list_ptr = (struct percpu_list *)
> +					atomic_load(&args->percpu_list_ptr);
> +
> +			struct percpu_list_node *node = list_ptr->c[cpu].head;
> +			const intptr_t prev = node->data;
> +
> +			ret = rseq_cmpeqv_cmpeqv_storev(&node->data, prev,
> +					&args->percpu_list_ptr,
> +					(intptr_t)list_ptr, prev + 1, cpu);
> +#endif

Please don't special-case the implementation of a test per architecture.

We should instead "skip" (or even fail) the test on architectures that do
not support this, as an incentive for architecture maintainers to implement
the missing APIs in the test.

One way to do this would be to define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV in the
architecture header, and skip the test if the define is not present.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
