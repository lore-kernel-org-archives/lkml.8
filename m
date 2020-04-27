Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C3BC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71BB20661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgD0QLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:11:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgD0QLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:11:51 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jT6MG-0007ay-2S; Mon, 27 Apr 2020 16:11:48 +0000
Date:   Mon, 27 Apr 2020 18:11:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
Message-ID: <20200427161147.6mtsweiw4nrq3cl6@wittgenstein>
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
 <87sggpeyy4.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sggpeyy4.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:21:55AM -0500, Eric W. Biederman wrote:
> 
> I am still catching up on the what exists for pidfd.  Do you have a way
> to safely go from a pidfd to the corresponding proc directory?

Yep, that's possible. The pidfd's fdinfo file contains the same format
for the Pid: and NSpid: fields as /proc/<pid>/status. Here's e.g. what
systemd is doing currently:

 int pidfd_get_pid(int fd, pid_t *ret) {
        char path[STRLEN("/proc/self/fdinfo/") + DECIMAL_STR_MAX(int)];
        _cleanup_free_ char *fdinfo = NULL;
        char *p;
        int r;

        if (fd < 0)
                return -EBADF;

        xsprintf(path, "/proc/self/fdinfo/%i", fd);

        r = read_full_file(path, &fdinfo, NULL);
        if (r == -ENOENT) /* if fdinfo doesn't exist we assume the process does not exist */
                return -ESRCH;
        if (r < 0)
                return r;

        p = startswith(fdinfo, "Pid:");
        if (!p) {
                p = strstr(fdinfo, "\nPid:");
                if (!p)
                        return -ENOTTY; /* not a pidfd? */

                p += 5;
        }

        p += strspn(p, WHITESPACE);
        p[strcspn(p, WHITESPACE)] = 0;

        return parse_pid(p, ret);
}

> 
> That would make this setns work just an optimization.  A nice one but
> just an optimization.

Hm, I tried to describe how it's not just a worthwhile optimization
because it gets the number of syscalls down from 14 to a single syscall
which is kinda excellent for something like attach/exec into a container
which is a fairly common operation but it also gives us a couple of
other nice properties such as atomic attach and appearing in all
namespace at the same time similar to clone with all namespace flags
set.

Thanks!
Christian
