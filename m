Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B4A2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591395113;
	bh=2vf0FVyNZ6JpMRIcZ4BUF4fBDhd5ywj3M5c6lC8qKN8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fqx/LaK8l+nHFf1iKPg1W4+TyiNL1e57lY+GlvxBiWqYBITAIM4xPMpBAXBI7l2CU
	 wZbLVVfLJHqIO0fJhinU8iNeGAtkfS2mji/ExJ94Pjumd+1ialV+z4w6d2kBxcNNvn
	 M0U1uxmrt9TcXgMbAxhp41d2i+rDOU4lbB2jRBWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgFEWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFEWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:11:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19709C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:11:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so8828270otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8V5hic85NTB4BCMrwgvie7KOwB1pB6CZu7nqNX+a3YA=;
        b=SU9DQBp86kYcCXakYR/iEltre6dJMGNiAKuyOP/xU5Qn8CgHbZ3DejtlDImhLt6Jes
         BGH4gNcAUt0RK/oz8ZXGqj1eOPJanev1F4mXzfzVrdIzhz18FfHYRubmC/I7o4th22U9
         VXbj0MyqTIF3UzBwovLMxah9GJqc3YYatEyF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8V5hic85NTB4BCMrwgvie7KOwB1pB6CZu7nqNX+a3YA=;
        b=eeaPYy8pbdqR9CJFz4LggY5r6dNj3xXReTIdczqxkxHKcns8Qtys0n/jb1ocpvaEJ/
         o/vcsJd2ufgLTVrT1HfoAAVIURI7gF7i5JJM2ThNMzglbqLFie/M+ixFr8kShok0gFMo
         vegDbIjnxfErngmC1xD2Jn+CLEMBH+nCWloVtTWbul+0lzq/rsQ6XztAE8HKNas8xJz6
         yJJ8+aWG5SnQAs5IqBSn27h7pXXZApGEMWSnWg9YEgF50jHtNXL5pbaGoJJiQXld8B1d
         stCiBwuyJzTWFYYxB2g79VB9Y5NXjm4AK7kMu6fygQ7EGWNzz6m4NbP6vU9aFv2OHgBZ
         iTBQ==
X-Gm-Message-State: AOAM532Yd8X/GzNsbGB9fFxV+OFhsOLqamJBFlNT/v563XleicGGQLKv
        QftvGirQiGDhatNgmou5widp9A==
X-Google-Smtp-Source: ABdhPJxEzMZ/BxdaHLB5o03WPB71MwVAbSenenf167qBSXxJ3tXee/kwm3LZSEsGbUa19Qm4DItFkw==
X-Received: by 2002:a9d:6a87:: with SMTP id l7mr9005247otq.265.1591395111455;
        Fri, 05 Jun 2020 15:11:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q65sm950420oia.13.2020.06.05.15.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:11:50 -0700 (PDT)
Subject: Re: [PATCH 5.7 00/14] 5.7.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200605135951.018731965@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ca04681a-77a3-09b8-d399-a27f1e48ba75@linuxfoundation.org>
Date:   Fri, 5 Jun 2020 16:11:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605135951.018731965@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 8:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.1 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

