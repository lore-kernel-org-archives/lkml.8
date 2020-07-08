Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6135420663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIV6d79e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgGHQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGHQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:35:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C43C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:35:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so49725973wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYhGd3Y/SzCkEcDEVqwZ3tT6SJLt4iioNIAlLF4sVo0=;
        b=mIV6d79eROzWII6u+qUmTo2GoOU5NYozqR6CQLELB4TMoXp6a+rtDHXEKIQiGQAf0x
         CpB3qrHJfJkZv+wsUEUg29Y9hVC/LQn5TxDfSPBrFc3l6mcU7eY6ngQsWA6XGtLGHIYz
         t4/qFeVZGKTjxiAiTDIdmtJRYiL1xQV42Asj1KVShtel9VVAxrL1lViuJjQrKgmJQjDy
         KGUQ4A/mXJr4AS8hL5K/esaAegdZaEMSnf9SXNLFrVACma0o5hjZxdaIKBgS6HxYTgfc
         XJK73tkX8aFKh1vp9X3r5Jo/SZTeG61zTSsxWgRNkUioh0T1T/mQDzn2lK/vxxKMjihM
         KIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FYhGd3Y/SzCkEcDEVqwZ3tT6SJLt4iioNIAlLF4sVo0=;
        b=KyHlugK6b0f8MZOpiEb9GsusKsrA/rJ42X++OOLyeZo7YZ7oEoL8yLDtt8ew+jygky
         8U+SiipKWUpth95SC0GTK9S80QQz/Q+K48MWouLiQbOcTXGYIEDLDFvHSfYCwdabnCx/
         xwMjAuhFtQ0/gEm5h0x5YXfrybxUSUKe1DUBNsP2g/0BK/Gou476QGNCQ+MyRHtGL+iY
         zyDtfH9VsPMMI/jI9eA13aO9CF7aITf9bnV3TWqVyZP3jo5I+RWIKs3vtBT8/4ZGBzjG
         ybzWuqTOeGzX38oLB1ytJNqCynbgkZQ6EZ/Wadq6JVLkfxb56CCC9QooP5sEmIGk3pHx
         jiAw==
X-Gm-Message-State: AOAM532DPxVGoQylm41tN5ddcUQ4ctFXX4BbmPdkJAexo2/jWD6evJmP
        g3PwcERaoA+eNRoKnj6fPLlUa7Kyd95mKw==
X-Google-Smtp-Source: ABdhPJyMlQZR6yVSVgE5dMMh+vYXQD4B4ID8DGZz9MF0LjVmaTsCOof4zO5ZgUFAXwg6DZUpRxOB6Q==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr58436000wrj.273.1594226114569;
        Wed, 08 Jul 2020 09:35:14 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id x18sm717846wrq.13.2020.07.08.09.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 09:35:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200702105751.20482-1-dmonakhov@gmail.com>
Date:   Wed, 8 Jul 2020 18:35:34 +0200
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <429E50C6-83BA-4A3F-BE9C-06C7C762AF33@linaro.org>
References: <20200702105751.20482-1-dmonakhov@gmail.com>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sorry for the delay.  The commit you propose to drop fix the issues
reported in [1].

Such a commit does introduce the leak that you report (thank you for
spotting it).  Yet, according to the threads mentioned in [1],
dropping that commit would take us back to those issues.

Maybe the solution is to fix the unbalance that you spotted?

I'll check it ASAP, unless you do it before me.

Thanks,
Paolo

[1] https://lkml.org/lkml/2020/1/31/94

> Il giorno 2 lug 2020, alle ore 12:57, Dmitry Monakhov =
<dmonakhov@gmail.com> ha scritto:
>=20
> commit db37a34c563b ("block, bfq: get a ref to a group when adding it =
to a service tree")
> introduce leak forbfq_group and blkcg_gq objects because of get/put
> imbalance. See trace balow:
> -> blkg_alloc
>   -> bfq_pq_alloc
>     -> bfqg_get (+1)
> ->bfq_activate_bfqq
>  ->bfq_activate_requeue_entity
>    -> __bfq_activate_entity
>       ->bfq_get_entity
>         ->bfqg_and_blkg_get (+1)  <=3D=3D=3D=3D : Note1
> ->bfq_del_bfqq_busy
>  ->bfq_deactivate_entity+0x53/0xc0 [bfq]
>    ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
>      -> bfq_forget_entity(is_in_service =3D true)
> 	 entity->on_st_or_in_serv =3D false   <=3D=3D=3D :Note2
> 	 if (is_in_service)
> 	     return;  =3D=3D> do not touch reference
> -> blkcg_css_offline
> -> blkcg_destroy_blkgs
>  -> blkg_destroy
>   -> bfq_pd_offline
>    -> __bfq_deactivate_entity
>         if (!entity->on_st_or_in_serv) /* true, because (Note2)
> 		return false;
> -> bfq_pd_free
>    -> bfqg_put() (-1, byt bfqg->ref =3D=3D 2) because of (Note2)
> So bfq_group and blkcg_gq  will leak forever, see test-case below.
> If fact bfq_group objects reference counting are quite different
> from bfq_queue. bfq_groups object are referenced by blkcg_gq via
> blkg_policy_data pointer, so  neither nor blkg_get() neither bfqg_get
> required here.
>=20
>=20
> This patch drop commit db37a34c563b ("block, bfq: get a ref to a group =
when adding it to a service tree")
> and add corresponding comment.
>=20
> ##TESTCASE_BEGIN:
> #!/bin/bash
>=20
> max_iters=3D${1:-100}
> #prep cgroup mounts
> mount -t tmpfs cgroup_root /sys/fs/cgroup
> mkdir /sys/fs/cgroup/blkio
> mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>=20
> # Prepare blkdev
> grep blkio /proc/cgroups
> truncate -s 1M img
> losetup /dev/loop0 img
> echo bfq > /sys/block/loop0/queue/scheduler
>=20
> grep blkio /proc/cgroups
> for ((i=3D0;i<max_iters;i++))
> do
>    mkdir -p /sys/fs/cgroup/blkio/a
>    echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
>    dd if=3D/dev/loop0 bs=3D4k count=3D1 of=3D/dev/null iflag=3Ddirect =
2> /dev/null
>    echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
>    rmdir /sys/fs/cgroup/blkio/a
>    grep blkio /proc/cgroups
> done
> ##TESTCASE_END:
>=20
> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
> ---
> block/bfq-cgroup.c  |  2 +-
> block/bfq-iosched.h |  1 -
> block/bfq-wf2q.c    | 15 +++++----------
> 3 files changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 68882b9..b791e20 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
> 		kfree(bfqg);
> }
>=20
> -void bfqg_and_blkg_get(struct bfq_group *bfqg)
> +static void bfqg_and_blkg_get(struct bfq_group *bfqg)
> {
> 	/* see comments in bfq_bic_update_cgroup for why refcounting =
bfqg */
> 	bfqg_get(bfqg);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index cd224aa..7038952 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct =
bfq_data *bfqd,
> struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
> struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
> struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, =
int node);
> -void bfqg_and_blkg_get(struct bfq_group *bfqg);
> void bfqg_and_blkg_put(struct bfq_group *bfqg);
>=20
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 34ad095..6a363bb 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -529,13 +529,14 @@ static void bfq_get_entity(struct bfq_entity =
*entity)
> {
> 	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);
>=20
> +	/* Grab reference only for bfq_queue's objects, bfq_group ones
> +	 * are owned by blkcg_gq
> +	 */
> 	if (bfqq) {
> 		bfqq->ref++;
> 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
> 			     bfqq, bfqq->ref);
> -	} else
> -		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
> -					       entity));
> +	}
> }
>=20
> /**
> @@ -649,14 +650,8 @@ static void bfq_forget_entity(struct =
bfq_service_tree *st,
>=20
> 	entity->on_st_or_in_serv =3D false;
> 	st->wsum -=3D entity->weight;
> -	if (is_in_service)
> -		return;
> -
> -	if (bfqq)
> +	if (bfqq && !is_in_service)
> 		bfq_put_queue(bfqq);
> -	else
> -		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
> -					       entity));
> }
>=20
> /**
> --=20
> 2.7.4
>=20

