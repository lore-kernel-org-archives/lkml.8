Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F32BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1088D20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgFXA1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:27:08 -0400
Received: from trent.utfs.org ([94.185.90.103]:37122 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbgFXA1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:27:08 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 2984E601B2;
        Wed, 24 Jun 2020 02:26:49 +0200 (CEST)
Date:   Tue, 23 Jun 2020 17:26:49 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] Re: filesystem being remounted supports timestamps until
 2038
In-Reply-To: <alpine.DEB.2.21.99999.375.2001041545350.21037@trent.utfs.org>
Message-ID: <alpine.DEB.2.22.1.446.2006231719390.3892@trent.utfs.org>
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org> <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org> <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
 <alpine.DEB.2.21.99999.375.2001041545350.21037@trent.utfs.org>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2020, Christian Kujau wrote:
> On Sun, 29 Dec 2019, Linus Torvalds wrote:
> > >     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
> > >     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
> > >     to make it stop.
> > 
> > How about just doing it once per mount?
> 
> Yes, once per mount would work, and maybe not print a warning on remounts 
> at all.

Is there any chance that this can be revisited perhaps? This is still 
flooding my dmesg just because I have that (curde?) mechanism in place to 
remount the backup device after the hourly backup-run to read-only. Sure, 
I could omit that ("Doc, it hurts when I do that", as Al would comment), 
but that's really the only repeating message that gets triggered because 
of this. 1067 messages in ~60 days of uptime :-|

Does the patch below make any sense, would that work?

Please reconsider,
Christian.

> Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp 
> expiry") introduced:
> 
>    Mounted %s file system at %s supports timestamps until [...]
> 
> in mnt_warn_timestamp_expiry(), but then 0ecee6699064 ("fs/namespace.c: 
> fix use-after-free of mount in mnt_warn_timestamp_expiry") changed this to
> 
>   %s filesystem being %s at %s supports timestamps until [...]
> 
> in order to fix a use-after-free.
> 
> > Of course, if you actually unmount and completely re-mount a
> > filesystem, then that would still warn multiple times, but at that
> > point I think it's reasonable to do.
> 
> Yes, of course. Umount/remount cycles should still issue a warning, but 
> "-o remount" should not, IMHO.
> 
> Thanks,
> Christian.

commit c9a5338b4930cdf99073042de0717db43d7b75be
Author: Christian Kujau <lists@nerdbynature.de>
Date:   Thu Dec 26 17:39:57 2019 -0800

    Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry") resp.
    0ecee6699064 ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") introduced
    a pr_warn message and the following gets sent to dmesg on every remount:
    
     [...] filesystem being remounted at /mnt supports timestamps until 2038 (0x7fffffff)
    
    When file systems are remounted a couple of times per day (e.g. rw/ro for backup
    purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
    to make it stop.
    
    Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/fs/namespace.c b/fs/namespace.c
index be601d3a8008..afc6a13e7316 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2478,7 +2478,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 
 		time64_to_tm(sb->s_time_max, 0, &tm);
 
-		pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
+		pr_debug("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
 			sb->s_type->name,
 			is_mounted(mnt) ? "remounted" : "mounted",
 			mntpath,




-- 
BOFH excuse #66:

bit bucket overflow
