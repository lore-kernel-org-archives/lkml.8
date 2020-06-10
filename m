Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D279204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgFJRmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:42:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB3C03E96B;
        Wed, 10 Jun 2020 10:42:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj4jY-006YSx-Ps; Wed, 10 Jun 2020 17:41:52 +0000
Date:   Wed, 10 Jun 2020 18:41:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] proc: s_fs_info may be NULL when proc_kill_sb is called
Message-ID: <20200610174152.GS23230@ZenIV.linux.org.uk>
References: <0000000000002d7ca605a7b8b1c5@google.com>
 <20200610130422.1197386-1-gladkov.alexey@gmail.com>
 <87mu5azvxl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu5azvxl.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:12:54PM -0500, Eric W. Biederman wrote:

> >  {
> >  	struct proc_fs_info *fs_info = proc_sb_info(sb);
> >  
> > -	if (fs_info->proc_self)
> > -		dput(fs_info->proc_self);
> > +	if (fs_info) {
> > +		if (fs_info->proc_self)
> > +			dput(fs_info->proc_self);
> >  
> > -	if (fs_info->proc_thread_self)
> > -		dput(fs_info->proc_thread_self);
> > +		if (fs_info->proc_thread_self)
> > +			dput(fs_info->proc_thread_self);
> > +
> > +		put_pid_ns(fs_info->pid_ns);
> > +		kfree(fs_info);

While we are at it, dput(NULL) is an explicit no-op.
