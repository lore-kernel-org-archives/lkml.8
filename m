Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97226C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B14D206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCGeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:34:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgFCGeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:34:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9106DF82E31B2524F33A;
        Wed,  3 Jun 2020 14:34:12 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.205) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 14:34:08 +0800
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        <linuxppc-dev@lists.ozlabs.org>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Frederic Barrat" <fbarrat@linux.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
 <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
 <20200603061443.GB531505@kroah.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <20ae5516-7e41-f706-46ba-955e1936f183@huawei.com>
Date:   Wed, 3 Jun 2020 14:34:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200603061443.GB531505@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/6/3 14:14, Greg Kroah-Hartman 写道:
> On Wed, Jun 03, 2020 at 09:42:41AM +0800, wanghai (M) wrote:
>> 在 2020/6/3 1:20, Markus Elfring 写道:
>>>> Fix it by adding a call to kobject_put() in the error path of
>>>> kobject_init_and_add().
>>> Thanks for another completion of the exception handling.
>>>
>>> Would an other patch subject be a bit nicer?
>> Thanks for the guidance, I will perfect this description and send a v2
> Please note that you are responding to someone that a lot of kernel
> developers and maintainers have blacklisted as being very annoying and
> not helpful at all.
>
> Please do not feel that you need to respond to, or change any patch in
> response to their emails at all.
>
> I strongly recommend you just add them to your filters to not have to
> see their messages.  That's what I have done.
>
> thanks,
>
> greg k-h
>
> .

Okay, so I don’t have to send the v2 patch.


--

thanks,

Wang Hai


