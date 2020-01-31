Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B9C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F23214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JXWuQhzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgAaDMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:12:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6425 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgAaDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:12:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e339aef0000>; Thu, 30 Jan 2020 19:11:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 19:12:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 19:12:36 -0800
Received: from [10.25.73.84] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 03:12:31 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 5/9] ASoC: tegra: add Tegra210 based AHUB driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
 <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <00ce0f46-4401-c1da-5513-4aa38d224a44@nvidia.com>
Date:   Fri, 31 Jan 2020 08:42:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580440304; bh=pOv0j2LC/b/wPjHJax5N8sojDpZ23UrGRdvxHFuGJS4=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=JXWuQhzY18eWXms0wSacXtCMzZKzJXcryJ0/IFA82s/qshH4SKD4koZBJMt7zjDPS
         Dl34fHgTC9mVA1mENlCbL4HHogea11m+shE/gxpbSTEu+JFKMuxx2CuszQnC+b3CDc
         /+VFo8N/sNXeK3SOCkHizNwBiXaG8nXspXCp4j8f9d8eho3tcWKq3lRrmtGqHXv4sA
         kk4tLGOfgPO15MHiT/iWuwlCddL4+hbWxdTNz7yhQ8NHL4rZ1HubFrsh3Ztf2+PxsF
         Uhxk1Jj7ux8d+3oIDAUqWZW0mPiYr82sFdqw9kuwUcB1PpuBqxKRRLHDe28nGgKt2a
         WdFfbrR9bg9Rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2020 10:55 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <sound/soc.h>
>> +#include "tegra210_ahub.h"
> Nit: I'd separate the per-directory includes with a blank line, like it
> done by the most of existing drivers, for consistency.

Hi Dmitry,

I'd assume these are the only review comments (which includes your other=20
replies for v2 5/9) for the series.
Let me know otherwise.

It would help me to discuss all the issues at once, finalize changes for=20
v3 and so that we can avoid multiple iterations.

Thanks,
Sameer.


