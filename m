Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58CCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24562065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594826301;
	bh=BE4nfUCM5upCtGB+VvYaPL1UXSpHGoFR76aJ46Bf3K0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wqFzIKbMWVeL/oGfg+nFKxND1+lEcHnQBrgdekCOwUy4fH5R/TAK1/5dq4UxMXqwM
	 Z2eUqthvrHWx0DjK5uOoNnR/LwJCcHzhwTQKJD+qFCaVVCx2SU4DPwQQtDzYlP8DYc
	 fG/KiPjKIGGx8kaeyXhsum6GPoVO7Pn9xMAkLAps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGOPSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgGOPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:18:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A5C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:18:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so1743799otq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGZrT5C+OJg/dALQFoR2ZSEYVyJtYgGFY+YpC3Erpsw=;
        b=C5RE3jdW4ZsdO1UdVDukf3InUdzEReBCssd7hCg8G1G/ZxF5LPBHeFwtJuWCPtizfV
         DNtQjrtzwALOkSRzxUnbiSoHK3v2CDFblx8To1rgM4bIidVH5nFM9hjaPaMwiHAez3Nj
         PJ8/QvXffLbUf+rc898BiuFM8Hb3unpxGKKDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGZrT5C+OJg/dALQFoR2ZSEYVyJtYgGFY+YpC3Erpsw=;
        b=G+4T7zSpTaLHO+3628urtW5zcq4Toj7K/Igt6WeA8bKR63LGiG9cH+GUCrjnhH2Rtf
         9ZqHDudVsKOHDPeLsM+1raUT7k54goyIXksw9Vpe8LQ0WPGB/ybfFAtRoZtYqOjoeFOM
         EYG1ybpdBizYmBMXtFtFzFNjAAYky33EOkTk+yuL21/eK8KXMu8uWRktSbIeb6RltK0m
         7FQZJYmwqoIb9UhPRRcVXTCLRUsKD0HuikNohSNcqa3HftiVaPh1K8LWNWcYmFB8bJBh
         t/81wRDOhXwhat3i4Xp0x2u+sAf+mdgxa1iJ9pJ/C/fZvXUYpRTpciAlP4jvyi5RoOB0
         /HtA==
X-Gm-Message-State: AOAM531riue6Pr1DImOj8jnnLxAKPg0PUA79PdtVvhWTsn9pI/c/78mq
        qGW9v3izc3G+AsVVbTSk6Uj8kQ==
X-Google-Smtp-Source: ABdhPJzcsWOqIAC9bUlBbYxT5fvs2+0huil4HgSCi+u8/mV6BPw3WkZeUOUph3tU6vKs+0neR4jl9w==
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr145626otr.116.1594826298533;
        Wed, 15 Jul 2020 08:18:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y1sm474728oto.1.2020.07.15.08.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:18:18 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/109] 5.4.52-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8cdff8fc-07c9-8d55-3559-21f5e7d3e537@linuxfoundation.org>
Date:   Wed, 15 Jul 2020 09:18:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 12:43 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.52 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jul 2020 18:40:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
