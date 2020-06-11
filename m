Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A5EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D852065C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFKPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:05:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbgFKPFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:05:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 387103BFC6CE0BC04C58;
        Thu, 11 Jun 2020 23:05:15 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.88) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 11 Jun 2020
 23:05:08 +0800
Subject: Re: [PATCH next] perf tools: fix potential memleak in perf events
 parser
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, <Markus.Elfring@web.de>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
References: <20200611014234.24304-1-chenwandun@huawei.com>
 <20200611131651.GC18482@kernel.org>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <af4efc64-b55a-959c-b342-b70357f10173@huawei.com>
Date:   Thu, 11 Jun 2020 23:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200611131651.GC18482@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.88]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/6/11 21:16, Arnaldo Carvalho de Melo 写道:
> Em Thu, Jun 11, 2020 at 09:42:34AM +0800, Chen Wandun escreveu:
>> Fix potential memory leak in function parse_events_term__sym_hw()
>> and parse_events_term__clone().
>>
>> 1. Free memory when errors occur.
>> 2. Function new_term may return error, so it is need to free memory
>>     when the return value is negative.
> Try to fix one thing per patch, i.e. first the most obvious one, then
> the other that requires going thru the new_term() logic, i.e. first
> this, which is super easy to review:

> Would you like to add the tag “Fixes” to the commit message?
>
Hi, Arnaldo and Markus.


Thank you for your reply, I will update in v2

Best Regards,

     Chen Wandun



