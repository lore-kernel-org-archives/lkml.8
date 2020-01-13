Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C3C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE295207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMOKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:10:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgAMOKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:10:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B278465F1C7162D1F9F;
        Mon, 13 Jan 2020 22:10:14 +0800 (CST)
Received: from [127.0.0.1] (10.133.229.220) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 22:10:12 +0800
Subject: Re: [PATCH] trace: ras: print the raw data of arm processor error
 info
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
CC:     <tony.luck@intel.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191214121109.8349-1-xiexiuqi@huawei.com>
 <20200109114603.GC5603@zn.tnic>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <3086a22d-6d66-df74-5878-60a8fc0f1499@huawei.com>
Date:   Mon, 13 Jan 2020 22:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200109114603.GC5603@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.229.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

What do you think of this patch?

On 2020/1/9 19:46, Borislav Petkov wrote:
>>  );
>>  
>>  /*
>> -- 
> That's for ARM folks to decide whether they wanna shuffle raw error
> records into userspace like that. CCed.

