Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6C7C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D009C2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585079391;
	bh=Cj88J/XEjFZS6MCH4aT+1wQZHQkyKDG8D2i38OVyRG8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GHZVeCmIsgQE7mBSwxQGxWsDbZJIM/HK106UTng681BoALxbdJ/NceZHSfcj9x7mu
	 oknpMetJY1mwzNWqhGlWyhsNNa0Fjad3ocGl+gldQPXnyzy4IIyWPcBcchLwwX31B4
	 4+/mgcQEStCvM377OjuPKeGp4hzOr9m2+Unkr3vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCXTtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgCXTtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:49:50 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30DD20753;
        Tue, 24 Mar 2020 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585079390;
        bh=Cj88J/XEjFZS6MCH4aT+1wQZHQkyKDG8D2i38OVyRG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mZcJ8f6YdbYcRz7skZILWmmtrLegr0MxiTq2XCL8DjHO0sihCcA1adTsAX6QckJiL
         fqIP2aUwLGj50TfZ6S+kf1glaG/uGQt+0SduvBLCy7vcu5F0EXhr3TexyD3WjfFas+
         J1MVdusd+KxLAlV0BH5pBGNIZoHKIymZx8z8qCWU=
Subject: Re: [PATCH 5.4 000/102] 5.4.28-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200324130806.544601211@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <eb928b7f-3ebd-d407-624d-881d217e9fc5@kernel.org>
Date:   Tue, 24 Mar 2020 13:49:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 7:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.28 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Mar 2020 13:06:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
