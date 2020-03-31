Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E2C2D0F3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD1620BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585693664;
	bh=RaMiVDzxO2Dn3x9dsg+2vW4FZPGQYDdsEU6DIIaK4n0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LPXvLu7zyXbAP0WL52dy19PUgsYSntZ5GC9NCK5tcQU0d1HhE9YlwPVEdCuetl7PN
	 1LCWtT40+RfrJ0vjHCFqXs/7sgh7v4gbR5/XTeRy7Fbn1GEOCB9T1u5i0ShAPNjZaX
	 ehO9iWSHa7zku2jbGPtC/2hL1OEeUwhH6YvNgroc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgCaW1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730556AbgCaW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:27:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2ADB20787;
        Tue, 31 Mar 2020 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585693661;
        bh=RaMiVDzxO2Dn3x9dsg+2vW4FZPGQYDdsEU6DIIaK4n0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ODDTEmeuwrefAjJOQ7QMSp+EECDFQz81Z6/ESxE2ci3+DHchlzxfGsmZs4vsmAqXv
         LSbKLiUzxDRd2XFn1b6L8S86fdLQYsyKAPxyBpTiBa8kIg9NYnGDpVGE6Bdodl4PQX
         OeVCzIpIy1T+zrrmcmwX2ejtxnwgu5HRB5xjVRaU=
Subject: Re: [PATCH 5.4 000/156] 5.4.29-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200331141448.508518662@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <6bd7a1b7-a498-a6ba-5a4b-a2b7e1a0c545@kernel.org>
Date:   Tue, 31 Mar 2020 16:27:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331141448.508518662@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 9:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.29 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2020 14:12:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.29-rc2.gz
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
