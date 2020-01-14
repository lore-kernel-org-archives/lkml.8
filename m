Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC3C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E2222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JVXLE9dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgANPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:01:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19831 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:01:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1dd79e0002>; Tue, 14 Jan 2020 07:00:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:01:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 07:01:41 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:01:38 +0000
Subject: Re: [PATCH 4.4 00/28] 4.4.210-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20200114094336.845958665@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3673e451-6d19-bfbf-1693-1e1eda376728@nvidia.com>
Date:   Tue, 14 Jan 2020 15:01:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114094336.845958665@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579014046; bh=UGYxn8XXuViTMygbPnUvXO+BE4JOD2+gQmkcAD5Fl6k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JVXLE9dLIgqmUut3n0Uc9oiuXdrNi22gaTjDete+zdrHQscIVQSMVqsbCpGkcwwVy
         dDKOgXZVYQWveCMu0J5wtXCRLszp9zEXlXHekZ70H38/O2nY+Eq2+7Kob+QBRUi6qT
         PRWk7+38/XSs698//ypuMG9kI5pImwa+2SfiTvDk/dFfz9KNYGgjL/64YpiN67OP8e
         jc/+I/75gJHSjtpAxFT+++n+2oeP3SY6XEqD0OSQoWsXE4nqpuKYNzsAZS1uBtP+wT
         ezAwKFDoZiRhwnGuwhSB90wL8V3JkDTzid+v/E9+3qvVpolHaCSkYLRTn4cryGyVgY
         h7NblMs+ESBdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/01/2020 10:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.210 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.210-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


All tests are passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail
    19 tests:	19 pass, 0 fail

Linux version:	4.4.210-rc1-ge249b6762aa6
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
