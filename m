Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EBC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570792082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgA3ONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:13:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59783 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3ONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:13:14 -0500
Received: from [109.134.33.162] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ixAZE-0008IN-2q; Thu, 30 Jan 2020 14:13:12 +0000
Date:   Thu, 30 Jan 2020 15:13:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 01/17] do_add_mount(): lift lock_mount/unlock_mount into
 callers
Message-ID: <20200130141311.zm54wadpeipckoqk@wittgenstein>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 03:17:13AM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> preparation to finish_automount() fix (next commit)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Just a naming nit below.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  fs/namespace.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 2fd0c8bcb8c1..5f0a80f17651 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2697,45 +2697,32 @@ static int do_move_mount_old(struct path *path, const char *old_name)
>  /*
>   * add a mount into a namespace's mount tree
>   */
> -static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
> +static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
> +			struct path *path, int mnt_flags)

Maybe this should now be named do_add_mount_locked() so callers know
that they need to do locking themselves?
But that's bikeshedding...

Christian
