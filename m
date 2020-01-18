Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E370C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195292468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgARJQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:16:00 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45567 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbgARJP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:15:59 -0500
Received: from [192.168.0.4] (ip5f5af7c3.dynamic.kabel-deutschland.de [95.90.247.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A08B1206446A1;
        Sat, 18 Jan 2020 10:15:55 +0100 (CET)
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, ck@xatom.net, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
References: <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
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
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <ba9b732f-a969-1840-abfc-829d21395f83@molgen.mpg.de>
Date:   Sat, 18 Jan 2020 10:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <789c7db3bafa4bf9a9348123492196b0@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mario,


Am 17.01.20 um 19:33 schrieb Mario.Limonciello@dell.com:
>>> I was able to reproduce the issue with an external HS hub as well, so  this issue
>>> appears to be more related to ASMedia host than the built in HS hub in TB16
>>
>> I contacted the (German) Dell support, and they asked me to update the laptop
>> firmware to 1.9.1 claiming that these issues might be fixed there (despite the
>> change-log not containing that). Anyway, after the update, the user is still
>> able to reproduce the issue.
>>
>> Mario, what can I do, so the issue is escalated to your team, so you can work
>> with ASMedia to solve this?

> From this thread it does sound to me like an ASMedia firmware problem,
> not a Linux kernel problem.
> 
> I do know there is an updated ASMedia firmware binary available.  Right now
> however there is unfortunately not a way to update ASMedia hub firmware using
> free software. 

The fwupd issue *Dell TB16: ASMedia USB controller can't be updated* [1] 
was closed by the “stale robot”.

> If possible, I would recommend that you try to update the
> firmware using a Windows machine and see if it helps the problem.

Thank you. I’ll try to do that on Monday.

> I'm sorry and I don't intend to "pass the buck" but if that doesn't help this needs
> to be prioritized and escalated with Dell support.
> 
> They will then work with the appropriate engineering team who owns the relationship
> to ASMedia to resolve it.

That’s how it should work theoretically, but have you ever dealt with 
Dell’s first level support? They have little experience with Ubuntu, and 
if you are unlucky, they say that Ubuntu support is not done by Dell but 
“by the Linux community”. If you are lucky to not get this answer, they 
do (Google) searches, telling you, your problem is solved by referencing 
only similar sounding problems from the Ubuntu *user* forums. If the 
firmware has a bug (in the UI!), they ask you to install Microsoft 
Windows to see if that solves the issue. If you tell them, the Linux 
developers analyzed the problem, and they say the following solution 
have to be found, they do not know what that means. It’s very annoying 
and time consuming often for naught.


Kind regards,

Paul


[1]: https://github.com/fwupd/fwupd/issues/1351
