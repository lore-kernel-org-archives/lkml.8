Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AA0C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE18920732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584750918;
	bh=z+TEk+VsE307yZZ0f+TRvYUS5mNXvPUK1zT7UpvRyZk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Km8YeJbOBFzVMYMKtAXoU0IvjLVEEKBKstJ8hXsQ9ueXxMp/b3UxNcMtov5KWVdha
	 rMcpXbhRdbbBlap0XLnXoC2tUlMOuSVSjb259E6KyJf91YoAXgu7d2CWBI5cmu5ORg
	 gDfPxfbkJeItZIe0nTjDAdZqQPA72JoDY63+WN+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCUAfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:35:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D282070A;
        Sat, 21 Mar 2020 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584750916;
        bh=z+TEk+VsE307yZZ0f+TRvYUS5mNXvPUK1zT7UpvRyZk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ETHR9sHxWRPldf+O9bAPC4q6r9JDgjDDrcbAS4TV5vTKO7LqijpsvDm+/dI8M+yyU
         UjNI52s+S4AJdo02n5iQn9xYLEWcJMN98xg7gf5F4FQ/tgcAWPzG6zf+SrN4FTruSF
         sYMGLXnqyhN6mStEih+w8w9MtmyLzQFC9uok5H1Q=
Subject: Re: [PATCH 5.5 00/54] 5.5.11-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200320113335.277810029@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <35b62550-2e03-9595-8518-efba73d17f09@kernel.org>
Date:   Fri, 20 Mar 2020 18:34:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320113335.277810029@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 5:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.11 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Mar 2020 11:32:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.11-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
