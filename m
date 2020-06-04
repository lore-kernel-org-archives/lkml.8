Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DCA206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xMsPeMUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgFDROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:14:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgFDROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:14:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054HC1Hv058872;
        Thu, 4 Jun 2020 17:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jvdH9PfBRNbWV7qBrkv1EMSWPevb7RPezMmAhgR9CYI=;
 b=xMsPeMUvH7i93tjqgLTHmpifPpW898ov6eZIXwNbQXAxzYb/kKkwxF98SziH7LuyALdL
 97YSSNZHL8Q39Jlszd7G0Itamh4tvL3Rx62sJOz9J5exOoXlnb6w4DbbcB4CjMoAM7gb
 DoMx1sXeWO2MZHXl2pzcB4XMOBVFSoSSjlZmYSE7n0kmqwJ5mFRLbmwJceNBhfbx9Roz
 DemX5v9WS80ououeMKqHbsFMuLTJL5WkAmo8DGIwKZthUK0Un0PkJpupR5+qQagJd+9p
 WpTnzHOrLjoO60792pwS/2JUquoebuv1kgOY4D5LdUve74JLk+tYRYq0AJllYK9E7lF8 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31evvn2q2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 17:14:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054HE4pC184800;
        Thu, 4 Jun 2020 17:14:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25vtbbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 17:14:44 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054HEgYh011916;
        Thu, 4 Jun 2020 17:14:42 GMT
Received: from [10.175.55.64] (/10.175.55.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 10:14:42 -0700
To:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Subject: slub freelist issue / BUG: unable to handle page fault for address:
 000000003ffe0018
Cc:     Marco Elver <elver@google.com>, Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Message-ID: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
Date:   Thu, 4 Jun 2020 19:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I ran into a boot problem with latest linus/master
(6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:

hpet0: 3 comparators, 64-bit 100.000000 MHz counter
clocksource: Switched to clocksource tsc-early
BUG: unable to handle page fault for address: 000000003ffe0018
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0+ #211
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:kmem_cache_alloc+0x70/0x1d0
Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 6f cc e7 7e 4d 8b 20 
4d 85 e4 0f 84 3d 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a 01 <49> 8b 1c 
04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
RSP: 0000:ffffc90000013df8 EFLAGS: 00010206
RAX: 0000000000000018 RBX: ffffffff81c49200 RCX: 0000000000000002
RDX: 0000000000000001 RSI: 0000000000000dc0 RDI: 000000000002b300
RBP: ffff88803e403d00 R08: ffff88803ec2b300 R09: 0000000000000001
R10: 0000000000000dc0 R11: 0000000000000006 R12: 000000003ffe0000
R13: ffffffff8110a583 R14: 0000000000000dc0 R15: ffffffff81c49a80
FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000003ffe0018 CR3: 0000000001c0a001 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __trace_define_field+0x33/0xa0
  event_trace_init+0xeb/0x2b4
  tracer_init_tracefs+0x60/0x195
  ? register_tracer+0x1e7/0x1e7
  do_one_initcall+0x74/0x160
  kernel_init_freeable+0x190/0x1f0
  ? rest_init+0x9a/0x9a
  kernel_init+0x5/0xf6
  ret_from_fork+0x35/0x40
CR2: 000000003ffe0018
---[ end trace 707efa023f2ee960 ]---
RIP: 0010:kmem_cache_alloc+0x70/0x1d0

Bisection gives me:

commit 3202fa62fb43087387c65bfa9c100feffac74aa6
Author: Kees Cook <keescook@chromium.org>
Date:   Wed Apr 1 21:04:27 2020 -0700

     slub: relocate freelist pointer to middle of object

Reverting these three commits fixes it:

3202fa62fb43087387c65bfa9c100feffac74aa6 slub: relocate freelist pointer 
to middle of object
89b83f282d8ba380cf2124f88106c57df49c538c slub: avoid redzone when 
choosing freepointer location
cbfc35a48609ceac978791e3ab9dde0c01f8cb20 mm/slub: fix incorrect 
interpretation of s->offset


Vegard
