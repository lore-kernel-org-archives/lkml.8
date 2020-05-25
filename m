Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB302071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ePS/+uns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbgEYQDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:03:30 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35354 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388432AbgEYQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:03:30 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id D135A2E0A38;
        Mon, 25 May 2020 19:03:26 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id NAeM9spR5e-3Q20fraS;
        Mon, 25 May 2020 19:03:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590422606; bh=6fMfPJImAYMqb9DBFtCBybi5ZMOsXbk7TMTbXjcpGFo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=ePS/+unsDrvrq3Vwpl5SI6hzU95mJcUmrDVWGMj5sCiXLxrSLq6otGZy9jR9sNIIP
         I6MtIIllcp/4Tdv1K1d40ZgiDZjpanzymxVDyRqtvD7+oNrACrEkAANM3s8ksePrfP
         lTVrByGVf3zoOsb0ZtF9suzqtH6wzBA5UBLV+BqY=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:603::1:c])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id jmItrKVgv5-3PWS8ElJ;
        Mon, 25 May 2020 19:03:25 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm: dump_page: add debugfs file for dumping page state by
 pfn
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <159041635119.987025.7321864888027213705.stgit@buzz>
 <20200525153315.GC17206@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a5d3f702-62e0-f683-da52-33bc3d1e5976@yandex-team.ru>
Date:   Mon, 25 May 2020 19:03:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525153315.GC17206@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2020 18.33, Matthew Wilcox wrote:
> On Mon, May 25, 2020 at 05:19:11PM +0300, Konstantin Khlebnikov wrote:
>> Tool 'page-types' could list pages mapped by process or file cache pages,
>> but it shows only limited amount of state exported via procfs.
>>
>> Let's employ existing helper dump_page() to reach remaining information:
>> writing pfn into /sys/kernel/debug/dump_page dumps state into kernel log.
>>
>> # echo 0x37c43c > /sys/kernel/debug/dump_page
>> # dmesg | tail -6
>>   page:ffffcb0b0df10f00 refcount:1 mapcount:0 mapping:000000007755d3d9 index:0x30
>>   0xffffffffae4239e0 name:"libGeoIP.so.1.6.9"
>>   flags: 0x200000000020014(uptodate|lru|mappedtodisk)
>>   raw: 0200000000020014 ffffcb0b187fd288 ffffcb0b189e6248 ffff9528a04afe10
>>   raw: 0000000000000030 0000000000000000 00000001ffffffff 0000000000000000
>>   page dumped because: debugfs request
> 
> This makes me deeply uncomfortable.  We're using %px, and %lx
> (for the 'raw' lines) so we actually get to see kernel addresses.
> We've rationalised this in the past as being acceptable because you're
> already in an "assert triggered" kind of situation.  Now you're adding
> a way for any process with CAP_SYS_ADMIN to get kernel addresses dumped
> into the syslog.
> 
> I think we need a different function for this, or we need to re-audit
> dump_page() for exposing kernel pointers, and not expose the raw data
> in struct page.
> 

It's better to add switch for disabling paranoia if bad things happening.
I.e. keep everything safe by default (or whatever sysctl/config set) and
flip the switch when needed.
