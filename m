Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2651BC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E785524670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579033975;
	bh=BvchwnWX9uvOtszORMeobzv/JaudnIkPV66R6bjuO/E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jzTdjbsevtqUFAJ9t4eJu6IHAIzZRVzdWNPmT49XwaJtuf8ffh1cRBMcv4xnzb+7Q
	 5/83IYl2vbOjgg9QXjNEIYNZNljtx0X09lzTiXGzYC+jJlZvspflOcybwc24vzsU0U
	 Tj8+3KHq45MMC8QAgs8L9KwRlKig6sNdGOXJlupc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgANUcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:32:53 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65EEF24655;
        Tue, 14 Jan 2020 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579033972;
        bh=BvchwnWX9uvOtszORMeobzv/JaudnIkPV66R6bjuO/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=By0zjO5g8GDo0SDNw+apeJlpiha3PhIq6P4bYSXMB5xDDpSSi/T3RcjdrWUNeUW9I
         jmrafwpyjAuqMsbMC8nxVT97+CoqLH8TOFfjAQ3uGbnYKcZg0D5vGnMmvkB0ZmX955
         4QKhxDLMslhDtmhLwsSmUl7J2y0DUZ6f11Z1v3Q4=
Subject: Re: [PATCH 4.9 00/31] 4.9.210-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200114094334.725604663@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <11099c2f-d807-a784-87a8-0340459a1e84@kernel.org>
Date:   Tue, 14 Jan 2020 13:32:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 3:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.210 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.210-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

