Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF0C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8922217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581643320;
	bh=3mgTXiiP22VF23Epkr3dSDj+4Id9gK5xTMiACJrUCSk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zxvqrANSCtdiDDZ1XzyqF1aLZRQwTV19wX76xgkKCeaGYDG8MUDYpzujTprDaqwhK
	 85VLE4jfL+2+/9F4pbrtro5tUMaIXx4QG08dsUMfa8GekZz5PAuyoksSxDFcJ/Ts6Q
	 SeAblBJ+gZk3BzP6V/M85UYftiiYjII2p0TBYAL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBNBWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbgBNBV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:21:59 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99FB2082F;
        Fri, 14 Feb 2020 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581643319;
        bh=3mgTXiiP22VF23Epkr3dSDj+4Id9gK5xTMiACJrUCSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KwjpqnwefJN9bndIiuoAPcr/ZNJexNq6Q/mzlNRE82+zYFpK4VoJIon3ooaqlMwBA
         YFtr8jAE12R4qWLisdnHWtoSXiztU8BHDKR3oOp47h2FHjCEQCmYo5zAn9meCKVJ0S
         RXv6Ej+DH6cI6OKi6clrrvV8DNI+1eiBjV7BJyFw=
Subject: Re: [PATCH 4.4 00/91] 4.4.214-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200213151821.384445454@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d0485c6e-db11-ef95-6f16-70f21df411ab@kernel.org>
Date:   Thu, 13 Feb 2020 18:21:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 8:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.214 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2020 15:16:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.214-rc1.gz
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

