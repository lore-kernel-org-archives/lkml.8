Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119DC47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F01208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sammserver.com header.i=@sammserver.com header.b="BSaFepju";
	dkim=pass (1024-bit key) header.d=sammserver.com header.i=@sammserver.com header.b="BSaFepju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgEIXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgEIXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:22:30 -0400
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 May 2020 16:22:29 PDT
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A19C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:22:29 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 4CFEAB977F0; Sun, 10 May 2020 01:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sammserver.com;
        s=email; t=1589065960;
        bh=7QaA+216Ra/pqltyIXWSczfrH3JuNxlObZf9vee8Otc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSaFepjun5Ap/XDWQqdM9N0ugSmJRbj+a9fIg7dX7JSwMomvvUPDi9ka/y5vhPC1V
         26DvOhQji2FEdW4S1Ah7R8w16xmal1vsFz//z81tn08q2tYFKb0/lbYHWE8tPlygWm
         YxflshZAgX+Y+xgPE5fTTf8gWUNV1LLKc4GRNcvE=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id CB21AB977ED;
        Sun, 10 May 2020 01:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sammserver.com;
        s=email; t=1589065960;
        bh=7QaA+216Ra/pqltyIXWSczfrH3JuNxlObZf9vee8Otc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSaFepjun5Ap/XDWQqdM9N0ugSmJRbj+a9fIg7dX7JSwMomvvUPDi9ka/y5vhPC1V
         26DvOhQji2FEdW4S1Ah7R8w16xmal1vsFz//z81tn08q2tYFKb0/lbYHWE8tPlygWm
         YxflshZAgX+Y+xgPE5fTTf8gWUNV1LLKc4GRNcvE=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id B1BB31420055; Sun, 10 May 2020 01:12:39 +0200 (CEST)
Date:   Sun, 10 May 2020 01:12:39 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <sammko@sammserver.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] HID for 5.7
Message-ID: <20200509231239.ccnbk4km7p77gafu@fastboi.localdomain>
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
 <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
 <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.2020 12:05, Jiri Kosina wrote:
> It would still be possible to access the report via hidraw, and maybe 
> that's analogy of what the Windows driver/special Glorious software :) 
> does, I don't know. It's hard to believe that Windows would be actually 
> willing to report any changes coming through HID_MAIN_ITEM_CONSTANT 
> reports, but who knows.

I did some research of what other HID implementations do in this
situation and would like to share it here.

Windows, as we already know, does not seem to mind the CONST flag and
accepts the reports just fine. Of course, whether this is the general
behaviour or only a special case, we can only speculate, short of
emulating devices with the descriptors incorrect in some way or another,
either in software or with some sort of microcontroller. I haven't yet
set out to do this, but I might eventually.

macOS (tested a 10.13 hackintosh) accepts the reports just fine. This
platform is an interesting case, because Apple's HID stack is
open-source. Assuming I understand the code correctly, the logic which
filters out padding is found in HIDIsButtonOrValue.c of the IOHIDFamily
component. The file can be found here[1]. The author(?) helpfully
provides a description in the changelog:

11/1/99    BWS     [2405720]
    We need a better check for 'bit padding' items,                                                                                                                   
    rather than just is constant. We will check to make sure the
    item is constant, and has no usage, or zero usage.

I am not particularly well-versed in HID, but this sounds like a
reasonable solution. Is there anything preventing this approach in
Linux? While doing the initial research when I was working on the
original patch, I noticed some code was purposefully setting the CONST
flag in order to get reports ignored. Food for thought, especially for
someone who knows what they are doing, unlike me :D

FreeBSD, to my limited knowledge, only includes a basic HID driver
in the kernel, capable of boot protocol mice and keyboards. There is a
userspace daemon, uhidd, which grabs the raw ugen device and submits
keycodes to a virtual keyboard (or mouse) with more comprehensive
support for consumer control and such. It ignores the reports as can be
seen on L318 of uhidd_cc.c [2].

I don't currently have access to other platforms, although I don't even
know of any with a comprehensive HID implementation. Maybe game consoles?

Of course, I am not sure this is worth the effort in the first place, I
was just curious. Also, not sure if I mentioned this before, I reached
out to the hardware manufacturer about this issue, they haven't
responded. Not a surprise.

Sam

[1]: https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-1446.61.2/IOHIDSystem/IOHIDDescriptorParser/
[2]: https://github.com/kaiwang27/uhidd/blob/master/uhidd/uhidd_cc.c#L318
