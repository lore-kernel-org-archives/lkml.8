Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E2C20760
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mtBjjCAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGNSMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:12:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16305 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGNSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:12:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0df54a0002>; Tue, 14 Jul 2020 11:11:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 11:12:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 11:12:20 -0700
Received: from [10.26.72.103] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 18:12:19 +0000
Subject: Re: [PATCH 0/5] firmware: tegra: Add support for in-band debug
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200712100118.13343-1-jonathanh@nvidia.com>
 <20200714161809.GE251696@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ff404043-3696-121d-52af-dbea4e1005d4@nvidia.com>
Date:   Tue, 14 Jul 2020 19:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714161809.GE251696@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594750282; bh=+018opWU1n69mTuUimpwA6LroZay1PBIuxMxVGCW+rs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mtBjjCAzABAGJHN4xvkUsy/3DRK+Y8oy5GvLCaujWARHCSMmz+c0ix+3SbOWYRjo1
         EUvhSM8cL3OIBjnHLk7Wt5+0kA9ho4MxupqYaz1crl8fMk061hmZn4MPxKamxfgdZ6
         0kRsnMldg/rF3SvlJYxDoUzvRAVZmkHct1JQwWuZojHrsPgagkDjIxnbVV+ctsMcTh
         MlPyoO5+Fa1Yrp5wHWVFDV1C5CzJRJy86nB93Y4ZYwF1PMVyakPXZPupBKe/bDiEF4
         rANTpaRu3ces4TVXPFO3TDZatAz6/SiEaYXaswBrd9ZBHWsSL2f98jBtI0Aq6RkzMK
         tjnD7SaIo20VQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/07/2020 17:18, Thierry Reding wrote:
> On Sun, Jul 12, 2020 at 11:01:13AM +0100, Jon Hunter wrote:
>> This series adds support for in-band debug messaging for the BPMP and
>> updates the BPMP ABI to align with the latest version.
>>
>> Jon Hunter (4):
>>   firmware: tegra: Use consistent return variable name
>>   firmware: tegra: Prepare for supporting in-band debugfs
>>   firmware: tegra: Add support for in-band debug
>>   firmware: tegra: Update BPMP ABI
>>
>> Timo Alho (1):
>>   firmware: tegra: add return code checks and increase debugfs size
>>
>>  drivers/firmware/tegra/bpmp-debugfs.c | 436 ++++++++++--
>>  drivers/firmware/tegra/bpmp.c         |   6 +-
>>  include/soc/tegra/bpmp-abi.h          | 913 ++++++++++++++++++--------
>>  3 files changed, 1038 insertions(+), 317 deletions(-)
> 
> All applied, thanks. I had to tweak a couple of things to make
> checkpatch happy, though. checkpatch also wasn't happy with the ABI
> header update, but I left it as-is to make it easier to update in the
> future.

Thanks. Yes I noticed that as well with the ABI update. I wonder if we
should get them to fix that.

Jon

-- 
nvpublic
