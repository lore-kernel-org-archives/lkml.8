Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA8C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253E8246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582861200;
	bh=OgDAKmLYzg+VPt1szoBjljv4yNfhU0lVQcU9jcLOR80=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=l4hmj/f48ot3b1TCsF+SQPqM3L6ZIFZh5odjD0g9G9Pe9PXOfz9rsbfnf+4W9P2ky
	 OHnYtNGjNcS6Gq5xz8DgPhFL7ZvVEJiOnMKN0v/qm/CFliqLENIknKLJr0p4Jfj/np
	 30QipCRR6R01ZGv0lJboAyQFEydOUuaMkmeKJHQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgB1Dj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbgB1Dj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:39:59 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE5424690;
        Fri, 28 Feb 2020 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582861198;
        bh=OgDAKmLYzg+VPt1szoBjljv4yNfhU0lVQcU9jcLOR80=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sohUn1Z2EbGKemRPnK4BPFrwNQLDdleCj0MnJfVdZFuGL/JrwdmWlAMyLeG84uoog
         G3DATrQ/A+kqqDMhkA32ot825zqaQ8uoTWoy4phL6qlhMQmj+J8cuadWqhiTYO4bsl
         On/L+hCK7XHaKyalS8ozWXtQVi6iYzXXd4ZLoCGE=
Subject: Re: [PATCH 4.19 00/97] 4.19.107-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200227132214.553656188@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f86c35fa-18d3-eaa7-6d90-3abbf00ca34b@kernel.org>
Date:   Thu, 27 Feb 2020 20:39:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.107 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.107-rc1.gz
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
