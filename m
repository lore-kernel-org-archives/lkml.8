Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62ADC20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rxAFard6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGMyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:54:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:33824 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:54:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B2A5E2C29CF;
        Fri,  7 Aug 2020 08:54:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4EwsZe04-pib; Fri,  7 Aug 2020 08:54:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1EB512C2A82;
        Fri,  7 Aug 2020 08:54:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1EB512C2A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596804858;
        bh=giI5AnJXLS5OTIBIX0MKceSIl1N8ZXV0M9kqWmew3Ho=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rxAFard6mtv/DHKrgdwG7hF/cbT/AG5a7K+1VSfIhgd2sQZcIjItAAUxML02ryprt
         Q4oRe2VzXa4acGH1hXrJ0IwbMbETVlKYkDTCGVHy0dj5HHQxzLCS7lC1fm1vzz8Mga
         I2EayRsVv2uRwG0SkfIVKIGWh60ZqnfL9Gti5B8nSGcJyfU0LmiWqn7l6x4bm7Mgeg
         Q4LP3k5vTL6xXU9aA2HEDFrVcrOg6RNr2T1FPJ80O6x4n4NkGaWBXcXVqygTlIeSzN
         aFizeUjbmxsHvW3+CTO1lxJst1LWfhrpU4dkS7Agab4MM9rLmXlCJF/janSCV/Suj5
         lAVSe8eSKWp6A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fe2cBgzueWjG; Fri,  7 Aug 2020 08:54:18 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EEE812C292A;
        Fri,  7 Aug 2020 08:54:17 -0400 (EDT)
Date:   Fri, 7 Aug 2020 08:54:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <1664989063.2279.1596804857895.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200807002705.GA889@tardis>
References: <20200806170544.382140-1-posk@google.com> <20200806170544.382140-2-posk@google.com> <20200807002705.GA889@tardis>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Thread-Index: NazZnFpUVny8C4cctcIbhKxhZjDGCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 6, 2020, at 8:27 PM, Boqun Feng boqun.feng@gmail.com wrote:

> On Thu, Aug 06, 2020 at 10:05:44AM -0700, Peter Oskolkov wrote:
>> Based on Google-internal RSEQ work done by
>> Paul Turner and Andrew Hunter.
>> 
>> This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU.
>> The test quite often fails without the previous patch in this patchset,
>> but consistently passes with it.
>> 
>> Signed-off-by: Peter Oskolkov <posk@google.com>
>> ---
>>  .../selftests/rseq/basic_percpu_ops_test.c    | 181 ++++++++++++++++++
>>  1 file changed, 181 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
>> b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
>> index eb3f6db36d36..147c80deac19 100644
>> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
>> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
>> @@ -3,16 +3,21 @@
>>  #include <assert.h>
>>  #include <pthread.h>
>>  #include <sched.h>
>> +#include <stdatomic.h>
>>  #include <stdint.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <stddef.h>
>> +#include <syscall.h>
>> +#include <unistd.h>
>>  
>>  #include "rseq.h"
>>  
>>  #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
>>  
>> +#define MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU	(1<<7)
>> +
>>  struct percpu_lock_entry {
>>  	intptr_t v;
>>  } __attribute__((aligned(128)));
>> @@ -289,6 +294,180 @@ void test_percpu_list(void)
>>  	assert(sum == expected_sum);
>>  }
>>  
>> +struct test_membarrier_thread_args {
>> +	int stop;
>> +	intptr_t percpu_list_ptr;
>> +};
>> +
>> +/* Worker threads modify data in their "active" percpu lists. */
>> +void *test_membarrier_worker_thread(void *arg)
>> +{
>> +	struct test_membarrier_thread_args *args =
>> +		(struct test_membarrier_thread_args *)arg;
>> +	const int iters = 10 * 1000 * 1000;
>> +	int i;
>> +
>> +	if (rseq_register_current_thread()) {
>> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
>> +			errno, strerror(errno));
>> +		abort();
>> +	}
>> +
>> +	for (i = 0; i < iters; ++i) {
>> +		while (true) {
>> +			int cpu, ret;
>> +			struct percpu_list *list_ptr = (struct percpu_list *)
>> +				atomic_load(&args->percpu_list_ptr);
>> +
> 
> What if the manager thread update ->percpu_list_ptr and call
> membarrier() here? I.e.
> 
>	CPU0			CPU1
>				list_ptr = atomic_load(&args->percpu_list_ptr); // read list_b
>	
>	atomic_store(&args->percpu_list_ptr, list_a);
>	sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi to
>	restart rseq.cs on CPU1
> 
>				<got IPI, but not in a rseq.cs, so nothing to do>
>				cpu = rseq_cpu_start(); // start a rseq.cs and accessing list_b!
> 
> The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
> is outside the rseq.cs, simply restarting rseq doesn't kill this
> reference.
> 
> Am I missing something subtle?

I'm with you on this, something looks fishy. It would be good to use
delay-inducing testing methods like rseq parametrized selftests to
increase the odds of hitting this race more reliably.

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>> +			if (!list_ptr)
>> +				continue;  /* Not yet initialized. */
>> +
>> +			cpu = rseq_cpu_start();
>> +			struct percpu_list_node *node = list_ptr->c[cpu].head;
>> +			const intptr_t prev = node->data;
>> +
>> +			ret = rseq_cmpeqv_cmpeqv_storev(&node->data, prev,
>> +					&args->percpu_list_ptr,
>> +					(intptr_t)list_ptr, prev + 1, cpu);
>> +			if (!ret)
>> +				break;  /* Success. */
>> +		}
>> +	}
>> +
>> +	if (rseq_unregister_current_thread()) {
>> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d):
>> %s\n",
>> +			errno, strerror(errno));
>> +		abort();
>> +	}
>> +	return NULL;
>> +}
>> +
>> +void test_membarrier_init_percpu_list(struct percpu_list *list)
>> +{
>> +	int i;
>> +
>> +	memset(list, 0, sizeof(*list));
>> +	for (i = 0; i < CPU_SETSIZE; i++) {
>> +		struct percpu_list_node *node;
>> +
>> +		node = malloc(sizeof(*node));
>> +		assert(node);
>> +		node->data = 0;
>> +		node->next = NULL;
>> +		list->c[i].head = node;
>> +	}
>> +}
>> +
>> +void test_membarrier_free_percpu_list(struct percpu_list *list)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < CPU_SETSIZE; i++)
>> +		free(list->c[i].head);
>> +}
>> +
>> +static int sys_membarrier(int cmd, int flags)
>> +{
>> +	return syscall(__NR_membarrier, cmd, flags);
>> +}
>> +
>> +/*
>> + * The manager thread swaps per-cpu lists that worker threads see,
>> + * and validates that there are no unexpected modifications.
>> + */
>> +void *test_membarrier_manager_thread(void *arg)
>> +{
>> +	struct test_membarrier_thread_args *args =
>> +		(struct test_membarrier_thread_args *)arg;
>> +	struct percpu_list list_a, list_b;
>> +	intptr_t expect_a = 0, expect_b = 0;
>> +	int cpu_a = 0, cpu_b = 0;
>> +
>> +	if (rseq_register_current_thread()) {
>> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
>> +			errno, strerror(errno));
>> +		abort();
>> +	}
>> +
>> +	/* Init lists. */
>> +	test_membarrier_init_percpu_list(&list_a);
>> +	test_membarrier_init_percpu_list(&list_b);
>> +
>> +	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
>> +
>> +	while (!atomic_load(&args->stop)) {
>> +		/* list_a is "active". */
>> +		cpu_a = rand() % CPU_SETSIZE;
>> +		/*
>> +		 * As list_b is "inactive", we should never see changes
>> +		 * to list_b.
>> +		 */
>> +		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
>> +			fprintf(stderr, "Membarrier test failed\n");
>> +			abort();
>> +		}
>> +
>> +		/* Make list_b "active". */
>> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
>> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_a);
>> +		/*
>> +		 * Cpu A should now only modify list_b, so we values
>> +		 * in list_a should be stable.
>> +		 */
>> +		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
>> +
>> +		cpu_b = rand() % CPU_SETSIZE;
>> +		/*
>> +		 * As list_a is "inactive", we should never see changes
>> +		 * to list_a.
>> +		 */
>> +		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
>> +			fprintf(stderr, "Membarrier test failed\n");
>> +			abort();
>> +		}
>> +
>> +		/* Make list_a "active". */
>> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
>> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, cpu_b);
>> +		/* Remember a value from list_b. */
>> +		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
>> +	}
>> +
>> +	test_membarrier_free_percpu_list(&list_a);
>> +	test_membarrier_free_percpu_list(&list_b);
>> +
>> +	if (rseq_unregister_current_thread()) {
>> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d):
>> %s\n",
>> +			errno, strerror(errno));
>> +		abort();
>> +	}
>> +	return NULL;
>> +}
>> +
>> +/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
>> +void test_membarrier(void)
>> +{
>> +	struct test_membarrier_thread_args thread_args;
>> +	pthread_t worker_threads[CPU_SETSIZE];
>> +	pthread_t manager_thread;
>> +	int i;
>> +
>> +	thread_args.stop = 0;
>> +	thread_args.percpu_list_ptr = 0;
>> +	pthread_create(&manager_thread, NULL,
>> +		       test_membarrier_manager_thread, &thread_args);
>> +
>> +	for (i = 0; i < CPU_SETSIZE; i++)
>> +		pthread_create(&worker_threads[i], NULL,
>> +		       test_membarrier_worker_thread, &thread_args);
>> +
>> +	for (i = 0; i < CPU_SETSIZE; i++)
>> +		pthread_join(worker_threads[i], NULL);
>> +
>> +	atomic_store(&thread_args.stop, 1);
>> +	pthread_join(manager_thread, NULL);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>  	if (rseq_register_current_thread()) {
>> @@ -300,6 +479,8 @@ int main(int argc, char **argv)
>>  	test_percpu_spinlock();
>>  	printf("percpu_list\n");
>>  	test_percpu_list();
>> +	printf("membarrier\n");
>> +	test_membarrier();
>>  	if (rseq_unregister_current_thread()) {
>>  		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
>>  			errno, strerror(errno));
>> --
>> 2.28.0.163.g6104cc2f0b6-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
