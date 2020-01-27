Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D0DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDB9214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgA0RDh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:03:37 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:34980 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0RDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:03:35 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 12:03:34 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id EB3581B0D9; Mon, 27 Jan 2020 16:56:15 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
References: <20200124152504.23411-1-mans@mansr.com>
        <20200127153506.GA4589@bogus>
Date:   Mon, 27 Jan 2020 16:56:15 +0000
In-Reply-To: <20200127153506.GA4589@bogus> (Rob Herring's message of "Mon, 27
        Jan 2020 09:35:06 -0600")
Message-ID: <yw1xy2tsvnww.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
>> Add a non-removable-ports property that lists the hardwired downstream
>> ports of a hub.  Although hubs can provide this information, they are
>> not always configured correctly.  An alternate means of indicating this
>> for built-in USB devices is thus useful.
>> 
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> I reviewed this already, but since you didn't add my reviewed-by, I'm 
> looking at it again and having 2nd thoughts.
>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
>> index 036be172b1ae..92d863cc96b6 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
>> @@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
>>  - #size-cells: shall be 0
>>  
>>  
>> +Optional properties for hub and host-controller nodes:
>> +- non-removable-ports: list of hardwired downstream ports
>
> If you have a hardwired device and need to know that, doesn't that imply 
> there's some other stuff you need to describe beyond what a standard USB 
> device has. Such as a power supply that's not Vbus from the hub.

I suppose there could be, but there isn't in my actual situation.

> At a minimum, I think this should be a per port property.

That's what I suggested first.  Greg told me to do it like this instead.

> Though really, I think this should just be implied by describing the
> device in DT. I'm not sure if there's a case for hotpluggable devices
> described in DT.  Maybe with overlays.

That's also an option.  Greg, what do you think?

-- 
Måns Rullgård
