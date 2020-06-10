Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05563C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EF62072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgFJRRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:17:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60928 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgFJRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:17:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj4LV-0006fQ-U5; Wed, 10 Jun 2020 11:17:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj4LV-0002OG-1e; Wed, 10 Jun 2020 11:17:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000002d7ca605a7b8b1c5@google.com>
        <20200610130422.1197386-1-gladkov.alexey@gmail.com>
Date:   Wed, 10 Jun 2020 12:12:54 -0500
In-Reply-To: <20200610130422.1197386-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Wed, 10 Jun 2020 15:04:22 +0200")
Message-ID: <87mu5azvxl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj4LV-0002OG-1e;;;mid=<87mu5azvxl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dBXhU4ULnzMCMzQEm7usNsGx80LULPAM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: s_fs_info may be NULL when proc_kill_sb is called
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> syzbot found that proc_fill_super() fails before filling up sb->s_fs_info,
> deactivate_locked_super() will be called and sb->s_fs_info will be NULL.
> The proc_kill_sb() does not expect fs_info to be NULL which is wrong.

For the case where s_fs_info is never allocated this looks correct.
That is because generic_shutdown_super has a special for !sb->s_root.

However for the existing cases I can't convince myself that it is safe
to change the order we free the pid namespace and free fs_info.

There is a lot of code that can run while generic_shutdown_super is
running and purging all of the inodes.  We have crazy things like
proc_flush_pid that might care, as well proc_evict_inode.

I haven't found anything that actually references fs_info or actually
depends on the pid namespace living longer than the proc inode but it
would be really easy to miss something.

Can you send a v2 version does not change the order things are freed in
for the case where we do allocate fs_info.  That will make it trivially
safe to apply.

Otherwise this looks like a very good patch.

Thank you,
Eric


> Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
> Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
> Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/proc/root.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index ffebed1999e5..a715eb9f196a 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -264,15 +264,18 @@ static void proc_kill_sb(struct super_block *sb)
>  {
>  	struct proc_fs_info *fs_info = proc_sb_info(sb);
>  
> -	if (fs_info->proc_self)
> -		dput(fs_info->proc_self);
> +	if (fs_info) {
> +		if (fs_info->proc_self)
> +			dput(fs_info->proc_self);
>  
> -	if (fs_info->proc_thread_self)
> -		dput(fs_info->proc_thread_self);
> +		if (fs_info->proc_thread_self)
> +			dput(fs_info->proc_thread_self);
> +
> +		put_pid_ns(fs_info->pid_ns);
> +		kfree(fs_info);
> +	}
>  
>  	kill_anon_super(sb);
> -	put_pid_ns(fs_info->pid_ns);
> -	kfree(fs_info);
>  }
>  
>  static struct file_system_type proc_fs_type = {
