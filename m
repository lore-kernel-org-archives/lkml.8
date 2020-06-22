Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3797E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="PFej7IpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFVIrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:47:18 -0400
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:51001
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgFVIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcnbg2I5idj0BKNb65Na2FRtAcL5gQjjC+7azjuFHToZf+FuQ26+wce/8Is2vSTins0njprZA17dQUbDb8RizHds/HoRTFp56sVTbAzHwjKCacRs/JXdj0xkDyWrUOJQVkzm+aPGVEWLy0Y6dCQf0qnlbkKks/xPoPo3AT4LTv1XwZhdIibsGkkpHtiNTtMFI2ZLT2i4205NjzUt30WpqX78reb4+UeqgAOYe6iXJ23GXqTVzc4z2R/5J0OfazAWkE8ScrR6YEJQ7RNeTkqdLZo4juHjvkuxB/a8ih2zjkSEQ7pPLKW6x6VeK1WEGVKZkJeMHgwJ94rLeBfhSOK6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgtXyPGpZJVjj7RNDIwPlbWeqPvVeSWpVTBWm1Y9T1g=;
 b=UTCRDI6pznphf89bDHxG8rXNvqeJKCdDbwV9Ihl0ay8p+U9GKbyWLX7MgcpYwq5c7nD7TctVmJq2CtfoGkslkcy8bbJeZbp3scC6WT57nL29o4E+ZKZNm0uXPNkrRm2fYa6LypuIdXVrN7NWQ75UxKj0wn1V2PwIQvv6d66KcNFC35maanVu+iJcyNvFxeJMErssGvsSnkxVQ29v6EBk9FzsbgeVIppg+rCy9e1KoX8Ki1L4ZG45rPROEV0/BmgsfKNAStGdRwV3uPYWWrpcMmNM4PbLADf1Xkpg1lHIx9HB4+5F2PBKon9HgiQ/dJcyySIgA5WThUtoXgSy8j9yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgtXyPGpZJVjj7RNDIwPlbWeqPvVeSWpVTBWm1Y9T1g=;
 b=PFej7IpXlepE0+rTw/WhcbpI9Px7RPOsflKHcE0pfk1wh6LoroJXWqRS/0hVwBsphK2dj28CWP5fk6HUCRgjFG5RBYhrCo79LCKPtzb70CN0YnJ6r5gEFr8U805LE1lFUif3AmcVAx7uGFpc35aaysGIB8gBRj7t6jBy2w3aF94=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3110.namprd11.prod.outlook.com (2603:10b6:a03:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 08:47:13 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 08:47:12 +0000
Subject: Re: [PATCH] usb: gadget: function: printer: fix use-after-free in
 __lock_acquire
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200605035652.10387-1-qiang.zhang@windriver.com>
 <20200618083001.GB1058534@kroah.com>
From:   "Zhang,Qiang" <qiang.zhang@windriver.com>
Message-ID: <1726a93f-29a7-3bb8-b17e-c8ed4593e7d9@windriver.com>
Date:   Mon, 22 Jun 2020 16:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200618083001.GB1058534@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 08:47:10 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f34db1c-37ac-4f60-e9b6-08d81688db68
X-MS-TrafficTypeDiagnostic: BYAPR11MB3110:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3110E37956DE7C8A7AB8558CFF970@BYAPR11MB3110.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGqkLJsDoRXH+NkD6Bw7aPDQZ5IBn+yHCR9r5k8NAfrzL1dI9i2uOQ3FyEd5E9godoeqTAQTt5HThLGrfEXcEFwDR26AKHKqjJ+lTrKydRq5N7P+mfcUq1QA1EwSXQUeTgS4eK17Cau6xCyol1igBirO54qnBu2YKSKMbvwcbSrGokPECb4YNGlQL1Pb2iI+dKLoj3N/cqXyOIKhJQAN2jsBcM4T5frha20zEQVcENt+4FkQU/HxjmIxExlkjQXQH+rTSETD5hDbMLZJGf51KHlH038+T9iRVmtfE8jPRY7vtVUwhse6yxVBw/wNEgkQRF7oTLfKJPQZ6CSq19GYXj+WnO24Yb5/RKuKmofDLC+TC+ERqQlODEc9dQKympYr2X6s5mPv6iUW3fJ0IMxryq4kXr1pZxPi3RrIISJKH6zBdkl7FaVAm6bxuCnt+OnN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(346002)(366004)(39840400004)(5660300002)(478600001)(66556008)(6706004)(6666004)(6916009)(66946007)(66476007)(2906002)(83380400001)(8676002)(36756003)(2616005)(6486002)(31686004)(8936002)(52116002)(956004)(4326008)(31696002)(316002)(16576012)(53546011)(86362001)(16526019)(186003)(26005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ht5JpsCDFwacewXx4L2lXC+gxq5mmgWM4+25VkkOeHYf5yz61XrLTcsHKT8mrNBM5aePflqM30570ouf87ihdf0lsl5Sm3cHJ5GhHjY0qqTA85deK4nfS4NpK7GnGpFqaru3MivCPIQcApuQMqKxD3kZDejCQyRBkm5BNjcRlUwhqV4j2KDtDOqdq2w8o9C954QHgMMxLKCZdl2CrwP9+oYiTVG/xuOF0/T57fblMVN09EdQc+drBtx7l/65g9fptVbucpf7C1/x39IX6tZX0bblHJbgKJ6SFgV/taBf8DDD8jIv8YAg94h5Ale8aQaGA+ENCDNNoLSbcb/ErDKC70Hq/mWl6QNwSZIcGY/xHJssenRmAOP8Q7GjBcUCpF7ikAvC2CrH+L3kSa4N83m3rMn0igtBoe1Ifs3IOAjLHfy6tI0q3hU5WFVFY8AvebOTtEPFx/wrvu/NqNo2jXu294MjH9Y/zG7GNB7noq/z3Vw=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34db1c-37ac-4f60-e9b6-08d81688db68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 08:47:12.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD5XbocnmKRJMmYD9gnKpe5H5afWeA/3O3bN+Kh+CnawZtZFyKPGH5MOFWj0ZpAAGz7gtaLp++yRvCgMVJKQcfTpv69OeacDw6TJ6Fj4wRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot find a reference count for this structure(printer_dev).
In this scenario:
When the Character device is still open, if you operate the device 
through configfs and execute commands like unlink, the resources 
allocated when the device is bound will be released(printer_dev). After 
that, if you perform ioctl operation again, it will appear 
use-after-free. add kref to show that this resource(printer_dev) will 
also use,
until this character device is close.

Similar problems can occur in f_hid.c.

As for the other gadget drivers, I haven't seen their logical 
implementation,so I'm not sure

thanks,
Zqiang

On 6/18/20 4:30 PM, Greg KH wrote:
> On Fri, Jun 05, 2020 at 11:56:52AM +0800, qiang.zhang@windriver.com wrote:
>> From: Zqiang <qiang.zhang@windriver.com>
>>
>> Fix this by increase object reference count.
>>
>> BUG: KASAN: use-after-free in __lock_acquire+0x3fd4/0x4180
>> kernel/locking/lockdep.c:3831
>> Read of size 8 at addr ffff8880683b0018 by task syz-executor.0/3377
>>
>> CPU: 1 PID: 3377 Comm: syz-executor.0 Not tainted 5.6.11 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0xce/0x128 lib/dump_stack.c:118
>>   print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
>>   __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
>>   kasan_report+0x12/0x20 mm/kasan/common.c:641
>>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>>   __lock_acquire+0x3fd4/0x4180 kernel/locking/lockdep.c:3831
>>   lock_acquire+0x127/0x350 kernel/locking/lockdep.c:4488
>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>   _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
>>   printer_ioctl+0x4a/0x110 drivers/usb/gadget/function/f_printer.c:723
>>   vfs_ioctl fs/ioctl.c:47 [inline]
>>   ksys_ioctl+0xfb/0x130 fs/ioctl.c:763
>>   __do_sys_ioctl fs/ioctl.c:772 [inline]
>>   __se_sys_ioctl fs/ioctl.c:770 [inline]
>>   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
>>   do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x4531a9
>> Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007fd14ad72c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 000000000073bfa8 RCX: 00000000004531a9
>> RDX: fffffffffffffff9 RSI: 000000000000009e RDI: 0000000000000003
>> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bbd61
>> R13: 00000000004d0a98 R14: 00007fd14ad736d4 R15: 00000000ffffffff
>>
>> Allocated by task 2393:
>>   save_stack+0x21/0x90 mm/kasan/common.c:72
>>   set_track mm/kasan/common.c:80 [inline]
>>   __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:515
>>   kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
>>   kmem_cache_alloc_trace+0xfa/0x2d0 mm/slub.c:2813
>>   kmalloc include/linux/slab.h:555 [inline]
>>   kzalloc include/linux/slab.h:669 [inline]
>>   gprinter_alloc+0xa1/0x870 drivers/usb/gadget/function/f_printer.c:1416
>>   usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
>>   config_usb_cfg_link+0x1ed/0x3e0 drivers/usb/gadget/configfs.c:444
>>   configfs_symlink+0x527/0x11d0 fs/configfs/symlink.c:202
>>   vfs_symlink+0x33d/0x5b0 fs/namei.c:4201
>>   do_symlinkat+0x11b/0x1d0 fs/namei.c:4228
>>   __do_sys_symlinkat fs/namei.c:4242 [inline]
>>   __se_sys_symlinkat fs/namei.c:4239 [inline]
>>   __x64_sys_symlinkat+0x73/0xb0 fs/namei.c:4239
>>   do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 3368:
>>   save_stack+0x21/0x90 mm/kasan/common.c:72
>>   set_track mm/kasan/common.c:80 [inline]
>>   kasan_set_free_info mm/kasan/common.c:337 [inline]
>>   __kasan_slab_free+0x135/0x190 mm/kasan/common.c:476
>>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
>>   slab_free_hook mm/slub.c:1444 [inline]
>>   slab_free_freelist_hook mm/slub.c:1477 [inline]
>>   slab_free mm/slub.c:3034 [inline]
>>   kfree+0xf7/0x410 mm/slub.c:3995
>>   gprinter_free+0x49/0xd0 drivers/usb/gadget/function/f_printer.c:1353
>>   usb_put_function+0x38/0x50 drivers/usb/gadget/functions.c:87
>>   config_usb_cfg_unlink+0x2db/0x3b0 drivers/usb/gadget/configfs.c:485
>>   configfs_unlink+0x3b9/0x7f0 fs/configfs/symlink.c:250
>>   vfs_unlink+0x287/0x570 fs/namei.c:4073
>>   do_unlinkat+0x4f9/0x620 fs/namei.c:4137
>>   __do_sys_unlink fs/namei.c:4184 [inline]
>>   __se_sys_unlink fs/namei.c:4182 [inline]
>>   __x64_sys_unlink+0x42/0x50 fs/namei.c:4182
>>   do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff8880683b0000
>>   which belongs to the cache kmalloc-1k of size 1024
>> The buggy address is located 24 bytes inside of
>>   1024-byte region [ffff8880683b0000, ffff8880683b0400)
>> The buggy address belongs to the page:
>> page:ffffea0001a0ec00 refcount:1 mapcount:0 mapping:ffff88806c00e300
>> index:0xffff8880683b1800 compound_mapcount: 0
>> flags: 0x100000000010200(slab|head)
>> raw: 0100000000010200 0000000000000000 0000000600000001 ffff88806c00e300
>> raw: ffff8880683b1800 000000008010000a 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Reported-by: Kyungtae Kim <kt0755@gmail.com>
>> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
>> ---
>>   drivers/usb/gadget/function/f_printer.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
>> index 9c7ed2539ff7..8ed1295d7e35 100644
>> --- a/drivers/usb/gadget/function/f_printer.c
>> +++ b/drivers/usb/gadget/function/f_printer.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/types.h>
>>   #include <linux/ctype.h>
>>   #include <linux/cdev.h>
>> +#include <linux/kref.h>
>>   
>>   #include <asm/byteorder.h>
>>   #include <linux/io.h>
>> @@ -64,7 +65,7 @@ struct printer_dev {
>>   	struct usb_gadget	*gadget;
>>   	s8			interface;
>>   	struct usb_ep		*in_ep, *out_ep;
>> -
>> +	struct kref             kref;
>>   	struct list_head	rx_reqs;	/* List of free RX structs */
>>   	struct list_head	rx_reqs_active;	/* List of Active RX xfers */
>>   	struct list_head	rx_buffers;	/* List of completed xfers */
> 
> Isn't there already a reference count for this structure?  Why not use
> that instead?
> 
> If not, should this be done to all gadget drivers?  What makes this one
> unique?
> 
> thanks,
> 
> greg k-h
> 
