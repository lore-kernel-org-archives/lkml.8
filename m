Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F20D2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg5jBIOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgE0XXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgE0XXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:23:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1CC08C5C1;
        Wed, 27 May 2020 16:23:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q13so2458842edi.3;
        Wed, 27 May 2020 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIVZxySUnBYIOh1u+axvWyg8nrJdsmWrI8rTFK6qLVg=;
        b=Qg5jBIOJ/fnN/Gke/Ow3JmBDV/gHExZTNzXoLEYshE5IPCFeaIyXdpSeewVt/pCERE
         QSy8ZFFHWMzfJ5mcOTathiF9yOLEHFX+Ib3VyDj3WORcpvTCUJ3SpvdVk5TU7NAcnsoW
         iDeHRty7UUBWQ78SUsxkvxadSzDLJX4ctgRVCjTbMh774Go9YfE5GtXADJsj3c+kUHSz
         L0uV0TAG0qejh3Hzz/Q8c8WW5K1Crr2ZcFSC30XUE01UzgI85Tb1VGKKmSokO5k2QDGR
         euSSu74G2kCqAykqTJv0cEAd5cAuVHbMbJP2Cfo/G8WVzhHSPKgypqe7I4jgJULBgUOg
         uOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIVZxySUnBYIOh1u+axvWyg8nrJdsmWrI8rTFK6qLVg=;
        b=qonFjQ6x2wRzpmdRCE0Z1AazjDR6rXgHSzq7EFnZ9HEmThHwU2/WVO+jfjYvjuJxQP
         lFLcFSTFj6zXdOzF9IMh/LQitpE/FfV9ZuoHR9nq+mjOkhsR9Ph77VajrvADHjU+dc5V
         ca5jRAvxavGw9S/eJ+czQ8Yk2az9UKvpJZEBw4mu8SvvygDoCd3sEURrlTEJNRsTY4xM
         IgYlgmMlp9L8SpheiEl7qVczv3rK7KN7Jf/34dlSOrYR75O5dpLeqw/0gA1gEe4+Jt1g
         NqqD2cqLVtoKRSECo4XEzJtiRJjkCZqP2IKRuP3JQj/1AsGS0SnbfJcWLDztkyM9iWds
         NqIQ==
X-Gm-Message-State: AOAM532zoTE0svSJMfD23KpF7Vb0HNWAmLgWZAuvo2g2AaLHENoCythq
        6/luA4gaJpSh2vRGTEsz3vXxw7HQ6N/BOZuIsBs=
X-Google-Smtp-Source: ABdhPJzFmTwEl6MHDoni4mS3GYwuJBWsIM1gkQwV01ccEMndn8oOJCrkDRqOfJHo0Ue19BklzCp7MWJWZ971zOtu80I=
X-Received: by 2002:a50:b082:: with SMTP id j2mr450297edd.201.1590621826391;
 Wed, 27 May 2020 16:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200527230442.24228-1-wu000273@umn.edu>
In-Reply-To: <20200527230442.24228-1-wu000273@umn.edu>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 28 May 2020 08:23:34 +0900
Message-ID: <CAKFNMokewQQnx9VyK1TpZx+o11UTmNoVsZ-eqFrRzXnYdP-NYg@mail.gmail.com>
Subject: Re: [PATCH V2] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kjlu@umn.edu,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        wu000273@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please pick this up as well.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

On Thu, May 28, 2020 at 8:04 AM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> In nilfs_sysfs_create_device_group(), the memory allocated by
> kobject_init_and_add() is not freed when kobject_init_and_add()
> fails. Fix this issue by calling kobject_put() to clean up the
> kobject.
>
> Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  V2: using kobject_put() to handle kobject_init_and_add() instead of
>  kobject_del().
>
>  fs/nilfs2/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index e60be7bb55b0..8416f915d118 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -999,8 +999,10 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>         init_completion(&nilfs->ns_dev_kobj_unregister);
>         err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
>                                     "%s", sb->s_id);
> -       if (err)
> +       if (err) {
> +               kobject_put(&nilfs->ns_dev_kobj);
>                 goto free_dev_subgroups;
> +       }
>
>         err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
>         if (err)
> --
> 2.17.1
>
