Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF29C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585693709;
	bh=+H9KYhTtif68WkFgafmI7NOvOk2qeubzD+Ql+KQDxVw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qrDgCbIlYYvp86P8iCllxX2UXPlWZeyDDToYvxzqAcWjEondczuqc9rjY7hN2pg2z
	 rwIpD8LMq/WzHtcS9UZ0u7LDwhocMFg4ONONndrwv+VfP8VczX7mW+o7/J/8PQXQJx
	 mJzsbhmtZkyqPObicXWAYORWKe4UYtydDMhiWnFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgCaW22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgCaW22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:28:28 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8481320787;
        Tue, 31 Mar 2020 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585693708;
        bh=+H9KYhTtif68WkFgafmI7NOvOk2qeubzD+Ql+KQDxVw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZJp0Q0KBO4cZ7UQ8Q9pq3OHIGpglwfs4UCLvDkvjDjy45J1WQUuyNbzTpWMHw32c6
         404GXODq9yE3d260tmuGtNwdUXRgQU94G30Sf/fgBz6M5negMD5Sco9OYw7tzLDNXX
         Qo2tfzmfITPhRTq9ToMn0y+vuhCiuMs+nSDbwMhs=
Subject: Re: [PATCH 5.5 000/171] 5.5.14-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200331141450.035873853@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <ecc90e76-fe9b-fd58-5eaf-dd0bfb433b0d@kernel.org>
Date:   Tue, 31 Mar 2020 16:28:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331141450.035873853@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 9:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.14 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2020 14:12:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.14-rc2.gz
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

