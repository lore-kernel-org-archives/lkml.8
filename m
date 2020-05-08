Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA29C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEF92070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:19:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHLTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:19:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BE995CE615340AAD23F;
        Fri,  8 May 2020 19:18:58 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 19:18:51 +0800
Subject: Re: [PATCH v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Shiyuan Hu" <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
Date:   Fri, 8 May 2020 19:18:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/8 19:03, Markus Elfring wrote:
> …
>> +++ b/tools/bootconfig/main.c
>> @@ -314,31 +314,35 @@ int apply_xbc(const char *path, const char *xbc_path)
> …
>> +free_data:
>>  	free(data);
> …
> 
> Would any software users prefer to omit the memory release for
> a quicker program termination?
> 
> Can the commit message become clearer about the explanation for
> the importance of the proposed change?
> 
ok, thanks. this change can fix the warning of tools.

> Regards,
> Markus
> 
> 

