Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4AC20702
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967827;
	bh=4UtPzAQyTPAgUcvOAScDAZiQ7NSdQcCffg04YWiZKPs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=iHVt+nRGvMvnMw5IU/Rrk0Ord8X+D8ySfnVWkZCPM/VJE6dBWdOevrOrMFZKcG02d
	 CDofJawzEu6HbmNnw7mX3iMQlKGBGTdME7G8CJRX6IjddfAw3xqStP1QMGcvdDQZJx
	 gDWyd5ZCmQpzISnogV6qBQ29XYtWnxgQF2EInIKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHTX5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgHTX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE470C061344
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:49:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so272534otx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnJZDGXI6zXjEF62GaddKutFQulnWj8IVNGC78lZ79U=;
        b=HoGuJETd9azLWHZJlZzmu0v0cRLthoTFA8Tp4H3VoRjT9GCoMfsbUTvQfE90Ncqrd1
         1i0nX7haiTwpkjb7Ao/f1zRVrM1K5i4IwC9r72a3PlWrZ3VSVV7rF+xHX6//bKO4ZyYM
         oSCGYTWHwZf6Pi0yBxoCiVhIixkwYwRTApVJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnJZDGXI6zXjEF62GaddKutFQulnWj8IVNGC78lZ79U=;
        b=ImBEIOcWNPhb1ofJ7zlbbe2NMT7CPGJxQcTudS4d2+MmJAcBDGQZVwzDgli466TQQb
         L7s2VbBOfX8ZQVPhN0GTh1BXkWDNdQLBDnBvAhxKvLs/3jUzcT/UWDaoRof5qHyR/V7Z
         DWuzjo8UAacWhikHYShXK4o8uyXmpCPLaUAscaiSxFCQNIxLF3Trh+uDFI9QWHbW1T8S
         8YYO9KyBqH3bKmj+mCsL6CARI3S9F/JDXElwdpL19cidmEfQKeUNxEnwq1q1RaUt7arL
         oWZPcFvs9/kYFvDEXLkx67zXa/sp2hY/o80FTMVF8p+HSOx2vzF9vgKcFfmvdyP6ERWa
         6/nQ==
X-Gm-Message-State: AOAM532UEIyHN/oQV2xVO2bv2tNXTUOCNgUv+ZZ57eG/qJFZ/9o1QH8E
        uUIe20L00hjNZ05Wd8SA1dReDdkg5PvPtQ==
X-Google-Smtp-Source: ABdhPJxRJ/FeP0jRFjDaeoUAiGM7TW9cSgqPX9ZiMYmD2RDMMLX2o8oIrgP/YNz/BfAnG4aut5nsjQ==
X-Received: by 2002:a9d:171:: with SMTP id 104mr173955otu.256.1597967344102;
        Thu, 20 Aug 2020 16:49:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y66sm33087otb.37.2020.08.20.16.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:49:03 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/152] 5.4.60-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aff708b3-7abc-ba23-746c-4603246b52a6@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:49:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.60 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.60-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
