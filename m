Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F80C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB10C20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBCFTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:19:36 -0500
Received: from mail-oln040092254087.outbound.protection.outlook.com ([40.92.254.87]:6315
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgBCFTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:19:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqIaAGFex6xSOHLS34JcvU+4O4wYTkSiuQ26iQrAQIcwCT7xvRN5G474zku0uFCLLtAtdvsEfJcvFf31GmojTeTKWNtZ+IzZeMl/HDXetPRONhfIsSEcBc4q3yKvtpVMM5le4OIi9OM4SfkG3Z/rveYDClOtQjF/f+f82+bXL/q0f8F+vTALM+W6TOo+Bq898cmxugKlXzQl10WTNm/SFTAKVjfd2NGqxce61YViv5OBXM+HEEWODnMP2ABRohpATyz9Gs7ID8y/TonZyCFSr9SPC6eS7tf9UN/FutPs6TYxhSRh1CkpglCQ8oPyIf/Qi+7lrYaqNyZJWVoMWC5JsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvh2yG4clWkAxsyCqYMPPlaUEAJaPMDA8mCVCk0Jz7c=;
 b=D+ITAotcV2DmpH5BXvHNbF9s8lZraOCbESMicZB+2/82tuZCOo5dijtVsQSEyO8iHokZBF5hYc05Z4v+n0GuVS/L8MXdFHDKO3oLNyFKJtHRScVsfH7gPRceXukv5QLk3LxSvFM//0teKF6GGLFCtegCGWHEuoEWpIufHmj3HwkyoYkmM74CeWi3c3no3iS8kL4af8XvfkyUuWPyVoVbIwGBYlPxxEBNEjDcfPGPayUNtdhqQ6eHVI3OnOWDAaECJeOhpTc4ADVwE7hur10miQ7YP9b/ZulGzEKf/uP2WZ5Av1awnXOx2163QySFrzacZNY/9Q8EhCHSNwzY+SsVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.cn; dmarc=pass action=none header.from=live.cn; dkim=pass
 header.d=live.cn; arc=none
Received: from PU1APC01FT026.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::38) by
 PU1APC01HT109.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::286)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.25; Mon, 3 Feb
 2020 05:19:30 +0000
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com (10.152.252.56) by
 PU1APC01FT026.mail.protection.outlook.com (10.152.252.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.25 via Frontend Transport; Mon, 3 Feb 2020 05:19:30 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3728DC8EAE5FA66CDFA56E9E30CD9ABA8DB1C45788CB2412F3B57C7E15EB2856;UpperCasedChecksum:8C4A5CA75E511C2FBB62146B002089E37EC0156D661038795B823C2B97B1E6CF;SizeAsReceived:9171;Count:49
Received: from HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::2cb7:1e4d:61c1:6fb1]) by HK0PR02MB3780.apcprd02.prod.outlook.com
 ([fe80::2cb7:1e4d:61c1:6fb1%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 05:19:30 +0000
Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file
To:     Gang He <GHe@suse.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Shuning Zhang <sunny.s.zhang@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200121050153.13290-1-ghe@suse.com>
 <CH2PR18MB3206F418382332EB25130477CF000@CH2PR18MB3206.namprd18.prod.outlook.com>
From:   Changwei Ge <gechangwei@live.cn>
Message-ID: <HK0PR02MB378058FC927798C4DCF574B2D5000@HK0PR02MB3780.apcprd02.prod.outlook.com>
Date:   Mon, 3 Feb 2020 13:19:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
In-Reply-To: <CH2PR18MB3206F418382332EB25130477CF000@CH2PR18MB3206.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To HK0PR02MB3780.apcprd02.prod.outlook.com
 (2603:1096:203:9c::13)
X-Microsoft-Original-Message-ID: <351b57b3-41ad-6e6a-ab8d-b3df3795bbdb@live.cn>
MIME-Version: 1.0
Received: from IT-C02YD3Q7JG5H.local (101.204.31.21) by HK2PR0302CA0009.apcprd03.prod.outlook.com (2603:1096:202::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.12 via Frontend Transport; Mon, 3 Feb 2020 05:19:28 +0000
X-Microsoft-Original-Message-ID: <351b57b3-41ad-6e6a-ab8d-b3df3795bbdb@live.cn>
X-TMN:  [ykZsVzNLTOpOXHeI+SBbgfoMuEs8oFln]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 3bbb2890-8690-436f-ecac-08d7a868a491
X-MS-TrafficTypeDiagnostic: PU1APC01HT109:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqhju6H5fAaJy2qvZvQLi0hQvqdUoTlk+Yhz4i8qmpqRQYFkAaH9JUK6eB7wuzYh+iqQ5jPz+xdIOVv+M7zVDkHnq1CnYZawEUunSzvkIowBcQAd3JDWeZ2RI9Ven7ns8cwzchwqvEuoJw74j/PcWAn0u4pa5CZRwGqXRbOLcbpk67pcrC/K6csA6DNyWRQ3
X-MS-Exchange-AntiSpam-MessageData: YFGgYGdVw2qUkcy4ftuPhgj3cFgZ5ObIyJy227hyc7BmX9csWUjQqBoZyh6BaJShfWRnL0uF8LWywAi1eIQ7jncBk7vdtge6JOVAApZ2froDAe/0d/rFynf2t1F3pJJnlRWNcZKzVrdKuXMALX0b2w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbb2890-8690-436f-ecac-08d7a868a491
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 05:19:30.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. I will try to allocate some time for this change.

     - Changwei

On 2/3/20 10:17 AM, Gang He wrote:
> Hello Joseph, Changwei, Sunny and all,
>
> Could you help to review this patch?
> This patch will fix the oops problem caused by write ocfs2 clone files.
> The root cause is inode buffer head is NULL when calling ocfs2_refcount_cow.
> Secondly, we should use EX meta lock when calling ocfs2_refcount_cow.
>
> Thanks a lot.
> Gang
>
> ________________________________________
> From: Gang He <GHe@suse.com>
> Sent: Tuesday, January 21, 2020 1:02 PM
> To: mark@fasheh.com; jlbec@evilplan.org; joseph.qi@linux.alibaba.com
> Cc: Gang He; linux-kernel@vger.kernel.org; ocfs2-devel@oss.oracle.com; akpm@linux-foundation.org
> Subject: [PATCH] ocfs2: fix the oops problem when write cloned file
>
> Writing a cloned file triggers a kernel oops and the user-space
> command process is also killed by the system.
> The bug can be reproduced stably, e.g.
> 1)create a file under ocfs2 file system directory.
>    journalctl -b > aa.txt
> 2)create a cloned file for this file.
>    reflink aa.txt bb.txt
> 3)write the cloned file with dd command.
>    dd if=/dev/zero of=bb.txt bs=512 count=1 conv=notrunc
>
> The dd command is killed by the kernel, then you can see the oops
> message via dmesg command.
>
> [  463.875404] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [  463.875413] #PF: supervisor read access in kernel mode
> [  463.875416] #PF: error_code(0x0000) - not-present page
> [  463.875418] PGD 0 P4D 0
> [  463.875425] Oops: 0000 [#1] SMP PTI
> [  463.875431] CPU: 1 PID: 2291 Comm: dd Tainted: G           OE     5.3.16-2-default
> [  463.875433] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [  463.875500] RIP: 0010:ocfs2_refcount_cow+0xa4/0x5d0 [ocfs2]
> [  463.875505] Code: 06 89 6c 24 38 89 eb f6 44 24 3c 02 74 be 49 8b 47 28
> [  463.875508] RSP: 0018:ffffa2cb409dfce8 EFLAGS: 00010202
> [  463.875512] RAX: ffff8b1ebdca8000 RBX: 0000000000000001 RCX: ffff8b1eb73a9df0
> [  463.875515] RDX: 0000000000056a01 RSI: 0000000000000000 RDI: 0000000000000000
> [  463.875517] RBP: 0000000000000001 R08: ffff8b1eb73a9de0 R09: 0000000000000000
> [  463.875520] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [  463.875522] R13: ffff8b1eb922f048 R14: 0000000000000000 R15: ffff8b1eb922f048
> [  463.875526] FS:  00007f8f44d15540(0000) GS:ffff8b1ebeb00000(0000) knlGS:0000000000000000
> [  463.875529] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  463.875532] CR2: 0000000000000028 CR3: 000000003c17a000 CR4: 00000000000006e0
> [  463.875546] Call Trace:
> [  463.875596]  ? ocfs2_inode_lock_full_nested+0x18b/0x960 [ocfs2]
> [  463.875648]  ocfs2_file_write_iter+0xaf8/0xc70 [ocfs2]
> [  463.875672]  new_sync_write+0x12d/0x1d0
> [  463.875688]  vfs_write+0xad/0x1a0
> [  463.875697]  ksys_write+0xa1/0xe0
> [  463.875710]  do_syscall_64+0x60/0x1f0
> [  463.875743]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  463.875758] RIP: 0033:0x7f8f4482ed44
> [  463.875762] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00
> [  463.875765] RSP: 002b:00007fff300a79d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  463.875769] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8f4482ed44
> [  463.875771] RDX: 0000000000000200 RSI: 000055f771b5c000 RDI: 0000000000000001
> [  463.875774] RBP: 0000000000000200 R08: 00007f8f44af9c78 R09: 0000000000000003
> [  463.875776] R10: 000000000000089f R11: 0000000000000246 R12: 000055f771b5c000
> [  463.875779] R13: 0000000000000200 R14: 0000000000000000 R15: 000055f771b5c000
>
> This regression problem was introduced by commit e74540b28556 ("ocfs2:
> protect extent tree in ocfs2_prepare_inode_for_write()").
>
> Fixes: e74540b28556 ("ocfs2: protect extent tree in ocfs2_prepare_inode_for_write()").
> Signed-off-by: Gang He <ghe@suse.com>
> ---
>   fs/ocfs2/file.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 9876db52913a..6cd5e4924e4d 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2101,17 +2101,15 @@ static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
>   static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
>                                              struct buffer_head **di_bh,
>                                              int meta_level,
> -                                           int overwrite_io,
>                                              int write_sem,
>                                              int wait)
>   {
>          int ret = 0;
>
>          if (wait)
> -               ret = ocfs2_inode_lock(inode, NULL, meta_level);
> +               ret = ocfs2_inode_lock(inode, di_bh, meta_level);
>          else
> -               ret = ocfs2_try_inode_lock(inode,
> -                       overwrite_io ? NULL : di_bh, meta_level);
> +               ret = ocfs2_try_inode_lock(inode, di_bh, meta_level);
>          if (ret < 0)
>                  goto out;
>
> @@ -2136,6 +2134,7 @@ static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
>
>   out_unlock:
>          brelse(*di_bh);
> +       *di_bh = NULL;
>          ocfs2_inode_unlock(inode, meta_level);
>   out:
>          return ret;
> @@ -2177,7 +2176,6 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
>                  ret = ocfs2_inode_lock_for_extent_tree(inode,
>                                                         &di_bh,
>                                                         meta_level,
> -                                                      overwrite_io,
>                                                         write_sem,
>                                                         wait);
>                  if (ret < 0) {
> @@ -2233,13 +2231,13 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
>                                                             &di_bh,
>                                                             meta_level,
>                                                             write_sem);
> +                       meta_level = 1;
> +                       write_sem = 1;
>                          ret = ocfs2_inode_lock_for_extent_tree(inode,
>                                                                 &di_bh,
>                                                                 meta_level,
> -                                                              overwrite_io,
> -                                                              1,
> +                                                              write_sem,
>                                                                 wait);
> -                       write_sem = 1;
>                          if (ret < 0) {
>                                  if (ret != -EAGAIN)
>                                          mlog_errno(ret);
> --
> 2.12.3
>
