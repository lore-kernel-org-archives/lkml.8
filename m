Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477CC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBDA217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBEL46 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:56:58 -0500
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:16905 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727479AbgBEL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:56:58 -0500
Subject: Re: [PATCH 5.4 17/78] HID: Fix slab-out-of-bounds read in
 hid_field_extract (Broken!)
To:     Jiri Kosina <jikos@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20200114094352.428808181@linuxfoundation.org>
 <20200114094356.028051662@linuxfoundation.org>
 <27ba705a-6734-9a92-a60c-23e27c9bce6d@sony.com>
 <20200205093226.GC1164405@kroah.com>
 <08ff9caa-0473-fae3-6f98-8530ed4c3b1a@sony.com>
 <nycvar.YFH.7.76.2002051053060.26888@cbobk.fhfr.pm>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <279470c3-d2f5-a318-7b4b-dfdb85328e44@sony.com>
Date:   Wed, 5 Feb 2020 12:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2002051053060.26888@cbobk.fhfr.pm>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=V88DLtvi c=1 sm=1 tr=0 a=T5MYTZSj1jWyQccoVcawfw==:117 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=l697ptgUJYAA:10 a=FxYwkRdRI45dUdk3YXgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 10:54 AM, Jiri Kosina wrote:
> On Wed, 5 Feb 2020, Enderborg, Peter wrote:
>
>>>> This patch breaks Elgato StreamDeck.
>>> Does that mean the device is broken with a too-large of a report?
>> Yes.
> In which way does the breakage pop up? Are you getting "report too long" 
> errors in dmesg, or the device just doesn't enumerate at all?
>
> Could you please post /sys/kernel/debug/hid/<device>/rdesc contents, and 
> if the device is at least semi-alive, also contents of 
> /sys/kernel/debug/hid/<device>/events from the time it misbehaves?
>
Sure.

[   18.710500] hid-generic 0003:0FD9:0060.0005: report is too long
[   18.716511] hid-generic 0003:0FD9:0060.0005: item 0 1 0 9 parsing failed
[   18.723359] hid-generic: probe of 0003:0FD9:0060.0005 failed with error -22
[root@imx ~]# cat /sys/kernel/debug/hid/0003\:0FD9\:0060.0005/rdesc
05 0c 09 01 a1 01 09 01 05 09 19 01 29 10 15 00 26 ff 00 75 08 95 10 85 01 81 02 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 a0 81 02 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 a1 81 02 0a 00 ff 15 00 26 ff 00 75 08 96 fe 1f 85 02 91 02 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 03 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 04 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 05 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 01 85 06 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 07 b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 01 85 08 b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 09 b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 0a b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 0b b1 04 c0 c0

The rdesc is different in 5.3.16 and quite long where it works. The head is there:

[root@imx ~]# cat rdesc.5.3.16 | more
05 0c 09 01 a1 01 09 01 05 09 19 01 29 10 15 00 26 ff 00 75 08 95 10 85 01 81 02
 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 a0 81 02 0a 00 ff 15 00 26 ff 00 75 08 9
5 10 85 a1 81 02 0a 00 ff 15 00 26 ff 00 75 08 96 fe 1f 85 02 91 02 a1 00 0a 00
ff 15 00 26 ff 00 75 08 95 10 85 03 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08
 95 10 85 04 b1 02 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 05 b1 02 c0 a
1 00 0a 00 ff 15 00 26 ff 00 75 08 95 01 85 06 b1 02 c0 a1 00 0a 00 ff 15 00 26
ff 00 75 08 95 10 85 07 b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 01 85 08
 b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08 95 10 85 09 b1 04 c0 a1 00 0a 00 f
f 15 00 26 ff 00 75 08 95 10 85 0a b1 04 c0 a1 00 0a 00 ff 15 00 26 ff 00 75 08
95 10 85 0b b1 04 c0 c0

  INPUT(1)[INPUT]
    Field(0)
      Application(Consumer.0001)
      Usage(17)
        Consumer.0001
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
  INPUT(160)[INPUT]
    Field(0)
      Application(Consumer.0001)
      Usage(16)
        Button.ff00
        Button.ff00
        Button.ff00
        Button.ff00

>>> Is it broken in Linus's tree?  If so, can you work with the HID
>>> developers to fix it there so we can backport the fix to all stable
>>> trees?
>> I cant see that there are any other fixes upon this so I dont think so. 
>> I can try.
>>
>>
>> Jiri is in the loop. I guess he is the "HID developers" ?
> Thanks,
>

