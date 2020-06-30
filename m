Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954FA20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gh3ACliK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgF3MyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:54:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10720 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387913AbgF3MyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:54:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb35850000>; Tue, 30 Jun 2020 05:52:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 05:54:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 05:54:00 -0700
Received: from [10.25.97.62] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 12:53:53 +0000
CC:     <spujar@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
Subject: Re: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI link
 with multiple Codecs
To:     Mark Brown <broonie@kernel.org>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-13-git-send-email-spujar@nvidia.com>
 <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
 <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
 <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
 <1d7888c7-a8cc-e891-01aa-016e31cc9113@nvidia.com>
 <87ftadyrec.wl-kuninori.morimoto.gx@renesas.com>
 <492079e9-4518-78ba-a227-859d31594369@nvidia.com>
 <20200630110100.GH5272@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <81d106c0-e1c8-a79a-8caf-1f3be0d61f0c@nvidia.com>
Date:   Tue, 30 Jun 2020 18:23:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630110100.GH5272@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593521541; bh=aXxCz2dTV4FtL79w8/1SiDck9RwhPcel5Fp7Yqr93ys=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Gh3ACliKpLklTAftBCph4CwFuABvt9iKOaYeZz9J9rKIAEuUd7rQRvaTVD6XQZt7T
         axfWqqI5PiBn9JpHQfL4rhdLKiL76uJ1w5S9AXLytg4BCoLvKCRCEH9kLNV2M1wDFw
         bc6uYFwF6yT2JQeqDfGjx6xCmCL2jAaPmAQbPZOZmOciS4J0knlc5kq1ijFmM7z6N3
         EG7PlhYruqj0fsBMzrETSEnSnHNxCc9q/3GEKJ4gd6mAJSiYMI0uvC/QIrlzYDJzWQ
         ZURoXaJ+7yXHbfQ/3oLA/KBcWn0rYoBp1R/7vrhUiBe9fHg6ZA8NE6L55EZOkiOWgP
         Q3oHajDJIRzZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 4:31 PM, Mark Brown wrote:
> On Tue, Jun 30, 2020 at 01:22:29PM +0530, Sameer Pujar wrote:
>
>> Yes there are complex use cases, but if we look at the amount of changes
>> required in simple-card driver that is not too much. Existing binding for
>> simple-card driver would still work fine for our cases. Yes there are some
>> deviations and we don't want to break existing users, that is why a *new*
>> compatible was introduced and specific items can be pushed under it.
>> Majority of the simple-card driver is getting re-used here. We just need to
>> make sure it does not affect anyone else.
> Why simple-card and not audio-graph-card?

Frankly speaking I have not used audio-graph-card before. I had a brief 
look at the related binding. It seems it can use similar DT properties 
that simple-card uses, although the binding style appears to be 
different. However I am not sure if it offers better solutions to the 
problems I am facing. For example, the ability to connect or form a 
chain of components to realize more complicated use cases with DPCM, 
some of which were discussed in [0]. Can you please help me understand 
why it could be preferred?

[0] https://lkml.org/lkml/2020/4/30/519

>>> Using fe/be instead of cpu/codec is easy to understand.
>> I guess you are referring to DT binding part. The parsing code specifically
>> looks for "codec" sub node and thus present conventions had to be used.
> Remember that this stuff gets fixed into the ABI so we'd have to live
> with this for ever.

