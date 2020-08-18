Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00B5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E01820709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597790229;
	bh=hUR2qDhaYWdcxc9Gpz1VWae/hvumfx5qhh8wRX+po7I=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=L17u7tojWfR4Miy5Hd1S5ZZfhOA9HhHBn4caVtcO0pfd+bRC0VDFrwFLF0js55x1n
	 4OeLWdY7FmJhcXHGIJvFlItJ0DdXM0IX883wPCaoLivbVhvdaQIzkiKLiUfsSGaEnx
	 9XYY586vt9cWYkVJSEC8N/xnD5GMtjRYhr0X1eFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHRWhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHRWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:37:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B38C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:37:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n128so15530111oif.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73Y+MT7r5XyV+Cr1TuQDj/66F8btZWmAus+HTymwMTw=;
        b=QtVX53UOnBH3nnNzznI1obMEqdSgHDzldLMWYlV4uBvJEckY3aaO/LMOjhgPH0R7Vl
         e7Rey1/vddK0+qbVFxCh73Ih2ijVZ87h0TLdDSkqdIEEA+FDIlw6vgj9r9yuYqI86dGd
         JK7T//mZmlnZZBMBsXHnxU96JJoL1wzMLK+mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73Y+MT7r5XyV+Cr1TuQDj/66F8btZWmAus+HTymwMTw=;
        b=LGzhhIZq6w3+T03qgtJRrnVJ1WVds2S1sfOIzZhJZLhD/WYdZMg3QfWcxhlA2FL3XD
         21L4yHkdzg6/9GNURJdqPdefO/eszigG8F1GdXddUDWxYqStuW3afS3zxBQnf5bPH7u1
         TZfoUeqkLVAVI/H2eYvGcqJtUi+KFZfiHixr9WaLzgZTGs4CfpBTaQXCaqP65mvslrdu
         6PhsrmpV43xP4+cHmK52QWwmpT9gVpGg/4jK2wxwocCjImnLgaPwAF7oMJJ8fsJ6EjL/
         Co0az3ttsmrN0GHxhn6SXRBX4YFJnXjj72uAXaiY1/ZrySYiaz7uhYDom7c7cOIGUEL4
         tXpA==
X-Gm-Message-State: AOAM530m25htnL5LCneOEnFHHOwXx9sJBjztRD0t7oJI0JbiqvJjg1pl
        ix6NT4PYOZp+Uuw9O+jmQPsuVQ==
X-Google-Smtp-Source: ABdhPJyvqUeFoR6R87jznn6iEr4Dw0TO27P67DAZKgBGHMdaa9KKPMpoyVKZeyaLQESdaJdryguFsQ==
X-Received: by 2002:aca:5102:: with SMTP id f2mr1447558oib.169.1597790222648;
        Tue, 18 Aug 2020 15:37:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a15sm4250035oid.49.2020.08.18.15.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:37:02 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/270] 5.4.59-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <06732ff3-cbe0-ab76-1280-2f0df64f6580@linuxfoundation.org>
Date:   Tue, 18 Aug 2020 16:37:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.59 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.59-rc1.gz
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
