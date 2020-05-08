Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AECC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C645A208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHLnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:43:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHLnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:43:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DBA5A7C8E54374FEAA2;
        Fri,  8 May 2020 19:43:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 19:43:08 +0800
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Shiyuan Hu" <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
 <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
 <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
Date:   Fri, 8 May 2020 19:42:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/8 19:30, Markus Elfring wrote:
>> this change can fix the warning of tools.
> 
> Would you like to point any specific source code analysis tools out
> for this issue?
> (Can a corresponding attribution become relevant for a clearer
> change description?)
> 
The tools we used is not for open source. it point out some error description like
"Memory leak: data" and "Resource leak: fd" in tools/bootconfig/main.c.

Can I only description:
  "Memory and resource leak is found by a static code analysis tools" ? thanks.


> Regards,
> Markus
> 
> 

