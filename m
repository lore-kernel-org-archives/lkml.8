Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73850C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA1PPN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:15:13 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:39866 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgA1PPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:15:13 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 321851B0DA; Tue, 28 Jan 2020 15:15:11 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
References: <20200124152504.23411-1-mans@mansr.com>
        <20200127153506.GA4589@bogus> <yw1xy2tsvnww.fsf@mansr.com>
        <20200128134745.GA3048749@kroah.com>
Date:   Tue, 28 Jan 2020 15:15:11 +0000
In-Reply-To: <20200128134745.GA3048749@kroah.com> (Greg Kroah-Hartman's
        message of "Tue, 28 Jan 2020 14:47:45 +0100")
Message-ID: <yw1xpnf3vchs.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Jan 27, 2020 at 04:56:15PM +0000, Måns Rullgård wrote:
>> Rob Herring <robh@kernel.org> writes:
>> 
>> > On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
>> >> Add a non-removable-ports property that lists the hardwired downstream
>> >> ports of a hub.  Although hubs can provide this information, they are
>> >> not always configured correctly.  An alternate means of indicating this
>> >> for built-in USB devices is thus useful.
>> >> 
>> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> >
>> > I reviewed this already, but since you didn't add my reviewed-by, I'm 
>> > looking at it again and having 2nd thoughts.
>> >
>> >> ---
>> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>> >>  1 file changed, 4 insertions(+)
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
>> >> index 036be172b1ae..92d863cc96b6 100644
>> >> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
>> >> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
>> >> @@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
>> >>  - #size-cells: shall be 0
>> >>  
>> >>  
>> >> +Optional properties for hub and host-controller nodes:
>> >> +- non-removable-ports: list of hardwired downstream ports
>> >
>> > If you have a hardwired device and need to know that, doesn't that imply 
>> > there's some other stuff you need to describe beyond what a standard USB 
>> > device has. Such as a power supply that's not Vbus from the hub.
>> 
>> I suppose there could be, but there isn't in my actual situation.
>> 
>> > At a minimum, I think this should be a per port property.
>> 
>> That's what I suggested first.  Greg told me to do it like this instead.
>
> I said that?  I do not remember discussing this at all, when did that
> happen?

https://lore.kernel.org/lkml/20190228155241.GC12050@kroah.com/

>> > Though really, I think this should just be implied by describing the
>> > device in DT. I'm not sure if there's a case for hotpluggable devices
>> > described in DT.  Maybe with overlays.
>> 
>> That's also an option.  Greg, what do you think?
>
> I have no idea, sorry, I'm totally lost here...

Background: I need to differentiate between on-board and external USB
devices on a few boards.  Although hubs can indicate the removable
status of each port, the configuration options are often limited and may
not be capable of describing the actual wiring.  Also, if a device is
hard-wired directly to a host port, there is no way of indicating this.

While I could match the full device path using per-board lists, I'd
prefer a generic solution.  To this end, it is necessary to add the
ability for DT to supply this information.  Three variants have been
discussed:

1. Add a "non-removable" property to the USB device node similar to how
   it's done for MMC.

2. Add a "non-removable-ports" property to the hub node.  Apparently
   ACPI can supply the information in this manner.

3. Make any USB device with a DT node implicitly non-removable.

Either one will work for me.

-- 
Måns Rullgård
