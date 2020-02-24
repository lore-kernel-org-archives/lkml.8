Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C6C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A682072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m7KGt/cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgBXM3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:29:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1502 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:29:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e53c16a0000>; Mon, 24 Feb 2020 04:28:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 04:29:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Feb 2020 04:29:42 -0800
Received: from [10.25.72.216] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 12:29:36 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
To:     Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
 <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
 <20200221165535.GG5546@sirena.org.uk>
 <47f94534-e997-d56c-5793-ae832fb2add4@nvidia.com>
 <20200224114406.GB6215@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <f70c7c12-dbc0-a725-f06a-86fab868e7dc@nvidia.com>
Date:   Mon, 24 Feb 2020 17:59:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224114406.GB6215@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582547306; bh=BkJlDeQ3uyXrk5Yxotr7FKq3o5UzwF+OuQbFVpldsnE=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=m7KGt/cW33jZxBsTvrRquBVKLgHFaOpj6cmOI1gq/8AfoWti0CfVl/UC/cKsdx2Tl
         LPR0FyGeYqObSIHNLgTpg/bnzwkiKdHynqTk0m96C/NuinqMnu0r5xDRx5dwYt6agw
         tCgQSj4p+W6tjaI5Xn8/IgyRug9t60KlWjGxqKSBvI+SyuQp8S3qvoypKpO9+glYu+
         oQyMNMxCdod4dN44ZuZmGj5aW5gUlPB3uhFx4xr1xNYQpnUlZ2ZEUzSppeWSF0JXX8
         s41KLrXdprytk/NksFqe/3VcKWs5xMpcFcJcLly5g9g2iheYHqFSBZy+BwHWFSqJDg
         XUFRvHcAR8D1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2020 5:14 PM, Mark Brown wrote:
> On Mon, Feb 24, 2020 at 11:28:57AM +0000, Jon Hunter wrote:
>> On 21/02/2020 16:55, Mark Brown wrote:
>>> The ideal thing in a component model would be to represent those sample
>>> rate convertors directly to usrspace so the routing and rewriting is
>>> explicit.
>> I assume that it would be OK for the sample rate converter itself to
>> expose mixer controls to configure its input and output rates so the
>> user could configure as needed?
> I don't think so, I'd not expect the individual drivers to be doing
> anything user visible here - if we know what a digital transformation
> looks like the framework should be offering anything that's needed to
> users (and hiding controls that don't have any practical control in a
> given system).

Are you suggesting to have some alternate way of users configuring 
sample rates (and other params) and not use mixer control method?

This is a typical use case we see,
- [stream-1] Lets say high resolution audio is playing (96kHz, 24-bit, 
stereo)
- [stream-2] Randomly system notifications of small durations come 
(48kHz, 16-bit, stereo)
The requirement is, both streams should be mixed and played.

Tegra Audio HW has Mixer module for mixing multiple streams. In above 
case, stream-2 requires upsampling to 96kHz (employ SRC) and 24-bit. 
Then mix with stream1 and play. This needs to be configured at runtime. 
In another session, mixing for 192kHz and 48kHz might be required with 
the same audio path. Idea was to allow users to setup their custom path 
for specific audio applications. In the current series, I am focussing 
on I/O modules (where overrides do not demonstrate the above use case) 
and does not include other HW accelerators that Tegra Audio HW offers. 
Things would be more complicated when user wants to use multiplexers and 
demultiplexers. For simple use cases overrides are not used.

Is there a better way for user to configure custom audio paths?

>
>>> Is there any *need* for these to be user configurable?  What's normally
>>> happening at the minute is that either the external DAIs are fixed
>>> configuration and the DSP just converts everything or there's no format
>>> conversion done and things get passed through.
>> I can see that in most cases there are a finite set of configurations
>> that the end user may use. However, we would like to make the
>> configuration flexible as possible and this also allow us to test lots
>> of different configurations for verification purposes as well.
> Internal testing often requires things that can't be exposed to users,
> the extreme examples are things like battery chargers with health and
> safety issues if the full range of control is available.

