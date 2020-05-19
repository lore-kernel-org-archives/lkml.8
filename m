Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73958C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469EB20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589900735;
	bh=LtYBiYur1QL1qTNWqPgQ6NMFqjF4b1L9uR5CR+kraSs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pLYto1NY+qjEY5h69u06c85j4mqvDOgMDpeH55aSc764ofnibRN1S1QSY0vaZ8wiE
	 UphjCh7y72cjkZMiMd6BckPiAnH4aISmS3jxPQL5tJHvbrt/vU84/LBJHtzRrkEIJu
	 GzyO/qiHZ27l7aCUu66lclFI35fXdc6zOznOqg7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgESPFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgESPFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:05:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC45207FB;
        Tue, 19 May 2020 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589900733;
        bh=LtYBiYur1QL1qTNWqPgQ6NMFqjF4b1L9uR5CR+kraSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hi7MDO801Cisw445Tt3/Aesm044ELa3EUOYE3u3jFmugZO2FHrIEYF3KXWbEp/qKc
         gogwJmbgZMlTn2tLnkQ8dV2YSCypoSFpNWoCbAJqHgg4jakXf+O1cXzr7qij47pCDf
         P5reH1vVGXTl2y2GQ9MILbUlW72xEe+NytXU4FmE=
Subject: Re: [PATCH 4.14 000/114] 4.14.181-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah@kernel.org
References: <20200518173503.033975649@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <79a6ae2b-7f9d-b2a8-5dff-e4fcd8e47dc9@kernel.org>
Date:   Tue, 19 May 2020 09:05:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 11:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.181 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 May 2020 17:32:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.181-rc1.gz
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

