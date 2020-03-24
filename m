Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB31C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABA320870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pL0afxlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgCXNZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:25:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53991 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgCXNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:25:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id b12so3179917wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JgEAVo+h2KzvKgD9gohdz9+sy8MG1M0rMtQ0IMKIBo=;
        b=pL0afxlgyYuxlAy2aJ2f4pMyRnBNpJaFAeGBzOfuByV8sqh7q4WkP4g9L9dsM0TrMJ
         MsjcFXmG1ZcLN/1ZRneJ5NM46sGAEY9HJbRecxzwaLNDu10MGoahXqm5sUL/TvCX1eVX
         R+4PqmQJDx1NqVV9ky4GBDsh8QeQnQmd20BtEtBp7bOOeGxgiInxgEYLbAjV6/YWUBnd
         rw8bOv1bzgciSgiz7TPQE5Mej8mMvDVHrRnNqZtAnRzOH1q0GNQSyQouSBwxXCHSpDEp
         6hmSR5gvZrQCMnM6ZIRK3k/1R3PX/vGg0Dopc5UjbKkAZ5qVR+IgcRqv7uB0wqDPauUr
         iDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JgEAVo+h2KzvKgD9gohdz9+sy8MG1M0rMtQ0IMKIBo=;
        b=DD2uPfwqCo/dXNNhAJGvpT4L0OfnbarMJdRIVNGUxFUEEf1OoA08XZDw4SrdQqvMZM
         xsVwLN7gT1fb1PfM08bMDQWhszmrSY/+UfZu/dzSZJWkEujc7tIbaJ4V6Say3s42l6/G
         CSRBEhiVC67MmzAjklpCOExTC8zHDAOGFt4WVkYrdnTcj1XpE01M+rWBUmvDgzKHcGfj
         brF/+wkvckMAfcw97n6KaKRFO3yk5h8vau8AIYQDgAHYpTHlIumLDEvcv4EuWs1eju7r
         E70XSEuSxaZr3yvyClknoI6P1YicSH4ZM1nCEb492zTATJM5Ej0d0j4SXVNusxqGUkbl
         ckGA==
X-Gm-Message-State: ANhLgQ1kWA4pqJQFYAVHZaU2PpAwBwzbLMv1IdER1WCqp8esVk3Inx1L
        qIJh9FDCL+whcrGgkkvqEQbE9XeKdfs=
X-Google-Smtp-Source: ADFU+vuygn50u5viVRe8jA1Uma1ZZIS4i0ebBLXI3yMDQMl6EY0lt8IYptSFHGUFVZvEFRcT7Lip6Q==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr1277278wmb.108.1585056347989;
        Tue, 24 Mar 2020 06:25:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i21sm4689117wmb.23.2020.03.24.06.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 06:25:47 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-kernel@vger.kernel.org
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
Date:   Tue, 24 Mar 2020 13:25:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200324122939.GA2348009@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2020 12:29, Greg KH wrote:
>> But the Idea here is :
>> We ended up with providing different options like read-only,root-only to
>> nvmem providers combined with read/write callbacks.
>> With that, there are some cases which are totally invalid, existing code
>> does very minimal check to ensure that before populating with correct
>> attributes to sysfs file. One of such case is with thunderbolt provider
>> which supports only write callback.
>>
>> With this new checks in place these flags and callbacks are correctly
>> validated, would result in correct file attributes.
> Why this crazy set of different groups?  You can set the mode of a sysfs
> file in the callback for when the file is about to be created, that's so
> much simpler and is what it is for.  This feels really hacky and almost
> impossible to follow:(
Thanks for the inputs, That definitely sounds much simpler to deal with.

Am guessing you are referring to is_bin_visible callback?

I will try to clean this up!

thanks,
srini
> 
> thanks,
> 
> greg k-h
