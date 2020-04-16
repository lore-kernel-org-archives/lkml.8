Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4EC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F3821973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587074725;
	bh=9goen5q97IXE1QNsquPqQOAcD07uSEh64MmoAuyZQVU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bAOigh/72ROPm4gfXBWev0fVnHcnMOEyYtZw0DRXEHTWxbHGsk92S1qT8HDayzUcu
	 Ry8diUwVKPUvirFzM8q+qBeGh28dA5w6amTitzq8GK659Vx+FzW6G+DGbR0UjKuA9A
	 hdzhk2WfAvRo+7Uo4ZhDIE2+VfpAzP17n1JWdZUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgDPWFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgDPWFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:05:23 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B35218AC;
        Thu, 16 Apr 2020 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587074723;
        bh=9goen5q97IXE1QNsquPqQOAcD07uSEh64MmoAuyZQVU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TVXfprzCU3S0/bb29TUEpGCQ6zLmeTHCdg0sVNPb0WNrplplrAKzxCwyQQRDWj6qt
         PU+3UJlqAppJEcrekP7G6XxpayRPbolAXoH9TzwvTNq5ppFYe5KhGqKmYaUh97HLBX
         Pjd9LDuIFhPL8vwge13tNBFXmxPDPLfRZryi79/4=
Subject: Re: [PATCH 5.4 000/232] 5.4.33-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200416131316.640996080@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1fbc738b-30d4-59db-184f-5d4812892481@kernel.org>
Date:   Thu, 16 Apr 2020 16:05:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 7:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.33 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Apr 2020 13:11:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.
reboot and poweroff hang forever. The same problem I am seeing
on Linux 5.7-rc1 and Linux 5.6.5-rc1 and now on 5.4.33-rc1.

I am starting bisect on 5.6.5.

thanks,
-- Shuah
