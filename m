Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C6B206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mETV3ciC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="b1sHy1Cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgFWRfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733173AbgFWRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05NHKVPa021174;
        Tue, 23 Jun 2020 10:35:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7zcEplS6mlqNp5G7fa76khh4XsD1AmQQTRanJ+eCBnA=;
 b=mETV3ciC+z1vynIWqq3+pXDMSKYjZenogpqH+mtDH4Q8TIUfRS6brXoilacVofWU5arW
 wrYqiUnDYOenKHYTWF9cLxu1rQseCeiZvaDVCaLvR5rhZ5DQtpMcKquXXby+cENBku+r
 me+tf8Kz6rm2DWMp3BGkC7IcwDf2Kn0PBQY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31uk1y94bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 10:35:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQF3+82PjsJWktwD4pGniq3AXlnam++2aJAyR3/jJi14MXYPykeDjWCplO3E5+jwmnlAoL5vDmnbZGeBEaur1klhMLjc7eVjFJvp1ZuycyKzG/ia7Eqk4aCHlzqSxjdRymZIdLlNVWB7woTcuSwNDRh84PV/McYyojNrpXzKyXr54KI70duuOwVxgQ22VOhy1pGUIVAqRsoqJnxoWp0wKBqr+Vquoh6mdJBANvwzW6aOPwz6SVOjhiyj5Z35Xqb7f2slHglyz6RY1uGG0tcifIimi3ZSQ+ACVfZXxnkgLxlZj6Qv8SohmUp+H/Ts8NHLys5UXHW2LuM00FvzA/OusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zcEplS6mlqNp5G7fa76khh4XsD1AmQQTRanJ+eCBnA=;
 b=QLgfUouQN8ADbbKz7rBhbhkvvUAAcNDSCfZNwNgc0o1ldc7d9wCCZciAPGWupUfOVCIau2qAATRiOzunIGN86iYH7OaLex4ANdrluaHuG4LDr1J/uyijVTYI7mVP/dJnxJ+A9lE04nzmlrT5hA9vRr0QsVgQrFOJslPwB/aUtRfCdlQi18wkvf0p60D7Ve27MkqSRPmioVqITEyeiWuxL8bDpLLVG54wT8V8IOa/PHCXTRy9WH3Oz7D1F3mXFFtDcJisvPmmBHTGOp8x0PQgGWDd5VEeAlnNuA8XLQVEwFl9pyAxpMyT86loVCkVtJPPmgM2T2FdgXIdI219Jtc0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zcEplS6mlqNp5G7fa76khh4XsD1AmQQTRanJ+eCBnA=;
 b=b1sHy1CbdbfLVZg58LyvNtyKW8zXxVJEm5upBuif0NouS9iTmhNkdT/V8H2xCc3zuRKLgb8BC0vlBMbwV10whgsedbYLu6KM8IRkra98WqHQ62RS1ipUIvlc0me5Ew7xN8xPTmw2oWxs4g/cQNZwvVMpjpr4WoIBWP17KqULwNU=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 17:35:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 17:35:04 +0000
Date:   Tue, 23 Jun 2020 10:35:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>
Subject: Re: [mm, slab/slub] 7b39adbb1b: WARNING:at_mm/slab.h:#kmem_cache_free
Message-ID: <20200623173501.GC345679@carbon.dhcp.thefacebook.com>
References: <20200623090213.GW5535@shao2-debian>
 <d6e6b64c-2870-1fbb-bca2-a27732af1ec3@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e6b64c-2870-1fbb-bca2-a27732af1ec3@suse.cz>
X-ClientProxiedBy: BYAPR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:161f) by BYAPR06CA0037.namprd06.prod.outlook.com (2603:10b6:a03:14b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 17:35:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:161f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd28ab8-63b7-446c-cbad-08d8179bc3c9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22796A3FA2B839A2CF676DD3BE940@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhwcgdeChA13ZK4Lvifq7xZj20A91AM/JksMqkgWPJ1sQW3wxNBkGPkd2W9dgb7SrchJ/0+BX2hkOtuTfDdtrXfhOu3P20bDnxAIiE20Uhj1Vmo+sa4r0Pwpf5llqANWrO9WXJm5sGZzI2i58Yads7/5GZlebsUGVNuNu2AJ7P8/t6eaH5P98hkw3BxMIoKUWBZkMztKLsn88x+o1r1q+fskfEEuB/F08r4LwpbSMYM+8AlIMVK/gq+COnU+KfOTS6QBLpjnynY1cq8iyPfigO7uYs7xOlPQt2LTOAzl28b0kr5ix90YYfwV1Gf+OH9kVmcohLM2R77IOxA6y63wQTcPC7M05rHTtYeePBO+fQc+dc8W5nsFLU9T1mGW743NW5q1hyhPfw5WLvtiMKocoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(7416002)(478600001)(5660300002)(66946007)(66476007)(66556008)(33656002)(6916009)(316002)(4326008)(966005)(9686003)(45080400002)(55016002)(86362001)(186003)(54906003)(8676002)(8936002)(2906002)(16526019)(1076003)(53546011)(6506007)(83380400001)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gX/L5nfxQp4yaf2RQrSS/03klN+55ruCMXKT3lurh9+YlxCzVCLjPl8evCprz/ZwNhIrsbw5HdLO6OitkCd3s0GOU5be72OKnV0h5SQegJmBdONCBwoBQjwqsiZ+oeMYribaNr9W9k0lq+2nChqOF8pVQ7x2auHqktmZJR9STLvz3Wp6Po4UAEbdy+GxmY1+4NPQxcJ6S2XP9HkKpbxC4jYL8YEa1sWjS8bmmewdLwsoq3lBr8GMxd9sOjG5eJ6HJJdS2MTKi2HC9OBzku9cP8nnGxsX6NjfqZaL0NKNo2hTPxiX0K6SjX/gCAy839iqXbdL2OM8a5myWtvo131Y2YAe9u9g5Mz1iJJYYp9usvnOCnqoVa/DIxYM+GldVWjLFpPfng9uteSvBRE4Unj4/rbxa3OVkyyF0EaggBi2RmzH7VP5bs0JCBQdbOec7NrYYanTrlIJcNPhd6qxie+fSoY9iyUYF7vOXpwcwKH36kApf7TaKJfjr6hKLv6tW9YHTQORTFbZcsYJzaUHSnFP7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd28ab8-63b7-446c-cbad-08d8179bc3c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:35:04.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APqCTepnRuUfL5u/vmyL/vRgAHv7wvcSA34c6VXl93fV9Y4fI/QHU73qNVDtapjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 mlxlogscore=947 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:35:21PM +0200, Vlastimil Babka wrote:
> On 6/23/20 11:02 AM, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-6):
> > 
> > commit: 7b39adbb1b1d3e73df9066a8d1e93a83c18d7730 ("mm, slab/slub: improve error reporting and overhead of cache_from_obj()")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +--------------------------------------------------------+------------+------------+
> > |                                                        | 5a2a0a5f04 | 7b39adbb1b |
> > +--------------------------------------------------------+------------+------------+
> > | boot_successes                                         | 4          | 0          |
> > | boot_failures                                          | 4          | 8          |
> > | WARNING:at_kernel/trace/trace.c:#trace_find_next_entry | 4          | 4          |
> > | EIP:trace_find_next_entry                              | 4          | 4          |
> > | WARNING:at_mm/slab.h:#kmem_cache_free                  | 0          | 8          |
> > | EIP:kmem_cache_free                                    | 0          | 8          |
> > +--------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [    3.251054] WARNING: CPU: 0 PID: 8 at mm/slab.h:298 kmem_cache_free+0x5/0x170
> 
> So this is due to the latest fixups.
> 
> Roman suggested VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS)); which triggered here.
> For Kees, the cache_from_obj() is again shared between SLAB and SLUB and is
> testing kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS).
> 
> However under CONFIG_SLAB, SLAB_DEBUG_FLAGS doesn't include SLAB_CONSISTENCY_CHECKS.
> 
> I think I'll need to move the VM_WARN_ON_ONCE() under #ifdef CONFIG_SLUB ?

Or just add SLAB_CONSISTENCY_CHECKS to SLAB's SLAB_DEBUG_FLAGS?

I'm fine with moving VM_WARN_ON_ONCE() too.

Thanks!


> 
> > [    3.251054] Modules linked in:
> > [    3.251054] CPU: 0 PID: 8 Comm: kdevtmpfs Not tainted 5.8.0-rc1-00277-g7b39adbb1b1d3 #1
> > [    3.251054] EIP: kmem_cache_free+0x5/0x170
> > [    3.251054] Code: 9f 8c 89 f8 e8 cc 58 fd ff 0f 0b 8d 78 ff e9 77 ff ff ff e8 2d d3 90 00 8d b4 26 00 00 00 00 8d b6 00 00 00 00 66 66 66 66 90 <0f> 0b 85 c0 0f 84 a6 00 00 00 8b 0d 64 50 b7 8c 85 c9 0f 84 33 01
> > [    3.251054] EAX: 80090780 EBX: 802b4000 ECX: 00000000 EDX: 802b4000
> > [    3.251054] ESI: 802b4000 EDI: 80305e04 EBP: 80305df4 ESP: 80305dec
> > [    3.251054] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> > [    3.251054] CR0: 80050033 CR2: ffffffff CR3: 0ceb2000 CR4: 000406b0
> > [    3.251054] Call Trace:
> > [    3.251054]  ? putname+0x5c/0x60
> > [    3.251054]  filename_lookup+0xde/0x1a0
> > [    3.251054]  ? rcu_read_lock_sched_held+0x20/0x50
> > [    3.251054]  ? strncpy_from_user+0x21/0x1a0
> > [    3.251054]  user_path_at_empty+0x2a/0x40
> > [    3.251054]  do_mount+0x5d/0x9b0
> > [    3.251054]  devtmpfsd+0x69/0x2c0
> > [    3.251054]  ? sched_clock_cpu+0x44/0xc0
> > [    3.251054]  ? _raw_spin_unlock_irqrestore+0x2a/0x72
> > [    3.251054]  ? trace_hardirqs_on+0xbf/0x270
> > [    3.251054]  ? __kthread_parkme+0x5a/0x80
> > [    3.251054]  kthread+0xf0/0x120
> > [    3.251054]  ? public_dev_mount+0x40/0x40
> > [    3.251054]  ? kthread_create_worker_on_cpu+0x20/0x20
> > [    3.251054]  ret_from_fork+0x19/0x30
> > [    3.251054] irq event stamp: 41
> > [    3.251054] hardirqs last  enabled at (41): [<8ba11885>] set_root+0x95/0x190
> > [    3.251054] hardirqs last disabled at (40): [<8ba11856>] set_root+0x66/0x190
> > [    3.251054] softirqs last  enabled at (0): [<8b87027b>] copy_process+0x3eb/0x15b0
> > [    3.251054] softirqs last disabled at (0): [<00000000>] 0x0
> > [    3.251054] ---[ end trace e72be312a52f9020 ]---
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.8.0-rc1-00277-g7b39adbb1b1d3 .config
> > 	make HOSTCC=gcc-6 CC=gcc-6 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > 
> > 
> > 
> > Thanks,
> > Rong Chen
> > 
> 
