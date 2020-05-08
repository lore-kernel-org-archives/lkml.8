Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC81C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3C5208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEHGlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:41:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgEHGln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:41:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63B79A0D0C0777DF1379;
        Fri,  8 May 2020 14:41:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 14:41:32 +0800
Subject: Re: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hewenliang <hewenliang4@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>
References: <63755ce8-5e1b-6c54-2f74-649cc2546371@web.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <9359694c-57bf-729f-593f-6e25c4b115f6@huawei.com>
Date:   Fri, 8 May 2020 14:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <63755ce8-5e1b-6c54-2f74-649cc2546371@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/8 4:30, Markus Elfring wrote:
>> The @data and @fd is leak in the error path of apply_xbc(), so this
>> patch fix it.
> 
> I suggest to improve this change description.
> 
> * Please use an imperative wording.
> 
> * Would you like to add the tag “Fixes”?
> 
> 
>> +++ b/tools/bootconfig/main.c
>> @@ -314,6 +314,7 @@  int apply_xbc(const char *path, const char *xbc_path)
>>  	ret = delete_xbc(path);
>>  	if (ret < 0) {
>>  		pr_err("Failed to delete previous boot config: %d\n", ret);
>> +		free(data);
>>  		return ret;
>>  	}
> 
> I propose to adjust the exception handling.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=6e7f2eacf09811d092c1b41263108ac7fe0d089d#n450
> 
> -		return ret;
> +		goto free_data;
> 
> 
>> @@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_path)
>>  	fd = open(path, O_RDWR | O_APPEND);
>>  	if (fd < 0) {
>>  		pr_err("Failed to open %s: %d\n", path, fd);
>> +		free(data);
>>  		return fd;
> 
> -		return fd;
> +		ret = fd;
> +		goto free_data;
> 
> 
>>  	}
>>  	/* TODO: Ensure the @path is initramfs/initrd image */
>>  	ret = write(fd, data, size + 8);
>>  	if (ret < 0) {
>>  		pr_err("Failed to apply a boot config: %d\n", ret);
>> -		return ret;
>> +		goto out;
> 
> +		goto free_data;
> 
> 
>>  	}
>>  	/* Write a magic word of the bootconfig */
>>  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
>>  	if (ret < 0) {
> 
> -	if (ret < 0) {
> +	if (ret < 0)
> 
> 
>>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
>> -		return ret;
>> +		goto out;
> 
> I suggest to avoid an extra jump at such a place.
> 
> 
>>  	}
> 
> -	}
> +
> 
> 
>> +out:
> 
> +close_fd:
>>  	close(fd);
> 
> +free_data:
>>  	free(data);
> 
> 
> How do you think about to complete the error handling also at other
> source code places?
> 
ok, I will modify and send the patch v2, thanks.

> Regards,
> Markus
> 
> 

