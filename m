Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F41206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGZJGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:06:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33403 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:06:45 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jzcbg-0007eV-AR; Sun, 26 Jul 2020 09:06:08 +0000
Date:   Sun, 26 Jul 2020 11:06:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH] fork: fix pid refcount leaks when destroying file
Message-ID: <20200726090605.bvcot4lnx2kknkob@wittgenstein>
References: <20200726044959.GA50544@xin-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200726044959.GA50544@xin-virtual-machine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:49:59PM +0800, Xin Xiong wrote:
> When clone_flags & CLONE_PIDFD is true,the function creates a new file
> object called pidfile,and invokes get_pid(),which increases the refcnt
> of pid for pidfile to hold.
> 
> The reference counting issues take place in the error handling paths.
> When error occurs after the construction of pidfile, the function only
> invokes fput() to destroy pidfile, in which the increased refcount
> won't be decreased, resulting in a refcount leak.
> 
> Fix this issue by adding put_pid() in the error handling path
> bad_fork_put_pidfd.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..7cbfb2c4fce3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2319,6 +2319,7 @@ static __latent_entropy struct task_struct *copy_process(
>  bad_fork_put_pidfd:
>  	if (clone_flags & CLONE_PIDFD) {
>  		fput(pidfile);
> +		put_pid(pid);
>  		put_unused_fd(pidfd);

Thanks for the patch but this is actually wrong. If you look further up
where pidfile is allocated you'll see the comment

		get_pid(pid);	/* held by pidfile now */

which I added to inidicate that the additional reference to struct pid
has now been transferred to the pidfile and is released when the file is
released. So the last fput(pidfile) will cause the vfs to call the
files' ->release() method which in this case is

static int pidfd_release(struct inode *inode, struct file *file)
{
	struct pid *pid = file->private_data;

	file->private_data = NULL;
	put_pid(pid);
	return 0;
}

Since fput(pidfile) in the bad_fork_put_pidfd error path is the only
reference to the pidfile the struct pid reference count will be
decremented.

Your additional put_pid() will cause a UAF which you should've seen
during testing if you injected an error by setting CLONE_PIDFD e.g. by
providing NULL as the args->pidfd argument to clone3() or NULL to the
parent_tidptr argument of clone() or by placing the parent into a cgroup
whos current pid_max limit doesn't allow it to fork.

Thanks!
Christian
