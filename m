Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09D52076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGQBTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:19:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbgGQBTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:19:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3E8B31C2C2E32A9A8F3;
        Fri, 17 Jul 2020 09:19:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 09:19:47 +0800
Subject: Re: [PATCH -next] s390/mm: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20200716090703.14315-1-miaoqinglang@huawei.com>
 <20200716112630.GB8484@osiris>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <8c16907a-e933-123e-880a-cdb76f4e56fc@huawei.com>
Date:   Fri, 17 Jul 2020 09:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716112630.GB8484@osiris>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/7/16 19:26, Heiko Carstens Ð´µÀ:
> On Thu, Jul 16, 2020 at 05:07:03PM +0800, Qinglang Miao wrote:
>> From: Chen Huang <chenhuang5@huawei.com>
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
>> ---
>>   arch/s390/mm/dump_pagetables.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
> Thanks for the patch, however we are going to convert the s390 page
> table dumper to generic code, so I'm not going to apply any cleanup
> patches for this code anymore.
Thanks for your replay, I'm glad to know that.

