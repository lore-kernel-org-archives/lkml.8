Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32821C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08644207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pantacor-com.20150623.gappssmtp.com header.i=@pantacor-com.20150623.gappssmtp.com header.b="qWa++oMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHUQik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgHUQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:38:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F22C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:38:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1122109plp.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pantacor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W9iCgbZK9Cw1buvEJZPkNGO1pB0TJP+IziLsIrcWLQ=;
        b=qWa++oMpGxJ4Bw6on2ysodl/N7exZxt3WocQm4s4PTPWs8wtdP6wADlHcM4rh/koD2
         iHIMLb2lbzoz77N8Su8CIHUPExc+EmRKETVn4/Jao711qUL14VQjc+K5Q1yEHu8hMpat
         /W2Uj7GFSpuI4sFRIom8jhadNvf+HW98mUZ772RTaUme8mTmUIinYRKNOmGYHErAr8BC
         srfHs3E1s2DHCP+iDHNlyxQJFVn+ysFWZii7OrGjTCZGT+/iGGDTT35/3LzM7K3GXMBC
         YdvX+XHasW6jBdCgPYl0Yh5FvQpwFSjxdk3jQUZzsHaeZfnqPi3sWV1vFmbJ5DzSnz+k
         B6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W9iCgbZK9Cw1buvEJZPkNGO1pB0TJP+IziLsIrcWLQ=;
        b=BsHbhBIa8FpN6IoOCsSDVd4YIr7W4cY1j55pBJx+XnZsGdwm5Q+1R1nIRxb3+BVQzU
         IbQ/x4VMxlgW7n4VjAhN1N6rCpuPhVa3oScEpDVjTTFnfbvy6A9MWftGkyL+thGd6dau
         Z4fPvtkp6yHugphRDW1C4aJwSIrAg+qL/IMFk1acv0ZdUTIx3YgBXMi6LLcwm6cRmjDf
         RsEJ0jLFIqvmJD+XkPt5zgMYVxLoXbVfertVwuk3An0pJzMQzGKI/me/ErpLYrpG+MYd
         SkmIbGNI6fg2qE0k6hAI2IZHsikJ9kGciP34FmJcS5pPyr2LXeawdIyMirBFLOOOZe0j
         bl6A==
X-Gm-Message-State: AOAM5319C2r81JijzjQJXp3HpsYHceg+UY4tnPG1UVfp/yl8tTRPQjLR
        yXR1phf2eRJ7Rbe5CQY5vfoOrkm64ioQoh1I9zjbBw==
X-Google-Smtp-Source: ABdhPJzxPHhy5wstykAk668oz2z0rXxsvRp9cZNcYsd0b6oEwQK0YiuuWTnuBT3qcCTpbLHQI09C+t6ItLQ6HUSmhZ4=
X-Received: by 2002:a17:90a:514a:: with SMTP id k10mr1746257pjm.81.1598027908631;
 Fri, 21 Aug 2020 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CABfyVHc=oQmZG9NuJgu1G92VQqsxkynE+S9DosQzh9r+9G1Jbg@mail.gmail.com>
In-Reply-To: <CABfyVHc=oQmZG9NuJgu1G92VQqsxkynE+S9DosQzh9r+9G1Jbg@mail.gmail.com>
From:   Pranay Srivastava <pranay.srivastava@pantacor.com>
Date:   Fri, 21 Aug 2020 22:08:17 +0530
Message-ID: <CABfyVHcmd0nymzr3M_zxxwbXfMXhJs4HDARy+eMZ+jfLGsy8tw@mail.gmail.com>
Subject: Re: mountinfo contents changed when rootfs is ramfs
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 5:20 PM Pranay Srivastava
<pranay.srivastava@pantacor.com> wrote:
>
> Hello,
>
> I'm running a system where rootfs is ramfs. For kernel version 5.2.11
>
> # cat /proc/self/mountinfo
> 0 0 0:1 / / rw - rootfs rootfs rw
> %<---snip>%
>
> while for kernel 5.4.58
> # cat /proc/self/mountinfo
> 0 0 0:1 / / rw - rootfs none rw
> %<---snip>%
>
> The reason for the above difference is because for kernel 5.2.11 the
> parse_param for
> rootfs was set to legacy_parse_param which handled the "source" param
> instead of
> ignoring it.
>
> With kernel 5.4.58 this is set to ramfs_parse_param which ignores any
> parameters not
> recognized and also returns 0 instead of -ENOPARAM. This causes
> vfs_parse_fs_param
> to not set the file context  source(fc->source) which results in "none" from
> alloc_vfs_mount(fc->source ? : "none")
>
> The commit which introduced the above change was
>
> commit f32356261d44d580649a7abce1156d15d49cf20f
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Mar 25 16:38:31 2019 +0000
>
>     vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
>
> I'm not sure if this is a regression? But if it is, do we handle it like
>
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index ee179a81b3da..47a39baa0535 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
>
> @@ -200,7 +200,7 @@ static int ramfs_parse_param(struct fs_context
> *fc, struct fs_parameter *param)
>                  * and as it is used as a !CONFIG_SHMEM simple substitute
>                  * for tmpfs, better continue to ignore other mount options.
>                  */
> -               if (opt == -ENOPARAM)
> +               if (opt == -ENOPARAM && strcmp(param->key, "source"))
>                         opt = 0;
>                 return opt;
>         }
>
> so that mountinfo gives the same information as for earlier kernels.
>
> Thanks!
> --
> Regards,
> Pranay Srivastava

Kindly let me know if the above is a regression and needs to be fixed?

-- 
Regards,
Pranay Srivastava
