Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26159C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0180F20756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7YCoH5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHLNZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgHLNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:25:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868FC06174A;
        Wed, 12 Aug 2020 06:25:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x15so1098657plr.11;
        Wed, 12 Aug 2020 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vsh9LbZS25VEwc0/PjxhGwt9OFiuf3IWSR0oj9yoXvw=;
        b=S7YCoH5o5rRbjQDSAxwO7eUJunX0kiLLGSMwZIWFWHz47Qw4/FgRFtCSjTTRcdUSu8
         9lVM94zWynKyrTS7KAxQji9qr/iZPkxY4fHzegWZJ354ByrUZiCkJ2NxJdk5h4ve4BMr
         dhJsQbllIxeqa9vrvc0fjQMSspTj1JbpkyxswO+lmuv4DQUQuUgAALFv2d8NBmmOjCLA
         Qe8JkUHBVvAg3IrdDM/mzYUoY8LDCNS4yX5wkPY0RGDX1FXJeNFhhey6Pkim+zPRJVz+
         ccR56uyIIHgZODeNBFkhXmcGFmJ8YIK+D5kFCR9iRFuExidvNlX2ebarebvG+MuGptfp
         KDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsh9LbZS25VEwc0/PjxhGwt9OFiuf3IWSR0oj9yoXvw=;
        b=R7skH/JdBp8yvi1zTXeMpUUd6MZZO/G7xVE/1IiKfovUKs8YSL8bJq6pqjAduTHR+f
         1zPQqwwKkNviIyCpGnIhT7gZLFwNWVuZFsUSkqnPMf5OUWdzKr+gdw4K/JDISRoWewi5
         HpaeCWygHVGxmVI3xqev/k+Fa8xsHANiCZhdCQ04C40ipU5tuAl3SCP3hLZ8DIJ6yrA+
         KHKVm7PYa4/oq48j3dea59JU9VSKTu6nNeZk4i527iW1BKL11hw8vcSG69xtMIVjSiGv
         tRU0NV/cJT05N9OhxQulSMgIk3UwzdoZBL3fQ0qStP8TbViPoD6MgqpAXdymwXKlCRHy
         I0Rg==
X-Gm-Message-State: AOAM531hIQM07pEJ+X7IOWQ3bv2ZPPUKPHZJrq3pgKPsLMpedUG6uCld
        lYTayh4e74TJLoIlB10rRjINuPyx
X-Google-Smtp-Source: ABdhPJywf5fkn5zbDctc5x8qw8OsvqeoMPKQfTt9CtRGOb52x5SpB0j4fnR6UiwnM7F93mibL4bXdA==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr5285483plb.179.1597238738473;
        Wed, 12 Aug 2020 06:25:38 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id q71sm2247255pjq.7.2020.08.12.06.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:25:38 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: integrates dir-entry getting and validation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
 <20200806010229.24690-1-kohada.t2@gmail.com>
 <003c01d66edc$edbb1690$c93143b0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
Date:   Wed, 12 Aug 2020 22:25:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <003c01d66edc$edbb1690$c93143b0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

>> @@ -171,7 +174,9 @@ struct exfat_entry_set_cache {
>>   	unsigned int start_off;
>>   	int num_bh;
>>   	struct buffer_head *bh[DIR_CACHE_SIZE];
>> -	unsigned int num_entries;
>> +	int num_entries;
>> +	struct exfat_de_file *de_file;
>> +	struct exfat_de_stream *de_stream;
> I prefer to assign validated entries to **de and use it using enum value.
> 	struct exfat_dentry **de;

I've tried several implementations that add a struct exfat_dentry type.(*de0 & *de1;  *de[2]; etc...)
The problem with the struct exfat_dentry type is that it is too flexible for type.
This means weak typing.
Therefore, when using them,
	de[XXX_FILE]->dentry.file.zzz ...
It is necessary to re-specify the type. (against the DRY principle)
Strong typing prevents use with wrong type, at compiling.

I think the approach of using de_file/de_stream could be strongly typed.
I don't think we need excessive flexibility.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
