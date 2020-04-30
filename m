Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E183AC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EA520836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD3UBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:01:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:46024 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3UBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:01:41 -0400
IronPort-SDR: JAy74jXcLui/Squ79xZDXcyyBpU21gKzsaAg9YZZmB0ycGNAVErMVCi3unOHOpadH/4mmMbzVs
 LJmWZ7XRMKsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 13:01:40 -0700
IronPort-SDR: Upk1DYOonbh9vpZzbFkQqkQP+XWtpRM+4qaWOcKCEZv31LmaoqvkgUggnv5Pzs7dQOeLmQm0f/
 bzz4/5EHLIYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="261892202"
Received: from dnlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.251]) ([10.255.231.251])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2020 13:01:39 -0700
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <fe1a2ecd-78ff-9bc6-717c-bdb55479b703@intel.com>
Date:   Thu, 30 Apr 2020 13:01:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f32fa7f8-a259-80cc-ec70-d9cd690a8430@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 12:38 PM, Christian Borntraeger wrote:
>>
>>> What do you see when you also do the  SetPageAccessible(page);
>>> in the else page of prep_new_page (order == 0).
>>> (I do get > 10000 of these non compound page allocs just during boot).
>> Yes, I see the same thing.
>>
>> I updated the patch and double-checked that it triggers properly with a
>> socket-based sendfile().
> Do you have a calltrace? 

It triggers with the thread from this patch _not_ applied.  I just
wanted to point out that it was able to find the real bug and that the
patch in question squashed this instance.

Here's the call trace I see:

> [  199.566150] WARNING: CPU: 0 PID: 878 at mm/page_alloc.c:8860 check_page_accessible+0x5f/0xb0
> [  199.567813] Modules linked in:
> [  199.568447] CPU: 0 PID: 878 Comm: server Not tainted 5.7.0-rc3-dirty #6544
> [  199.569948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [  199.571980] RIP: 0010:check_page_accessible+0x5f/0xb0
> [  199.572737] Code: 4c 01 48 85 db 74 18 48 8b 03 48 8b 7b 08 48 83 c3 18 48 89 ee ff d0 48 8b 03 48 85 c0 75 eb 48 8b 45 00 a9 00 00 20 00 75 bb <0f> 0b 0f 1f 44 00 00 3e 80 4d 02 20 5b 5d c3 65 8b 05 db 72 d3 7e
> [  199.576514] RSP: 0018:ffffc900003f7810 EFLAGS: 00010246
> [  199.577556] RAX: 000ffff800020016 RBX: ffff88800ff5b068 RCX: 0000000000000000
> [  199.578964] RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88800fc18400
> [  199.580352] RBP: ffffea0001d5ca40 R08: 00000000000001b5 R09: ffff88800fe74000
> [  199.581784] R10: ffff88800fe74170 R11: ffff88800fc18400 R12: 0000000000001000
> [  199.583179] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc900005e52d0
> [  199.584587] FS:  00007ffff7fe8700(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
> [  199.586045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  199.587200] CR2: 00007ffff7b042b0 CR3: 000000007ab5a000 CR4: 00000000003406f0
> [  199.588655] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  199.591784] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  199.593217] Call Trace:
> [  199.593755]  ? e1000_xmit_frame+0x50c/0x1040
> [  199.594626]  ? dev_hard_start_xmit+0x8d/0x1e0
> [  199.596126]  ? sch_direct_xmit+0xe8/0x220
> [  199.597676]  ? __qdisc_run+0x13a/0x4e0
> [  199.598476]  ? __dev_queue_xmit+0x2d7/0x710
> [  199.599767]  ? ip_finish_output2+0x2a8/0x550
> [  199.601195]  ? skb_gso_validate_network_len+0x11/0x70
> [  199.602272]  ? ip_output+0x6d/0xe0
> [  199.602955]  ? ip_forward_options.cold.9+0x27/0x27
> [  199.603918]  ? __ip_queue_xmit+0x14f/0x370
> [  199.604734]  ? __tcp_transmit_skb+0x54b/0xad0
> [  199.605608]  ? tcp_write_xmit+0x379/0x10c0
> [  199.606354]  ? do_tcp_sendpages+0x2bc/0x5f0
> [  199.607206]  ? tcp_sendpage_locked+0x44/0x60
> [  199.608066]  ? tcp_sendpage+0x37/0x50
> [  199.608801]  ? inet_sendpage+0x4f/0x80
> [  199.609554]  ? kernel_sendpage+0x17/0x20
> [  199.610341]  ? sock_sendpage+0x20/0x30
> [  199.610989]  ? pipe_to_sendpage+0x60/0xa0
> [  199.611658]  ? __splice_from_pipe+0x9f/0x180
> [  199.612567]  ? generic_pipe_buf_nosteal+0x10/0x10
> [  199.613509]  ? generic_pipe_buf_nosteal+0x10/0x10
> [  199.614452]  ? splice_from_pipe+0x5d/0x90
> [  199.615258]  ? direct_splice_actor+0x32/0x40
> [  199.616102]  ? splice_direct_to_actor+0x101/0x220
> [  199.617054]  ? pipe_to_sendpage+0xa0/0xa0
> [  199.617858]  ? do_splice_direct+0x9a/0xd0
> [  199.618660]  ? do_sendfile+0x1ce/0x3d0
> [  199.619411]  ? __x64_sys_sendfile64+0x5c/0xc0
> [  199.620343]  ? do_syscall_64+0x4a/0x130
> [  199.621042]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [  199.622119] ---[ end trace 19796ac5d41cc1f4 ]---
