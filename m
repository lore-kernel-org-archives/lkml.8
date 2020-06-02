Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41907C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174472067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W4wKFKGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgFBQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:02:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11519 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:02:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed677a50001>; Tue, 02 Jun 2020 09:00:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jun 2020 09:02:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jun 2020 09:02:04 -0700
Received: from [10.26.72.151] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 16:02:02 +0000
Subject: Re: [PATCH 4.9 00/59] 4.9.226-rc2 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>
References: <20200602101841.662517961@linuxfoundation.org>
 <3c900c0e-b15c-da05-d3d8-e68acf660076@roeck-us.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ecef7839-1e7e-21aa-66f3-920ad2aa190f@nvidia.com>
Date:   Tue, 2 Jun 2020 17:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3c900c0e-b15c-da05-d3d8-e68acf660076@roeck-us.net>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591113638; bh=sXtiFhFNHcN+wnPI6TgxXav1J0ly43LLMHxXgH+Pvuo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W4wKFKGM8LSnUY1mVQPmA/FTMcoFPA8/84Q2FxFpj2ZlOexEb4X6U6Xw17DEhtNVm
         y8JrCOjFLMZmk/kIWz7mXHNtdp3ZgVtYyzm72kNY+/RyYR1FdYDu8Rq0akGU7jWvJY
         vpzG4X3G1qyMVa7ZIY86Sy0Iuel5ZHqpk2LlfzFeQZSSTSNpEnAoUoDuVnss1mCC47
         hrMrVJ6/v19WqQ/sueTqWRGWwC/TOTsRdfqPFVjHoBuq48ceQ3nzHDkqeItO2RqIFE
         uuTN+CxmfZdvlGmEGirNkA+v2xS5EUoESjTyt5bQfmuE0IXmWzXTUUljSXNxKkwIB3
         jS9xyc+kFWZiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/06/2020 16:37, Guenter Roeck wrote:
> On 6/2/20 3:23 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.9.226 release.
>> There are 59 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
>> Anything received after that time might be too late.
>>
> 
> Many arm builds still fail as attached. Is it really only me seeing this problem ?

No I am seeing this as well. Been having some email problems today ...

> FWIW, if we need/want to use unified assembler in v4.9.y, shouldn't all unified
> assembler patches be applied ?
> 
> $ git log --oneline v4.9..c001899a5d6 arch/arm | grep unified
> c001899a5d6c ARM: 8843/1: use unified assembler in headers

Bisect points to this one for me.

Cheers
Jon

-- 
nvpublic
