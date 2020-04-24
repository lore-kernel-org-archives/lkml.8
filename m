Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214FFC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64ED2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587746917;
	bh=p+QeMID3kPyii7SFNnhDqEwYvz2LQWPZooNHuLS2yt4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=a5HtXasvW7jZpJ+QH0BrZr/R/wpLRu1MSJNWg9rU1gULpXp1zz9k9L8liOMT13wOU
	 fTLdlqnSrafyKzx27E86F61Aso0rnBL4R3o7oTePVK3xlW04DHQwLktVqeR147iIF2
	 g25dFgwWP3bFrMOUUCm1v8A6fy06ZaAFWQOqqIKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgDXQsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgDXQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:48:36 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A07E20728;
        Fri, 24 Apr 2020 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587746915;
        bh=p+QeMID3kPyii7SFNnhDqEwYvz2LQWPZooNHuLS2yt4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nc009m0S8u4PHZKfUp1lsY552kDX+HfDJXbWqww/OQbZjY3ct8Hp7Zj9kz4FrrgWe
         E/Gd/qELtWw6mkJBx+WvWkkTUC5TRMkdn68FyrRMxoQjYHQxwnD4G9fq+0o+udnXU6
         6r+QWSOg89K66eVfu/BggTegjg9R1stcCczdAyFA=
Subject: Re: [PATCH 4.9 000/124] 4.9.220-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200423103316.219054872@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5c7f48f5-ba5d-2ce3-3bee-5faf286042f3@kernel.org>
Date:   Fri, 24 Apr 2020 10:48:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423103316.219054872@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 4:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.220 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Apr 2020 10:31:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.220-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions,

thanks,
-- Shuah

