Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF21C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55219222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581640851;
	bh=C2pQA43F3UjvjYbnsyHni/6SXQNyvyvE6xKg5HA7oLs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=L4MN0/nByB2r1wb8owbIh3UD2D+yBOqfnhDKpTo5G82suiQx8LMVEkORq289UDnOx
	 9j26Ra5/ANv7v2aH4TZV4ap5FAp8egBfQXQyd/Xubi1Pd+2Kmyr4828/0N4fnIUwR8
	 F6dQGVYnd0ovjyF0ahq/1tIpyVlFZ0wDBerRKdCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgBNAku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgBNAku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:40:50 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3F02187F;
        Fri, 14 Feb 2020 00:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581640850;
        bh=C2pQA43F3UjvjYbnsyHni/6SXQNyvyvE6xKg5HA7oLs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U22HFmGZTjeiQqW8QDDqH0MAi4JsAbtf6WAiXM+NGrzN3APuF4BE2Urpq5rsta2bc
         Xbdf54Vpz33Db24sVj0Vr5T+0qNrqiJr6EJP3SQg6trodyusZu3Rh6TWBqlcYqlTSf
         AIiGvl0llyGVEbSrNW6aOD65b3SYumGGc964Hr80=
Subject: Re: [PATCH 5.5 000/120] 5.5.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200213151901.039700531@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <ac7421a1-63d0-3a81-f049-0be6a3bc4db0@kernel.org>
Date:   Thu, 13 Feb 2020 17:40:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 8:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.4 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2020 15:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.4-rc1.gz
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
