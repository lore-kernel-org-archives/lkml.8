Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54CEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A10F20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwII+POC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgCYKkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:40:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:40:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id z5so1795489wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nj2kazE3YWhtgF6kfE4asmf5+zrkJeM2oOuF3hQW69M=;
        b=iwII+POCZ/RfTdTjkQcv7QrcqMvLpTLbas3kOG65ZGW32RvEv/n39QzxHr8ydZ/0pY
         EcCN8APvVWixkMiHHnni2aDyj+rlAvBIoify7ydBx9vssCqfN7su8MrS5gAtRGOCWRXf
         +IrHcsmoVRyzsWCB6CvWl27hwkltv5CICVnnNt9kYb7zU+DPXW425hicW5paWlM/SOgq
         F4/pwAa0C61YbZaU92FgveDLb239Xt45y7GV25FW0kqnSP+iWfkxVFpekkb+LMIXcKtF
         DyIej6NEvipcQKnf5gwimij/86+1+kqLoA3GZo1fhguq86IUPlNHKBe+0zo4X1LBPZNn
         0S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nj2kazE3YWhtgF6kfE4asmf5+zrkJeM2oOuF3hQW69M=;
        b=Qh1NInASc5sliZfB7za2zpuUYRNAePq1PiheBYA5PMPg6i97h7M7crUlEk82SGwWsb
         QQ5wL3q3r3mRN5pVe0akqxXaHpSvG4bqCFxWS0YDBeU+MoqPr16LEqln1emf0UGfmgeV
         Jsz1iXwzjDUnwRbLGCLpoDHDv2i1JyDZzVHW108kH07S+AN+d8nPQCwDfRRoAM/qRxhh
         PCMR7LUoDDZOilr94DnaBOXUsz8w2ktps2NvLOrqXV4jiO3gv/AGXtQJvY4ufgeBuX2I
         53Ypv5O/IhkbYc7QqA8ZAqpKNOlEU5x7Lk8SDXLYP5nzeCCSbPChLFHOK5OM9LqL8Zl7
         GkGg==
X-Gm-Message-State: ANhLgQ2Nc7ID8JNO9u5/fbWkVoJZXE12cuhN7q7A6yrmQHgtfi4t6M8M
        rXIB9db1RqmsnGX8GLSET4UenxIyAVY=
X-Google-Smtp-Source: ADFU+vsvGWTT4bPfupnS9X8Zt+rqYP6nV/+xSU4FPyFBOzB4M/xJV9WpPLK+dWVZDPppn+B8Oq/JJw==
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr2716565wmf.41.1585132811442;
        Wed, 25 Mar 2020 03:40:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u5sm25318696wrq.85.2020.03.25.03.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 03:40:10 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmem: core: use is_bin_visible for permissions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
References: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
 <20200325100138.17854-3-srinivas.kandagatla@linaro.org>
 <20200325102134.GA3084470@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e1e768dd-7e6f-b917-dfb6-cf2e1fc6114a@linaro.org>
Date:   Wed, 25 Mar 2020 10:40:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200325102134.GA3084470@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/2020 10:21, Greg KH wrote:
>> -
>>   const struct attribute_group **nvmem_sysfs_get_groups(
>>   					struct nvmem_device *nvmem,
>>   					const struct nvmem_config *config)
> You no longer need any parameters for this function, right?
no we do not need that, I can update that in next version.

> 
> Also, you really don't even need the function, just point to the
> variable instead.
We have a use case where in the user can chose to not have sysfs entry, 
specially if we have hypervisor trapping access to some range of entries 
in nvmem. This is enforced using CONFIG_NVMEM_SYSFS option.

Currently in upstream we have a stub function when CONFIG_NVMEM_SYSFS is 
not selected returning NULL.

If we want to remove this function and subsequently the nvmem-sysfs.c 
file then we have to have #ifdef in the code which am okay to do if that 
is something that you are keen on.


thanks,
srini

> 
> thanks,
