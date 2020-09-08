Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AE921D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzitBvmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgIHIT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgIHITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:19:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:19:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so18078904wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=onJm5JoeC8wX6+ligEVQFIaG2k7uPzPHxbYAuHbpW6s=;
        b=dzitBvmxxPd0DOKY9vCthE+mkoJQdvLGSUrs45nVY4M2qJIhMIdhBpg+WPNIEgAjwp
         5UWlLrxf7Ppw74nA3bkqczIe988DdwWh1PM+3HL101h8pJB9EtURdgqnb7ni48A4zE5T
         UUxGfMrgNOVAtzRNhGwxcue4hF8QcriQCL26kKOANnOTW21JuHdjbn9Q4IQlGBMMu5TY
         jJkmwnqSskLaP3dH4lSMdhEetwX5bQVtQlMHWU0KFDaax4lvrE4F0OdR1Ofj3KgmC3BN
         7GHontSjT9d2tK8/GyDr5/MIWOQvrYqBJb2IrFXXIZ+b0P2zbDeYwDIIQcmP7CRAQkh4
         HCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onJm5JoeC8wX6+ligEVQFIaG2k7uPzPHxbYAuHbpW6s=;
        b=ffhmY6kXsjK4MPI3MdWHcGpWplzrkILns3e57giQuHX//rSkGJBaJofM3qxiY2///6
         gCelL9RG4Nqihq/ZLHS5Nq9fQn7oAANZlnLsd8CuTYhBGNaPRywBxKtpqSuds4h8Atlx
         cJi7Td6LSsP8Ro7iwUNpvn9Gh/1iu2dYVpcETIyAQxYgwIpVvt1SVMNHqsc0iyo1j8uh
         WKNJdPKNmgh8qozZD8aZD5FoUlOH7g4u+QLPXBmYVOaqcWuOWuS839g5v8OJKitUaWoO
         SkMAVEIg1nCKdLxF0OkAeLAVF+L6dV0Gj2RmwCOHMNfAmaQMw4MfL4mzRPX4rQEleeit
         NgAA==
X-Gm-Message-State: AOAM531Tnev4NuC1PdoBc6ebgUSJU8wLZIEk4xi0CuBoKXF8DZbeiSl4
        t+Zm+9BRIxEAjQ6B0BsOIc1p13M2d+79WQ==
X-Google-Smtp-Source: ABdhPJxj2bfSNW8Ovib+gu1LoHpS3QT4XJEReAaEIVQ3y4/K/GkrM+u+4MSvbj4y4JreCiUH4teq/Q==
X-Received: by 2002:adf:ab5a:: with SMTP id r26mr24977054wrc.194.1599553192356;
        Tue, 08 Sep 2020 01:19:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id c205sm31146488wmd.33.2020.09.08.01.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 01:19:51 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Jonathan Marek <jonathan@marek.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
 <20200907123344.GA2371705@kroah.com>
 <a9d142c9-8a61-ee59-d849-393af1b3eaec@marek.ca>
 <e0db9beb-bbd2-8f20-d7f4-675b62acf782@linaro.org>
 <4b617c4c-f0f8-3d6b-c726-9dd4bf705fbc@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ba161732-038e-de38-e357-a36494ad92ab@linaro.org>
Date:   Tue, 8 Sep 2020 09:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4b617c4c-f0f8-3d6b-c726-9dd4bf705fbc@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2020 15:02, Jonathan Marek wrote:
>>>
>>> Srini do you have any suggestions for how to name these values?
>>
>> These are domain id corresponding to each core.
>> you can use SDSP_DOMAIN_ID in here!
>> these are already defined in the file as:
>>
>> #define ADSP_DOMAIN_ID (0)
>> #define MDSP_DOMAIN_ID (1)
>> #define SDSP_DOMAIN_ID (2)
>> #define CDSP_DOMAIN_ID (3)
>>
> 
> I don't think this is right:
> 
> FASTRPC_IOCTL_INIT_ATTACH uses pd = 0
> FASTRPC_IOCTL_INIT_CREATE uses pd = 1
> 
> And these two ioctl are used with all DSP cores. So it wouldn't make 
> sense for the pd value to correspond to the domain id.
> 
You are right, values are pretty much similar to domain ids but not 
exactly the same as Protection Domain(PD) ids.

I spoke to qcom guys about this, and this is what I have.

0 is Audio Process PD
1 is Dynamic User PD, cases like SNPE or CV
2 is Sensor Process PD.


Hope this helps!

--srini
