Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC455C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFCD205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgD3UDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:03:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgD3UDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:03:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UK2Gtn037736;
        Thu, 30 Apr 2020 16:03:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggxb9r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 16:03:31 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UK2eCY040488;
        Thu, 30 Apr 2020 16:03:31 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggxb9pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 16:03:31 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UK0GoA029009;
        Thu, 30 Apr 2020 20:03:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 30mcu5axsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 20:03:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UK3Pn126476794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 20:03:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31378AE04D;
        Thu, 30 Apr 2020 20:03:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470BFAE045;
        Thu, 30 Apr 2020 20:03:24 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.16.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 20:03:24 +0000 (GMT)
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Dave Hansen <dave.hansen@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc:     david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        peterz@infradead.org, sean.j.christopherson@intel.com
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
 <540f483f-5e58-f342-e771-9d90c4d3fb6a@intel.com>
 <f32fa7f8-a259-80cc-ec70-d9cd690a8430@de.ibm.com>
 <fe1a2ecd-78ff-9bc6-717c-bdb55479b703@intel.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <5173673f-9aeb-4753-1e74-4ef442e06e6a@de.ibm.com>
Date:   Thu, 30 Apr 2020 22:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fe1a2ecd-78ff-9bc6-717c-bdb55479b703@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_12:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.04.20 22:01, Dave Hansen wrote:
> On 4/30/20 12:38 PM, Christian Borntraeger wrote:
>>>
>>>> What do you see when you also do the  SetPageAccessible(page);
>>>> in the else page of prep_new_page (order == 0).
>>>> (I do get > 10000 of these non compound page allocs just during boot).
>>> Yes, I see the same thing.
>>>
>>> I updated the patch and double-checked that it triggers properly with a
>>> socket-based sendfile().
>> Do you have a calltrace? 
> 
> It triggers with the thread from this patch _not_ applied.  I just
> wanted to point out that it was able to find the real bug and that the
> patch in question squashed this instance.


Ah now it makes sense. Thanks. 
> 
> Here's the call trace I see:
> 
>> [  199.566150] WARNING: CPU: 0 PID: 878 at mm/page_alloc.c:8860 check_page_accessible+0x5f/0xb0
>> [  199.567813] Modules linked in:
>> [  199.568447] CPU: 0 PID: 878 Comm: server Not tainted 5.7.0-rc3-dirty #6544
>> [  199.569948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
>> [  199.571980] RIP: 0010:check_page_accessible+0x5f/0xb0
>> [  199.572737] Code: 4c 01 48 85 db 74 18 48 8b 03 48 8b 7b 08 48 83 c3 18 48 89 ee ff d0 48 8b 03 48 85 c0 75 eb 48 8b 45 00 a9 00 00 20 00 75 bb <0f> 0b 0f 1f 44 00 00 3e 80 4d 02 20 5b 5d c3 65 8b 05 db 72 d3 7e
>> [  199.576514] RSP: 0018:ffffc900003f7810 EFLAGS: 00010246
>> [  199.577556] RAX: 000ffff800020016 RBX: ffff88800ff5b068 RCX: 0000000000000000
>> [  199.578964] RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88800fc18400
>> [  199.580352] RBP: ffffea0001d5ca40 R08: 00000000000001b5 R09: ffff88800fe74000
>> [  199.581784] R10: ffff88800fe74170 R11: ffff88800fc18400 R12: 0000000000001000
>> [  199.583179] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc900005e52d0
>> [  199.584587] FS:  00007ffff7fe8700(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
>> [  199.586045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  199.587200] CR2: 00007ffff7b042b0 CR3: 000000007ab5a000 CR4: 00000000003406f0
>> [  199.588655] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  199.591784] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  199.593217] Call Trace:
>> [  199.593755]  ? e1000_xmit_frame+0x50c/0x1040
>> [  199.594626]  ? dev_hard_start_xmit+0x8d/0x1e0
>> [  199.596126]  ? sch_direct_xmit+0xe8/0x220
>> [  199.597676]  ? __qdisc_run+0x13a/0x4e0
>> [  199.598476]  ? __dev_queue_xmit+0x2d7/0x710
>> [  199.599767]  ? ip_finish_output2+0x2a8/0x550
>> [  199.601195]  ? skb_gso_validate_network_len+0x11/0x70
>> [  199.602272]  ? ip_output+0x6d/0xe0
>> [  199.602955]  ? ip_forward_options.cold.9+0x27/0x27
>> [  199.603918]  ? __ip_queue_xmit+0x14f/0x370
>> [  199.604734]  ? __tcp_transmit_skb+0x54b/0xad0
>> [  199.605608]  ? tcp_write_xmit+0x379/0x10c0
>> [  199.606354]  ? do_tcp_sendpages+0x2bc/0x5f0
>> [  199.607206]  ? tcp_sendpage_locked+0x44/0x60
>> [  199.608066]  ? tcp_sendpage+0x37/0x50
>> [  199.608801]  ? inet_sendpage+0x4f/0x80
>> [  199.609554]  ? kernel_sendpage+0x17/0x20
>> [  199.610341]  ? sock_sendpage+0x20/0x30
>> [  199.610989]  ? pipe_to_sendpage+0x60/0xa0
>> [  199.611658]  ? __splice_from_pipe+0x9f/0x180
>> [  199.612567]  ? generic_pipe_buf_nosteal+0x10/0x10
>> [  199.613509]  ? generic_pipe_buf_nosteal+0x10/0x10
>> [  199.614452]  ? splice_from_pipe+0x5d/0x90
>> [  199.615258]  ? direct_splice_actor+0x32/0x40
>> [  199.616102]  ? splice_direct_to_actor+0x101/0x220
>> [  199.617054]  ? pipe_to_sendpage+0xa0/0xa0
>> [  199.617858]  ? do_splice_direct+0x9a/0xd0
>> [  199.618660]  ? do_sendfile+0x1ce/0x3d0
>> [  199.619411]  ? __x64_sys_sendfile64+0x5c/0xc0
>> [  199.620343]  ? do_syscall_64+0x4a/0x130
>> [  199.621042]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
>> [  199.622119] ---[ end trace 19796ac5d41cc1f4 ]---
