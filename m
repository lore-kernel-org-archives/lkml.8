Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135FCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DF42087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgIIQuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:50:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35004 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbgIIQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:50:06 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kFzcp-0005yj-AB; Wed, 09 Sep 2020 06:54:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kFzco-0004SP-M1; Wed, 09 Sep 2020 06:54:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200729151740.GA3430@haolee.github.io>
        <20200908130656.GC22780@haolee.github.io>
        <20200908184857.GT1236603@ZenIV.linux.org.uk>
        <20200908231156.GA23779@haolee.github.io>
Date:   Wed, 09 Sep 2020 07:54:44 -0500
In-Reply-To: <20200908231156.GA23779@haolee.github.io> (Hao Lee's message of
        "Tue, 8 Sep 2020 23:11:56 +0000")
Message-ID: <87k0x39kkr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kFzco-0004SP-M1;;;mid=<87k0x39kkr.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cGAlwG5SJvXhASPH3BzmknXhShGQlYMk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more clear
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hao Lee <haolee.swjtu@gmail.com> writes:

> On Tue, Sep 08, 2020 at 07:48:57PM +0100, Al Viro wrote:
>> On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
>> > ping
>> > 
>> > On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
>> > > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
>> > > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
>> > > some long statements for example
>> > > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
>> > > inode_lock(dentry->d_inode) to do the same thing now, and its length is
>> > > acceptable. Furthermore, it seems not concise that assign path->dentry
>> > > to local variable dentry in the statement before goto. So, this function
>> > > would be more clear if we eliminate the local variable dentry.
>> 
>> How does it make the function more clear?  More specifically, what
>> analysis of behaviour is simplified by that?
>
> When I first read this function, it takes me a few seconds to think
> about if the local variable dentry is always equal to path->dentry and
> want to know if it has special purpose. This local variable may confuse
> other people too, so I think it would be better to eliminate it.

I tend to have the opposite reaction.  I read your patch and wonder
why path->dentry needs to be reread what is changing path that I can not see.
my back.

Now for clarity it would probably help to do something like:

diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713..430f3b4785e3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2206,7 +2206,7 @@ static struct mountpoint *lock_mount(struct path *path)
                return mp;
        }
        namespace_unlock();
-       inode_unlock(path->dentry->d_inode);
+       inode_unlock(dentry->d_inode);
        path_put(path);
        path->mnt = mnt;
        dentry = path->dentry = dget(mnt->mnt_root);


So at least the inode_lock and inode_unlock are properly paired.

At first glance inode_unlock using path->dentry instead of dentry
appears to be an oversight in 84d17192d2af ("get rid of full-hash scan
on detaching vfsmounts").  


Eric
