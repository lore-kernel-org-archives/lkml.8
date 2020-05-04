Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E541A206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EC2a+3lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgEDIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:35:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7313 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgEDIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:35:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafd34e0000>; Mon, 04 May 2020 01:33:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 01:35:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 May 2020 01:35:25 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 08:35:25 +0000
Received: from [10.25.97.23] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 08:35:14 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>
Subject: Re: [PATCH 0/3] Tegra194 HW Fixes
To:     Takashi Iwai <tiwai@suse.de>
References: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
 <s5ho8r4f6hx.wl-tiwai@suse.de>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <124d4a5c-e198-d8c0-5fb7-65d008852e32@nvidia.com>
Date:   Mon, 4 May 2020 14:05:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5ho8r4f6hx.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588581198; bh=LxS7ZfO41qCLpMhFUX0mFEgCD+fiFILtv0nazI/gBKY=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=EC2a+3lQ6ViudY5YFmLk7lQv+Sl4n/1ojJfqN56+K9adPBtWQM8jxiX2PZokGyZ3W
         J3Mc6uTlS1j0isTYlOFSW4e3fDuORqun5bNUlmUcsO//FfIpTVGOZZEj9AvwXSkL5+
         tXDApbU2d9BGio+Kg9l1fETPTQOthbOwAaIR7VjKAEw8CIyVp/WU8Qk0aOobKoyt6B
         dDzONGILUPCQkgy/EpxfNPgPQelV0CyCYhj/v8X0L7NJWQMT+JcxFhta2UDVUX/+8H
         ht4oAzS6pgXJGGNnILWyBBvrlzHUPDYmEN88pEReoviZCROY+PQJSJ4grPPjAaL40l
         Vd6d8Pbo1NIbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2020 1:59 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 04 May 2020 10:16:13 +0200,
> Sameer Pujar wrote:
>> This series proposes SW workarounds for Tegra194 HDA HW bugs.
>> Following are the two issues seen:
>>   1. GCAP register does not reflect true capability.
>>      The actual number of SDO lines is "4", where as it reflects "2".
>>   2. With 4 SDO line configuration playback fails for,
>>      44.1K/48K, 2-channel, 16-bps audio stream.
>>
>> After fixing [1], issue [2] is uncovered.
>> As per recommendation by Tegra HW team the workarounds are pushed.
>>
>> Testing done
>> ============
>>   * Verify GCAP register after registering HDA sound card
>>   * Verify audio playback for 44.1K/48K, 2-channel, 16-bps.
>>
>> Sameer Pujar (3):
>>    ALSA: hda/tegra: correct number of SDO lines for Tegra194
>>    ALSA: hda: add member to store ratio for stripe control
>>    ALSA: hda/tegra: workaround playback failure on Tegra194
> Through a quick glance, all changes look good.
>
> Is the device already in market, i.e. it had hit users?  If yes, I'm
> going to merge for 5.7, otherwise for 5.8.

Yes the device is in the market. But has not been reported by end users.
During internal resting this has been discovered. I am fine with merging 
this to 5.8.

Thanks,
Sameer.
>
>
> thanks,
>
> Takashi

