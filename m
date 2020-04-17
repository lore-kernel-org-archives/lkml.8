Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F8C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2911206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X6yVjy3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgDQLpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:45:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15516 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:45:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99968e0000>; Fri, 17 Apr 2020 04:44:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 04:45:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 04:45:14 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 11:45:13 +0000
Received: from [10.26.73.163] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 11:45:12 +0000
Subject: Re: [PATCH V2 2/3] soc/tegra: fuse: Correct Tegra194 revision
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200331103341.19571-1-jonathanh@nvidia.com>
 <20200331103341.19571-2-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b4458eb2-192a-b5a3-8255-e42f9fc52c1a@nvidia.com>
Date:   Fri, 17 Apr 2020 12:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200331103341.19571-2-jonathanh@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587123855; bh=x3xNcjW5cEUnM1T8PUGYs+pLcMFOIuhwL7/hxdohjb4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X6yVjy3o+monjBvKX1QsjYWouFHKnL7OOjln23s0xB/VaHbYF8dQxHrKeV298YfGo
         caZgHqkerRxCJ0A3r2S3OmPnRbas0CfcVCoyhFMlUvAPb+sP2g5H44P3a/+lqihM+Q
         GaogPUGfcRREECkuLAAj7d1LCafGOARicrDPw79JQyKsN0RzRCi1aMy452QHxUkL1F
         2apKfqVqZ5fgXFBKiH1fnNmFME/RP/2mUvmaN5gvILNWMPrt0nBYgn/3P9gF11x4EJ
         N9nsY9E6wy/CAdM3bbVSwrBBiiee/jS+20q4maD9KPRx5wwV+N1H88Nsd46vzYGvpe
         JOOPtGuCjQi+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/03/2020 11:33, Jon Hunter wrote:
> Determining the revision for Tegra194 devices is slightly different from
> previous generations. For Tegra194, the majorrev field of the HIDREV
> register determines if the major revision is A, B, C, etc and the
> minorrev field determines if the minorrev is 01, 02, 03, etc.
> 
> For Tegra194, there are two main revisions which are A01 and A02.
> Therefore, add a new function to correctly identify the revision for
> Tegra194 devices.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra20.c  |  3 ++-
>  drivers/soc/tegra/fuse/fuse-tegra30.c  |  8 ++++++-
>  drivers/soc/tegra/fuse/fuse.h          |  2 ++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 29 ++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 2 deletions(-)

Although there is a slight difference, it turns out that the existing
code does work fine for Tegra194 as well and so I will drop this change
as it is not needed.

Jon

-- 
nvpublic
