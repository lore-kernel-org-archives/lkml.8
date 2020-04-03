Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E14C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11559206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bXEmj37N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbgDCBd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:33:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDCBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=SCRT2UG5Qsu+Cz6vuDN/Aw7Mnmw2doVb42M3j+OCBgI=; b=bXEmj37NUbVC9gRqY/YRlj7WOt
        x+g7JTU2gOH3VMLC/iY4BVvBHpErcd9UBzESM6YdPt/2McfvSll74J+z5Pd4cW183QdiZKmwY+R95
        o10eU+s/ztBp0LhDN5eq9lZyO/wehBGn3gRqjq9ZYj4AeiXxQEoyDU1vo8hYJTVdrwPHJUA4bQnq4
        +D/MBAFbEDmVqpveVjQhtDWaS5bZPCfE23YEbb6UKv+Him45s1gX9rik1OOMKs1ZyE0LcKWME/V1l
        peuSK/0kbu/BpNwI3IfLzcNUSIXQaFG8kbbUdFnul44KHYwtY+6Hz0TIcVN4WPCNJ5xryZQP51pLx
        oclesC/w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKBD5-0005KG-Vl; Fri, 03 Apr 2020 01:33:28 +0000
Subject: Re: why does "mem auto-init: clearing system memory may take some
 time..." takes about 14 sec under 5.4.17 but only few msec under 5.5.1?
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <c7a23250-6b23-2a9e-88c8-924c34fb9139@gmx.de>
 <a8e02d42-a16a-c665-6a55-1c43818fa48c@infradead.org>
 <5f7c4aac-2b6c-3dc3-cf4d-ee6c19d0d959@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <011e98b7-e73d-99e3-d0e7-5b68f89636bf@infradead.org>
Date:   Thu, 2 Apr 2020 18:33:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5f7c4aac-2b6c-3dc3-cf4d-ee6c19d0d959@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 2:12 AM, Toralf Förster wrote:
> On 3/30/20 4:55 AM, Randy Dunlap wrote:
>> Hi > Toralf,
>>
>> Curious/odd.
>>
>> Do you have the kernel .config files for 5.4.17 and 5.5.1?
>> Looks like it would have to be a config difference AFAICT.
> 
> Sry,
> 
> attached the wrong configs at my previous mail. Here are 2 configs from the affected server attached.

Hi Toralf,

There's not much difference in the kernel config files, although
the one for 5.5.8 does have CONFIG_DEBUG_KERNEL=y while it's not set
in 5.4.17.

I built both kernels and booted them. I don't see a big time difference
like you reported.  Here's what I get:

5.4.17:

[    0.112274] mem auto-init: stack:off, heap alloc:on, heap free:on
[    0.112275] mem auto-init: clearing system memory may take some time...
[    0.621019] Memory: 3935312K/4095412K available (10243K kernel code, 1427K rwdata, 1924K rodata, 968K init, 768K bss, 160100K reserved, 0K cma-reserved)

and 5.5.8:

[    0.114455] mem auto-init: stack:off, heap alloc:on, heap free:on
[    0.114456] mem auto-init: clearing system memory may take some time...
[    0.622989] Memory: 3933200K/4095412K available (12291K kernel code, 1438K rwdata, 1952K rodata, 964K init, 708K bss, 162212K reserved, 0K cma-reserved)

but then a lot of the timestamps in your 5.5.8 log are 0.

-- 
~Randy

