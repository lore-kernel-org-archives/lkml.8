Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C67C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315C120829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589900906;
	bh=G4KD1KxDtZ8spmwj3kC8plb8V5lO1L4ImGakIonfMmo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IclyzjXZ7FNfqcMg8C3pmRAL+OlbrI0dnB6PsnTgAM31qCh+Ux9zfEHK1v6DVPzda
	 CQmGRdubTTBU0+mf2y5NtEBpFA8N7qJjKD6ti28E6AmwDfzZPUogP1SxTtRBnDue6g
	 UwiX42gCiNM4xqJokmwSaOaP+GsbPy5csLcMh3v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgESPIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgESPIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:08:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949DB207FB;
        Tue, 19 May 2020 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589900905;
        bh=G4KD1KxDtZ8spmwj3kC8plb8V5lO1L4ImGakIonfMmo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MjCSpBzIu802WAePJAWYoFW6olUhGWW+ciIphiLfbgA5yvLhfksh3pE+JH065jQ2X
         B3bqHo/Nu5LYv64zg6xXmTwIYq3u69Eqt0zfbSBfX9pvMpJUqFWrBHMin9cPdn9Yoh
         pCyHjqyfKoGPoT1jXleW9A+JuupIkXuGUjUZ58h4=
Subject: Re: [PATCH 4.9 00/90] 4.9.224-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200518173450.930655662@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <39ad5113-d198-5be1-5c73-b95851f3ff68@kernel.org>
Date:   Tue, 19 May 2020 09:08:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 11:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.224 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 May 2020 17:32:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.224-rc1.gz
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
