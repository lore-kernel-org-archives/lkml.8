Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1617C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9476D20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGAGgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:36:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgGAGgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:36:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33A915B5D58E87AE5F1F;
        Wed,  1 Jul 2020 14:36:04 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 14:36:03 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add symbolic link to kobject in sysfs
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200630005625.2405062-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
Date:   Wed, 1 Jul 2020 14:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200630005625.2405062-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

On 2020/6/30 8:56, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a symbolic link to directory of sysfs. It will
> create a symbolic link such as "mount_0" and "mount_1" to
> each f2fs mount in the order of mounting filesystem. It will
> provide easy access to sysfs node even if not knowing the
> specific device node name like sda19 and dm-3.

Just out of curiosity, if we mount/umount as below:

mount /dev/zram0 /mnt/f2fs0
mount /dev/zram1 /mnt/f2fs1
umount /mnt/f2fs0
mount /dev/zram0 /mnt/f2fs0

Shouldn't sysfs structure be:
mount_2 -> zram0
mount_1 -> zram1
zram0
zram1

Then we can know zram0 is mounted after zram1?

However the result shows:
mount_0 -> zram0
mount_1 -> zram1
zram0
zram1

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/f2fs.h  |  4 ++++
>  fs/f2fs/sysfs.c | 31 +++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4b28fd42fdbc..7d6c5f8ce16b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1419,6 +1419,8 @@ struct decompress_io_ctx {
>  #define MAX_COMPRESS_LOG_SIZE		8
>  #define MAX_COMPRESS_WINDOW_SIZE	((PAGE_SIZE) << MAX_COMPRESS_LOG_SIZE)
>  
> +#define MOUNT_NAME_SIZE			20
> +
>  struct f2fs_sb_info {
>  	struct super_block *sb;			/* pointer to VFS super block */
>  	struct proc_dir_entry *s_proc;		/* proc entry */
> @@ -1599,6 +1601,8 @@ struct f2fs_sb_info {
>  	/* For sysfs suppport */
>  	struct kobject s_kobj;
>  	struct completion s_kobj_unregister;
> +	int s_mount_id;
> +	char s_mount_name[MOUNT_NAME_SIZE];
>  
>  	/* For shrinker support */
>  	struct list_head s_list;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index ab40e1f89f23..64bbe0b3b830 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -18,6 +18,7 @@
>  #include <trace/events/f2fs.h>
>  
>  static struct proc_dir_entry *f2fs_proc_root;
> +static struct ida f2fs_mount_ida;
>  
>  /* Sysfs support for f2fs */
>  enum {
> @@ -906,6 +907,9 @@ int __init f2fs_init_sysfs(void)
>  	} else {
>  		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
>  	}
> +
> +	ida_init(&f2fs_mount_ida);
> +
>  	return ret;
>  }
>  
> @@ -915,6 +919,7 @@ void f2fs_exit_sysfs(void)
>  	kset_unregister(&f2fs_kset);
>  	remove_proc_entry("fs/f2fs", NULL);
>  	f2fs_proc_root = NULL;
> +	ida_destroy(&f2fs_mount_ida);
>  }
>  
>  int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> @@ -926,12 +931,22 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>  	init_completion(&sbi->s_kobj_unregister);
>  	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
>  				"%s", sb->s_id);
> -	if (err) {
> -		kobject_put(&sbi->s_kobj);
> -		wait_for_completion(&sbi->s_kobj_unregister);
> -		return err;
> +	if (err)
> +		goto err1;
> +
> +	sbi->s_mount_id = ida_simple_get(&f2fs_mount_ida, 0, 0, GFP_KERNEL);
> +	if (sbi->s_mount_id < 0) {
> +		err = sbi->s_mount_id;
> +		goto err1;
>  	}
>  
> +	snprintf(sbi->s_mount_name, MOUNT_NAME_SIZE, "mount_%d",
> +			sbi->s_mount_id);
> +	err = sysfs_create_link(&f2fs_kset.kobj, &sbi->s_kobj,
> +			sbi->s_mount_name);
> +	if (err)
> +		goto err2;
> +
>  	if (f2fs_proc_root)
>  		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
>  
> @@ -946,6 +961,12 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>  				victim_bits_seq_show, sb);
>  	}
>  	return 0;
> +err2:
> +	ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
> +err1:
> +	kobject_put(&sbi->s_kobj);
> +	wait_for_completion(&sbi->s_kobj_unregister);
> +	return err;
>  }
>  
>  void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
> @@ -957,6 +978,8 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>  		remove_proc_entry("victim_bits", sbi->s_proc);
>  		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>  	}
> +	sysfs_remove_link(&f2fs_kset.kobj, sbi->s_mount_name);
> +	ida_simple_remove(&f2fs_mount_ida, sbi->s_mount_id);
>  	kobject_del(&sbi->s_kobj);
>  	kobject_put(&sbi->s_kobj);
>  }
> 
