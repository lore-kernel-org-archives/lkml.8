Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4EC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97F2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KtXwcD6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgAJEuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 23:50:13 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11322 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbgAJEuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:50:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1802720000>; Thu, 09 Jan 2020 20:49:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 20:50:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 20:50:12 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 04:50:09 +0000
Subject: Re: [PATCH v3] regmap: add iopoll-like atomic polling macro
To:     Dmitry Osipenko <digetx@gmail.com>, <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
 <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
 <b9f5459f-007e-3139-a3cf-c7dfd3fc335a@nvidia.com>
 <e1ab2304-2ef8-c50d-d9c7-21569b397c23@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <b14d6130-8a9e-28ac-3ce6-dc6b9e3a3886@nvidia.com>
Date:   Fri, 10 Jan 2020 10:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e1ab2304-2ef8-c50d-d9c7-21569b397c23@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578631794; bh=LY4ub5S3YLyUMHW9VwtXF4qLAIdLW7v5zkvc2e4WsWo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=KtXwcD6m6Q1VZ7ZAu+bNuGyMK5a4FXr0cVyJODK85m1UG12DNg50tgV1j7H71q+EP
         VaKoPeRiasO8ZAq3YC3cQ2IDLkRtkkoeA+qlKtIc9dg4aABv1IDbDrMGmDIiWAYr02
         B8/r/XAjRH49mmbYFJAv53ga1BcYg9v52l6QbaZ+MxhT1WShFCBJxumlM0wvVbcdJB
         mtptRrgRaB3PNcmsSq34JiM9CqFLFgUGW/Hjw7rw3FQEsC1F0vHomhif7XfRmvEv3m
         1dc8yMcHbQBRNIVZJ9hY6C60BloumdsFkfmf5NIHlwZLRDVfnTgFOLrc1k0D/OAwyG
         8GsjPFUnQCR4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/2020 7:27 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 09.01.2020 10:24, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/9/2020 11:30 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 09.01.2020 08:09, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
>>>> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
>>>> is atomic version of already available 'regmap_read_poll_timeout' macr=
o.
>>>>
>>>> It should be noted that above atomic macro cannot be used by all
>>>> regmaps.
>>>> If the regmap is set up for atomic use (flat or no cache and MMIO) the=
n
>>>> only it can use.
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> ---
>>> Could you please explain what is the targeted use-case here?
>> I was trying to use regmap_read_poll_timeout() to poll for status change
>> of a register. This resulted in "BUG: scheduling while atomic". The
>> callback function, in which I was trying to use the macro, runs in
>> atomic context. Hence new atomic macro is added. I was checking ALSA
>> playback/capture and trigger() callback had to monitor some register
>> status.
>>
>> In general, the new macro can be used in atomic callbacks where regmap
>> interface is used and polling is required.
>>
> You should send a full patchset because it may turn out that the patch
> which makes use of the new feature isn't correct or maybe the new
> feature isn't really needed.
>
> If there was a previous discussion about the need for this change, then
> you should provide a link to that discussion.
>
> Please note that usually changes without a real use-case in kernel are
> not getting picked up or they are getting removed later on if nobody
> makes use of them, so I assume this is a kind of an RFC patch for now.

OK. I will send this as part of the complete series. Thank you.

