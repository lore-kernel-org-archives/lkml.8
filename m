Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC6C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CFD222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583877668;
	bh=FHJBbVeJDftKsUx1ivj1xU7+bvTV7743vzSrlOaY5Yg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=W2K/+kW/jpXcI5yf9sb2+fwnIg94bXmGZooROuwZs3xGJbtUXUJ2Deg5MSCB1UQxn
	 od6nd4qDnxPdnRVVWBMxCEZYmrVu5NwM9u7IrQSgYNH116fp90dYWKjNYeuNtOqjtK
	 RF5RstmNdUzMmw7laH0kf95MfBPrMEW9Jpf+ZhaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgCJWBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJWBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:01:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0390821927;
        Tue, 10 Mar 2020 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583877666;
        bh=FHJBbVeJDftKsUx1ivj1xU7+bvTV7743vzSrlOaY5Yg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DQQZJZP6Jq9jBS4BzbRDPDDwgdj8TggVCeeOGlIOEwvKp2LBqfhLJ9CMcb/z1o29m
         gJYHwB0iD6B9q+PhKM02ihPv2KKYw48khFfeLoJFVJ4+yWzIbZ68eXmkALvZxuENDg
         FCBYgpedFf3hQG9MD/UYeaghPBg0PNNdVkN5QP24=
Subject: Re: [PATCH 4.4 00/72] 4.4.216-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200310123601.053680753@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <e0ca467d-8861-13e9-35e5-d84c6491983e@kernel.org>
Date:   Tue, 10 Mar 2020 16:01:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 6:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.216 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Mar 2020 12:34:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.216-rc1.gz
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
