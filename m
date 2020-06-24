Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A268C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCCA2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7cghLvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbgFXHsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:48:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27959 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387725AbgFXHsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592984929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=dAH3fuQ9GlgXVA4SNlalMF0sv1EKVmnCC12bGX8cR7o=;
        b=O7cghLvze9qWwhqy8mSIfB4OcePJnmW9aPbjTW4AcP7rcd40W8qHjocNtmRRsAyFZ5y9hx
        hD8FQJC6oq2ggUkIQjOC9jdTGE2xtVcwHh/wUKMvPWfQ6q2ZFCJnbUnI/wUmmYGNEwp7GL
        7rcwr5b+67v0tfqQsceYUYNZjJEjryM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Hh-w-NxXMQ2T7_A_UYIVjw-1; Wed, 24 Jun 2020 03:48:47 -0400
X-MC-Unique: Hh-w-NxXMQ2T7_A_UYIVjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A31800D5C;
        Wed, 24 Jun 2020 07:48:45 +0000 (UTC)
Received: from [10.36.113.65] (ovpn-113-65.ams2.redhat.com [10.36.113.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1063A5BACC;
        Wed, 24 Jun 2020 07:48:43 +0000 (UTC)
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <57d8a558-dcb3-b318-8e38-6c016b050414@redhat.com>
Date:   Wed, 24 Jun 2020 09:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623151828.GA31426@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.20 17:18, Michal Hocko wrote:
> On Tue 23-06-20 17:42:58, Wei Yang wrote:
>> For early sections, we assumes its memmap will never be partially
>> removed. But current behavior breaks this.
>>
>> Let's correct it.
>>
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> 
> Can a user trigger this or is this a theoretical bug?

I tried to reproduce it, but somehow I get unexpected behavior.
With a hacked QEMU I can get

$ cat /proc/iomem
[...]
100000000-143ffffff : System RAM
144000000-343dfffff : Persistent Memory
  144000000-1441fffff : namespace0.0
  144200000-144ffffff : dax0.0

After
$ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M

I get

$ cat /proc/iomem
[...]
100000000-143ffffff : System RAM
144000000-343dfffff : Persistent Memory
  144000000-1441fffff : namespace0.0
  144200000-144ffffff : dax0.0

I can trigger remove+re-add via 
$ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M

So we clearly have an overlap between System RAM and dax0.0 within a section.
However, I never get early_section() to trigger in
section_activate()/section_deactivate() ? That's unexpected


Definitely something seems to go wrong after the first "ndctl create-namespace".
Using a random page walker:

[root@localhost ~]# ./page-types 
[  387.019229] general protection fault, probably for non-canonical address 0xfdfdfdfdfdfdfdfc: 0000 [#1] SMP NOPTI
[  387.020172] CPU: 17 PID: 1314 Comm: page-types Kdump: loaded Tainted: G        W         5.8.0-rc2 #20
[  387.021015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
[  387.022056] RIP: 0010:stable_page_flags+0x27/0x3f0
[  387.022519] Code: 00 00 00 66 66 66 66 90 48 85 ff 0f 84 d2 03 00 00 41 54 55 48 89 fd 53 48 8b 57 08 48 8b 1f 48f
[  387.024291] RSP: 0018:ffff9f8781057e58 EFLAGS: 00010202
[  387.024775] RAX: fdfdfdfdfdfdfdfc RBX: fdfdfdfdfdfdfdfd RCX: 00007ffc4f4f1f78
[  387.025423] RDX: 0000000000000001 RSI: 0000002000000000 RDI: ffffc590c5100000
[  387.026052] RBP: ffffc590c5100000 R08: 0000000000000001 R09: 0000000000000000
[  387.026696] R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffc4f4f1f80
[  387.027324] R13: 0000000000040000 R14: 00007ffc4f4d1f80 R15: ffffffffa1577ee0
[  387.027974] FS:  00007f91a0f9c580(0000) GS:ffff888b3f7c0000(0000) knlGS:0000000000000000
[  387.028699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  387.029223] CR2: 0000000000449b00 CR3: 000000007a7fc000 CR4: 00000000000006e0
[  387.029864] Call Trace:
[  387.030108]  kpageflags_read+0xcc/0x160
[  387.030473]  proc_reg_read+0x53/0x80
[  387.030809]  vfs_read+0x9d/0x150
[  387.031114]  ksys_pread64+0x65/0xa0
[  387.031449]  do_syscall_64+0x4d/0x90
[  387.031783]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


-- 
Thanks,

David / dhildenb

