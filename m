Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC86C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048324691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blueyonder.co.uk header.i=@blueyonder.co.uk header.b="T4tfyila"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgB0Lel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:34:41 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:34527
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgB0Lel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:34:41 -0500
Received: from [192.168.10.214] ([82.47.85.138])
        by cmsmtp with ESMTPA
        id 7HR9joFfJIUP97HR9jMhre; Thu, 27 Feb 2020 11:34:39 +0000
X-Originating-IP: [82.47.85.138]
X-Authenticated-User: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Is0wjo3g c=1 sm=1 tr=0 a=mctQX8G8JfdR+oUIdXtpKQ==:117
 a=mctQX8G8JfdR+oUIdXtpKQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=N659UExz7-8A:10 a=x7bEGLp0ZPQA:10 a=a5Gf7U6LAAAA:8 a=VwQbUJbxAAAA:8
 a=bgUkVmbCD3rZoZhqrOMA:9 a=pILNOxqGKmIA:10 a=VWYBCMy2-3DvUfgBPAUA:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1582803279;
        bh=kyU+HwFBHW2yIellqsW7HfGh+tJNY06Lde13A6sZuZM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T4tfyilac2vZkL2q2TlxVyhgebDS9QjK9o86Kx/f1lLi8n4A6ioJ+mJcdCJTH0RmT
         swmZK32QofJ+IQfsn0zgtdJoJNTnX+YAaU/dSrdWUGRUbEo6sadXZBY6oqz81o22pC
         PGWlO09tlajW5z+bKDQlxOJ8yTs2Orl8hmaFB1N4b15c1W9SfYmRZzdcJOActMoNOm
         bqB0vUWTegObcBopOHVvtpNP4f+j6alo5pcLGY4X/E8fRAihwjkmeFkzqx4hyZa4lX
         V77SibGBok/qxd0YQ1VMaY6hC2zOr3MtIi8SM7f+WdCZZHaP9OE/MKtDpz1NvAC/jO
         0EenTdevzxvwA==
Reply-To: sboyce@blueyonder.co.uk
Subject: Re: 5.6-rc3 nouveau failure, 5.6-rc2 OK
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     LKML Mailing List <linux-kernel@vger.kernel.org>
References: <ae2dc143-8d38-1942-9ebd-87c9c9c09960@blueyonder.co.uk>
 <CAEJqkgiXE-ye_P99FGcFM8j7Qqd3npKM9kY44MEnxGZF2_Hntw@mail.gmail.com>
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
Message-ID: <a2c26090-0b40-1011-503d-68425daf1ef3@blueyonder.co.uk>
Date:   Thu, 27 Feb 2020 11:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiXE-ye_P99FGcFM8j7Qqd3npKM9kY44MEnxGZF2_Hntw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfBJzzRL/vOuOHfpayiTIbmJTyaFh1X3lah1kq27GAtjf+qcyDMkHy/hlUR1ZiYwYhh3A/T9KTFaObWcBerCs6qha54inGdhfkamqC+A+BXx5Fvlyh1sh
 XfIszymtD1oY7/kuJfN5AtP36bhEF1lixUbDEvfm+KvxYOdq9leoy+mABhKWLPjyvBrJ28L0VRfbKAo31s7B62hl2tbkdUpyzvxUZXjXJcUFkStbg2yUXszn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Gabriel.
I'll do that.
Regards
Sid.

On 27/02/2020 03:14, Gabriel C wrote:
> Am Do., 27. Feb. 2020 um 01:24 Uhr schrieb Sid Boyce <sboyce@blueyonder.co.uk>:
>
> Hello,
>
>> [94.455712] [T411] nouveau 0000:07:00.0 disp ctor failed, -12
>>
>> Welcome to openSUSE Tumbleweed 20200224 - Kernel 5.6.0-rc3 (tty1)
>>
>> ens3s0: 192.168.10.214 .......
>>
>> login:
>>
>>
>> I can login here but X does not start -- lspci
>>
>> 07:00.0 VGA compatible controller: NVIDIA Corporation TU117 [GeForce GTX
>> 1650] (rev a1)
>>
>> from dmesg:-
>>
>> [Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: NVIDIA TU117 (167000a1)
>> [Wed Feb 26 22:42:39 2020] nouveau 0000:07:00.0: bios: version
>> 90.17.2a.00.39
>> [Wed Feb 26 22:44:12 2020] nouveau 0000:07:00.0: disp ctor failed, -12
>> [Wed Feb 26 22:44:12 2020] nouveau: probe of 0000:07:00.0 failed with
>> error -12
>>
> *Warning* I have no idea bout Nvidia GPU HW :-). I saw this commit in
> linux-firmware git added 8 days ago:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=2277987a593d54c1e922a9f25445802071015f42
>
> Maybe you just need to update your firmware package.
>
> BR,
>
> Gabriel C.


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

