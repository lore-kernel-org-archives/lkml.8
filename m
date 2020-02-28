Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D407C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10490246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgB1NnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:43:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgB1NnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:43:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SDdmlL105438
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:43:21 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepx5fs07-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:43:21 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 28 Feb 2020 13:43:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 13:43:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01SDgHek32244106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 13:42:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12BB642047;
        Fri, 28 Feb 2020 13:43:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC08F42041;
        Fri, 28 Feb 2020 13:43:14 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 13:43:14 +0000 (GMT)
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
 <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date:   Fri, 28 Feb 2020 14:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022813-0016-0000-0000-000002EB2D0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022813-0017-0000-0000-0000334E669F
Message-Id: <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_04:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=530 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.20 14:32, Vincent Guittot wrote:
> On Fri, 28 Feb 2020 at 13:04, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>> I was able to reproduce this with 5.5.0
> 
> This might even be earlier as there weren't any changes on this area recently
> 
> Do you have more details about your setup ? Are you using cgroup
> bandwidth an an example ?

These are KVM guests managed by libvirt. So all kind of cgroups are
active (with default values).

I will try if I can bisect. It seems to happen after some hours so this might take some time.


>>
>> On 28.02.20 08:54, Christian Borntraeger wrote:
>>> Peter,
>>>
>>> it seems that your new assert did trigger for me:
>>>
>>> The system was running fine for 4 hours and then this happened.
>>> Unfortunately I have no idea if this reproduces and if so how.
>>>
>>> [15260.753944] ------------[ cut here ]------------
>>> [15260.753949] rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
>>> [15260.753959] WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
>>> [15260.753961] Modules linked in: kvm xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp xt_CT tun bridge stp llc xt_tcpudp ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter rpcrdma sunrpc rdma_ucm rdma_cm iw_cm ib_cm configfs s390_trng mlx5_ib ghash_s390 prng ib_uverbs aes_s390 ib_core des_s390 libdes sha3_512_s390 genwqe_card vfio_ccw vfio_mdev sha3_256_s390 mdev crc_itu_t sha512_s390 vfio_iommu_type1 sha1_s390 vfio eadm_sch zcrypt_cex4 sch_fq_codel ip_tables x_tables mlx5_core sha256_s390 sha_common pkey zcrypt rng_core autofs4
>>> [15260.754002] CPU: 48 PID: 17435 Comm: cc1 Not tainted 5.6.0-rc3+ #24
>>> [15260.754004] Hardware name: IBM 3906 M04 704 (LPAR)
>>> [15260.754005] Krnl PSW : 0404c00180000000 0000000942282e3c (enqueue_task_fair+0x32c/0x440)
>>> [15260.754008]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>> [15260.754010] Krnl GPRS: 00000000000003e0 0000001fbd60ee00 000000000000002d 00000009435347c2
>>> [15260.754012]            000000000000002c 00000009428ec950 0000000900000000 0000000000000001
>>> [15260.754013]            0000001fbd60ed00 0000001fbd60ed00 0000001fbd60ee00 0000000000000000
>>> [15260.754014]            0000001c633ea000 0000000942c34670 0000000942282e38 000003e00140baf8
>>> [15260.754066] Krnl Code: 0000000942282e2c: c020005d39d8      larl    %r2,0000000942e2a1dc
>>>                           0000000942282e32: c0e5fffdcc3f      brasl   %r14,000000094223c6b0
>>>                          #0000000942282e38: af000000          mc      0,0
>>>                          >0000000942282e3c: a7f4ff22          brc     15,0000000942282c80
>>>                           0000000942282e40: 41b06340          la      %r11,832(%r6)
>>>                           0000000942282e44: e3d063480004      lg      %r13,840(%r6)
>>>                           0000000942282e4a: b904004b          lgr     %r4,%r11
>>>                           0000000942282e4e: b904003d          lgr     %r3,%r13
>>> [15260.754080] Call Trace:
>>> [15260.754083]  [<0000000942282e3c>] enqueue_task_fair+0x32c/0x440
>>> [15260.754085] ([<0000000942282e38>] enqueue_task_fair+0x328/0x440)
>>> [15260.754087]  [<0000000942272d78>] activate_task+0x88/0xf0
>>> [15260.754088]  [<00000009422732e8>] ttwu_do_activate+0x58/0x78
>>> [15260.754090]  [<00000009422742ce>] try_to_wake_up+0x256/0x650
>>> [15260.754093]  [<000000094229248e>] swake_up_locked.part.0+0x2e/0x70
>>> [15260.754095]  [<00000009422927ac>] swake_up_one+0x54/0x88
>>> [15260.754151]  [<000003ff8044c15a>] kvm_vcpu_wake_up+0x52/0x78 [kvm]
>>> [15260.754161]  [<000003ff8046af02>] kvm_s390_vcpu_wakeup+0x2a/0x40 [kvm]
>>> [15260.754171]  [<000003ff8046b68e>] kvm_s390_idle_wakeup+0x6e/0xa0 [kvm]
>>> [15260.754175]  [<00000009422dd05c>] __hrtimer_run_queues+0x114/0x2f0
>>> [15260.754178]  [<00000009422dddb4>] hrtimer_interrupt+0x12c/0x2a8
>>> [15260.754181]  [<0000000942200d3c>] do_IRQ+0xac/0xb0
>>> [15260.754185]  [<0000000942c25684>] ext_int_handler+0x130/0x134
>>> [15260.754186] Last Breaking-Event-Address:
>>> [15260.754189]  [<000000094223c710>] __warn_printk+0x60/0x68
>>> [15260.754190] ---[ end trace e84a48be72a8b514 ]---
>>>
>>

