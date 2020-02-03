Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6913C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EA22082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgBCOd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:33:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:42134 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgBCOd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:33:27 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iycmd-0006Ed-DN; Mon, 03 Feb 2020 17:33:03 +0300
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <7a876b46-b80c-1164-d139-6026adcb222c@virtuozzo.com>
 <20200203134441.GI14914@hirez.programming.kicks-ass.net>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0b035f3f-35fe-542f-8120-b57d7b66eb36@virtuozzo.com>
Date:   Mon, 3 Feb 2020 17:33:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203134441.GI14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.2020 16:44, Peter Zijlstra wrote:
> Hi Kirill,
> 
> On Mon, Feb 03, 2020 at 02:45:16PM +0300, Kirill Tkhai wrote:
> 
>> Maybe, this is not a subject of this patchset. But since this is a newborn function,
>> can we introduce it to save one unneeded wake_up of writer? This is a situation,
>> when writer becomes woken up just to write itself into sem->writer.task.
>>
>> Something like below:
>>
>> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
>> index a136677543b4..e4f88bfd43ed 100644
>> --- a/kernel/locking/percpu-rwsem.c
>> +++ b/kernel/locking/percpu-rwsem.c
>> @@ -9,6 +9,8 @@
>>  #include <linux/sched/task.h>
>>  #include <linux/errno.h>
>>  
>> +static bool readers_active_check(struct percpu_rw_semaphore *sem);
>> +
>>  int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
>>  			const char *name, struct lock_class_key *key)
>>  {
>> @@ -101,6 +103,16 @@ static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
>>  	return __percpu_down_write_trylock(sem);
>>  }
>>  
>> +static void queue_sem_writer(struct percpu_rw_semaphore *sem, struct task_struct *p)
>> +{
>> +	rcu_assign_pointer(sem->writer.task, p);
>> +	smp_mb();
>> +	if (readers_active_check(sem)) {
>> +		WRITE_ONCE(sem->writer.task, NULL);
>> +		wake_up_process(p);
>> +	}
>> +}
>> +
>>  /*
>>   * The return value of wait_queue_entry::func means:
>>   *
>> @@ -129,7 +141,11 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
>>  	list_del_init(&wq_entry->entry);
>>  	smp_store_release(&wq_entry->private, NULL);
>>  
>> -	wake_up_process(p);
>> +	if (reader || readers_active_check(sem))
>> +		wake_up_process(p);
>> +	else
>> +		queue_sem_writer(sem, p);
>> +
>>  	put_task_struct(p);
>>  
>>  	return !reader; /* wake (readers until) 1 writer */
>> @@ -247,8 +263,11 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
>>  	 * them.
>>  	 */
>>  
>> -	/* Wait for all active readers to complete. */
>> -	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
>> +	if (rcu_access_pointer(sem->writer.task))
>> +		WRITE_ONCE(sem->writer.task, NULL);
>> +	else
>> +		/* Wait for all active readers to complete. */
>> +		rcuwait_wait_event(&sem->writer, readers_active_check(sem));
>>  }
>>  EXPORT_SYMBOL_GPL(percpu_down_write);
>>  
>> Just an idea, completely untested.
> 
> Hurm,.. I think I see what you're proposing. I also think your immediate
> patch is racy, consider for example what happens if your
> queue_sem_writer() finds !readers_active_check(), such that we do in
> fact need to wait. Then your percpu_down_write() will find
> sem->writer.task and clear it -- no waiting.

You mean, down_read() wakes up waiters unconditionally. So, optimization
in percpu_down_write() will miss readers_active_check() check.

You are sure. Then we have to modify this a little bit and to remove
the optimization from percpu_down_write():

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a136677543b4..90647ab28804 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -9,6 +9,8 @@
 #include <linux/sched/task.h>
 #include <linux/errno.h>
 
+static bool readers_active_check(struct percpu_rw_semaphore *sem);
+
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
 {
@@ -101,6 +103,16 @@ static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
 	return __percpu_down_write_trylock(sem);
 }
 
+static void queue_sem_writer(struct percpu_rw_semaphore *sem, struct task_struct *p)
+{
+	rcu_assign_pointer(sem->writer.task, p);
+	smp_mb();
+	if (readers_active_check(sem)) {
+		WRITE_ONCE(sem->writer.task, NULL);
+		wake_up_process(p);
+	}
+}
+
 /*
  * The return value of wait_queue_entry::func means:
  *
@@ -129,7 +141,11 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 
-	wake_up_process(p);
+	if (reader || readers_active_check(sem))
+		wake_up_process(p);
+	else
+		queue_sem_writer(sem, p);
+
 	put_task_struct(p);
 
 	return !reader; /* wake (readers until) 1 writer */
@@ -248,6 +264,7 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	 */
 
 	/* Wait for all active readers to complete. */
+	/* sem->writer is NULL or points to current */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);

> Also, I'm not going to hold up these patches for this, we can always do
> this on top.
> 
> Still, let me consider this a little more.

No problem, this is just an idea.
