Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A64C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAF9206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgFDUh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:37:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39988 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgFDUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:37:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwc9-00064N-Lz; Thu, 04 Jun 2020 14:37:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwc8-0000m9-GV; Thu, 04 Jun 2020 14:37:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
Date:   Thu, 04 Jun 2020 15:33:25 -0500
In-Reply-To: <20200604200413.587896-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 4 Jun 2020 22:04:11 +0200")
Message-ID: <87ftbah8q2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgwc8-0000m9-GV;;;mid=<87ftbah8q2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+vjCBiGzqIgIt/FfYuiYQafWqnnlO4w2E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level procfs entries
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Greetings!
>
> Preface
> -------
> This patch set can be applied over:
>
> git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git d35bec8a5788

I am not going to seriously look at this for merging until after the
merge window closes. 

Have you thought about the possibility of relaxing the permission checks
to mount proc such that we don't need to verify there is an existing
mount of proc?  With just the subset pids I think this is feasible.  It
might not be worth it at this point, but it is definitely worth asking
the question.  As one of the benefits early propopents of the idea of a
subset of proc touted was that they would not be as restricted as they
are with today's proc.

I ask because this has a bearing on the other options you are playing
with.

Do we want to find a way to have the benefit of relaxed permission
checks while still including a few more files.

> Overview
> --------
> Directories and files can be created and deleted by dynamically loaded modules.
> Not all of these files are virtualized and safe inside the container.
>
> However, subset=pid is not enough because many containers wants to have
> /proc/meminfo, /proc/cpuinfo, etc. We need a way to limit the visibility of
> files per procfs mountpoint.

Is it desirable to have meminfo and cpuinfo as they are today or do
people want them to reflect the ``container'' context.   So that
applications like the JVM don't allocation too many cpus or don't try
and consume too much memory, or run on nodes that cgroups current make
unavailable.

Are there any users or planned users of this functionality yet?

I am concerned that you might be adding functionality that no one will
ever use that will just add code to the kernel that no one cares about,
that will then accumulate bugs.  Having had to work through a few of
those cases to make each mount of proc have it's own super block I am
not a great fan of adding another one.

If the runc, lxc and other container runtime folks can productively use
such and option to do useful things and they are sensible things to do I
don't have any fundamental objection.  But I do want to be certain this
is a feature that is going to be used.

Eric


> Introduced changes
> ------------------
> Allow to specify the names of files and directories in the subset= parameter and
> thereby make a whitelist of top-level permitted names.
>
>
> Alexey Gladkov (2):
>   proc: use subset option to hide some top-level procfs entries
>   docs: proc: update documentation about subset= parameter
>
>  Documentation/filesystems/proc.rst |  6 +++
>  fs/proc/base.c                     | 15 +++++-
>  fs/proc/generic.c                  | 75 +++++++++++++++++++++------
>  fs/proc/inode.c                    | 18 ++++---
>  fs/proc/internal.h                 | 12 +++++
>  fs/proc/root.c                     | 81 ++++++++++++++++++++++++------
>  include/linux/proc_fs.h            | 11 ++--
>  7 files changed, 175 insertions(+), 43 deletions(-)
