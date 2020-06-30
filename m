Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E004C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D3F2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jn0m7rcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgF3M5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:57:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10977 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbgF3M5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:57:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb36430000>; Tue, 30 Jun 2020 05:55:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 05:57:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 05:57:10 -0700
Received: from [10.25.97.62] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 12:57:02 +0000
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
Subject: Re: Re: [PATCH v4 08/23] ASoC: soc-core: Fix component name_prefix
 parsing
To:     Mark Brown <broonie@kernel.org>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-9-git-send-email-spujar@nvidia.com>
 <20200630104514.GE5272@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <187db7de-51cc-0607-9178-cfca59ef6714@nvidia.com>
Date:   Tue, 30 Jun 2020 18:26:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630104514.GE5272@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593521731; bh=Dee884CwudQ4Vp0WOR0GFwZwO63Qzfttr/zlLVEdFn8=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Jn0m7rcGseZLTd7KPQKTe/UcR5Yx3lEDSYweTJjMJf8PrKzX/EiA2n53MSk+DdZYy
         W9oUjqN5kR6NXtscOUmAkgAv+vHxgdkAx33IxYpffk2yyDQVYF19ALPVdi5Vh7smBl
         xqOMup6YhiaJ1IKOZ5QoBper9KxWBVjOSPMAC7AEKNsV5HX2L2ZvzMNY9KWD3ATmqS
         i29y2MMx1ODPUadtVfZYyH4fHFeTZ8NP4Gr+1yBUnbTtzMGXvvCF5RyJZTZFlPzIzY
         CdwPtQ02TSC6qDrdKLGC5TgKSuT8nef4qqDc6BKcyeYhLbPcgsiegVGTm2PnvzBYdi
         BjolkeUw+Pw1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 4:15 PM, Mark Brown wrote:
> On Sat, Jun 27, 2020 at 10:23:30AM +0530, Sameer Pujar wrote:
>> The "prefix" can be defined in DAI link node or it can be specified as
>> part of the component node itself. Currently "sound-name-prefix" defined
>> in a component is not taking effect. Actually the property is not getting
>> parsed. It can be fixed by parsing "sound-name-prefix" property whenever
>> "prefix" is missing in DAI link Codec node.
> Any fixes should go at the start of a series so they can be applied as
> such without needing to pull in the rest of the series.

OK. I will re-order the patches accordingly in the next revision.

