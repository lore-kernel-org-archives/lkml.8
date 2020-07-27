Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74179C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5773120719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgG0Qco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:32:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58066 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgG0Qcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:32:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k063O-0005DQ-1Z; Mon, 27 Jul 2020 10:32:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k063M-0005L4-S3; Mon, 27 Jul 2020 10:32:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20200727141411.203770-1-gladkov.alexey@gmail.com>
        <20200727141411.203770-3-gladkov.alexey@gmail.com>
Date:   Mon, 27 Jul 2020 11:29:36 -0500
In-Reply-To: <20200727141411.203770-3-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Mon, 27 Jul 2020 16:14:11 +0200")
Message-ID: <87blk0ncpb.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k063M-0005L4-S3;;;mid=<87blk0ncpb.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HvToJCGgqP/yRDgtU2woGKqvlS5lpgrM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1 2/2] Show /proc/self/net only for CAP_NET_ADMIN
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Show /proc/self/net only for CAP_NET_ADMIN if procfs is mounted with
> subset=pid option in user namespace. This is done to avoid possible
> information leakage.
>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/proc/proc_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index dba63b2429f0..11fa2c4b3529 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -275,6 +275,12 @@ static struct net *get_proc_task_net(struct inode *dir)
>  	struct task_struct *task;
>  	struct nsproxy *ns;
>  	struct net *net = NULL;
> +	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
> +
> +	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
> +	    (current_user_ns() != &init_user_ns) &&
> +	    !capable(CAP_NET_ADMIN))
> +		return net;
>
>  	rcu_read_lock();
>  	task = pid_task(proc_pid(dir), PIDTYPE_PID);

Hmm.

I see 3 options going forward.

1) We just make PROC_PIDONLY_ON mean the net directory does not exist.
   No permission checks just always fail.

2) Move the permission checks into opendir/readdir and whichever
   is the appropriate method there and always allow the dentries
   to be cached.

3) Simply cache the mounters credentials and make access to the
   net directories contingent of the permisions of the mounter of
   proc.  Something like the code below.

static struct net *get_proc_task_net(struct inode *dir)
{
	struct task_struct *task;
	struct nsproxy *ns;
	struct net *net = NULL;

	rcu_read_lock();
	task = pid_task(proc_pid(dir), PIDTYPE_PID);
	if (task != NULL) {
		task_lock(task);
		ns = task->nsproxy;
		if (ns != NULL)
			net = get_net(ns->net_ns);
		task_unlock(task);
	}
	rcu_read_unlock();
	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
            !security_capable(fs_info->mounter_cred,
			      net->user_ns, CAP_SYS_ADMIN,
			      CAP_OPT_NONE)) {
		put_net(net);
		net = NULL;
	}
	return net;
}

Eric
