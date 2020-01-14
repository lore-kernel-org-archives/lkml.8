Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EACC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1204F24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579033377;
	bh=YbQTajE7YvAN49UaYJLiPm1Xwm6KCKn5jLGZ01KW3O4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ej86rR+0NpwvDCjZNTZuQaa+rdRsqk8TeDMyPkZN69DK/0JrzBuUCbNwUM4sWST+M
	 7dxoYWmkVWLxD4h40M0P7aalXAYYPunMMDAXMi36yoRXIPRMJt+vD7W97veG/A37NN
	 1dqVgB/CdtMJdZqdYZtp3oPo6041GQHgLQ87maxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANUW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANUW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:22:56 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFCD24655;
        Tue, 14 Jan 2020 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579033375;
        bh=YbQTajE7YvAN49UaYJLiPm1Xwm6KCKn5jLGZ01KW3O4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AvJIfinXLt45LbbST9DUSvUFUY5Teqqft3pgkjau6HSfsv2Sw8I6JX9yx/iwMrzqd
         bBRwiHR7BpfmIjF2esGSyC/bJll/bfmGI+KRjNW2KZWTLahEjU0Gz1d0wm2gaFCzkW
         Q5STdGqb6SVD7hRJle9S8DgTcuITb6Ed5pqFQ4rc=
Subject: Re: [PATCH 4.19 00/46] 4.19.96-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200114094339.608068818@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <89d2275e-39b4-32db-56fb-8f7dec531b42@kernel.org>
Date:   Tue, 14 Jan 2020 13:22:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 3:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.96 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
