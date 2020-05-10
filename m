Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FAAC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1720820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9b3L/es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgEJIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:31:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEJIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:31:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04A8U11e092843;
        Sun, 10 May 2020 08:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Atqumdmal45VYZmqMthcZVoeOgj6oQR4wyqpkYwrhTo=;
 b=d9b3L/esn51vhz9PBkwpIJvwfMIDdoZF38eR3aA0uxQ2jUUgUyMTqzgqzhTt/djoWitT
 SZtQdNBuB+JNL1ctXjEnyzHMVi7hKuWWw/nfsBrKOxURilGEZaM9N7GdVcStsAblL3wq
 qarkKg5lYC75OLwCX3NzzcCR8u+yKcoES6kCSEcY/kx2UC2Yn8yBc3gJB1LeBv1XNHsO
 sh0qESeG+h4ODZcF2TQuNkUBCRzxUvhzg8W7/p4yqSINmNV+33zMxiIgRBxIUqWsd3u4
 LkGJ04dpTbWnOfW1JY8zP9lUlKRoIfLm8os5KlgAH46qeyXmG/t1+rWFfmkF2+s/GZDS GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30x3gs90eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 08:30:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04A8Twdj184381;
        Sun, 10 May 2020 08:29:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30x69nkmpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 08:29:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04A8TpkM020289;
        Sun, 10 May 2020 08:29:51 GMT
Received: from [10.175.202.229] (/10.175.202.229)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 May 2020 01:29:51 -0700
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org
Cc:     tony.luck@intel.com, ak@linux.intel.com, chang.seok.bae@intel.com
References: <20200423232207.5797-1-sashal@kernel.org>
 <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
Message-ID: <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
Date:   Sun, 10 May 2020 10:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9616 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=973 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9616 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/20 10:09 AM, Vegard Nossum wrote:
> 
> On 4/24/20 1:21 AM, Sasha Levin wrote:
>> Benefits:
>> Currently a user process that wishes to read or write the FS/GS base must
>> make a system call. But recent X86 processors have added new instructions
>> for use in 64-bit mode that allow direct access to the FS and GS segment
>> base addresses.  The operating system controls whether applications can
>> use these instructions with a %cr4 control bit.
[...]
> So FWIW I've done some overnight fuzz testing of this patch set and
> haven't seen any problems. Will try a couple of other kernel configs too.

I spoke a few minutes too soon. Just hit this, if anybody wants to have
a look:

[ 6402.786418] ------------[ cut here ]------------
[ 6402.787769] WARNING: CPU: 0 PID: 13802 at arch/x86/kernel/traps.c:811 
do_debug+0x16c/0x210
[ 6402.790042] CPU: 0 PID: 13802 Comm: init Not tainted 5.7.0-rc4+ #194
[ 6402.791779] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 6402.793365] RIP: 0010:do_debug+0x16c/0x210
[ 6402.794496] Code: ef e8 f8 fb 00 00 f6 85 91 00 00 00 02 74 b9 fa 66 
66 90 66 66 90 e8 c3 f5 11 00 eb ab f6 85 88 00 00 00 03 0f 85 6e ff ff 
ff <0f> 0b 80 e4 bf 49 89 84 24 58 0a 00 00 f0 41 80 0c 24 10 48 81 a5
[ 6402.799557] RSP: 0000:fffffe0000011f20 EFLAGS: 00010046
[ 6402.800995] RAX: 0000000000004002 RBX: 0000000000000000 RCX: 
00000000ffffffff
[ 6402.802959] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 
ffffffff82471e60
[ 6402.804891] RBP: fffffe0000011f58 R08: 0000000000000000 R09: 
0000000000000005
[ 6402.806836] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff88803e739a00
[ 6402.808775] R13: 0000000000000000 R14: 000000003ce24000 R15: 
0000000000000000
[ 6402.810723] FS:  000000000097a8c0(0000) GS:ffff88803ec00000(0000) 
knlGS:0000000000000000
[ 6402.812933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6402.814509] CR2: 0000000040000010 CR3: 000000003ce24000 CR4: 
00000000000006f0
[ 6402.816468] DR0: 0000000000000001 DR1: 0000000040006070 DR2: 
00007ffff7ffd000
[ 6402.818406] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000003b3062a
[ 6402.820353] Call Trace:
[ 6402.821043]  <#DB>
[ 6402.821622]  debug+0x37/0x70
[ 6402.822449] RIP: 0010:arch_stack_walk_user+0x79/0x110
[ 6402.823851] Code: b8 f0 ff ff bf be f0 df ff ff 48 0f 44 c6 48 39 d0 
0f 82 94 00 00 00 41 83 87 b8 09 00 00 01 66 66 90 0f ae e8 31 c0 48 8b 
1a <66> 66 90 85 c0 75 72 66 66 90 0f ae e8 48 8b 72 08 66 66 90 85 c0
[ 6402.828923] RSP: 0000:ffffc90003807d80 EFLAGS: 00000046
[ 6402.830346] RAX: 0000000000000000 RBX: 0040001000bf4800 RCX: 
0000000000000001
[ 6402.832288] RDX: 0000000040006073 RSI: 00000000400060dd RDI: 
ffffc90003807db8
[ 6402.834250] RBP: ffffc90003807f58 R08: 0000000000000001 R09: 
ffff88803e444400
[ 6402.836203] R10: 000000000000054c R11: ffff88803d2d955c R12: 
ffff88803e739a00
[ 6402.838139] R13: ffffffff810f16a0 R14: ffffc90003807db8 R15: 
ffff88803e739a00
[ 6402.840083]  ? profile_setup.cold+0xa1/0xa1
[ 6402.841235]  </#DB>
[ 6402.841836]  stack_trace_save_user+0x8c/0xd4
[ 6402.843045]  trace_buffer_unlock_commit_regs+0x122/0x1a0
[ 6402.844501]  trace_event_buffer_commit+0x6d/0x240
[ 6402.845799]  trace_event_raw_event_preemptirq_template+0x75/0xc0
[ 6402.847441]  ? debug+0x53/0x70
[ 6402.848299]  ? trace_hardirqs_off_thunk+0x1a/0x33
[ 6402.849593]  trace_hardirqs_off_caller+0xa6/0xd0
[ 6402.850862]  ? debug+0x4e/0x70
[ 6402.851727]  trace_hardirqs_off_thunk+0x1a/0x33
[ 6402.852983]  debug+0x53/0x70
[ 6402.853785] RIP: 0033:0x400060dd
[ 6402.854681] Code: 7a 1e 9e 91 de 4c 65 49 be 00 d0 ff f7 ff 7f 00 00 
49 bf de a7 b3 e8 d7 21 3c 15 9c 48 81 0c 24 00 01 00 00 9d b8 62 00 00 
00 <8e> c0 0f 05 66 8c c8 9c 48 81 24 24 ff fe ff ff 9d 48 89 04 25 40
[ 6402.859689] RSP: 002b:000000004000aea0 EFLAGS: 00000317
[ 6402.861116] RAX: 0000000000000062 RBX: 0000000040001000 RCX: 
ffffffffffffffff
[ 6402.863097] RDX: 0000000040003000 RSI: 0000000040004000 RDI: 
0000000040001000
[ 6402.866199] RBP: 0000000040006073 R08: 0000000000000001 R09: 
0000000000000001
[ 6402.868142] R10: ffffffffef080df2 R11: 1000000000000000 R12: 
fdffffffffffffff
[ 6402.870083] R13: 654cde919e1e7ab5 R14: 00007ffff7ffd000 R15: 
153c21d7e8b3a7de
[ 6402.872049] ---[ end trace 91a3039d0fd63799 ]---

It might not be related to the patch set, mind.


Vegard
