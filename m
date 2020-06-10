Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D365C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709CC204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UTlj2Y1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgFJRjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:39:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19580 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:39:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee11a8c0000>; Wed, 10 Jun 2020 10:38:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 10 Jun 2020 10:39:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 10 Jun 2020 10:39:52 -0700
Received: from krypton.plattnerplace.us (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jun
 2020 17:39:52 +0000
Subject: Re: [PATCH] ALSA: hda: Add NVIDIA codec IDs 9a & 9d through a0 to
 patch table
To:     Takashi Iwai <tiwai@suse.de>
CC:     Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        Nikhil Mahale <nmahale@nvidia.com>
References: <20200605171707.8587-1-aplattner@nvidia.com>
 <s5h36787heo.wl-tiwai@suse.de>
X-Nvconfidentiality: public
From:   Aaron Plattner <aplattner@nvidia.com>
Message-ID: <b64129f4-dfd2-1e1c-4034-6d784d6c41ab@nvidia.com>
Date:   Wed, 10 Jun 2020 10:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <s5h36787heo.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591810700; bh=dkJK8uhHxSkGlkS1wCRSDT9sGT6285+nfvdIw4vwg4I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Language:Content-Transfer-Encoding:X-Originating-IP:
         X-ClientProxiedBy;
        b=UTlj2Y1Z0Y0bXkN8N5DMd5u6n8t1xLaUeTU3UNMeiwDNVysZ6B2DLLH3lZzz8zBbD
         zGGWl+RXP5OUYr2+DsRf3mxfOXjQhMNxut74N6HS9E5a5Ee2lGaPZJ7W9DZNIfYraY
         +qGsvkTNOKce1aW2RenK4nXIPgYa9uxPwA0JsYTYKA9JaTSIlVkYqRg2KbW/BFjOZ4
         NUvT0wczxZjRQMsu4dZrTIF4AbYmFdWbsCqhqQCWjjD1X+/InWUw5MgRe+PIB6FrX8
         3FWgv0epamlOUcKv/NENkzG8CHPvjES/xSlU0M007stJR69s4y7Etn/RFn5R1xWvMH
         Uv6pjszoyIgdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/20 1:00 AM, Takashi Iwai wrote:
> On Fri, 05 Jun 2020 19:17:07 +0200,
> Aaron Plattner wrote:
>>
>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> 
> Could you give a bit more information?

Hi Takashi. Sorry for the slow reply and the terse commit message. I 
can't say a whole lot about these but I can say that they're for 
upcoming chips with audio functions that are largely similar to the 
existing ones.

-- Aaron

> We have no idea whether they've tested, whether they are already in
> market, whether any feature changes on those chips or compatible with
> others, etc.
> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>   sound/pci/hda/patch_hdmi.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index fbd7cc6026d8..e2b21ef5d7d1 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -4145,6 +4145,11 @@ HDA_CODEC_ENTRY(0x10de0095, "GPU 95 HDMI/DP",	patch_nvhdmi),
>>   HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
>>   HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
>>   HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
>> +HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
>> +HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
>> +HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
>> +HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
>> +HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
>>   HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
>>   HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
>>   HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
>> -- 
>> 2.27.0
>>
