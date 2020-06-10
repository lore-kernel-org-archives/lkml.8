Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68598206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591817881;
	bh=j2yp4piU/UtHkBTu69UdUH0/br279V+t4NUSMCxtTkg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=C5Fa64piqdgJuO9GZhFahnfanZiajFq+jItQppIb3oqbdHkGEpTMVn1Zx5pVmXSYT
	 63O/7qjldImgg04iiuz46MlFSNGxvFxLzcI0dYwqVM5g650o0BImyjfXwjsfHeHotl
	 WLSp/5pzG1mRT2dCRTfEkVtrx1hQl4bGoU1qh8xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgFJTh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFJTh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:37:58 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:37:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i74so3223851oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qw7mwA33eVi6Ku9Rv3oEh0XhxvWo5n6dAxDv4/ZVn4Q=;
        b=Cl+/Mzk/0SZ3XffJNq32Ne2MCmXxwekCz05Fm7Bm+7CjSaVPVxcMysuVRdv6C0EWDP
         CUQBz+ypmPSZ47o1g8EQveiPFae2ysIw2eXX3xojpL6fd2zPjvbsEvaP3Ag/m1VR4qnP
         Lpo+qYxyrZAJqTh+YQQSLf7sZfyS7a42TjO+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qw7mwA33eVi6Ku9Rv3oEh0XhxvWo5n6dAxDv4/ZVn4Q=;
        b=KeVL1Sgq8hIn2myoOb5/CDIQ8mDXRRoFjByco3pg2qtH/Mknk5FVu0/09OfXjehX/c
         dPutLRU4GA1UZiMXMq5VYSRq+KPZdOjYezd9Te124yEeWu97DfgukkF60gpGA5xb6eY5
         p0R1ta69k3sJyerxVQ2IjhmTIStXPhUAHrU9PLPuOYWM4PdLvv4WEuclfc61tPMUwqI9
         1jlBe9q81JRntw9gbFHHgKfGhUKRX0/pkmpZkXcLBQ07mHuhpCjG6KPUe9BEykdOm/4R
         lwQWiKJjDfaifnulqOyyFpNFmI4zoJ1quHzN1J1+YGbCSnb/t9sQ2gvxwTuRISWFkUDI
         5NtQ==
X-Gm-Message-State: AOAM5319C+DnTd9yhQlBunprXZ5HwWb0F7m/17ALi2XthuPWpH21guOD
        W9nyKrc65pYiR1ANMEZPom33zA==
X-Google-Smtp-Source: ABdhPJzVvS64iuCcJSk72RzaJ30X/jutQHsqxWHMVgIr8ZyLUB7b5a8cG2WaomugGeNTRmgB+YVfhA==
X-Received: by 2002:aca:b155:: with SMTP id a82mr3658802oif.122.1591817878292;
        Wed, 10 Jun 2020 12:37:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d13sm198468otq.46.2020.06.10.12.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 12:37:57 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/36] 4.4.227-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200609190211.793882726@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d78b5b05-2f40-9152-1752-4a1823d0ab46@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 13:37:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609190211.793882726@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.227 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 19:02:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.227-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
