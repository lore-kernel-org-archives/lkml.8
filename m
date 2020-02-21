Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B0C3565D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2C1206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XickjLfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgBUSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:30:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUSaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:30:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so1404313pgu.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ViDmi6LANQiHZ9fbuRb7b9SQvH9otsi+PGHBtwaKrQM=;
        b=XickjLfbcjz4i5DfLBgvrvSjCgGrYe7fBppOOqIqcLJS5jW2sco8qVSMZUR9+Vdt/q
         R4qO7WFK50yG2U2oF8jIL+9AC7MO+gv00zJ4Te7OMHx0BOPYVhklWm8HQ5F4mO2cqK13
         vzER9mPVBhRipa54AiuDIzW2CpLKq+IFlCab4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ViDmi6LANQiHZ9fbuRb7b9SQvH9otsi+PGHBtwaKrQM=;
        b=GLdViePjMU50JYBjWviDQMLDf3dLY0ED8mb8Tg8djyVcfEdbhLqyh4yPV2ONoY1JUG
         kLTbQWFEHW+9Yd7gjtkOa3Zutsix9m3ZsOcQ/VkmjbLqPnqsEqlDDif7WyoiPXvMHSJf
         2oIJJT/6lAYr7Ex/Hb9D5aBpumybewb4tF5AN5FkWMkuBNnbF11TQS1BINWo1ebNDK/+
         qDoMpZ9Jn+IFr8CKePeeXUg+8VlmQTvwJ5fLepQBPI4SyeHmSMGJFtaoiATf5+B1RikM
         BT8KSfdSdss7P50kx9m+JepR3CsdcQD/2nNy5PsU3ecaYV+NWEl//3AvNG/rnJsxL0cl
         7G/A==
X-Gm-Message-State: APjAAAX4KpfThUeZN+6VrvpptGq1rMjutMzbJR4Z5YJcZNr3Zr0RMlhr
        /SU2I4FY5YkCPJc5uv2IStfEsw==
X-Google-Smtp-Source: APXvYqyo9nEvkqt/D9QeY7GO9t6Wbt7JpPLDlJgQzH/6aHvn9HigxRbtbwXnIcRQ8StTZHRoC3sI7A==
X-Received: by 2002:a63:5561:: with SMTP id f33mr39995141pgm.14.1582309829947;
        Fri, 21 Feb 2020 10:30:29 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s130sm3743993pfc.62.2020.02.21.10.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:30:28 -0800 (PST)
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
 <20200220084255.GW7838@kadam>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Date:   Fri, 21 Feb 2020 10:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220084255.GW7838@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for your review and valuable comments.
Will have to investigate fully and correct anything wrong.

On 2020-02-20 12:42 a.m., Dan Carpenter wrote:
> On Wed, Feb 19, 2020 at 04:48:21PM -0800, Scott Branden wrote:
>> +static int test_dev_config_update_size_t(const char *buf,
>> +					 size_t size,
>> +					 size_t *cfg)
>> +{
>> +	int ret;
>> +	long new;
>> +
>> +	ret = kstrtol(buf, 10, &new);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (new > SIZE_MAX)
> This "new" variable is long and SIZE_MAX is ULONG_MAX so the condition
> can't be true.
>
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	*(size_t *)cfg = new;
>> +	mutex_unlock(&test_fw_mutex);
>> +
>> +	/* Always return full write size even if we didn't consume all */
>> +	return size;
>> +}
>> +
>> +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
>> +{
>> +	size_t val;
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	val = cfg;
>> +	mutex_unlock(&test_fw_mutex);
> Both val and cfg are stack variables so there is no need for locking.
> Probably you meant to pass a pointer to cfg?
>
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%zu\n", val);
>> +}
>> +
>>   static ssize_t test_dev_config_show_int(char *buf, int cfg)
>>   {
>>   	int val;
> regards,
> dan carpenter
>
>

