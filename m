Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6CC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3A2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgB0GhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgB0GhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:37:10 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF3F24672;
        Thu, 27 Feb 2020 06:37:07 +0000 (UTC)
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
 <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
 <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <1a16c680-2bbe-eb24-6ea3-4b50d0c3e377@linux-m68k.org>
Date:   Thu, 27 Feb 2020 16:37:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/2/20 8:31 am, Finn Thain wrote:
> On Wed, 26 Feb 2020, Greg Ungerer wrote:
> 
>> On 26/2/20 4:39 pm, Finn Thain wrote:
>>>
>>> If -EBUSY means the end user has misconfigured something, printing
>>> "request_irq failed" would be helpful. But does that still happen?
>>
>> I have seen it many times. Its not at all difficult to get interrupt
>> assignments wrong, duplicated, or otherwise mistaken when creating
>> device trees. Not so much m68k/coldfire platforms where they are most
>> commonly hard coded.
>>
> 
> I was thinking of end users and production builds. You seem to be
> concerned about developers. Catering to developers argues for pr_debug()
> here, if anything.

Perhaps. But most of the kernel boot output as it stands today
is more debug (or maybe notice) than useful.


> You say you've seen -16 errors "many times". Have you also seen -22? Did
> the ability to distinguish these values help you to fix your device tree?

Probably not. But the real difficulty is trying to diagnose other
peoples problems with just console trace output. The more information
there the better.


>>> ...
>>>
>>> BTW, one of the benefits of "%s: request_irq failed" is that a
>>> compilation unit with multiple request_irq calls permits the compiler
>>> to coalesce all duplicated format strings. Whereas, that's not
>>> possible with "foo: request_irq failed" and "bar: request_irq failed".
>>
>> Given the wide variety of message text used with failed request_irq()
>> calls it would be shear luck that this matched anything else. A quick
>> grep shows that "%s: request_irq() failed\n" has no other exact matches
>> in the current kernel source.
>>
> 
> You are overlooking the patches in this series that produce multiple
> identical format strings.

No I didn't :-)  None of these will end up compiled in at the same time.
The various ColdFire SoC parts have a single timer hardware module -
and only the required one will be compiled in, not all of them.

Regards
Greg
