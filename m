Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2736020780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H21t0clf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgF3LzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:55:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16640 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732491AbgF3LzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:55:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb27e70002>; Tue, 30 Jun 2020 04:54:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 04:55:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 04:55:04 -0700
Received: from [10.25.97.62] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 11:54:54 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
Subject: Re: Re: [PATCH v4 00/23] Add support for Tegra210 Audio
To:     Mark Brown <broonie@kernel.org>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <20200630105142.GF5272@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <b44cf9a8-f01b-5c73-5929-d02c4502832e@nvidia.com>
Date:   Tue, 30 Jun 2020 17:24:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630105142.GF5272@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593518055; bh=aqJ2upnaq3qCdZVAi6vfeAtGXsTFXwxy04lLWsSjgro=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=H21t0clf+ESX3Od8FVqcK5gF9fZG/EUdlFKDC3XhnyXrw6fVxcoWIf0w1/Cpajsr2
         6VetDIIzPOi0BA+1zTh4B73h3xNayfS9R0gF2aof1JJrljcsrshrWTiwKCSGFl4zbu
         hWf9OTFMoGsB+dosGpJqCInbxpxgJWxX78KrLlYWzR9gps5pIwodyG0Hq6M+43kqic
         MCZPJKCyQNxtykKcNpUxIrEN6OIh4WZnL0Bim+mk476Hb2q1c/DCXbzMcGKf3f5VN1
         vKaBCrtQD54fv/DlxFcHUIhj6Azi59YOhzUKce4yr/TWqXjUwhOWPJTBTNe3iiwVXd
         96jpXFk5aTrHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 4:21 PM, Mark Brown wrote:
> On Sat, Jun 27, 2020 at 10:23:22AM +0530, Sameer Pujar wrote:
>
>> Following is the summary of current series.
>>   * Add YAML DT binding documentation for above mentioned modules.
>>   * Helper function for ACIF programming is exposed for Tegra210 and later.
>>   * Add ASoC driver components for each of the above modules.
>>   * Add DT entries for above components for Tegra210, Tegra186 and
>>     Tegra194.
>>   * Enable these components for Jetson Nano/TX1/TX2/Xavier
>>   * Enhance simple-card DPCM driver to suit Tegra Audio applications with
>>     few changes in core.
>>   * To begin with, enable sound card support for Tegra210 based platforms
>>     like Jetson Nano/TX1.
> This series is too big and covers a few different topics which makes it
> difficult to manage, please split it up.  The most obvious thing here is
> that it contains both the drivers you're adding and a bunch of changes
> to the generic audio cards (which are a single throwaway line in your
> cover letter) - splitting out the generic card changes into a separate
> series would result in more manageable sizes.

My initial thought was, it would be better to present a entire picture 
where complete audio path can be tested or reviewed and hence added 
simple-card patches in the series. I will split this up in next revision.

