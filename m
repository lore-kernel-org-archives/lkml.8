Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023A2204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHGRgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:36:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:36:21 -0400
Received: from [177.9.89.61] (helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1k46Hw-0006Pt-Un; Fri, 07 Aug 2020 17:36:17 +0000
Date:   Fri, 7 Aug 2020 14:36:09 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: wine fails to start with seccomp updates for v5.9-rc1
Message-ID: <20200807173609.GJ4402@mussarela>
References: <1596812929.lz7fuo8r2w.none.ref@localhost>
 <1596812929.lz7fuo8r2w.none@localhost>
 <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 08:48:46AM -0700, Linus Torvalds wrote:
> On Fri, Aug 7, 2020 at 8:19 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> >
> > On Linus' master, wine fails to start with the following error:
> >
> > wine client error:0: write: Bad file descriptor
> >
> > This issue is not present on 5.8. It appears to be caused by failure to
> > write to a pipe FD received via SCM_RIGHTS. Therefore, I tried reverting
> > 9ecc6ea491f0, which resolved the issue.
> 
> Would you mind trying to bisect exactly where it happens?
> 

This report [1] seemed related and pointed out at c0029de50982 ("net/scm:
Regularize compat handling of scm_detach_fds()"). The use of CMSG_USER_DATA
instead of CMSG_COMPAT_DATA seems fishy.

Alex, can you try applying the patch below?

Cascardo.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216156.html

> I don't think any of the commits in that pull are supposed to change
> semantics, and while reverting the whole merge shows that yes, that's
> what brought in the problems, it would be good to pinpoint just which
> change breaks so that we can fix just that thing.
> 
> Kees, ideas?
> 
>                  Linus

---
diff --git a/net/compat.c b/net/compat.c
index 703acb51c698..95ce707a30a3 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -294,7 +294,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 		(struct compat_cmsghdr __user *)msg->msg_control;
 	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
 	int fdmax = min_t(int, scm_max_fds_compat(msg), scm->fp->count);
-	int __user *cmsg_data = CMSG_USER_DATA(cm);
+	int __user *cmsg_data = CMSG_COMPAT_DATA(cm);
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
