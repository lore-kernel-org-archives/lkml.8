Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A944CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F822073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F1rkM9cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGBKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:36:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8627 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgGBKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:36:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efdb8450000>; Thu, 02 Jul 2020 03:34:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 03:36:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 03:36:26 -0700
Received: from [10.25.97.252] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 10:36:18 +0000
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
Subject: Re: Re: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI link
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
 <81d106c0-e1c8-a79a-8caf-1f3be0d61f0c@nvidia.com>
 <20200630153220.GL5272@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <fb286ab7-21f2-43ad-2751-c76b7b6e4cf2@nvidia.com>
Date:   Thu, 2 Jul 2020 16:06:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630153220.GL5272@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593686085; bh=UhnflAwDmheF6iWSFj2l1i5hhV4k8BcKcVrUdRQwc8s=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=F1rkM9cPVeb7rPxjtk0sAt/FK+bVJMWr4+G+nzSwwSzPOhJZy4bNSnY9lsDXLZB6s
         E13ynpqjMwugH2lHSR7csU9Aif915rGDThTt0pM8Gwxbbi/sAbLsGaUkZDclgplWlh
         nhmByXvOq0Cj+gF0gd8bgi0guTosvpDKEcTIPOqEGuCDfPnk7aC31at8iCwh8iCvcc
         /gtuk6RBsvmyrLeFDE1+WbHmlJRDPo7qiJKrNyf/Vn4O1TfB2Cfzgl9j6nA1dahXgx
         gVBPxZ/da40o08tRHb+QRfUinkRHmxO7E1Ay1cciUBoxC6xtCi75FifrgXKZLb0gBS
         CnX7QtdScbmNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 9:02 PM, Mark Brown wrote:
> On Tue, Jun 30, 2020 at 06:23:49PM +0530, Sameer Pujar wrote:
>> On 6/30/2020 4:31 PM, Mark Brown wrote:
>>> Why simple-card and not audio-graph-card?
>> Frankly speaking I have not used audio-graph-card before. I had a brief look
>> at the related binding. It seems it can use similar DT properties that
>> simple-card uses, although the binding style appears to be different.
>> However I am not sure if it offers better solutions to the problems I am
>> facing. For example, the ability to connect or form a chain of components to
>> realize more complicated use cases with DPCM, some of which were discussed
>> in [0]. Can you please help me understand why it could be preferred?
>> [0] https://lkml.org/lkml/2020/4/30/519
> It's the more modern thing which covers everything simple-card does and
> more, I'd expect new development to go into that rather than
> simple-card.

Hi Mark & Kuninori,

For the HW I am using, there are no fixed endpoints and I am not sure if 
it is allowed to have empty endpoints in audio-graph-card. 
Crossbar/router provides the flexibility to connect the components in 
any required order. Patch [05/23] exposes required graph and MUX 
controls for the flexible configurations. Mostly, in DT, I am trying to 
model the component itself and finally router can help me specify the 
audio path to interconnect various components. Hence I was trying to 
understand if it is really necessary to represent the links using 
audio-graph-card. Kindly help me understand what more it offers. If 
simple-card works fine, are we allowed to use it?

Thank you,
Sameer.

