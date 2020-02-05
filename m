Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C7C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE18217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgBENKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:10:44 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58093 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgBENKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:10:43 -0500
Received: from [172.18.205.202] (unknown [46.183.103.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id ADDE620643EEF;
        Wed,  5 Feb 2020 14:10:39 +0100 (CET)
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, ck@xatom.net, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
References: <20191104154446.GH2552@lahna.fi.intel.com>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <20191122105012.GD11621@lahna.fi.intel.com>
 <edfe1e3c-779b-61e4-8551-f2e13d46d733@molgen.mpg.de>
 <20191122112921.GF11621@lahna.fi.intel.com>
 <ae67c377-4763-4648-a91c-b9351e3b1cf1@molgen.mpg.de>
 <20191122114108.GG11621@lahna.fi.intel.com>
 <cf4140c8-5b92-f1e5-c9e4-e362ab06d6f8@linux.intel.com>
 <e5e3df06-4ddd-aadb-f1ad-6dd24fa2a5c2@molgen.mpg.de>
 <4b25e707-d2b5-11d1-4b16-48122828fde7@linux.intel.com>
 <a9e12353-6f88-edeb-0d78-15c1ac75666b@molgen.mpg.de>
 <87670037-8af5-c209-cbf8-70042e0a8fc5@linux.intel.com>
 <44d8eb12-9af5-7b9a-fa24-be8e8ec3cd48@molgen.mpg.de>
 <789c7db3bafa4bf9a9348123492196b0@AUSX13MPC105.AMER.DELL.COM>
 <ba9b732f-a969-1840-abfc-829d21395f83@molgen.mpg.de>
 <20ad18e8-08ca-f62a-dd7b-cdd671dcd997@molgen.mpg.de>
Message-ID: <e9205ed2-68d2-e08d-2a50-00fe17a08a29@molgen.mpg.de>
Date:   Wed, 5 Feb 2020 14:10:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20ad18e8-08ca-f62a-dd7b-cdd671dcd997@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Mario, dear Mathias,


Am 27.01.20 um 23:16 schrieb Paul Menzel:

> Am 18.01.20 um 10:15 schrieb Paul Menzel:
> 
>> Am 17.01.20 um 19:33 schrieb Mario.Limonciello@dell.com:
>>>>> I was able to reproduce the issue with an external HS hub as well, 
>>>>> so  this issue appears to be more related to ASMedia host
>>>>> than the built in HS hub in TB16
>>>>
>>>> I contacted the (German) Dell support, and they asked me to
>>>> update the laptop firmware to 1.9.1 claiming that these issues
>>>> might be fixed there (despite the change-log not containing
>>>> that). Anyway, after the update, the user is still able to
>>>> reproduce the issue.
>>>>
>>>> Mario, what can I do, so the issue is escalated to your team, so you 
>>>> can work with ASMedia to solve this?
>>
>>> From this thread it does sound to me like an ASMedia firmware problem,
>>> not a Linux kernel problem.
>>>
>>> I do know there is an updated ASMedia firmware binary available. 
>>> Right now however there is unfortunately not a way to update
>>> ASMedia hub firmware using free software.
>>
>> The fwupd issue *Dell TB16: ASMedia USB controller can't be updated* 
>> [1] was closed by the “stale robot”.
>>
>>> If possible, I would recommend that you try to update the
>>> firmware using a Windows machine and see if it helps the problem.
>>
>> Thank you. I’ll try to do that on Monday.
>>
>>> I'm sorry and I don't intend to "pass the buck" but if that doesn't 
>>> help this needs to be prioritized and escalated with Dell support.
>>>
>>> They will then work with the appropriate engineering team who owns 
>>> the relationship to ASMedia to resolve it.
>>
>> That’s how it should work theoretically, but have you ever dealt with 
>> Dell’s first level support? They have little experience with Ubuntu, 
>> and if you are unlucky, they say that Ubuntu support is not done by 
>> Dell but “by the Linux community”. If you are lucky to not get this 
>> answer, they do (Google) searches, telling you, your problem is solved 
>> by referencing only similar sounding problems from the Ubuntu *user* 
>> forums. If the firmware has a bug (in the UI!), they ask you to 
>> install Microsoft Windows to see if that solves the issue. If you tell 
>> them, the Linux developers analyzed the problem, and they say the 
>> following solution have to be found, they do not know what that means. 
>> It’s very annoying and time consuming often for naught.
> 
> As reported in [1], updating the Dell TB16 firmware using a *Dell* 
> laptop (with updated firmware and Thunderbolt drivers) and Dell’s 
> Microsoft Windows update utility, the firmware parts below were updated, 
> everything seems to work now.
> 
> MST1                 3.10.002    3.12.002
> MST2                 3.10.002    3.12.002
> ASM USB 3.0 Cntlr    10.11.23    10.11.A9
> Dock NVM             00.00.16    00.00.27
> 
> Mathias, can you please confirm, and maybe also approach ASMedia from 
> Intel to ask them to improve the situation?
> 
> Can the Linux kernel (or some user space) carry a list of non-working 
> firmware versions, and output a warning, that a firmware update is needed?

After testing this some more, the user reports, that the situation 
actually got worse.

No the docking station additionally disconnects randomly when working 
with the system. This did not happen before. Only the Ethernet port of 
the docking station works more reliably now.

Mathias, can you confirm this behavior? Is it the same problem as before?


Kind regards,

Paul


>> [1]: https://github.com/fwupd/fwupd/issues/1351
