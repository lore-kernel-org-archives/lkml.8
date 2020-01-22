Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB949C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8553424673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579726355;
	bh=oNUL379nV0bqZZNWGpgtIBHQU000RcUJt4vm6BlsP2s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rWLoA1ehFEnbEtt00W7xA+F7VhmI9vSoajUIzqmCz/jQzep78SuekJTdIBkxIJFgw
	 wmXksac6nL34+DQ4KpCfYjr8aHRd2px1VOX/Rk5FDHAszk/nHt+2O2IpwUWixp0iLh
	 aWm8HUmGMx+gBDWncr42jCosc3DvqAHDZycPnYR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAVUwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:52:34 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1842087E;
        Wed, 22 Jan 2020 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579726354;
        bh=oNUL379nV0bqZZNWGpgtIBHQU000RcUJt4vm6BlsP2s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=chrLZbo8zWFHbCMXQn+W10q9/eEKwWjV/Encp4T2iWMzh6jymtIdTzilc9QtTkL1p
         Xw87Wgixg+Uw3dKLYgsxzRWwNdJsdzIt8Rg/X6V0v+yDE4xQSSConrv6sHxmFUKMte
         Gk5Cs2CHUjYT3uf7F7BudKtMyBdv90cHzSiTBAQs=
Subject: Re: [PATCH 4.4 00/76] 4.4.211-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200122092751.587775548@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <449d7183-f373-5d49-df42-0372a225b213@kernel.org>
Date:   Wed, 22 Jan 2020 13:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 2:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.211 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.211-rc1.gz
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
