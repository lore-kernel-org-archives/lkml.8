Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA1C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849A420787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585846697;
	bh=94acs22/ufkGM3PkaWe2l1MIKc5PPd7XnOPcfdS+ocw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FKXiyDZsMXMiFpTqkUXehzc77gIYmPUjJPQtAt2Wir+7m3Z4Vsz4yiG6JDP2wQAHi
	 +2TZfNApPmLTvd09eLwmT3IARGtxV81h3LYRu36Z29imaZuOBBxcIu7KR9nabRPiKc
	 OdZls/9ZZQ1FcUP+Tryq0HJGxdLqamwraYvLUrNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbgDBQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbgDBQ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:58:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544C920737;
        Thu,  2 Apr 2020 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585846695;
        bh=94acs22/ufkGM3PkaWe2l1MIKc5PPd7XnOPcfdS+ocw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V/fgbAPQEaRARQNC+OG36NoXyyeTrShsVQ7FoTvAMp9GQzfmXIRei8Vsncr4e36im
         xMnsTJMc7Ewdzv2gtYzBvPOFC5j5+CG6+KdsnfLE6O6N8uM/OScpvA2ch84YhBTgJ4
         k/RKN7Ic9vEtJffRfdxYDv0yyL7zXn3tzOQGrdQo=
Subject: Re: [PATCH 4.9 000/102] 4.9.218-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200401161530.451355388@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <84768482-4fa1-9b4a-6287-438298ed5ca7@kernel.org>
Date:   Thu, 2 Apr 2020 10:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 10:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.218 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.218-rc1.gz
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
