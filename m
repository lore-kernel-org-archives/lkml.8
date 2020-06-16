Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B49FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104412071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frn5/8fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgFPMfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:35:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54727 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgFPMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592310935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iB+tLxbMFnSjf4OCKzC/4HIzsCJg+C3y/2+RqkCXgU8=;
        b=frn5/8fpcjbNNA7v4SdAj1bplqoGAR4sWzU2fu+FVKBiidMJQseEwnKqCdmv/4XgUoSL1s
        DL9smDs0sn2K/oay0VE/KdpaIfWMdPj/hd9Plw1weA+aa/0RFFPveb88uSwlWAmkSM5Cn0
        L1nYYsuzdyprGB08Xxc4wGPPGZtlKLw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-p-iBgtDtPUe-w19YV8D85A-1; Tue, 16 Jun 2020 08:35:32 -0400
X-MC-Unique: p-iBgtDtPUe-w19YV8D85A-1
Received: by mail-qv1-f71.google.com with SMTP id v15so15473979qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iB+tLxbMFnSjf4OCKzC/4HIzsCJg+C3y/2+RqkCXgU8=;
        b=dvmEEqLhBrCFqG51z72B/MdEtfwc5V6prTugeMoag/NNsoUWl/DFjxGjUzvNfnlUWC
         3QvrvPgpTr2sCY1/GU9lK5+4rkRWtCuck9Ns/aKyHYp67KYLBs44FPHKMzdKaj3VhgTO
         0LB+PFAAXbKDIKlX9hDsYUw+dY6cOMbZEq9gtyLZYg6GPtiY6DzID4UJtusmFeu1X4EV
         MALx6UB4tbIzN1PGB+oVU6xdBl8uaU+qtyqFXXP95JQmW5lvlsZqB9rZyHkwIJz7GqDt
         hcf9YGEBeUKSOxk3MySrHUb5a9fwxVDCTD4ATHgdWrPhesHaDcNrBHHPMXQlBgiLXf6/
         Pxxg==
X-Gm-Message-State: AOAM533914WjCOEmESuwIlefcMXPWnrtYZMWhyE2DEdR4tJqYbWd/Gye
        CgzQb8xRHXAvQTkjz4HqYmoEx1iOcPt70G4BeA8BXeQh01ODdteLODdazkZKs8w490HpBklA5hi
        tWHhCK3DJdUy1FEi63E2hyBbxwjiaI4C4SY6xAqju
X-Received: by 2002:a05:620a:1f6:: with SMTP id x22mr19508295qkn.199.1592310931713;
        Tue, 16 Jun 2020 05:35:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD4tHLw1E0ehjNHkVDjusAddWEBYWv/x2eWVDzoN/sgBYEWc5uf2aqeTAd6jxRf8hGh0NAJfqwzHHULWAOJcw=
X-Received: by 2002:a05:620a:1f6:: with SMTP id x22mr19508274qkn.199.1592310931497;
 Tue, 16 Jun 2020 05:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200615005036.GU12456@shao2-debian> <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
In-Reply-To: <ea00a67e-5a61-2e70-215e-004e3dcc57c1@virtuozzo.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 16 Jun 2020 14:35:20 +0200
Message-ID: <CAOssrKdTTZEBEfwFm+3dYJ5XB9FsFAeF5g5ydeSo7ZPKkqjJXQ@mail.gmail.com>
Subject: Re: [fuse] 6b2fb79963: WARNING:at_fs/fuse/file.c:#tree_insert[fuse]
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Maxim Patlasov <maximvp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 7:59 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 6/15/20 3:50 AM, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 6b2fb79963fbed7db3ef850926d913518fd5c62f ("fuse: optimize writepages search")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> > [ 1030.995703] ------------[ cut here ]------------
> > [ 1030.997563] WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
> > [ 1031.021943] RIP: 0010:tree_insert+0xab/0xc0 [fuse]
> > [ 1031.057802] Call Trace:
> > [ 1031.060015]  fuse_writepages_fill+0x5da/0x6a0 [fuse]
> > [ 1031.062536]  write_cache_pages+0x171/0x470
> > [ 1031.064933]  ? fuse_writepages+0x100/0x100 [fuse]
> > [ 1031.067419]  ? terminate_walk+0xd3/0xf0
> > [ 1031.069707]  ? _cond_resched+0x19/0x30
> > [ 1031.072140]  ? __kmalloc+0x274/0x280
> > [ 1031.074407]  fuse_writepages+0x8a/0x100 [fuse]
> > [ 1031.076599]  do_writepages+0x43/0xe0
>
> It is  WARN_ON(!wpa->ia.ap.num_pages);
> however tree_insert() was called from fuse_writepages_fill() with ap->num_pages = 0;
> In submitted PATCH RFC we have used
>
> +static int tree_insert(struct rb_root *root, struct fuse_req *ins_req)
> ...
> +       pgoff_t idx_to   = idx_from + (ins_req->num_pages ?
> +                               ins_req->num_pages - 1 : 0);
>
> Though committed patch version have
>
> +static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
> ...
> +       pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
> ...
> +       WARN_ON(!wpa->ia.ap.num_pages);
>
> Miklos,
> do you have any objections if I return to our initial proposal?
> Am I missed something and it is not allowed now?

No objections, but you need to explain with a comment why that special
casing of num_pages == 0 is needed.  I don't understand it yet.

Thanks,
Miklos

