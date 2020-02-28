Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD683246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582860924;
	bh=bj1WrnSQVnFoIj3k8BTk2xhWVva1ZbWMO1HNMcVAvFw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uNArfTv9rL6UGFgoH1C65ebvclgTMbVFHZj/aIycwbc9H6dyCxKkBGDh6F5MznNag
	 14YrkMFo+0vvCUchfG2UdWxf1paToxdcMHt0+YjbvzCB0VbaBhJIOD02JMjdkaNZgB
	 AeXfNl3LfPMv/++tZpGqAg6lQkIzUgY29FhiAzo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgB1DfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbgB1DfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:35:23 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E37D20665;
        Fri, 28 Feb 2020 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582860923;
        bh=bj1WrnSQVnFoIj3k8BTk2xhWVva1ZbWMO1HNMcVAvFw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M03vmg4smuyU8J07MbTZ6ELPYfx+zr11c3bSUnsYRiTS/7rIMux8Hqt4lKXM1ggUS
         Q7jHukr/dzVNGNE8ytFcd3yE4exnvN3dDHyCO/rLpJW7DhSpCp+NFMMS61kKmLxyPr
         L2L/PS7+99mqU+MznwEVD+h6VLojU7Xnb6eveGuI=
Subject: Re: [PATCH 5.5 000/150] 5.5.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200227132232.815448360@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e1772ba8-f03a-4423-b41c-ca54e85ad7e2@kernel.org>
Date:   Thu, 27 Feb 2020 20:35:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.7 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.7-rc1.gz
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

