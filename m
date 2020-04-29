Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5AC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A38D206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD2O4g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2O4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:56:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF213C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:56:35 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jTo8X-0001n7-9E; Wed, 29 Apr 2020 16:56:33 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans()
References: <20200119215233.7292-1-richard@nod.at>
Date:   Wed, 29 Apr 2020 16:56:31 +0200
In-Reply-To: <20200119215233.7292-1-richard@nod.at> (Richard Weinberger's
        message of "Sun, 19 Jan 2020 22:52:33 +0100")
Message-ID: <875zdibasg.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Could you CC this patch to stable? It fixes a serious problem that I am
seeing on real devices (i.e. Linux not being able to mount its root
filesystem after a power cut). Thanks.

John Ogness

On 2020-01-19, Richard Weinberger <richard@nod.at> wrote:
> Orphans are allowed to point to deleted inodes.
> So -ENOENT is not a fatal error.
>
> Reported-by: Кочетков Максим <fido_max@inbox.ru>
> Reported-and-tested-by: "Christian Berger" <Christian.Berger@de.bosch.com>
> Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when killing orphans.")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/orphan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
> index 54d6db61106f..2645917360b9 100644
> --- a/fs/ubifs/orphan.c
> +++ b/fs/ubifs/orphan.c
> @@ -688,14 +688,14 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
>  
>  			ino_key_init(c, &key1, inum);
>  			err = ubifs_tnc_lookup(c, &key1, ino);
> -			if (err)
> +			if (err && err != -ENOENT)
>  				goto out_free;
>  
>  			/*
>  			 * Check whether an inode can really get deleted.
>  			 * linkat() with O_TMPFILE allows rebirth of an inode.
>  			 */
> -			if (ino->nlink == 0) {
> +			if (err == 0 && ino->nlink == 0) {
>  				dbg_rcvry("deleting orphaned inode %lu",
>  					  (unsigned long)inum);
