Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2FCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6613220708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:32:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgEHKco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:32:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B9288C16EDEDE9957474;
        Fri,  8 May 2020 18:32:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 18:32:31 +0800
Subject: Re: [PATCH v2] tools/bootconfig: fix resource leak in apply_xbc()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <Markus.Elfring@web.de>,
        <kernel-janitors@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
 <20200508093059.GF9365@kadam>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <5e8e9e2e-e7a0-a9f7-79d7-1b48d5f7a6ae@huawei.com>
Date:   Fri, 8 May 2020 18:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200508093059.GF9365@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/8 17:30, Dan Carpenter wrote:
> On Fri, May 08, 2020 at 02:51:15PM +0800, Yunfeng Ye wrote:
>> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
>> index 16b9a420e6fd..d034f86022b7 100644
>> --- a/tools/bootconfig/main.c
>> +++ b/tools/bootconfig/main.c
>> @@ -314,31 +314,33 @@ int apply_xbc(const char *path, const char *xbc_path)
>>  	ret = delete_xbc(path);
>>  	if (ret < 0) {
>>  		pr_err("Failed to delete previous boot config: %d\n", ret);
>> -		return ret;
>> +		goto free_data;
>>  	}
>>
>>  	/* Apply new one */
>>  	fd = open(path, O_RDWR | O_APPEND);
>>  	if (fd < 0) {
>>  		pr_err("Failed to open %s: %d\n", path, fd);
>> -		return fd;
>> +		ret = fd;
>> +		goto free_data;
>>  	}
>>  	/* TODO: Ensure the @path is initramfs/initrd image */
>>  	ret = write(fd, data, size + 8);
>>  	if (ret < 0) {
>>  		pr_err("Failed to apply a boot config: %d\n", ret);
>> -		return ret;
>> +		goto close_fd;
>>  	}
>>  	/* Write a magic word of the bootconfig */
>>  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> 
> write returns the number of bytes written on success
> 
>> -	if (ret < 0) {
>> +	if (ret < 0)
>>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
>> -		return ret;
>> -	}
>> +
>> +close_fd:
>>  	close(fd);
>> +free_data:
>>  	free(data);
>>
>> -	return 0;
>> +	return ret;
> 
> But we want to return zero on success.
> 
yes, I should set 'ret' to 0 before returning on success. thanks.

>>  }
> 
> Btw, these leaks are totally harmless.  This is a short running user
> space program with is going to immediately exit on error so the memory
> will be freed anyway.  But the benifit is to silence static checker
> warnings so that's useful.
> 
> regards,
> dan carpenter
> 
> 
> .
> 

