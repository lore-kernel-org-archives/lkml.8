Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741F924699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgB1PIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:08:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgB1PIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:08:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SF4lKF003881
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:08:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepwk2crp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:08:14 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 28 Feb 2020 15:08:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 15:08:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01SF885Z52035634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:08:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53E195205F;
        Fri, 28 Feb 2020 15:08:08 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 338DF52051;
        Fri, 28 Feb 2020 15:08:08 +0000 (GMT)
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
 <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date:   Fri, 28 Feb 2020 16:08:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022815-0016-0000-0000-000002EB3332
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022815-0017-0000-0000-0000334E6D21
Message-Id: <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_04:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=648 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also happened with 5.4:
Seems that I just happen to have an interesting test workload/system size interaction
on a newly installed system that triggers this.


[ 9761.439278] ------------[ cut here ]------------
[ 9761.439283] rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
[ 9761.439300] WARNING: CPU: 58 PID: 17405 at kernel/sched/fair.c:381 enqueue_task_fair+0x7cc/0x9b0
[ 9761.439303] Modules linked in: kvm xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp xt_CT tun bridge stp llc xt_tcpudp ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter rpcrdma sunrpc rdma_ucm rdma_cm iw_cm ib_cm configfs s390_trng ghash_s390 prng mlx5_ib aes_s390 ib_uverbs des_s390 libdes ib_core sha3_512_s390 sha3_256_s390 sha512_s390 genwqe_card sha1_s390 crc_itu_t vfio_ccw vfio_mdev mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel ip_tables x_tables mlx5_core sha256_s390 sha_common pkey zcrypt rng_core autofs4
[ 9761.439335] CPU: 58 PID: 17405 Comm: sh Not tainted 5.4.0 #27
[ 9761.439336] Hardware name: IBM 3906 M04 704 (LPAR)
[ 9761.439338] Krnl PSW : 0404c00180000000 00000007353f2d4c (enqueue_task_fair+0x7cc/0x9b0)
[ 9761.439340]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[ 9761.439342] Krnl GPRS: 00000000000003e0 0400000735f500bc 000000000000002d 00000007365f4bc2
[ 9761.439343]            000000000000002c 0000000735a49388 0000000000000001 0400001f00000000
[ 9761.439344]            000003e0015ebc88 0000001fbd856c00 0000001fbd856d00 0000000000000000
[ 9761.439345]            0000001bc8a12000 0000000735d853c0 00000007353f2d48 000003e0015ebad0
[ 9761.439385] Krnl Code: 00000007353f2d3c: c020005ae9c0	larl	%r2,735f500bc
                          00000007353f2d42: c0e5fffdc487	brasl	%r14,7353ab650
                         #00000007353f2d48: a7f40001		brc	15,7353f2d4a
                         >00000007353f2d4c: a7f4fcda		brc	15,7353f2700
                          00000007353f2d50: e33073480004	lg	%r3,840(%r7)
                          00000007353f2d56: 41b07340		la	%r11,832(%r7)
                          00000007353f2d5a: b9040063		lgr	%r6,%r3
                          00000007353f2d5e: b904004b		lgr	%r4,%r11
[ 9761.439397] Call Trace:
[ 9761.439399] ([<00000007353f2d48>] enqueue_task_fair+0x7c8/0x9b0)
[ 9761.439401]  [<00000007353e1b48>] activate_task+0x88/0xf0 
[ 9761.439403]  [<00000007353e20c6>] ttwu_do_activate+0x56/0x80 
[ 9761.439405]  [<00000007353e3106>] try_to_wake_up+0x256/0x650 
[ 9761.439408]  [<000000073540353e>] swake_up_locked.part.0+0x2e/0x70 
[ 9761.439409]  [<0000000735403764>] swake_up_one+0x54/0x90 
[ 9761.439449]  [<000003ff8047be52>] kvm_vcpu_wake_up+0x52/0x80 [kvm] 
[ 9761.439458]  [<000003ff80498e3a>] kvm_s390_vcpu_wakeup+0x2a/0x40 [kvm] 
[ 9761.439466]  [<000003ff8049959e>] kvm_s390_idle_wakeup+0x6e/0xa0 [kvm] 
[ 9761.439470]  [<000000073544acb4>] __hrtimer_run_queues+0x114/0x2f0 
[ 9761.439472]  [<000000073544b97c>] hrtimer_interrupt+0x12c/0x2b0 
[ 9761.439475]  [<0000000735370a1a>] do_IRQ+0xaa/0xb0 
[ 9761.439480]  [<0000000735d75998>] ext_int_handler+0x128/0x12c 
[ 9761.439485]  [<00000007355abd28>] get_page_from_freelist+0x528/0x1860 
[ 9761.439486] ([<00000007355abc36>] get_page_from_freelist+0x436/0x1860)
[ 9761.439488]  [<00000007355ae420>] __alloc_pages_nodemask+0x120/0x320 
[ 9761.439492]  [<00000007355cca8a>] alloc_pages_vma+0x9a/0x280 
[ 9761.439494]  [<0000000735588062>] wp_page_copy+0xb2/0x730 
[ 9761.439495]  [<000000073558b642>] do_wp_page+0xa2/0x760 
[ 9761.439497]  [<000000073558def2>] __handle_mm_fault+0x852/0x910 
[ 9761.439498]  [<000000073558e076>] handle_mm_fault+0xc6/0x180 
[ 9761.439500]  [<0000000735389c44>] do_protection_exception+0x164/0x4b0 
[ 9761.439502]  [<0000000735d7558c>] pgm_check_handler+0x1c8/0x220 
[ 9761.439502] Last Breaking-Event-Address:
[ 9761.439503]  [<00000007353f2d48>] enqueue_task_fair+0x7c8/0x9b0
[ 9761.439504] ---[ end trace 40ea9b5f62b01ed1 ]---

