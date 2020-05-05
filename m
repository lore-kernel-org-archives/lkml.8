Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC123C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CDE2495A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588694020;
	bh=p9Woo9z9n8xA+9kz94/h9Cdxg2sbFA84E5pUXLlkmCI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dxPCVLQ14tzZB5mB+nf/1loXOQGjJComkiQWKQyavsatRJ8qbS5a4dqDeOXtxqate
	 7nSEI9DJWJkWKOC3TTeiv5/5yhgTLYy4rxmtJg+oPsvBkQbVTX+fsXoeVSKakllwjs
	 PVphnZjyvJoCvxIS6hQFqjD4n3O24er7EHPXuy1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgEEPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgEEPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:53:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF73C20663;
        Tue,  5 May 2020 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588694019;
        bh=p9Woo9z9n8xA+9kz94/h9Cdxg2sbFA84E5pUXLlkmCI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LOjMLRi+77aXP7Yv6CyDHZGZ0/KkTr9uxppBKEvWgLvsrAxH/yBXYrenLvWLikMvt
         jUG5F9fCyJilVIHSNJBmJtkoU/bMfWFOe/U9zRLsNSFJ/EfqO1wzaLdTWuuDrCTmiQ
         69d9yV1BbwQISE8RB73SG45G0v4Q3Ve/0b3NJcfg=
Subject: Re: [PATCH 4.14 00/26] 4.14.179-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200504165442.494398840@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <20ccf168-6636-2032-a5ca-d5a2aacabdb5@kernel.org>
Date:   Tue, 5 May 2020 09:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 11:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.179 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.179-rc1.gz
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

