Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B08120835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589899544;
	bh=/dgqySkNnw+UK5kssnhg5AYKnoQk02tynr9C8SngIMw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vW0U10swsWG2bWGyYVdxQoknqAHUJTlzdutaejXvYed6CIYjfv6knP6vaDV0AcAKU
	 8y5Gx8LenDe0v5mGeTcvVnFzoNG+FFbpsdBL1R0ZO26xRz2mH3gzr9dqymH2oa6rYm
	 /XKVLgc0r6vzBGmw8MUCcViR58gTfbc1J+97Vess=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgESOpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgESOpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:45:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0124207FB;
        Tue, 19 May 2020 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589899543;
        bh=/dgqySkNnw+UK5kssnhg5AYKnoQk02tynr9C8SngIMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KfwNFTCXBfZCdibht0nlEElq287INyWzpWXwpzkjdCDLoq04PnGMc1mBD44iG+zej
         9KqGVp/ypVDpaRfKv2tl3aYHLNuwf+WxVNX3yn0BHcnVW5eswkSrV35xq7rgAaE4QH
         hGv19Y0PDFOfZNYwhd0rSouNewH7WhTXmbrejQUI=
Subject: Re: [PATCH 5.4 000/147] 5.4.42-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200518173513.009514388@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <8787b77d-8b8d-a4ff-c4c7-3b87f325cc80@kernel.org>
Date:   Tue, 19 May 2020 08:45:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 11:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.42 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 May 2020 17:32:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.42-rc1.gz
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
