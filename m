Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF3FC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619FB20732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751446;
	bh=h4P7E0pVLo9O7XlYssZcLGMTxlYJWYNtFW0fo8tGXbU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VgSFCMalnDb9a43cj1083yA/vQHcohqRArRfKzRAwyaV9qBAdg7WMoXaYs9rf3I8Z
	 uxDZ+Iaj4vU5BEjIplpnh15DoeyBHxwMMvGX2MYBgkDpDi35/bVEbVK7d47GT+fNf+
	 FoVXsO04AWxKVVu/Ee/odQ0yhh8kp6depDxaRIY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCUAoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:44:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA252070A;
        Sat, 21 Mar 2020 00:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584751444;
        bh=h4P7E0pVLo9O7XlYssZcLGMTxlYJWYNtFW0fo8tGXbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fw8QCccp9N7Wfil+KZrTrNva5n3LN5BLVmGBblxtIgY6f7oCpj9PzjZ3IhljQRXKJ
         h3Rzp2ifFewxO2LxBTEgxdfB7JW+u+sMjMOhfNSEK5XbdSKyEBcK/LHg9PEnMbx845
         naGHLUWM9OzKd+kUVhXoeq1G80Cmxjr+i3hu8Tc8=
Subject: Re: [PATCH 4.14 00/99] 4.14.174-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200319123941.630731708@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <2401f255-a2c6-aeb5-ba43-54ca2ed67d5d@kernel.org>
Date:   Fri, 20 Mar 2020 18:44:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 7:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.174 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 21 Mar 2020 12:37:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.174-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

