Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90834C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A60320675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594068921;
	bh=krWDS83/hftSDvyxvOYSbQhjtzu6ud5flupDuCyqiiE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z3nltohall8qbrMnliau1NVmm2wJNSSPY/IgmlNseQtssl+FbB6+6ow8Ebx9rI2+M
	 wPYO2h2PAR4zepHKslocod/sG/Bea2G8YxvS0LH/cN5OS3bWeSYLWk00rzly48ppDm
	 4sKxJIQ9tTM9JZusWOw9mtr3WCUeiOCwBdgZNBvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGFUzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFUzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:55:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DAEC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:55:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r8so33119425oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cynLjJyLUOsY4VOEmxldJUEFC/8ScvtiG3yRvbagFFo=;
        b=aw0L6ppw4UM72rsA+cDjHWgBPv5FMcleKEs8uLYdX4bLw8r5dNasFvLILv/6NLBZav
         Y0FYgqIQSOaiZiDHc7k9RLj+VuUJM/zKdL8XKkrW0oyGiwI4tHI4E4giXH1C+U99IDm5
         Kgq2WP3PqBKeRqAo7z9Jm0lDU7dbyShp0Glgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cynLjJyLUOsY4VOEmxldJUEFC/8ScvtiG3yRvbagFFo=;
        b=qbk5M1JBzh1u24J1zNCC/2Ey9xiPbtL6+eJ17JfV08xxb1s/wsq3KjMNWQLf/7tEX7
         5DziD2+85Cs2kbF+oZ2YhgsnAdI1OV2IjodvcfFQRwQRNyPVSOeZyi4VAawYnONky2En
         99C5Nl1t2AZ3I453sMSavf56OU+2+m6mY6nxkr0qSkHTluLAVxtLBZVzzgNi8KxXdjIK
         p1P59pmDxDmjbNPcLiYfLp9txK5d1snTm1t17M/Qkb1ds/nGIE0B1HbNij4yCnEDu8RP
         mq9SNnEYlsbkDrwRFtzC98woZnpFKViZ232gW84CBMU+nXhqmcKQsifsirJ6oPRJ0RwL
         k3KQ==
X-Gm-Message-State: AOAM533XIciYuOidX8GSFYio6LvOcK5hX9PLiAXtWFNXuwQJKaqKWbtA
        IYG28DiuKKAXlBgukLMxTQYsGw==
X-Google-Smtp-Source: ABdhPJzBgD2nIR407/PVN5Z/ENeWzlxgZrtqJqxnPCgMekbWkw4ce92Eg72NSk4VDT2msPBmZ/Kfpg==
X-Received: by 2002:aca:ea88:: with SMTP id i130mr896936oih.156.1594068918445;
        Mon, 06 Jul 2020 13:55:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n141sm4551294oig.24.2020.07.06.13.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 13:55:17 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
 <20200623204441.phngiwlj2idonpe6@wittgenstein>
 <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0b60da1-ce3f-da53-9ffc-94fea233181a@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 14:55:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 12:21 AM, Paolo Bonzini wrote:
> On 23/06/20 22:44, Christian Brauner wrote:
>>>   	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>>>   	if (ret < 0) {
>>> -		if (errno == ENOSYS)
>>> -			ksft_exit_skip(
>>> +		if (errno == ENOSYS) {
>>> +			ksft_test_result_skip(
>>>   				"%s test: pidfd_send_signal() syscall not supported\n",
>>>   				test_name);
>> If pidfd_send_signal() is not supported, you're falling through and then
>> you're reporting:
>>
>> ok 5 # SKIP pidfd_send_signal check for support test: pidfd_send_signal() syscall not supported
>> ok 6 pidfd_send_signal check for support test: pidfd_send_signal() syscall is supported. Tests can be executed
> 
> You're right, this needs a "return".
> 

Hi Paulo,

I am applying the rest of the patches in this series except this one.
Please send v3 for this.

thanks,
-- Shuah
