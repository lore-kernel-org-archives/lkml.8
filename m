Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A887C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF42071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ShmAblQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbgEYQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbgEYQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:05:13 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6336C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:05:13 -0700 (PDT)
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9C0F52E152E;
        Mon, 25 May 2020 19:05:09 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Z7kgGVoVQI-582aU5bh;
        Mon, 25 May 2020 19:05:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590422709; bh=3jjWtTMGhPjbcVtg1vx9q6LAmq5WMdmzmKwCRrGUnXY=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=ShmAblQJNrB/m8kYudhCcdYABE5rOPwX7rwEN/qmbozIaPXffxJheetH9txX4dmRQ
         xApC3NJx5O8/zc5g8CEMLlyb9QthU3l3bQvOj2wbtBFUbB7noxKNiwY8s1mP+xmkdr
         1mdAWXL3Z8mNtjaIit05w0yLxvoPcyU0WzKBR7mQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:603::1:c])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id WUrga2wuLw-58XSDtYm;
        Mon, 25 May 2020 19:05:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm: dump_page: add debugfs file for dumping page state by
 pfn
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <159041635119.987025.7321864888027213705.stgit@buzz>
 <20200525153315.GC17206@bombadil.infradead.org>
 <a5d3f702-62e0-f683-da52-33bc3d1e5976@yandex-team.ru>
Message-ID: <f2c3e93a-6e43-8ce3-d711-2018c7be3063@yandex-team.ru>
Date:   Mon, 25 May 2020 19:05:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a5d3f702-62e0-f683-da52-33bc3d1e5976@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b

On 25/05/2020 19.03, Konstantin Khlebnikov wrote:
> 
> 
> On 25/05/2020 18.33, Matthew Wilcox wrote:
>> On Mon, May 25, 2020 at 05:19:11PM +0300, Konstantin Khlebnikov wrote:
>>> Tool 'page-types' could list pages mapped by process or file cache pages,
>>> but it shows only limited amount of state exported via procfs.
>>>
>>> Let's employ existing helper dump_page() to reach remaining information:
>>> writing pfn into /sys/kernel/debug/dump_page dumps state into kernel log.
>>>
>>> # echo 0x37c43c > /sys/kernel/debug/dump_page
>>> # dmesg | tail -6
>>>   page:ffffcb0b0df10f00 refcount:1 mapcount:0 mapping:000000007755d3d9 index:0x30
>>>   0xffffffffae4239e0 name:"libGeoIP.so.1.6.9"
>>>   flags: 0x200000000020014(uptodate|lru|mappedtodisk)
>>>   raw: 0200000000020014 ffffcb0b187fd288 ffffcb0b189e6248 ffff9528a04afe10
>>>   raw: 0000000000000030 0000000000000000 00000001ffffffff 0000000000000000
>>>   page dumped because: debugfs request
>>
>> This makes me deeply uncomfortable.  We're using %px, and %lx
>> (for the 'raw' lines) so we actually get to see kernel addresses.
>> We've rationalised this in the past as being acceptable because you're
>> already in an "assert triggered" kind of situation.  Now you're adding
>> a way for any process with CAP_SYS_ADMIN to get kernel addresses dumped
>> into the syslog.
>>
>> I think we need a different function for this, or we need to re-audit
>> dump_page() for exposing kernel pointers, and not expose the raw data
>> in struct page.
>>
> 
> It's better to add switch for disabling paranoia if bad things happening.
> I.e. keep everything safe by default (or whatever sysctl/config set) and
> flip the switch when needed.

Also I'm ok to seal this interface if kernel in mode of serious paranoia.
