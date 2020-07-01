Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D86C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AFC20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMNg22jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGAHFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgGAHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:05:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C98C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:05:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so25678874ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dvUBuTvRieomSCqnJCq8xhXaqV0MYHK0mUXKNMYT7fg=;
        b=ZMNg22jfuWpv9FHjsLcHmAl1n4nnGMwS8YXn4/XRsSjhkWhDqFYthlc8VwYfnobFe0
         7NuOL1C2Q7Jqn6V/3i/diCS7/6kaFbceDtONervucpWDVCF6dbkXc00DO3C38mIHEYrE
         /VbI83vtmfp6O43qQMuCpF1QQ5L4jxByWQF0VRuOtxy7AnsLpo/bocETdiSoIttQ7vIO
         +ApYPvAM2bY6c/KD2nqQ4CIPLNv1na6E6h3XSCayN8ctLqIwCSwcYILnEmJM+Kgr5XtV
         lWGRls5ON69/6fq31hnDpoVdMOATQlGRk6AA6aVGXZ1cVgiJhNQAkrH4VrYQENoEh73T
         daog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dvUBuTvRieomSCqnJCq8xhXaqV0MYHK0mUXKNMYT7fg=;
        b=p7dInz6sQF5HG6AZUZIBLpcYuCwqqw3U12lBO0p+T5GPyGxT7QJX93dPlmef9lF5Il
         t7mbWzSaB9LrwRYl2gjJpAz/q5kU0CI2yBbn103aHB5vu0Z1RdA7M9nCfYCGzgC+mPKk
         4qd0iSk4MCTPBDsNZFEhTF5s+pA/y2Wd9zzdKdMWEVUr8BvGlF1I51JXqBgvHsZcQzt8
         FWKzEAltrZ9zRofjZQEusybP4WcWY4Nf3jC8/XR2uYTTrpLgz3S9hIqric4bGfrGH0Wm
         b3amIs8moH6qlar8vqivwGgkTrMJC9kfMeg6j50ZWC/Z0MOjoMYaQ+C15k3cyNWbiAWc
         xWsw==
X-Gm-Message-State: AOAM532wr/OOB06b8t3M8lz5WWn6HefOpTSmG9HJ3/Ogcm2PJFmnzmUS
        66VVtMfXeNUn0UQ7W2eXcJJv5tDDHIsrdAa9TOI=
X-Google-Smtp-Source: ABdhPJwV5n0TyL60rtFVSJgv1WVFA75LA/7Y+Aomb1kRpVO700ihvwguTRmM/eSrsdaAEArhv7jw1+jQLsLPyUdQed8=
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr5916934ljk.335.1593587103306;
 Wed, 01 Jul 2020 00:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200630005625.2405062-1-daeho43@gmail.com> <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
In-Reply-To: <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 1 Jul 2020 16:04:52 +0900
Message-ID: <CACOAw_wQx5wjdWDX_WFebNS42t=wBuSh_k7oQ4v7abBv80SZXw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add symbolic link to kobject in sysfs
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I want to keep the mount number remaining to the same
number, even if it's re-mounted.
Or we need to keep track of the number being increased whenever it's
remounted. :(

2020=EB=85=84 7=EC=9B=94 1=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:36, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Daeho,
>
> On 2020/6/30 8:56, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a symbolic link to directory of sysfs. It will
> > create a symbolic link such as "mount_0" and "mount_1" to
> > each f2fs mount in the order of mounting filesystem. It will
> > provide easy access to sysfs node even if not knowing the
> > specific device node name like sda19 and dm-3.
>
> Just out of curiosity, if we mount/umount as below:
>
> mount /dev/zram0 /mnt/f2fs0
> mount /dev/zram1 /mnt/f2fs1
> umount /mnt/f2fs0
> mount /dev/zram0 /mnt/f2fs0
>
> Shouldn't sysfs structure be:
> mount_2 -> zram0
> mount_1 -> zram1
> zram0
> zram1
>
> Then we can know zram0 is mounted after zram1?
>
> However the result shows:
> mount_0 -> zram0
> mount_1 -> zram1
> zram0
> zram1
>
> Thanks,
>
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/f2fs.h  |  4 ++++
> >  fs/f2fs/sysfs.c | 31 +++++++++++++++++++++++++++----
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4b28fd42fdbc..7d6c5f8ce16b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1419,6 +1419,8 @@ struct decompress_io_ctx {
> >  #define MAX_COMPRESS_LOG_SIZE                8
> >  #define MAX_COMPRESS_WINDOW_SIZE     ((PAGE_SIZE) << MAX_COMPRESS_LOG_=
SIZE)
> >
> > +#define MOUNT_NAME_SIZE                      20
> > +
> >  struct f2fs_sb_info {
> >       struct super_block *sb;                 /* pointer to VFS super b=
lock */
> >       struct proc_dir_entry *s_proc;          /* proc entry */
> > @@ -1599,6 +1601,8 @@ struct f2fs_sb_info {
> >       /* For sysfs suppport */
> >       struct kobject s_kobj;
> >       struct completion s_kobj_unregister;
> > +     int s_mount_id;
> > +     char s_mount_name[MOUNT_NAME_SIZE];
> >
> >       /* For shrinker support */
> >       struct list_head s_list;
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index ab40e1f89f23..64bbe0b3b830 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -18,6 +18,7 @@
> >  #include <trace/events/f2fs.h>
> >
> >  static struct proc_dir_entry *f2fs_proc_root;
> > +static struct ida f2fs_mount_ida;
> >
> >  /* Sysfs support for f2fs */
> >  enum {
> > @@ -906,6 +907,9 @@ int __init f2fs_init_sysfs(void)
> >       } else {
> >               f2fs_proc_root =3D proc_mkdir("fs/f2fs", NULL);
> >       }
> > +
> > +     ida_init(&f2fs_mount_ida);
> > +
> >       return ret;
> >  }
> >
> > @@ -915,6 +919,7 @@ void f2fs_exit_sysfs(void)
> >       kset_unregister(&f2fs_kset);
> >       remove_proc_entry("fs/f2fs", NULL);
> >       f2fs_proc_root =3D NULL;
> > +     ida_destroy(&f2fs_mount_ida);
> >  }
> >
> >  int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> > @@ -926,12 +931,22 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >       init_completion(&sbi->s_kobj_unregister);
> >       err =3D kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
> >                               "%s", sb->s_id);
> > -     if (err) {
> > -             kobject_put(&sbi->s_kobj);
> > -             wait_for_completion(&sbi->s_kobj_unregister);
> > -             return err;
> > +     if (err)
> > +             goto err1;
> > +
> > +     sbi->s_mount_id =3D ida_simple_get(&f2fs_mount_ida, 0, 0, GFP_KER=
NEL);
> > +     if (sbi->s_mount_id < 0) {
> > +             err =3D sbi->s_mount_id;
> > +             goto err1;
> >       }
> >
> > +     snprintf(sbi->s_mount_name, MOUNT_NAME_SIZE, "mount_%d",
> > +                     sbi->s_mount_id);
> > +     err =3D sysfs_create_link(&f2fs_kset.kobj, &sbi->s_kobj,
> > +                     sbi->s_mount_name);
> > +     if (err)
> > +             goto err2;
> > +
> >       if (f2fs_proc_root)
> >               sbi->s_proc =3D proc_mkdir(sb->s_id, f2fs_proc_root);
> >
> > @@ -946,6 +961,12 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> >                               victim_bits_seq_show, sb);
> >       }
> >       return 0;
> > +err2:
> > +     ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
> > +err1:
> > +     kobject_put(&sbi->s_kobj);
> > +     wait_for_completion(&sbi->s_kobj_unregister);
> > +     return err;
> >  }
> >
> >  void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
> > @@ -957,6 +978,8 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi=
)
> >               remove_proc_entry("victim_bits", sbi->s_proc);
> >               remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
> >       }
> > +     sysfs_remove_link(&f2fs_kset.kobj, sbi->s_mount_name);
> > +     ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
> >       kobject_del(&sbi->s_kobj);
> >       kobject_put(&sbi->s_kobj);
> >  }
> >
