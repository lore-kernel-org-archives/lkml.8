Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBDFC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A824672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579033632;
	bh=/sDtGiNEleGcDc04+WohmWiv1Ar+jBntlN5yNz9LTCc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bxrFxN4USC3b1zbPidaW0Dd7JkBn3EqjfmdyvnpNJkj0UOy5g2iq1cxa9ruXmXcWL
	 1xzIKzW/JfJMvCB/cZIQ+RF7TovA1OZ+DH8aX1oo8x+oLpXHR3iJTD/59E6gI4a7xw
	 mONc4/fdJUwvdbejt1MUxnFKk2QC2bff6K80BWTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:27:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANU1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:27:11 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA0024655;
        Tue, 14 Jan 2020 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579033630;
        bh=/sDtGiNEleGcDc04+WohmWiv1Ar+jBntlN5yNz9LTCc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o+fMEYG0pJEZ6ySI+W0aD5q1EUnmmn0ixO3oZ1+C/3rytiWrdTrIFwZf7lhwokfr7
         6U+p/khh0F+KJ6LpKpMdwUAsJ9qyVOh0jPPng9CObjJLjJehPmlKrK4g9aKEaWwTop
         F1yNwYvVDDuxwhvOOcvXHIYVnScpUENaCtdTt3KE=
Subject: Re: [PATCH 4.14 00/39] 4.14.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200114094336.210038037@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <04753837-7ce1-6fc0-6018-2d5978d9dbf4@kernel.org>
Date:   Tue, 14 Jan 2020 13:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 3:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.165 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.165-rc1.gz
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

