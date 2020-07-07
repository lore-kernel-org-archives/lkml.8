Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B77C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEB1206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFExuLQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGGLxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGGLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:53:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DBC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:53:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so37751651qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lhR2DZXpozvvgwzQZE1TCPc3qqJrMpIFfl0B2ci+vU=;
        b=vFExuLQFOH/bXTR/xQJn75B8oonlcSiIttbkfBjYRxIChwEd2AR3gU2B1S+lwXsSRl
         R3WqH0yxCnRrY2KezY865zfBmTKORaxsXKfWcSiLF1SOD2peJy0N9Cewg7q5cYrnrwfW
         n1CgK+S/uqzPLW2XqkTUZVphPCEu2Nh+Ux0A51K52eQ2Z48jprlhtMq+AIeStSSHhh+l
         1h8Vprw543xz2CaF83OXxvIYtOvDUac7kcDUiR1nUI3nz8xk3rOEbwvXhCYNMA5jYckd
         a+nh9RXpYON2GH08oVNgGrqJNNmQha9h52VJ+2R3hj72ne8kjBQNbtj4coPkrSSH4q7U
         S9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lhR2DZXpozvvgwzQZE1TCPc3qqJrMpIFfl0B2ci+vU=;
        b=ABPkdMTxugkrfEgbTU6tGNEer1NLYILjYFyEbXayQGqT+/Uiqhvnda3V6gH+3GQVPx
         NSwWW3lr9vgcAj2pyegi5zKE+W94Ls51JKgEJemU7yc5ocp4Jm+3LN5U0w+qfaQUFVyt
         B+Ix+kIy2GvX7HIdFsd9/hdk7kmfkv6fSw5vfB28AYtVzfxSu2Q7/tVB9WW9Aq6PIai9
         p5skL6dktJnxzWin9pjNTJsbz+mVvYDh7+EOV2ViQsHhXlShzYusPtS87PhgUwDuoUv5
         ofbfDbK5oNCKijOSGbFHRwzqkP5yByec3ENHifWn+zLYCwlkZ55XnjKh7PbdvTQm8Kmn
         /gaA==
X-Gm-Message-State: AOAM533a0DxxQ4PO9A7NGCyxQXfLkrRoNZi6NKX2RpP90nRlCsUfGb4k
        2ci+kyKx2dBVWyIXy/4UrXg1bnvP19V6msXiXR8=
X-Google-Smtp-Source: ABdhPJxI0yK/3FTcBZrGCc+QfO7hVhj1GBMGcBdmHTMw0+jvC5IYgvfTIPEaDGxgMCOZTnR4yIJOJZHt4XFq01W7GeI=
X-Received: by 2002:a37:8b01:: with SMTP id n1mr51153237qkd.370.1594122784112;
 Tue, 07 Jul 2020 04:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152048.1819867-1-chengzhihao1@huawei.com>
In-Reply-To: <20200702152048.1819867-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 7 Jul 2020 13:52:53 +0200
Message-ID: <CAFLxGvybobVbhS4zQSxSmq3xR40QP=pkyDG8j7jA8a6eOOKfHg@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix wrong orphan node deletion in ubifs_jnl_update()
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 5:21 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> There a wrong orphan node deleting in error handling path in
> ubifs_jnl_update(), which may cause following error msg:
>
>   UBIFS error (ubi0:0 pid 1522): ubifs_delete_orphan [ubifs]:
>   missing orphan ino 65
>
> Fix this by checking whether the node has been operated for
> adding to orphan list before being deleted,
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/ubifs/journal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index e5ec1afe1c66..db0a80dd9d52 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -539,7 +539,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>                      const struct fscrypt_name *nm, const struct inode *inode,
>                      int deletion, int xent)
>  {
> -       int err, dlen, ilen, len, lnum, ino_offs, dent_offs;
> +       int err, dlen, ilen, len, lnum, ino_offs, dent_offs, orphan_added = 0;
>         int aligned_dlen, aligned_ilen, sync = IS_DIRSYNC(dir);
>         int last_reference = !!(deletion && inode->i_nlink == 0);
>         struct ubifs_inode *ui = ubifs_inode(inode);
> @@ -630,6 +630,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>                         goto out_finish;
>                 }
>                 ui->del_cmtno = c->cmt_no;
> +               orphan_added = 1;
>         }
>
>         err = write_head(c, BASEHD, dent, len, &lnum, &dent_offs, sync);
> @@ -702,7 +703,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>         kfree(dent);
>  out_ro:
>         ubifs_ro_mode(c, err);
> -       if (last_reference)
> +       if (last_reference && orphan_added)

I think you can just check for orphan_added here.
Looks good otherwise, thanks for fixing! :-)

-- 
Thanks,
//richard
