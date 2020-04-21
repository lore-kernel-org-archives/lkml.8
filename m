Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547DC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C752070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587487816;
	bh=aEsNkHD0/awEs6mmzUftqfRrNzWzB+UVs0jmyzHOFic=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lLhFWjlFKG4S/dNJUPQIUhk42ctMX6unmVseVArqGXP935Zc1dKVe4clPKChBlR7n
	 wV80ZRUi2V6rdBSYH2x0N1Qq3lN7/k1cb84Aax5ozHawx7SyOJkBRwv6jLDJjrK4a7
	 nIi8K2lTDCIxZkQ+KeDCEMMhR1IbMF8dPKPzoe9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDUQuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgDUQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:50:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDD2206A1;
        Tue, 21 Apr 2020 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587487814;
        bh=aEsNkHD0/awEs6mmzUftqfRrNzWzB+UVs0jmyzHOFic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VTT4RXXjsoBgN2uPgGvfbWPxNtURv584EYyxVvp1AKSlY8ZtWl3XQQ0igJd+qSnw6
         wcip7wQUIi7OKXszcfJPTgNZVQ5g4xqycDlAJFYXw1l/LQnEZvTzRPbRR1q3jX+9vK
         3d2GC98JLA4xrDmx8BI5D4RyDOjcJcDM5TTpy7e4=
Subject: Re: [PATCH 5.6 00/71] 5.6.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200420121508.491252919@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b2fe599c-4cd6-1302-99ad-336fdaf67912@kernel.org>
Date:   Tue, 21 Apr 2020 10:49:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 6:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.6 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2020 12:10:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.
Reboot/poweroff worked with no hangs.

thanks,
-- Shuah

