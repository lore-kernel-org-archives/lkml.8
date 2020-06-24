Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D01C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA0320768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593035974;
	bh=melluhzqNmWHAYbNmzvj1J35Gv4F1lsN1EsHAvOqrpM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IOWOBba832cZ9TyPIh5xMdMlnyAtcqK515dXoDUlKGFPRE8Ltcib7gIff1UyX/jpj
	 gB1AJXBhiJprVyA/qMQISX7auV9ZZAZXcxg1don+yEzlknyO8KcGo070CjWyk0NS3P
	 rT+/c0ZUUPnRHhxrDL4N+2IYH7kWMRDTrTnB4J3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390770AbgFXV7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388452AbgFXV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:59:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:59:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k15so3405309otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEXhJgBgPrqHMMJogxhjG1bdCWukEFMnbzG4N1vRV7c=;
        b=JvVENXq1wzSp2eMxk6pEMLtvr0SU3Kd17HTaulkVgPEby4Sxex36KUd1Vcx/28tOf9
         9JMhb62xU6xGhdewqIjyWRnGYc2+zFMWBchj7DKMuct2Hzw+WWo2/tW8aXs5KhmOk3MR
         iQk87wZgxlQ5POjg4urLzVLbLz8xzgqMJt+uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEXhJgBgPrqHMMJogxhjG1bdCWukEFMnbzG4N1vRV7c=;
        b=tB58GvSUCkiuDwB/M4G7YpDhZI1/Etjp4uochoLg4BYv7anzfe0Y/t4FGCRDgjIaU+
         Ln922jZ2+wSMf+krzn3SoVS8Y+1PlBUCcwDjIAVxv9qV1stWi3rskuZ/t0Dhx54fw9WE
         qBdjZV7XpaG6ec+CvtnYSC2GSKk1C8F65tGPcM+Dfh6frvHtm7H5fgCEdBbpTyXQ4J9K
         qQtOcT7CGhWiBPu2+V9fYtThOSUOOxwO+x5mTVfDxb1dFvMLGnyljgSWjUtwkOy/5ru8
         YJOMXWB9eSE2OwvV2/ElcFUcFDdqsGVEOYnf4a5SQld3eK2l4IZODGv1T3J4gNvtFnrN
         ez4g==
X-Gm-Message-State: AOAM530jFrU95TEVsSqZ6ZZrdkZa7FlUZixi8E7+eEKtcZszIZFJ9DJe
        sCQiQ6rPNycG285GIJD4iAblRw==
X-Google-Smtp-Source: ABdhPJzsN/3QWLW2SpTQqN8LiebWhT0I3GqHv5grQ6oZDR90JY0rEk1dqlJNH7smQw4QUh5ZfP9cVA==
X-Received: by 2002:a05:6830:1dbb:: with SMTP id z27mr24465512oti.340.1593035971629;
        Wed, 24 Jun 2020 14:59:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f30sm1957785ook.4.2020.06.24.14.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 14:59:31 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/206] 4.19.130-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1b7194d1-b8f1-6b38-32ea-d8370c98bc59@linuxfoundation.org>
Date:   Wed, 24 Jun 2020 15:59:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 1:55 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.130 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

