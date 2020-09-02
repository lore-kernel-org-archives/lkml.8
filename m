Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE9C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC95920767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgIBNSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:18:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgIBNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:15:40 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDSbt-0000jw-Cg; Wed, 02 Sep 2020 13:15:33 +0000
Date:   Wed, 2 Sep 2020 15:15:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Harley Paterson <harley.paterson@hotmail.co.nz>
Cc:     "christian@brauner.io" <christian@brauner.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        oleg@redhat.com
Subject: Re: [PATCH] kernel/pid: Rename `find_ge_pid` to `find_get_vpid`.
Message-ID: <20200902131532.vpsn3gjx42sn3iwq@wittgenstein>
References: <DB3PR0202MB3387446FE969A6D39819D879F92F0@DB3PR0202MB3387.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB3PR0202MB3387446FE969A6D39819D879F92F0@DB3PR0202MB3387.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:23:10PM +0000, Harley Paterson wrote:
> Most PID functions in `kernel/pid.c` are named in the format
> [do_something]_pid, and functions with a VPID counterpart have
> the corresponding name [do_something]_vpid.
> 
> `find_get_pid` and its VPID counterpart, `find_ge_pid` do not share
> this convention.
> 
> This patch renames `find_ge_pid` to `find_get_vpid` to conform to the
> existing PID function naming idioms. I believe the proposed name
> makes the purpose of the function clearer.
> 
> I have built and tested this patch on an x64 virtual machine, running
> Ubuntu 20.04 LTS. My tests involved building the modified kernel,
> installing it, and booting into a Ubuntu GUI session.
> 
> This patch is applied on top of the linux-5.9-rc3 kernel
> 
> This patch effects four lines, one in each of four files.
> 
> Signed-off-by: H Paterson <harley.paterson@hotmail.co.nz>
> ---
>  fs/proc/base.c         | 2 +-
>  include/linux/pid.h    | 2 +-
>  kernel/bpf/task_iter.c | 2 +-
>  kernel/pid.c           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617db4e0f..e2ff20311 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3390,7 +3390,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
>  	rcu_read_lock();
>  retry:
>  	iter.task = NULL;
> -	pid = find_ge_pid(iter.tgid, ns);
> +	pid = find_get_vpid(iter.tgid, ns);
>  	if (pid) {
>  		iter.tgid = pid_nr_ns(pid, ns);
>  		iter.task = pid_task(pid, PIDTYPE_TGID);
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 176d6cf80..2875b4189 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -128,7 +128,7 @@ extern struct pid *find_vpid(int nr);
>   * Lookup a PID in the hash table, and return with it's count elevated.
>   */
>  extern struct pid *find_get_pid(int nr);
> -extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
> +extern struct pid *find_get_vpid(int nr, struct pid_namespace *);
>  
>  extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			     size_t set_tid_size);
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 99af4cea1..334cb8831 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -29,7 +29,7 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
>  
>  	rcu_read_lock();
>  retry:
> -	pid = find_ge_pid(*tid, ns);
> +	pid = find_get_vpid(*tid, ns);
>  	if (pid) {
>  		*tid = pid_nr_ns(pid, ns);
>  		task = get_pid_task(pid, PIDTYPE_PID);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index b2562a7ce..0c77fef72 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -514,7 +514,7 @@ EXPORT_SYMBOL_GPL(task_active_pid_ns);
>   *
>   * If there is a pid at nr this function is exactly the same as find_pid_ns.
>   */
> -struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> +struct pid *find_get_vpid(int nr, struct pid_namespace *ns)

Hey Harley,

Thanks for the patch.

I think we shouldn't rename this function but I see why you got
confused. 
find_ge_pid() gives you the struct pid associated with the next greatest
or equal pid number in the provided pid namespace.

A few notes why this patch is problematic:

- The "_vpid" prefix is usually used in contexts where a (virtual)
  pid nr is looked up in the caller's pid namespace and some object
  associated with it returned. But this takes a pid namespace argument
  and so can be used to look up a pid based on a pid nr in any pid
  namespace not just in the caller's.

- The "ge" here is actually a meaningful abbreviation afaict for
  "greater than or equal" so replacing it with "get" would lose this
  important piece of information.

- "get" is usually used - and especially here - to indicate that a
  reference count is increased which isn't happening here so this would
  be potentially dangerous as it would signal callers that a reference
  count is incremented when it really isn't.

Thanks!
Christian
